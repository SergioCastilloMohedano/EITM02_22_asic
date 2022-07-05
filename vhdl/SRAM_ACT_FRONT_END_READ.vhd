-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SRAM_ACT_FRONT_END_READ.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-06-25
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : Activations SRAM Front-End Read Interface
-------------------------------------------------------------------------------------------------------
-- Input Signals  :
--         * clk: clock
--         * reset: synchronous, active high.
--         * ...
-- Output Signals :
--         * ...
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SRAM_ACT_FRONT_END_READ is
    port (
        h_p : in std_logic_vector (7 downto 0);
        w_p : in std_logic_vector (7 downto 0);
        HW : in std_logic_vector (7 downto 0);
        ACT_NL_ready : in std_logic; -- Reads SRAM exactly on those moments in which this signal is '0', when NL is not idle.
        ACT_NL_finished : in std_logic; -- ACT NL has finished. Do not read SRAM anymore.
        act_out : out std_logic_vector (7 downto 0);
        -- Back-End (BE) Interface Ports
        act_BE : in std_logic_vector (7 downto 0);
        RE_BE : out std_logic   -- Read Enable, active high
    );
end SRAM_ACT_FRONT_END_READ;

architecture dataflow of SRAM_ACT_FRONT_END_READ is

    signal ACT_NL_ready_int : std_logic;
    signal ACT_NL_finished_int : std_logic;

    signal h_p_int : natural range 0 to 127;
    signal w_p_int : natural range 0 to 127;
    signal HW_int : natural range 0 to 127;
    signal p : natural range 0 to 127; -- p = padding = (-1+RS)/2. since RS = 3 is fixed for our HW accelerator, p = 1 always.


    signal h_ctrl : std_logic;
    signal w_ctrl : std_logic;

    signal act_out_int : std_logic_vector (7 downto 0);
    signal act_BE_int : std_logic_vector (7 downto 0);

    signal RE_BE_int : std_logic;

begin

    p <= 1; -- padding = (-1 + RS)/2. since RS = 3 is fixed for our HW accelerator, p = 1 always.

    h_ctrl <= '1' when ((h_p_int < p) OR (h_p_int > (HW_int - 1 + p))) else '0';
    w_ctrl <= '1' when ((w_p_int < p) OR (w_p_int > (HW_int - 1 + p))) else '0';

    act_out_int <= act_BE_int;
    RE_BE_int <= '1' when (((NOT(h_ctrl OR w_ctrl)) AND (ACT_NL_ready_int NOR ACT_NL_finished_int)) = '1') else '0';

    -- PORT Assignations
    h_p_int <= to_integer(unsigned(h_p));
    w_p_int <= to_integer(unsigned(w_p));
    HW_int <= to_integer(unsigned(HW));
    ACT_NL_ready_int <= ACT_NL_ready;
    ACT_NL_finished_int <= ACT_NL_finished;
    act_BE_int <= act_BE;
    act_out <= act_out_int;
    RE_BE <= RE_BE_int;

end architecture;