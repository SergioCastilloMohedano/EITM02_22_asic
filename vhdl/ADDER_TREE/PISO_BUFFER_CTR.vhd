library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity PISO_BUFFER_CTR is
    generic (
        -- HW Parameters, at synthesis time.
        X : natural := X_PKG
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        r  : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- From Adder Tree
        PISO_Buffer_start_1 : in std_logic;
        PISO_Buffer_start_2 : in std_logic;
        PISO_Buffer_start_4 : in std_logic;

        -- To PISO Buffer
        shift       : out std_logic;
        parallel_in : out std_logic;
        j           : out natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

        -- To Sys Controller
        buffer_empty : out std_logic
    );
end PISO_BUFFER_CTR;

architecture behavioral of PISO_BUFFER_CTR is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_parallel, s_serial, s_empty);
    signal state_next, state_reg : state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal j_cnt_done      : std_logic;
    signal buffer_cnt_done : std_logic;
    signal buffer_empty_tmp    : std_logic;

    ---- External Command Signals to the FSMD
    signal r_tmp                 : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal EF_tmp                : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal PISO_Buffer_start_tmp : std_logic; -- triggers FSMD.

    -------- OUTPUTS --------
    ----- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal parallel_in_tmp : std_logic;
    signal shift_tmp       : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal j_cnt_reg, j_cnt_next           : natural;
    signal buffer_cnt_reg, buffer_cnt_next : natural range 0 to (X_PKG - 1);
    signal empty_cnt_reg, empty_cnt_next   : natural range 0 to X_PKG;

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    ---- Functional Units Intermediate Signals
    signal j_cnt_out      : natural;
    signal buffer_cnt_out : natural range 0 to (X_PKG - 1);
    signal empty_cnt_out : natural range 0 to X_PKG;

    ---- Data Outputs
    signal j_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    -- Intermediate Signals
    -- Other Signals

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
    asmd_ctrl : process (state_reg, PISO_Buffer_start_tmp, j_cnt_done, buffer_cnt_done, buffer_empty_tmp)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;

            when s_idle =>
                if (PISO_Buffer_start_tmp = '1') then
                    state_next <= s_parallel;
                else
                    state_next <= s_idle;
                end if;

            when s_parallel =>
                if (j_cnt_done = '1') then
                    state_next <= s_serial;
                else
                    state_next <= s_idle;
                end if;

            when s_serial =>
                if (buffer_cnt_done = '1') then
                    if (PISO_Buffer_start_tmp = '1') then
                        state_next <= s_parallel;
                    else
                        if (buffer_empty_tmp = '0') then
                            state_next <= s_empty;
                        else
                            state_next <= s_idle;
                        end if;
                    end if;
                else
                    state_next <= s_serial;
                end if;

            when s_empty =>
                if (buffer_empty_tmp = '1') then
                    state_next <= s_idle;
                else
                    state_next <= s_empty;
                end if;

            when others =>
                state_next <= s_init;

        end case;
    end process;

    -- control path : output logic
    parallel_in_tmp <= '1' when state_reg = s_parallel else '0';
    shift_tmp       <= '1' when (state_reg = s_serial) or (state_reg = s_empty) else '0';

    -- data path : data registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                j_cnt_reg      <= 0;
                buffer_cnt_reg <= 0;
                empty_cnt_reg  <= 0;
            else
                j_cnt_reg      <= j_cnt_next;
                buffer_cnt_reg <= buffer_cnt_next;
                empty_cnt_reg  <= empty_cnt_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    j_cnt_out <= j_cnt_reg + 1 when (j_cnt_reg < (r_tmp - 1)) else j_cnt_reg;
    j_tmp     <= (j_cnt_reg + 1) when (state_reg = s_parallel) else 0; -- output

    buffer_cnt_out <= buffer_cnt_reg + 1 when (buffer_cnt_reg < (EF_tmp - 1)) else 0;

    empty_cnt_out <= empty_cnt_reg - 1          when (state_reg = s_serial) or (state_reg = s_empty) else
                     empty_cnt_reg + EF_tmp     when (state_reg = s_parallel) else
                     empty_cnt_reg;

    -- data path : status (inputs to control path to modify next state logic)
    j_cnt_done      <= '0' when (state_reg = s_idle )else
                       '1' when (j_cnt_reg = (r_tmp - 1)) else
                       '0';
    buffer_cnt_done <= '1' when (buffer_cnt_reg = (EF_tmp - 1)) else '0'; -- Buffer has shifted E values and a new set of E values can be added.

    buffer_empty_tmp <= '1' when (empty_cnt_reg = 1) else '0'; -- Buffer is empty.

    -- data path : mux routing and logic
    data_mux : process (state_reg, j_cnt_reg, buffer_cnt_reg, j_cnt_out, buffer_cnt_out, empty_cnt_reg, empty_cnt_out)
    begin
        case state_reg is
            when s_init =>
                j_cnt_next      <= j_cnt_reg;
                buffer_cnt_next <= buffer_cnt_reg;
                empty_cnt_next  <= empty_cnt_reg;

            when s_idle =>
                j_cnt_next      <= j_cnt_reg;
                buffer_cnt_next <= buffer_cnt_reg;
                empty_cnt_next  <= empty_cnt_reg;

            when s_parallel =>
                j_cnt_next      <= j_cnt_out;
                buffer_cnt_next <= buffer_cnt_reg;
                empty_cnt_next  <= empty_cnt_out;

            when s_serial =>
                j_cnt_next      <= j_cnt_reg;
                buffer_cnt_next <= buffer_cnt_out;
                empty_cnt_next  <= empty_cnt_out;

            when s_empty =>
                j_cnt_next      <= 0;
                buffer_cnt_next <= buffer_cnt_reg;
                empty_cnt_next  <= empty_cnt_out;

            when others =>
                j_cnt_next      <= j_cnt_reg;
                buffer_cnt_next <= buffer_cnt_reg;
                empty_cnt_next  <= empty_cnt_reg;

        end case;
    end process;

    -- PORT Assignations
    with r_tmp select PISO_Buffer_start_tmp <=
        PISO_Buffer_start_1 when 1,
        PISO_Buffer_start_2 when 2,
        PISO_Buffer_start_4 when 4,
        '0' when others;

    r_tmp        <= to_integer(unsigned(r));
    EF_tmp       <= to_integer(unsigned(EF));
    parallel_in  <= parallel_in_tmp;
    shift        <= shift_tmp;
    j            <= j_tmp;
    buffer_empty <= buffer_empty_tmp;

end architecture;
