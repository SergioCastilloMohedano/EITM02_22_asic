-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SYS_CTR_WB_NL.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-05-12
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : This block triggers the Nested Loop for sweeping along all the weights & biases.
--                  "r" and "s" increase from 0 to "RS - 1". "pm" weight output channels are increased
--                  as well from 0 to "m + p - 1". Values are increased row-wise (s) and
--                  channel-wise (pm):
--
--                  for r’ = 0 to r’ = R – 1, r’++
--                      for pm = 0 to pm = m + p – 1, pm++
--                          for s = 0 to s = S – 1, s++
--                              [s, pm and r_p]
--                          end for
--                      end for
--                  end for
--
--                  r’ as to differentiate it from unrolling factor ‘r’
-------------------------------------------------------------------------------------------------------
-- Input Signals  :
--         * clk: clock
--         * reset: synchronous, active high.
--         * WB_NL_start: triggers the FSM that outputs all the parameters of a speficic layer within
--       the network.
--         * RS: height/width of a kernel of weights.
--         * p: number of 3D weights processed by a PE Set.
--         * m: current output feature map being read, it increases in batches of "p" from "0" to
--       "M - p".
-- Output Signals :
--         * WB_NL_ready: active high, set when the FSM is in its idle state. It means the FSM is
--       ready to be triggered.
--         * WB_NL_finished: active high, set for 1 clock cycle when the Nested Loop has finished.
--         * r_p (r'): parameter that represents weight's row.
--         * pm: parameter that represents weight's channel.
--         * s: parameter that represents weight's column.
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SYS_CTR_WB_NL is
    port (
        clk : in std_logic;
        reset : in std_logic;
        WB_NL_start : in std_logic;
        WB_NL_ready : out std_logic;
        WB_NL_finished : out std_logic;
        WB_NL_busy : out std_logic;
        RS : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        p : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        m : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r_p : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        pm : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        s : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
    );
end SYS_CTR_WB_NL;

architecture behavioral of SYS_CTR_WB_NL is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_WB_NL, s_finished);
    signal state_next, state_reg: state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal WB_NL_cnt_done_tmp : std_logic;

    ---- External Command Signals to the FSMD
    signal WB_NL_start_tmp : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal WB_NL_ready_tmp : std_logic;
    signal WB_NL_finished_tmp : std_logic;
    signal WB_NL_busy_tmp : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal r_p_next, r_p_reg : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal pm_next, pm_reg : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal s_next, s_reg : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal RS_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal p_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal m_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Functional Units Intermediate Signals
    signal s_out : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal pm_out : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal pm_out_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal r_p_out : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal r_p_out_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Data Outputs
    -- Out PORTs "r_p", "s" and "pm"

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
    asmd_ctrl : process(state_reg, WB_NL_start_tmp , WB_NL_cnt_done_tmp )
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if WB_NL_start_tmp = '1' then
                    state_next <= s_WB_NL;
                else
                    state_next <= s_idle;
                end if;
            when s_WB_NL =>
                if WB_NL_cnt_done_tmp = '1' then
                    state_next <= s_finished;
                else
                    state_next <= s_WB_NL;
                end if;
            when s_finished =>
                state_next <= s_idle;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    WB_NL_ready_tmp <= '1' when state_reg = s_idle else '0';
    WB_NL_finished_tmp <= '1' when state_reg = s_finished else '0';
    WB_NL_busy_tmp <= '1' when state_reg = s_WB_NL else '0';

    -- data path : data registers
    data_reg : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                r_p_reg <= 0;
                pm_reg <= 0;
                s_reg <= 0;
            else
                r_p_reg <= r_p_next;
                pm_reg <= pm_next;
                s_reg <= s_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    s_out <= s_reg + 1 when s_reg < (RS_tmp - 1) else 0;

    pm_out_tmp <= pm_reg + 1 when (pm_reg < (m_tmp + p_tmp - 1)) else m_tmp ;
    pm_out <= pm_out_tmp when s_reg = (RS_tmp - 1) else pm_reg;

    r_p_out_tmp <= r_p_reg + 1 when r_p_reg < (RS_tmp - 1) else 0;
    r_p_out <= r_p_out_tmp when ((pm_reg = (m_tmp + p_tmp - 1)) AND (s_reg = (RS_tmp - 1))) else r_p_reg;

    -- data path : status (inputs to control path to modify next state logic)
    WB_NL_cnt_done_tmp <= '1' when ((s_reg = (RS_tmp - 1)) AND (pm_reg = (m_tmp + p_tmp - 1)) AND (r_p_reg = (RS_tmp - 1))) else '0';

    -- data path : mux routing
    data_mux : process(state_reg, s_reg, pm_reg, r_p_reg, s_out, pm_out, r_p_out, m_tmp )
    begin
        case state_reg is
            when s_init =>
                s_next <= s_reg;
                pm_next <= pm_reg;
                r_p_next <= r_p_reg;
            when s_idle =>
                s_next <= s_reg;
                pm_next <= m_tmp ;
                r_p_next <= r_p_reg;
            when s_WB_NL =>
                s_next <= s_out;
                pm_next <= pm_out;
                r_p_next <= r_p_out;
            when s_finished =>
                s_next <= s_reg;
                pm_next <= pm_reg;
                r_p_next <= r_p_reg;
            when others =>
                s_next <= s_reg;
                pm_next <= pm_reg;
                r_p_next <= r_p_reg;
        end case;
    end process;

    -- PORT Assignations
    WB_NL_start_tmp <= WB_NL_start;
    WB_NL_ready <= WB_NL_ready_tmp ;
    WB_NL_finished <= WB_NL_finished_tmp ;
    WB_NL_busy <= WB_NL_busy_tmp ;
    r_p <= std_logic_vector(to_unsigned(r_p_reg, r_p'length));
    pm <= std_logic_vector(to_unsigned(pm_reg, pm'length));
    s <= std_logic_vector(to_unsigned(s_reg, s'length));
    RS_tmp <= to_integer(unsigned(RS));
    p_tmp <= to_integer(unsigned(p));
    m_tmp <= to_integer(unsigned(m));

end architecture;