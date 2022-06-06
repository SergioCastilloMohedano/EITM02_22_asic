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
-- ......
        M_div_pt : in std_logic_vector (7 downto 0)
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
            RS : in std_logic_vector (7 downto 0);
            p : in std_logic_vector (7 downto 0);
            m : in std_logic_vector (7 downto 0);
            r_p : out std_logic_vector (7 downto 0);
            pm : out std_logic_vector (7 downto 0);
            s : out std_logic_vector (7 downto 0)
        );
    end component;

    component SYS_CTR_ACT_NL is
        port (
            clk : in std_logic;
            reset : in std_logic;
            ACT_NL_start : in std_logic;
            ACT_NL_ready : out std_logic;
            ACT_NL_finished : out std_logic;
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
            ACT_NL_finished : in std_logic;
            pass_flag : out std_logic
         );
    end component;

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_start, s_wait_1, s_wait_2, s_NL, s_finished);
    signal state_next, state_reg: state_type;

    -- ************** FSMD SIGNALS **************
    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal NL_cnt_done_int : std_logic;
    signal ACT_NL_flag_int : std_logic;
 
    ---- External Command Signals to the FSMD
    signal NL_start_int : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    signal WB_NL_ready_int : std_logic;
    signal WB_NL_finished_int : std_logic;
    signal ACT_NL_ready_int : std_logic;
    signal ACT_NL_finished_int : std_logic;

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

    -- SYS_CTR_WB_NL Intermediate Signals
    signal s_int : std_logic_vector (7 downto 0);
    signal pm_int : std_logic_vector (7 downto 0);
    signal r_p_int : std_logic_vector (7 downto 0);
    signal WB_NL_start_int : std_logic;

    -- SYS_CTR_ACT_NL Intermediate Signals
    signal h_p_int : std_logic_vector (7 downto 0);
    signal w_p_int : std_logic_vector (7 downto 0);
    signal ACT_NL_start_int : std_logic;
    ----------------------------------------------


    -- pass flag
    signal pass_flag_int : std_logic;
    signal M_div_pt_int : natural range 0 to 127;

begin

    -- SYS_CTR_WB_NL
    SYS_CTR_WB_NL_inst : SYS_CTR_WB_NL
    port map (
        clk             =>  clk,
        reset           =>  reset,
        WB_NL_start     =>  WB_NL_start_int,
        WB_NL_ready     =>  WB_NL_ready_int,
        WB_NL_finished  =>  WB_NL_finished_int,
        RS              =>  std_logic_vector(to_unsigned(RS_int,RS'length)),
        p               =>  std_logic_vector(to_unsigned(p_int,p'length)),
        m               =>  std_logic_vector(to_unsigned(m_reg,m'length)),
        r_p             =>  r_p_int,
        pm              =>  pm_int,
        s               =>  s_int
    );

    -- SYS_CTR_ACT_NL
    SYS_CTR_ACT_NL_inst : SYS_CTR_ACT_NL
    port map (
        clk             =>  clk,
        reset           =>  reset,
        ACT_NL_start    =>  ACT_NL_start_int,
        ACT_NL_ready    =>  ACT_NL_ready_int,
        ACT_NL_finished =>  ACT_NL_finished_int,
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
        ACT_NL_finished => ACT_NL_finished_int,
        pass_flag       => pass_flag_int
    );

    -- control path : state register
    asmd_reg : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state_reg <= s_init;
            else
                state_reg <= state_next;
            end if;
        end if;
    end process;

    -- control path : next state logic
    asmd_ctrl : process(state_reg, NL_start_int, WB_NL_finished_int, ACT_NL_finished_int, WB_NL_ready_int, ACT_NL_ready_int, NL_cnt_done_int, ACT_NL_flag_int)
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
                if (ACT_NL_flag_int = '1') then
                    state_next <= s_wait_1;
                else
                    state_next <= s_wait_2;
                end if;
            when s_wait_1 =>
                if (WB_NL_finished_int XOR ACT_NL_finished_int) = '0' then
                    if (WB_NL_finished_int AND ACT_NL_finished_int) = '1' then
                        state_next <= s_NL;
                    else
                        state_next <= s_wait_1;
                    end if;
                else
                    state_next <= s_wait_2;
                end if;
            when s_wait_2 =>
                if (WB_NL_finished_int OR ACT_NL_finished_int) = '1' then
                    state_next <= s_NL;
                else
                    state_next <= s_wait_2;
                end if;
            when s_NL =>
                if (WB_NL_ready_int AND ACT_NL_ready_int) = '0' then
                    state_next <= s_NL;
                else
                    if NL_cnt_done_int = '1' then
                        state_next <= s_finished;
                    else
                        state_next <= s_start;
                    end if;
                end if;
            when s_finished =>
                state_next <= s_idle;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    NL_ready_int <= '1' when state_reg = s_idle else '0';
    WB_NL_start_int <= '1' when state_reg = s_start else '0';
    ACT_NL_start_int <= '1' when (state_reg = s_start AND ACT_NL_flag_int = '1') else '0';
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
    NL_cnt_done_int <= '1' when ((c_reg = (C_cap_int - r_int)) AND
                                 (m_reg = (M_cap_int - p_int)) AND
                                 (rc_reg = (c_reg + r_int - 1))) else '0';

    ACT_NL_flag_int <= '1' when m_reg = 0 else '0';

    -- data path : mux routing
    data_mux : process(state_reg, rc_reg, m_reg, c_reg, rc_out, m_out, c_out, WB_NL_ready_int, ACT_NL_ready_int)
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
                if (WB_NL_ready_int AND ACT_NL_ready_int) = '0' then
                    rc_next <= rc_reg;
                    m_next <= m_reg;
                    c_next <= c_reg;
                else
                    rc_next <= rc_out;
                    m_next <= m_out;
                    c_next <= c_out;
                end if;
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

    -- ..
    M_div_pt_int <= to_integer(unsigned(M_div_pt));



end architecture;