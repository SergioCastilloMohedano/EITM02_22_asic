library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity CEIL_LOG2_DIV_BLOCK_tb is
end CEIL_LOG2_DIV_BLOCK_tb;

architecture sim of CEIL_LOG2_DIV_BLOCK_tb is

    constant log2r_tb : integer_array := (4, 5, 6, 7, 8);

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;
    signal clk : std_logic := '1';

    signal x_tb : std_logic_vector (7 downto 0) := (others => '0');
    signal z_tb : std_logic_vector_array(0 to (log2r_tb'length - 1));

    component CEIL_LOG2_DIV_BLOCK is
        generic (
            log2r : integer_array  -- array with all possible "log2r" values of the accelerator.
        );
        port (
            x : in std_logic_vector (7 downto 0);
            z : out std_logic_vector_array(0 to log2r'length-1)
        );
    end component;

begin

    clk <= not clk after clk_period / 2;

    inst_CEIL_LOG2_DIV_BLOCK_UUT : CEIL_LOG2_DIV_BLOCK
    generic map (
        log2r => log2r_tb
    )
    port map (
        x => x_tb,
        z => z_tb
    );

    SEQUENCER_PROC : process
    begin

        wait for clk_period * 10;

        x_tb <= std_logic_vector(unsigned(x_tb) + to_unsigned(1, x_tb'length));

    end process;
end architecture;