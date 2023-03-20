library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.log2;

entity TOP_LU_PADS_tb is
end TOP_LU_PADS_tb;

architecture sim of TOP_LU_PADS_tb is

    constant clk_hz     : integer := 200e6; -- 200 MHz
--    constant clk_hz     : integer := 125e6; -- 125 MHz
--    constant clk_hz     : integer := 1e6; -- 1 MHz
    constant clk_period : time    := 1 sec / clk_hz;


    signal clk                     : std_logic     := '1';
    signal reset                   : std_logic     := '1';

    signal NL_start_tb    : std_logic := '0';
    signal NL_ready_tb    : std_logic;
    signal NL_finished_tb : std_logic;

    component TOP_LU_PADS is
    port (
        clk_p         : in std_logic;
        reset_p       : in std_logic;
        NL_start_p    : in std_logic;
        NL_ready_p    : out std_logic;
        NL_finished_p : out std_logic
    );
    end component;

begin

    clk <= not clk after clk_period / 2;

    inst_TOP_UUT : TOP_LU_PADS
    port map(
        clk_p         => clk,
        reset_p       => reset,
        NL_start_p    => NL_start_tb,
        NL_ready_p    => NL_ready_tb,
        NL_finished_p => NL_finished_tb
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2 + clk_period/2;

        reset <= '0';

        wait for clk_period * 9;
        NL_start_tb <= '1';
        wait for clk_period;
        NL_start_tb <= '0';
        wait;
    end process;

end architecture;
