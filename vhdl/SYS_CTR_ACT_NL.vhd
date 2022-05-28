library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_ACT_NL is
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
end SYS_CTR_ACT_NL;

architecture behavioral of SYS_CTR_ACT_NL is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_ACT_NL, s_finished);
    signal state_next, state_reg: state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal ACT_NL_cnt_done_int : std_logic;

    ---- External Command Signals to the FSMD
    signal ACT_NL_start_int : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal ACT_NL_ready_int : std_logic;
    signal ACT_NL_finished_int : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal h_p_next, h_p_reg : natural range 0 to 127;
    signal w_p_next, w_p_reg : natural range 0 to 127;

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal HW_p_int : natural range 0 to 127;

    ---- Functional Units Intermediate Signals
    signal h_p_out : natural range 0 to 127;
    signal w_p_out : natural range 0 to 127;
    signal w_p_out_tmp : natural range 0 to 127;

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
    asmd_ctrl : process(state_reg, ACT_NL_start_int, ACT_NL_cnt_done_int)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if ACT_NL_start_int = '1' then
                    state_next <= s_ACT_NL;
                else
                    state_next <= s_idle;
                end if;
            when s_ACT_NL =>
                if ACT_NL_cnt_done_int = '1' then
                    state_next <= s_finished;
                else
                    state_next <= s_ACT_NL;
                end if;
            when s_finished =>
                state_next <= s_idle;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    ACT_NL_ready_int <= '1' when state_reg = s_idle else '0';
    ACT_NL_finished_int <= '1' when state_reg = s_finished else '0';

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
    h_p_out <= h_p_reg + 1 when h_p_reg < (HW_p_int - 1) else 0;

    w_p_out_tmp <= w_p_reg + 1 when (w_p_reg < (HW_p_int - 1)) else 0;
    w_p_out <= w_p_out_tmp when h_p_reg = (HW_p_int - 1) else w_p_reg;

    -- data path : status (inputs to control path to modify next state logic)
    ACT_NL_cnt_done_int <= '1' when ((h_p_reg = (HW_p_int - 1)) AND (w_p_reg = (HW_p_int - 1))) else '0';

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
            when s_ACT_NL =>
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
    ACT_NL_start_int <= ACT_NL_start;
    ACT_NL_ready <= ACT_NL_ready_int;
    ACT_NL_finished <= ACT_NL_finished_int;
    h_p <= std_logic_vector(to_unsigned(h_p_reg, h_p'length));
    w_p <= std_logic_vector(to_unsigned(w_p_reg, w_p'length));
    HW_p_int <= to_integer(unsigned(HW_p));

end architecture;