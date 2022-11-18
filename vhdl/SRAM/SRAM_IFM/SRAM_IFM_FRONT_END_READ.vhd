-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SRAM_IFM_FRONT_END_READ.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-06-25
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : Input Features Map SRAM Front-End Read Interface
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
use work.thesis_pkg.all;

entity SRAM_IFM_FRONT_END_READ is
    port (
        h_p             : in std_logic_vector (7 downto 0);
        w_p             : in std_logic_vector (7 downto 0);
        HW              : in std_logic_vector (7 downto 0);
        RS              : in std_logic_vector (7 downto 0);
        IFM_NL_ready    : in std_logic; -- Reads SRAM exactly on those moments in which this signal is '0', when NL is not idle.
        IFM_NL_finished : in std_logic; -- IFM NL has finished. Do not read SRAM anymore.
        ifm_out         : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        -- Back-End (BE) Interface Ports
        ifm_BE_r : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        RE_BE    : out std_logic -- Read Enable, active high
    );
end SRAM_IFM_FRONT_END_READ;

architecture dataflow of SRAM_IFM_FRONT_END_READ is

    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;

    signal h_p_tmp : natural range 0 to 255;
    signal w_p_tmp : natural range 0 to 255;
    signal HW_tmp  : natural range 0 to 255;
    signal p       : natural range 0 to 255; -- p = padding = (-1+RS)/2.
    signal h_ctrl  : std_logic;
    signal w_ctrl  : std_logic;

    signal ifm_out_tmp  : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal ifm_BE_r_tmp : std_logic_vector (COMP_BITWIDTH - 1 downto 0);

    signal RE_BE_tmp : std_logic;

begin

    p      <= to_integer(shift_right((unsigned(RS) - to_unsigned(1, 8)), 1)); -- padding = (-1 + RS)/2
    h_ctrl <= '1' when ((h_p_tmp < p) or (h_p_tmp > (HW_tmp - 1 + p))) else '0';
    w_ctrl <= '1' when ((w_p_tmp < p) or (w_p_tmp > (HW_tmp - 1 + p))) else '0';

    ifm_out_tmp <= ifm_BE_r_tmp;
    RE_BE_tmp   <= '1' when (((not(h_ctrl or w_ctrl)) and (IFM_NL_ready_tmp nor IFM_NL_finished_tmp)) = '1') else '0';

    -- PORT Assignations
    h_p_tmp             <= to_integer(unsigned(h_p));
    w_p_tmp             <= to_integer(unsigned(w_p));
    HW_tmp              <= to_integer(unsigned(HW));
    IFM_NL_ready_tmp    <= IFM_NL_ready;
    IFM_NL_finished_tmp <= IFM_NL_finished;
    ifm_BE_r_tmp        <= ifm_BE_r;
    ifm_out             <= ifm_out_tmp;
    RE_BE               <= RE_BE_tmp;

end architecture;