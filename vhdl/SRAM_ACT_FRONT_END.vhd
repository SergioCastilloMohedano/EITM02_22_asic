-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SRAM_ACT_FRONT_END.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-06-25
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : Activations SRAM Front-End Interface
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

entity SRAM_ACT_FRONT_END is
    port (
        clk : in std_logic;
        reset : in std_logic;
        h_p : in std_logic_vector (7 downto 0);
        w_p : in std_logic_vector (7 downto 0);
        rc : in std_logic_vector (7 downto 0);
        HW : in std_logic_vector (7 downto 0);
        ACT_NL_ready : in std_logic; -- Reads SRAM exactly on those moments in which this signal is '0', when NL is not idle.
        ACT_NL_finished : in std_logic; -- ACT NL has finished. Do not read SRAM anymore.
        act_out : out std_logic_vector (7 downto 0);

        -- Back-End (BE) Interface Ports
        h_addr_BE : out std_logic_vector (7 downto 0);
        w_addr_BE : out std_logic_vector (7 downto 0);
        rc_addr_BE : out std_logic_vector (7 downto 0);
        act_BE : in std_logic_vector (7 downto 0);
        RE_BE : out std_logic   -- Read Enable, active high

        -- ...
    );
end SRAM_ACT_FRONT_END;

architecture combinational of SRAM_ACT_FRONT_END is

    signal ACT_NL_ready_int : std_logic;
    signal ACT_NL_finished_int : std_logic;

    signal h_p_int : natural range 0 to 127;
    signal w_p_int : natural range 0 to 127;
    signal rc_int : natural range 0 to 127;
    signal h_addr_int : natural range 0 to 127;
    signal w_addr_int : natural range 0 to 127;
    signal rc_addr_int : natural range 0 to 127;
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
    h_addr_int <= 0 when (h_ctrl = '1') else h_p_int;

    w_ctrl <= '1' when ((w_p_int < p) OR (w_p_int > (HW_int - 1 + p))) else '0';
    w_addr_int <= 0 when (w_ctrl = '1') else w_p_int;

    rc_addr_int <= 0 when ((h_ctrl OR w_ctrl) = '1') else rc_int; -- when pixel is out of range, apply zero padding.

    act_out_int <= (others => '0') when ((h_ctrl OR w_ctrl) = '1') else act_BE_int; -- when pixel is out of range, apply zero padding.

    RE_BE_int <= '1' when (((NOT(h_ctrl OR w_ctrl)) AND (ACT_NL_ready_int NOR ACT_NL_finished_int)) = '1') else '0';

    -- PORT Assignations
    h_p_int <= to_integer(unsigned(h_p));
    w_p_int <= to_integer(unsigned(w_p));
    rc_int <= to_integer(unsigned(rc));
    HW_int <= to_integer(unsigned(HW));
    ACT_NL_ready_int <= ACT_NL_ready;
    ACT_NL_finished_int <= ACT_NL_finished;
    h_addr_BE <= std_logic_vector(to_unsigned(h_addr_int, h_addr_BE'length));
    w_addr_BE <= std_logic_vector(to_unsigned(w_addr_int, w_addr_BE'length));
    rc_addr_BE <= std_logic_vector(to_unsigned(rc_addr_int, rc_addr_BE'length));
    act_BE_int <= act_BE;
    act_out <= act_out_int;
    RE_BE <= RE_BE_int;

end architecture;