-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SYS_CTR_IFM_NL.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-05-15
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : This block triggers the Nested Loop for sweeping along all the Input Feature Map.
--                  "h'" and "w'" increase from 0 to "HW' - 1" column-wise.
--
--                  for w’ = 0 to w’ = W’ – 1, w’++
--                      for h’ = 0 to h’ = H’ – 1, h’++
--                          [h’, w’]
--                      end for
--                  end for
--
--                  Notice that:
--                  HW' = HW + 2*padding => [HW = EF] => HW + 2*(-1 + RS)/2 => [RS = 3] => HW + 2
--                  Parameters are sent including padding which, due to a fixed kernel size of 3x3, is
--                  always 1 pixel.
-------------------------------------------------------------------------------------------------------
-- Input Signals  :
--         * clk: clock
--         * reset: synchronous, active high.
--         * IFM_NL_start: triggers the FSM that outputs all the parameters of a speficic layer within
--       the network.
--         * HW_p: height/width of the Input Feature Map, including padding.
-- Output Signals :
--         * IFM_NL_ready: active high, set when the FSM is in its idle state. It means the FSM is
--       ready to be triggered.
--         * IFM_NL_finished: active high, set for 1 clock cycle when the Nested Loop has finished.
--         * h_p (r'): parameter that represents pixel's row, including padding.
--         * w_p: parameter that represents pixel's column, including padding.
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_IFM_NL is
    port (
        clk : in std_logic;
        reset : in std_logic;
        IFM_NL_start : in std_logic;
        IFM_NL_ready : out std_logic;
        IFM_NL_finished : out std_logic;
        HW_p : in std_logic_vector (7 downto 0);
        h_p : out std_logic_vector (7 downto 0);
        w_p : out std_logic_vector (7 downto 0)
    );
end SYS_CTR_IFM_NL;

architecture behavioral of SYS_CTR_IFM_NL is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_IFM_NL, s_finished);
    signal state_next, state_reg: state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal IFM_NL_cnt_done_int : std_logic;

    ---- External Command Signals to the FSMD
    signal IFM_NL_start_int : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal IFM_NL_ready_int : std_logic;
    signal IFM_NL_finished_int : std_logic;

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
    asmd_ctrl : process(state_reg, IFM_NL_start_int, IFM_NL_cnt_done_int)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if IFM_NL_start_int = '1' then
                    state_next <= s_IFM_NL;
                else
                    state_next <= s_idle;
                end if;
            when s_IFM_NL =>
                if IFM_NL_cnt_done_int = '1' then
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
    IFM_NL_ready_int <= '1' when state_reg = s_idle else '0';
    IFM_NL_finished_int <= '1' when state_reg = s_finished else '0';

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
    IFM_NL_cnt_done_int <= '1' when ((h_p_reg = (HW_p_int - 1)) AND (w_p_reg = (HW_p_int - 1))) else '0';

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
    IFM_NL_start_int <= IFM_NL_start;
    IFM_NL_ready <= IFM_NL_ready_int;
    IFM_NL_finished <= IFM_NL_finished_int;
    h_p <= std_logic_vector(to_unsigned(h_p_reg, h_p'length));
    w_p <= std_logic_vector(to_unsigned(w_p_reg, w_p'length));
    HW_p_int <= to_integer(unsigned(HW_p));

end architecture;