library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SYS_CTR_IFM_NL is
    port (
        clk : in std_logic;
        reset : in std_logic;
        IFM_NL_start : in std_logic;
        IFM_NL_ready : out std_logic;
        IFM_NL_finished : out std_logic;
        IFM_NL_busy : out std_logic;
        HW_p : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        h_p : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        w_p : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
    );
end SYS_CTR_IFM_NL;

architecture behavioral of SYS_CTR_IFM_NL is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_IFM_NL, s_finished);
    signal state_next, state_reg: state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal IFM_NL_cnt_done_tmp : std_logic;

    ---- External Command Signals to the FSMD
    signal IFM_NL_start_tmp : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal IFM_NL_ready_tmp : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal IFM_NL_busy_tmp : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal h_p_next, h_p_reg : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal w_p_next, w_p_reg : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal HW_p_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Functional Units Intermediate Signals
    signal h_p_out : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal w_p_out : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal w_p_out_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Data Outputs
    -- Out PORTs "h_p" and "w_p"

begin

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
    asmd_ctrl : process(state_reg, IFM_NL_start_tmp , IFM_NL_cnt_done_tmp )
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if IFM_NL_start_tmp = '1' then
                    state_next <= s_IFM_NL;
                else
                    state_next <= s_idle;
                end if;
            when s_IFM_NL =>
                if IFM_NL_cnt_done_tmp = '1' then
                    state_next <= s_finished;
                else
                    state_next <= s_IFM_NL;
                end if;
            when s_finished =>
                state_next <= s_idle;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    IFM_NL_ready_tmp <= '1' when state_reg = s_idle else '0';
    IFM_NL_finished_tmp <= '1' when state_reg = s_finished else '0';
    IFM_NL_busy_tmp <= '1' when state_reg = s_IFM_NL else '0';

    -- data path : data registers
    data_reg : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                h_p_reg <= 0;
                w_p_reg <= 0;
            else
                h_p_reg <= h_p_next;
                w_p_reg <= w_p_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    h_p_out <= h_p_reg + 1 when h_p_reg < (HW_p_tmp - 1) else 0;

    w_p_out_tmp <= w_p_reg + 1 when (w_p_reg < (HW_p_tmp - 1)) else 0;
    w_p_out <= w_p_out_tmp when h_p_reg = (HW_p_tmp - 1) else w_p_reg;

    -- data path : status (inputs to control path to modify next state logic)
    IFM_NL_cnt_done_tmp <= '1' when ((h_p_reg = (HW_p_tmp - 1)) AND (w_p_reg = (HW_p_tmp - 1))) else '0';

    -- data path : mux routing
    data_mux : process(state_reg, h_p_reg, w_p_reg, h_p_out, w_p_out)
    begin
        case state_reg is
            when s_init =>
                h_p_next <= h_p_reg;
                w_p_next <= w_p_reg;
            when s_idle =>
                h_p_next <= h_p_reg;
                w_p_next <= w_p_reg;
            when s_IFM_NL =>
                h_p_next <= h_p_out;
                w_p_next <= w_p_out;
            when s_finished =>
                h_p_next <= h_p_reg;
                w_p_next <= w_p_reg;
            when others =>
                h_p_next <= h_p_reg;
                w_p_next <= w_p_reg;
    end case;
    end process;

    -- PORT Assignations
    IFM_NL_start_tmp <= IFM_NL_start;
    IFM_NL_ready <= IFM_NL_ready_tmp ;
    IFM_NL_finished <= IFM_NL_finished_tmp ;
    IFM_NL_busy <= IFM_NL_busy_tmp ;
    h_p <= std_logic_vector(to_unsigned(h_p_reg, h_p'length));
    w_p <= std_logic_vector(to_unsigned(w_p_reg, w_p'length));
    HW_p_tmp <= to_integer(unsigned(HW_p));

end architecture;