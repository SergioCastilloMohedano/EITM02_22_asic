-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SYS_CTR_NL.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-05-15
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : This block integrates the Nested Loops for both weights/biases and Input Features Map,
--                  triggers them so that corresponding values of both weights/biases and ifmaps
--                  can be retrieved from SRAM blocks concurrently and also be sent concurrently to the
--                  Multicast Controllers.
--               
--              TBD
--              It needs to be modified to hold for its state when pass is totally loaded into PE Array
--              and wait for computation to be finished. During this time, at some point, Nested Loop
--              for the ifmap outputs of next layer shall be triggered.
-------------------------------------------------------------------------------------------------------
-- Input Signals  :
--         * clk: clock
--         * reset: synchronous, active high.
--         * 
-- Output Signals :
--         * ...
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_NL is
    port (
        clk : in std_logic;
        reset : in std_logic;
        NL_start : in std_logic;
        NL_ready : out std_logic;
        NL_finished : out std_logic;
        M_cap : in std_logic_vector (7 downto 0);
        C_cap : in std_logic_vector (7 downto 0);
        r : in std_logic_vector (7 downto 0);
        p : in std_logic_vector (7 downto 0);
        RS : in std_logic_vector (7 downto 0);
        HW_p : in std_logic_vector (7 downto 0);
        c : out std_logic_vector (7 downto 0);
        m : out std_logic_vector (7 downto 0);
        rc : out std_logic_vector (7 downto 0);
        r_p : out std_logic_vector (7 downto 0);
        pm : out std_logic_vector (7 downto 0);
        s : out std_logic_vector (7 downto 0);
        w_p : out std_logic_vector (7 downto 0);
        h_p : out std_logic_vector (7 downto 0);
        M_div_pt : in std_logic_vector (7 downto 0);
        NoC_ACK_flag : in std_logic;
        IFM_NL_ready : out std_logic;
        IFM_NL_finished : out std_logic;
        IFM_NL_busy : out std_logic;
        WB_NL_ready : out std_logic;
        WB_NL_finished : out std_logic;
        WB_NL_busy : out std_logic
    );
end SYS_CTR_NL;

architecture behavioral of SYS_CTR_NL is

    -- COMPONENT DECLARATIONS
    component SYS_CTR_WB_NL is
        port (
            clk : in std_logic;
            reset : in std_logic;
            WB_NL_start : in std_logic;
            WB_NL_ready : out std_logic;
            WB_NL_finished : out std_logic;
            WB_NL_busy : out std_logic;
            RS : in std_logic_vector (7 downto 0);
            p : in std_logic_vector (7 downto 0);
            m : in std_logic_vector (7 downto 0);
            r_p : out std_logic_vector (7 downto 0);
            pm : out std_logic_vector (7 downto 0);
            s : out std_logic_vector (7 downto 0)
        );
    end component;

    component SYS_CTR_IFM_NL is
        port (
            clk : in std_logic;
            reset : in std_logic;
            IFM_NL_start : in std_logic;
            IFM_NL_ready : out std_logic;
            IFM_NL_finished : out std_logic;
            IFM_NL_busy : out std_logic;
            HW_p : in std_logic_vector (7 downto 0);
            h_p : out std_logic_vector (7 downto 0);
            w_p : out std_logic_vector (7 downto 0)
        );
    end component;

    component SYS_CTR_PASS_FLAG is
        port (
            clk : in std_logic;
            reset : in std_logic;
            NL_start : in std_logic;
            NL_finished : in std_logic;
            r : in std_logic_vector (7 downto 0);
            M_div_pt : in std_logic_vector (7 downto 0);
            WB_NL_finished : in std_logic;
            IFM_NL_finished : in std_logic;
            pass_flag : out std_logic
         );
    end component;

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_start, s_wait_1, s_wait_2, s_NL, s_finished, s_NoC_ACK);
    signal state_next, state_reg: state_type;

    -- ************** FSMD SIGNALS **************
    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal NL_cnt_done_next : std_logic;    -- signal that is set high only once the whole current layer of the network has been processed by the Nested Loops.
    signal NL_cnt_done_reg : std_logic;
    signal IFM_NL_flag_int : std_logic;     -- allows the IFM NL to be triggered only once, when m = 0.
 
    ---- External Command Signals to the FSMD
    signal NL_start_int : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    signal WB_NL_ready_int : std_logic;
    signal WB_NL_finished_int : std_logic;
    signal WB_NL_busy_int : std_logic;
    signal IFM_NL_ready_int : std_logic;
    signal IFM_NL_finished_int : std_logic;
    signal IFM_NL_busy_int : std_logic;

    ---- External Status Signals to indicate status of the FSMD
    signal NL_ready_int : std_logic;
    signal NL_finished_int : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal rc_next, rc_reg : natural range 0 to 127;
    signal m_next, m_reg : natural range 0 to 127;
    signal c_next, c_reg : natural range 0 to 127;

    ---- External Control Signals used to control Data Path Operation
    signal M_cap_int : natural range 0 to 127;
    signal C_cap_int : natural range 0 to 127;
    signal r_int : natural range 0 to 127;
    signal p_int : natural range 0 to 127;
    signal RS_int : natural range 0 to 127;
    signal HW_p_int : natural range 0 to 127;

    ---- Functional Units Intermediate Signals
    signal rc_out : natural range 0 to 127;
    signal m_out : natural range 0 to 127;
    signal m_out_tmp : natural range 0 to 127;
    signal c_out : natural range 0 to 127;
    signal c_out_tmp : natural range 0 to 127;
    -- ******************************************

    ---------------- Data Outputs ----------------
    -- Out PORTs "rc", "c" and "m"

    -- SYS_CTR_NL Intermediate Signals
    signal IFM_NL_start_tmp : std_logic;
    signal NoC_ACK_flag_int : std_logic;
    signal start_flag_next, start_flag_reg : std_logic;         -- these two signals avoid that "NL_cnt_done_next" signal gets set to "1" the first time the conditions 
    signal start_flag_next_2, start_flag_reg_2 : std_logic;     -- of "c", "m" and "rc" being 0 are met, allowing "NL_cnt_done_next" to be set to "1" only when it has to.

    -- SYS_CTR_WB_NL Intermediate Signals
    signal s_int : std_logic_vector (7 downto 0);
    signal pm_int : std_logic_vector (7 downto 0);
    signal r_p_int : std_logic_vector (7 downto 0);
    signal WB_NL_start_int : std_logic;

    -- SYS_CTR_IFM_NL Intermediate Signals
    signal h_p_int : std_logic_vector (7 downto 0);
    signal w_p_int : std_logic_vector (7 downto 0);
    signal IFM_NL_start_int : std_logic;

    -- SYS_CTR_PASS_FLAG Intermediate Signals
    signal pass_flag_int : std_logic;
    signal M_div_pt_int : natural range 0 to 127;
    ----------------------------------------------

begin

    -- SYS_CTR_WB_NL
    SYS_CTR_WB_NL_inst : SYS_CTR_WB_NL
    port map (
        clk             =>  clk,
        reset           =>  reset,
        WB_NL_start     =>  WB_NL_start_int,
        WB_NL_ready     =>  WB_NL_ready_int,
        WB_NL_finished  =>  WB_NL_finished_int,
        WB_NL_busy      =>  WB_NL_busy_int,
        RS              =>  std_logic_vector(to_unsigned(RS_int,RS'length)),
        p               =>  std_logic_vector(to_unsigned(p_int,p'length)),
        m               =>  std_logic_vector(to_unsigned(m_reg,m'length)),
        r_p             =>  r_p_int,
        pm              =>  pm_int,
        s               =>  s_int
    );

    -- SYS_CTR_IFM_NL
    SYS_CTR_IFM_NL_inst : SYS_CTR_IFM_NL
    port map (
        clk             =>  clk,
        reset           =>  reset,
        IFM_NL_start    =>  IFM_NL_start_int,
        IFM_NL_ready    =>  IFM_NL_ready_int,
        IFM_NL_finished =>  IFM_NL_finished_int,
        IFM_NL_busy     =>  IFM_NL_busy_int,
        HW_p            =>  std_logic_vector(to_unsigned(HW_p_int,HW_p'length)),
        h_p             =>  h_p_int,
        w_p             =>  w_p_int
    );

    -- SYS_CTR_PASS_FLAG
    SYS_CTR_PASS_FLAG_inst : SYS_CTR_PASS_FLAG
    port map (
        clk             =>  clk,
        reset           =>  reset,
        NL_start        => NL_start_int,
        NL_finished     => NL_finished_int,
        r               => std_logic_vector(to_unsigned(r_int,r'length)),
        M_div_pt        => std_logic_vector(to_unsigned(M_div_pt_int,M_div_pt'length)),
        WB_NL_finished  => WB_NL_finished_int,
        IFM_NL_finished => IFM_NL_finished_int,
        pass_flag       => pass_flag_int
    );

    -- control path : registers
    asmd_reg : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- state register
                state_reg <= s_init;
                -- control signals registers
                NL_cnt_done_reg <= '0';
                start_flag_reg <= '0';
                start_flag_reg_2 <= '0';
            else
                -- state register
                state_reg <= state_next;
                -- control signal registers
                NL_cnt_done_reg <= NL_cnt_done_next;
                start_flag_reg <= start_flag_next;
                start_flag_reg_2 <= start_flag_next_2;
            end if;
        end if;
    end process;

    -- control path : next state logic
    asmd_ctrl : process(state_reg, NL_start_int, WB_NL_finished_int, IFM_NL_finished_int, WB_NL_ready_int, IFM_NL_ready_int, NL_cnt_done_reg, IFM_NL_flag_int, pass_flag_int, NoC_ACK_flag_int)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if NL_start_int = '1' then
                    state_next <= s_start;
                else
                    state_next <= s_idle;
                end if;
            when s_start =>
                if (pass_flag_int = '0') then
                    if (IFM_NL_flag_int = '1') then
                        state_next <= s_wait_1;
                    else
                        state_next <= s_wait_2;
                    end if;
                else
                    state_next <= s_NoC_ACK;
                end if;
            when s_wait_1 =>
                if (WB_NL_finished_int XOR IFM_NL_finished_int) = '0' then
                    if (WB_NL_finished_int AND IFM_NL_finished_int) = '1' then
                        state_next <= s_NL;
                    else
                        state_next <= s_wait_1;
                    end if;
                else
                    state_next <= s_wait_2;
                end if;
            when s_wait_2 =>
                if (WB_NL_finished_int OR IFM_NL_finished_int) = '1' then
                    state_next <= s_NL;
                else
                    state_next <= s_wait_2;
                end if;
            when s_NL =>
                if (WB_NL_ready_int AND IFM_NL_ready_int) = '0' then
                    state_next <= s_NL;
                else
                    state_next <= s_start;
                end if;
            when s_NoC_ACK =>
                if NOC_ACK_flag_int = '1' then
                    if NL_cnt_done_reg = '1' then
                        state_next <= s_finished;
                    else
                        state_next <= s_start;
                    end if;
                else
                    state_next <= s_NoC_ACK;
                end if;
            when s_finished =>
                state_next <= s_idle;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    NL_ready_int <= '1' when state_reg = s_idle else '0';
    WB_NL_start_int <= '1' when (state_reg = s_start AND pass_flag_int = '0') else '0';
    IFM_NL_start_tmp <= '1' when (state_reg = s_start AND pass_flag_int = '0') else '0';
    IFM_NL_start_int <= '1' when (IFM_NL_start_tmp = '1' AND IFM_NL_flag_int = '1') else '0';
    NL_finished_int <= '1' when state_reg = s_finished else '0';

    -- data path : data registers
    data_reg : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                rc_reg <= 0;
                m_reg <= 0;
                c_reg <= 0;
            else
                rc_reg <= rc_next;
                m_reg <= m_next;
                c_reg <= c_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    rc_out <= (rc_reg + 1) when (rc_reg < (c_reg + r_int - 1)) else c_out;

    m_out_tmp <= (m_reg + p_int) when (m_reg < (M_cap_int - p_int)) else 0;
    m_out <= m_out_tmp when (rc_reg = (c_reg + r_int - 1)) else m_reg;

    c_out_tmp <= (c_reg + r_int) when (c_reg < (C_cap_int - r_int)) else 0;
    c_out <= c_out_tmp when ((m_reg = (M_cap_int - p_int)) AND (rc_reg = (c_reg + r_int - 1))) else c_reg;

    -- data path : status (inputs to control path to modify next state logic)
    start_flag_next <= '0' when (state_reg = s_finished) else
                       '1' when (state_reg = s_idle AND NL_start_int = '1') else 
                       start_flag_reg;

    start_flag_next_2 <= start_flag_reg;

    NL_cnt_done_next <= '1' when (((c_reg = 0) AND
                                 (m_reg = 0) AND
                                 (rc_reg = 0)) AND
                                 (start_flag_reg_2 = '1') AND
                                 (state_reg = s_start)) else
                        '0' when state_reg = s_finished else
                        NL_cnt_done_reg;

    IFM_NL_flag_int <= '1' when m_reg = 0 else '0';

    -- data path : mux routing
    data_mux : process(state_reg, rc_reg, m_reg, c_reg, rc_out, m_out, c_out, WB_NL_ready_int, IFM_NL_ready_int)
    begin
        case state_reg is
            when s_init =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
            when s_idle =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
            when s_start =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
            when s_wait_1 =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
            when s_wait_2 =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
            when s_NL =>
                if (WB_NL_ready_int AND IFM_NL_ready_int) = '0' then
                    rc_next <= rc_reg;
                    m_next <= m_reg;
                    c_next <= c_reg;
                else
                    rc_next <= rc_out;
                    m_next <= m_out;
                    c_next <= c_out;
                end if;
            when s_NOC_ACK =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
            when s_finished =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
            when others =>
                rc_next <= rc_reg;
                m_next <= m_reg;
                c_next <= c_reg;
        end case;
    end process;

    -- PORT Assignations
    NL_start_int <= NL_start;
    NL_ready <= NL_ready_int;
    NL_finished <= NL_finished_int;
    m <= std_logic_vector(to_unsigned(m_reg, m'length));
    c <= std_logic_vector(to_unsigned(c_reg, c'length));
    rc <= std_logic_vector(to_unsigned(rc_reg, rc'length));
    r_p <= r_p_int;
    pm <= pm_int;
    s <= s_int;
    h_p <= h_p_int;
    w_p <= w_p_int;
    M_cap_int <= to_integer(unsigned(M_cap));
    C_cap_int <= to_integer(unsigned(C_cap));
    r_int <= to_integer(unsigned(r));
    p_int <= to_integer(unsigned(p));
    HW_p_int <= to_integer(unsigned(HW_p));
    RS_int <= to_integer(unsigned(RS));
    M_div_pt_int <= to_integer(unsigned(M_div_pt));
    NoC_ACK_flag_int <= NoC_ACK_flag;
    IFM_NL_ready <= IFM_NL_ready_int;
    IFM_NL_finished <= IFM_NL_finished_int;
    IFM_NL_busy <= IFM_NL_busy_int;
    WB_NL_ready <= WB_NL_ready_int;
    WB_NL_finished <= WB_NL_finished_int;
    WB_NL_busy <= WB_NL_busy_int;

end architecture;