-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SRAM_WB_FRONT_END_READ.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-07-04
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : Weights & Biases SRAM Front-End Read Interface
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

entity SRAM_WB_FRONT_END_READ is
    port (
        WB_NL_ready : in std_logic; -- Reads SRAM exactly on those moments in which this signal is '0', when NL is not idle.
        WB_NL_finished : in std_logic; -- WB NL has finished. Do not read SRAM anymore.
        wb_out : out std_logic_vector (15 downto 0);
        -- Back-End (BE) Interface Ports
        wb_BE : in std_logic_vector (15 downto 0);
        RE_BE : out std_logic   -- Read Enable, active high
    );
end SRAM_WB_FRONT_END_READ;

architecture dataflow of SRAM_WB_FRONT_END_READ is

    signal WB_NL_ready_int : std_logic;
    signal WB_NL_finished_int : std_logic;
    signal wb_out_int : std_logic_vector (15 downto 0);
    signal wb_BE_int : std_logic_vector (15 downto 0);
    signal RE_BE_int : std_logic;

begin

    wb_out_int <= wb_BE_int;
    RE_BE_int <= '1' when ((WB_NL_ready_int NOR WB_NL_finished_int) = '1') else '0';

    -- PORT Assignations
    WB_NL_ready_int <= WB_NL_ready;
    WB_NL_finished_int <= WB_NL_finished;
    wb_BE_int <= wb_BE;
    wb_out <= wb_out_int;
    RE_BE <= RE_BE_int;

end architecture;