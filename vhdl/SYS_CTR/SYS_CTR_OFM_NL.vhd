library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_OFM_NL is
    port (
        clk                       : in std_logic;
        reset                     : in std_logic;
        OFM_NL_start              : in std_logic;
        OFM_NL_ready              : out std_logic;
        OFM_NL_finished           : out std_logic;
        OFM_NL_busy               : out std_logic;
        C_cap                     : in std_logic_vector (7 downto 0);
        M_cap                     : in std_logic_vector (7 downto 0);
        EF                        : in std_logic_vector (7 downto 0);
        r                         : in std_logic_vector (7 downto 0);
        p                         : in std_logic_vector (7 downto 0);
        NoC_c                     : out std_logic_vector (7 downto 0);
        NoC_pm                    : out std_logic_vector (7 downto 0);
        NoC_f                     : out std_logic_vector (7 downto 0);
        NoC_e                     : out std_logic_vector (7 downto 0);
        shift_PISO                : in std_logic;
        OFM_NL_cnt_finished       : out std_logic;
        OFM_NL_NoC_m_cnt_finished : out std_logic
    );
end SYS_CTR_OFM_NL;

architecture behavioral of SYS_CTR_OFM_NL is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_OFM_NL);
    signal state_next, state_reg : state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    -- ..

    ---- External Command Signals to the FSMD
    signal OFM_NL_start_tmp : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal OFM_NL_ready_tmp    : std_logic;
    signal OFM_NL_finished_tmp : std_logic;
    signal OFM_NL_busy_tmp     : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal NoC_c_next, NoC_c_reg   : natural range 0 to 255;
    signal NoC_m_next, NoC_m_reg   : natural range 0 to 255;
    signal NoC_pm_next, NoC_pm_reg : natural range 0 to 255;
    signal NoC_f_next, NoC_f_reg   : natural range 0 to 255;
    signal NoC_e_next, NoC_e_reg   : natural range 0 to 255;

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal C_cap_tmp      : natural range 0 to 255;
    signal M_cap_tmp      : natural range 0 to 255;
    signal EF_tmp         : natural range 0 to 255;
    signal r_tmp          : natural range 0 to 255;
    signal p_tmp          : natural range 0 to 255;
    signal shift_PISO_tmp : std_logic;

    ---- Functional Units Intermediate Signals
    signal NoC_c_out, NoC_c_tmp   : natural range 0 to 255;
    signal NoC_m_out, NoC_m_tmp   : natural range 0 to 255;
    signal NoC_pm_out, NoC_pm_tmp : natural range 0 to 255;
    signal NoC_f_out, NoC_f_tmp   : natural range 0 to 255;
    signal NoC_e_out, NoC_e_tmp   : natural range 0 to 255;

    ---- Data Outputs
    signal OFM_NL_cnt_finished_tmp       : std_logic;
    signal OFM_NL_NoC_m_cnt_finished_tmp : std_logic;

begin

    -- control path : state register
    asmd_reg : process (clk, reset)
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
    asmd_ctrl : process (state_reg, OFM_NL_start_tmp, OFM_NL_finished_tmp)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if OFM_NL_start_tmp = '1' then
                    state_next <= s_OFM_NL;
                else
                    state_next <= s_idle;
                end if;
            when s_OFM_NL =>
                if OFM_NL_finished_tmp = '1' then
                    state_next <= s_idle;
                else
                    state_next <= s_OFM_NL;
                end if;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    OFM_NL_ready_tmp <= '1' when state_reg = s_idle else '0';
    OFM_NL_busy_tmp  <= '1' when state_reg = s_OFM_NL else '0';

    -- data path : data registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                NoC_c_reg  <= 0;
                NoC_m_reg  <= 0;
                NoC_pm_reg <= 0;
                NoC_f_reg  <= 0;
                NoC_e_reg  <= 0;
            else
                NoC_c_reg  <= NoC_c_next;
                NoC_m_reg  <= NoC_m_next;
                NoC_pm_reg <= NoC_pm_next;
                NoC_f_reg  <= NoC_f_next;
                NoC_e_reg  <= NoC_e_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    NoC_e_tmp <= NoC_e_reg + 1 when (NoC_e_reg < (EF_tmp - 1)) else 0;
    NoC_e_out <= NoC_e_tmp when (shift_PISO_tmp = '1') else NoC_e_reg;

    NoC_f_tmp <= NoC_f_reg + 1 when (NoC_f_reg < (EF_tmp - 1)) else 0;
    NoC_f_out <= NoC_f_tmp when (NoC_e_reg = (EF_tmp - 1)) else NoC_f_reg;

    NoC_pm_tmp <= NoC_pm_reg + 1 when (NoC_pm_reg < (NoC_m_reg + p_tmp - 1)) else NoC_m_out;
    NoC_pm_out <= NoC_pm_tmp when (NoC_f_reg = (EF_tmp - 1)) and (NoC_e_reg = (EF_tmp - 1)) else NoC_pm_reg;

    NoC_m_tmp <= NoC_m_reg + p_tmp when (NoC_m_reg < (M_cap_tmp - p_tmp)) else 0;
    NoC_m_out <= NoC_m_tmp when ((NoC_pm_reg = (NoC_m_reg + p_tmp - 1)) and (NoC_f_reg = (EF_tmp - 1)) and (NoC_e_reg = (EF_tmp - 1))) else NoC_m_reg;

    NoC_c_tmp <= NoC_c_reg + r_tmp when (NoC_c_reg < (C_cap_tmp - r_tmp)) else 0;
    NoC_c_out <= NoC_c_tmp when ((NoC_m_reg = (M_cap_tmp - p_tmp)) and (NoC_pm_reg = (NoC_m_reg + p_tmp - 1)) and (NoC_f_reg = (EF_tmp - 1)) and (NoC_e_reg = (EF_tmp - 1))) else NoC_c_reg;

    -- data path : status (inputs to control path to modify next state logic)
    OFM_NL_finished_tmp <= '1' when ((NoC_pm_reg = (NoC_m_reg + p_tmp - 1)) and (NoC_f_reg = (EF_tmp - 1)) and (NoC_e_reg = (EF_tmp - 1))) else '0';

    -- data path : output to control OFM_SRAM (does not affect OFM_NL FSMD)
    OFM_NL_cnt_finished_tmp       <= '1' when ((NoC_c_reg = (C_cap_tmp - r_tmp)) and (NoC_pm_reg = (M_cap_tmp - 1)) and (NoC_f_reg = (EF_tmp - 1)) and (NoC_e_reg = (EF_tmp - 1))) else '0';
    OFM_NL_NoC_m_cnt_finished_tmp <= '1' when ((NoC_pm_reg = (M_cap_tmp - 1)) and (NoC_f_reg = (EF_tmp - 1)) and (NoC_e_reg = (EF_tmp - 1))) else '0';

    -- data path : mux routing
    data_mux : process (state_reg, NoC_c_reg, NoC_m_reg, NoC_f_reg, NoC_e_reg, NoC_c_next, NoC_m_next, NoC_f_next, NoC_e_next, NoC_c_out, NoC_m_out, NoC_f_out, NoC_e_out)
    begin
        case state_reg is
            when s_init =>
                NoC_c_next  <= NoC_c_reg;
                NoC_m_next  <= NoC_m_reg;
                NoC_pm_next <= NoC_pm_reg;
                NoC_f_next  <= NoC_f_reg;
                NoC_e_next  <= NoC_e_reg;
            when s_idle =>
                NoC_c_next  <= NoC_c_reg;
                NoC_m_next  <= NoC_m_reg;
                NoC_pm_next <= NoC_pm_reg;
                NoC_f_next  <= NoC_f_reg;
                NoC_e_next  <= NoC_e_reg;
            when s_OFM_NL =>
                NoC_c_next  <= NoC_c_out;
                NoC_m_next  <= NoC_m_out;
                NoC_pm_next <= NoC_pm_out;
                NoC_f_next  <= NoC_f_out;
                NoC_e_next  <= NoC_e_out;
            when others =>
                NoC_c_next  <= NoC_c_reg;
                NoC_m_next  <= NoC_m_reg;
                NoC_pm_next <= NoC_pm_reg;
                NoC_f_next  <= NoC_f_reg;
                NoC_e_next  <= NoC_e_reg;
        end case;
    end process;

    -- PORT Assignations
    OFM_NL_start_tmp          <= OFM_NL_start;
    OFM_NL_ready              <= OFM_NL_ready_tmp;
    OFM_NL_finished           <= OFM_NL_finished_tmp;
    OFM_NL_busy               <= OFM_NL_busy_tmp;
    NoC_c                     <= std_logic_vector(to_unsigned(NoC_c_reg, NoC_c'length));
    NoC_pm                    <= std_logic_vector(to_unsigned(NoC_pm_reg, NoC_pm'length));
    NoC_f                     <= std_logic_vector(to_unsigned(NoC_f_reg, NoC_f'length));
    NoC_e                     <= std_logic_vector(to_unsigned(NoC_e_reg, NoC_e'length));
    C_cap_tmp                 <= to_integer(unsigned(C_cap));
    M_cap_tmp                 <= to_integer(unsigned(M_cap));
    EF_tmp                    <= to_integer(unsigned(EF));
    r_tmp                     <= to_integer(unsigned(r));
    p_tmp                     <= to_integer(unsigned(p));
    shift_PISO_tmp            <= shift_PISO;
    OFM_NL_cnt_finished       <= OFM_NL_cnt_finished_tmp;
    OFM_NL_NoC_m_cnt_finished <= OFM_NL_NoC_m_cnt_finished_tmp;

end architecture;