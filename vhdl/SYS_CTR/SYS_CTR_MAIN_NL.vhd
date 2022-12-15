library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SYS_CTR_MAIN_NL is
    port (
        clk                       : in std_logic;
        reset                     : in std_logic;
        NL_start                  : in std_logic;
        NL_ready                  : out std_logic;
        NL_finished               : out std_logic;
        M_cap                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        C_cap                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        p                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        c                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        m                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        rc                        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_ACK_flag              : in std_logic;
        IFM_NL_ready              : in std_logic;
        IFM_NL_finished           : in std_logic;
        WB_NL_ready               : in std_logic;
        WB_NL_finished            : in std_logic;
        IFM_NL_start              : out std_logic;
        WB_NL_start               : out std_logic;
        pass_flag                 : in std_logic;
        OFM_NL_ready              : in std_logic;
        OFM_NL_finished           : in std_logic;
        OFM_NL_start              : out std_logic;
        OFM_NL_NoC_m_cnt_finished : in std_logic;
        CFG_start                 : out std_logic;
        CFG_finished              : in std_logic;
        L                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        layer_finished            : out std_logic
    );
end SYS_CTR_MAIN_NL;

architecture behavioral of SYS_CTR_MAIN_NL is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_start, s_wait_1, s_wait_2, s_NL, s_finished, s_NoC_ACK, s_OFM_READ, s_CFG, s_layer_done);
    signal state_next, state_reg : state_type;

    -- ************** FSMD SIGNALS **************
    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal NL_cnt_done_next : std_logic; -- signal that is set high only once the whole current layer of the network has been processed by the Nested Loops.
    signal NL_cnt_done_reg  : std_logic;
    signal IFM_NL_flag_tmp  : std_logic; -- allows the IFM NL to be triggered only once, when m = 0.

    ---- External Command Signals to the FSMD
    signal NL_start_tmp : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    signal WB_NL_ready_tmp     : std_logic;
    signal WB_NL_finished_tmp  : std_logic;
    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal OFM_NL_ready_tmp    : std_logic;
    signal OFM_NL_finished_tmp : std_logic;
    ---- External Status Signals to indicate status of the FSMD
    signal NL_ready_tmp    : std_logic;
    signal NL_finished_tmp : std_logic;
    signal layer_finished_tmp : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal rc_next, rc_reg       : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal m_next, m_reg         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal c_next, c_reg         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal layer_reg, layer_next : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- External Control Signals used to control Data Path Operation
    signal M_cap_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal C_cap_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal r_tmp     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal p_tmp     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal L_tmp     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Functional Units Intermediate Signals
    signal rc_out    : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal m_out     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal m_out_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal c_out     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal c_out_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    -- ******************************************

    ---------------- Data Outputs ----------------
    -- Out PORTs "rc", "c" and "m"

    -- SYS_CTR_NL Intermediate Signals
    signal IFM_NL_start_tmp                    : std_logic;
    signal IFM_NL_start_tmp_2                  : std_logic;
    signal WB_NL_start_tmp                     : std_logic;
    signal NoC_ACK_flag_tmp                    : std_logic;
    signal start_flag_next, start_flag_reg     : std_logic; -- these two regs avoid that "NL_cnt_done_next" signal gets set to "1" the first time the conditions 
    signal start_flag_next_2, start_flag_reg_2 : std_logic; -- of "c", "m" and "rc" being 0 are met, allowing "NL_cnt_done_next" to be set to "1" only when it has to.
    signal pass_flag_tmp                       : std_logic;
    signal OFM_NL_start_tmp                    : std_logic;
    signal CFG_start_tmp                       : std_logic;
    ----------------------------------------------

begin

    -- control path : registers
    asmd_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- state register
                state_reg <= s_init;
                -- control signals registers
                NL_cnt_done_reg  <= '0';
                start_flag_reg   <= '0';
                start_flag_reg_2 <= '0';
            else
                -- state register
                state_reg <= state_next;
                -- control signal registers
                NL_cnt_done_reg  <= NL_cnt_done_next;
                start_flag_reg   <= start_flag_next;
                start_flag_reg_2 <= start_flag_next_2;
            end if;
        end if;
    end process;

    -- control path : next state logic
    asmd_ctrl : process (state_reg, NL_start_tmp, WB_NL_finished_tmp, IFM_NL_finished_tmp, WB_NL_ready_tmp, IFM_NL_ready_tmp, NL_cnt_done_reg, IFM_NL_flag_tmp, pass_flag_tmp, OFM_NL_finished, NoC_ACK_flag_tmp, OFM_NL_NoC_m_cnt_finished, CFG_finished, layer_reg, L_tmp)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if NL_start_tmp = '1' then
                    state_next <= s_CFG;
                else
                    state_next <= s_idle;
                end if;
            when s_CFG =>
                if (CFG_finished = '1') then
                    state_next <= s_start;
                else
                    state_next <= s_CFG;
                end if;
            when s_start =>
                if (pass_flag_tmp = '0') then
                    if (IFM_NL_flag_tmp = '1') then
                        state_next <= s_wait_1;
                    else
                        state_next <= s_wait_2;
                    end if;
                else
                    state_next <= s_NoC_ACK;
                end if;
            when s_wait_1 =>
                if (WB_NL_finished_tmp xor IFM_NL_finished_tmp) = '0' then
                    if (WB_NL_finished_tmp and IFM_NL_finished_tmp) = '1' then
                        state_next <= s_NL;
                    else
                        state_next <= s_wait_1;
                    end if;
                else
                    state_next <= s_wait_2;
                end if;
            when s_wait_2 =>
                if (WB_NL_finished_tmp or IFM_NL_finished_tmp) = '1' then
                    state_next <= s_NL;
                else
                    state_next <= s_wait_2;
                end if;
            when s_NL =>
                if (WB_NL_ready_tmp and IFM_NL_ready_tmp) = '0' then
                    state_next <= s_NL;
                else
                    state_next <= s_start;
                end if;
            when s_NoC_ACK =>
                if OFM_NL_finished = '1' then
                    if NoC_ACK_flag_tmp = '1' then
                        if NL_cnt_done_reg = '1' then
                            state_next <= s_OFM_READ;
                        else
                            state_next <= s_start;
                        end if;
                    else
                        state_next <= s_NoC_ACK;
                    end if;
                else
                    state_next <= s_NoC_ACK;
                end if;
            when s_OFM_READ =>
                if (OFM_NL_NoC_m_cnt_finished = '1') then
                    state_next <= s_layer_done;
                else
                    state_next <= s_OFM_READ;
                end if;
            when s_layer_done =>
                if (layer_reg < L_tmp - 1) then
                    state_next <= s_cfg;
                else
                    state_next <= s_finished;
                end if;
            when s_finished =>
                state_next <= s_idle;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    NL_ready_tmp       <= '1' when (state_reg = s_idle) else '0';
    WB_NL_start_tmp    <= '1' when (state_reg = s_start and pass_flag_tmp = '0') else '0';
    IFM_NL_start_tmp_2 <= '1' when (state_reg = s_start and pass_flag_tmp = '0') else '0';
    IFM_NL_start_tmp   <= '1' when (IFM_NL_start_tmp_2 = '1' and IFM_NL_flag_tmp = '1') else '0';
    NL_finished_tmp    <= '1' when (state_reg = s_finished) else '0';
    OFM_NL_start_tmp   <= '1' when (state_reg = s_start and pass_flag_tmp = '1') else '0';
    CFG_start_tmp      <= '1' when (state_reg = s_CFG) else '0';
    layer_finished_tmp <= '1' when (state_reg = s_layer_done) else '0';

    -- data path : data registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                rc_reg    <= 0;
                m_reg     <= 0;
                c_reg     <= 0;
                layer_reg <= 0;
            else
                rc_reg    <= rc_next;
                m_reg     <= m_next;
                c_reg     <= c_next;
                layer_reg <= layer_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    rc_out <= (rc_reg + 1) when (rc_reg < (c_reg + r_tmp - 1)) else c_out;

    m_out_tmp <= (m_reg + p_tmp) when (m_reg < (M_cap_tmp - p_tmp)) else 0;
    m_out     <= m_out_tmp when (rc_reg = (c_reg + r_tmp - 1)) else m_reg;

    c_out_tmp <= (c_reg + r_tmp) when (c_reg < (C_cap_tmp - r_tmp)) else 0;
    c_out     <= c_out_tmp when ((m_reg = (M_cap_tmp - p_tmp)) and (rc_reg = (c_reg + r_tmp - 1))) else c_reg;

    -- data path : status (inputs to control path to modify next state logic)
    start_flag_next <= '0' when (state_reg = s_layer_done) else
        '1' when (CFG_finished = '1') else
        start_flag_reg;

    start_flag_next_2 <= start_flag_reg;

    NL_cnt_done_next <= '1' when (((c_reg = 0) and
        (m_reg = 0) and
        (rc_reg = 0)) and
        (start_flag_reg_2 = '1') and
        (state_reg = s_start)) else
        '0' when state_reg = s_layer_done else
        NL_cnt_done_reg;

    IFM_NL_flag_tmp <= '1' when m_reg = 0 else '0';

    -- data path : mux routing
    data_mux : process (state_reg, rc_reg, m_reg, c_reg, rc_out, m_out, c_out, WB_NL_ready_tmp, IFM_NL_ready_tmp, layer_reg)
    begin
        case state_reg is
            when s_init =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg;
            when s_idle =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg;
            when s_start =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg;
            when s_wait_1 =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg;
            when s_wait_2 =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg;
            when s_NL =>
                if (WB_NL_ready_tmp and IFM_NL_ready_tmp) = '0' then
                    rc_next <= rc_reg;
                    m_next  <= m_reg;
                    c_next  <= c_reg;
                else
                    rc_next <= rc_out;
                    m_next  <= m_out;
                    c_next  <= c_out;
                end if;
                layer_next <= layer_reg;
            when s_NOC_ACK =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg;
            when s_layer_done =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg + 1;
            when s_finished =>
                rc_next   <= rc_reg;
                m_next    <= m_reg;
                c_next    <= c_reg;
                layer_next <= layer_reg;
            when others =>
                rc_next    <= rc_reg;
                m_next     <= m_reg;
                c_next     <= c_reg;
                layer_next <= layer_reg;
        end case;
    end process;

    -- PORT Assignations
    NL_start_tmp        <= NL_start;
    NL_ready            <= NL_ready_tmp;
    NL_finished         <= NL_finished_tmp;
    m                   <= std_logic_vector(to_unsigned(m_reg, m'length));
    c                   <= std_logic_vector(to_unsigned(c_reg, c'length));
    rc                  <= std_logic_vector(to_unsigned(rc_reg, rc'length));
    M_cap_tmp           <= to_integer(unsigned(M_cap));
    C_cap_tmp           <= to_integer(unsigned(C_cap));
    r_tmp               <= to_integer(unsigned(r));
    p_tmp               <= to_integer(unsigned(p));
    NoC_ACK_flag_tmp    <= NoC_ACK_flag;
    IFM_NL_start        <= IFM_NL_start_tmp;
    WB_NL_start         <= WB_NL_start_tmp;
    WB_NL_finished_tmp  <= WB_NL_finished;
    IFM_NL_finished_tmp <= IFM_NL_finished;
    WB_NL_ready_tmp     <= WB_NL_ready;
    IFM_NL_ready_tmp    <= IFM_NL_ready;
    pass_flag_tmp       <= pass_flag;
    OFM_NL_start        <= OFM_NL_start_tmp;
    OFM_NL_finished_tmp <= OFM_NL_finished;
    OFM_NL_ready_tmp    <= OFM_NL_ready;
    CFG_start           <= CFG_start_tmp;
    L_tmp               <= to_integer(unsigned(L));
    layer_finished      <= layer_finished_tmp;

end architecture;
