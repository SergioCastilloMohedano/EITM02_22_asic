library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;
use IEEE.math_real.log2;

entity NOC_tb is
end NOC_tb;

architecture sim of NOC_tb is

    constant clk_hz     : integer := 100e6;
    constant clk_period : time    := 1 sec / clk_hz;

    constant HYP_BITWIDTH          : natural       := 8;

    constant X                     : natural       := 32;
    constant Y                     : natural       := 3;
    constant hw_log2_r             : integer_array := (0, 1, 2);
    constant hw_log2_EF            : integer_array := (5, 4, 3); -- for E = (32, 16, 8)
    constant NUM_REGS_IFM_REG_FILE : natural       := 34; -- W' max (conv0 and conv1)
    constant NUM_REGS_W_REG_FILE   : natural       := 24; -- p*S = 8*3 = 24
    constant ADDR_4K_CFG           : natural       := 4042;

    signal clk                     : std_logic     := '1';
    signal reset                   : std_logic     := '1';

    signal NL_start_tb    : std_logic := '0';
    signal NL_ready_tb    : std_logic;
    signal NL_finished_tb : std_logic;

    component TOP is
        generic (
            -- HW Parameters, at synthesis time.
            X                     : natural       := 32;
            Y                     : natural       := 3;
            hw_log2_r             : integer_array := (0, 1, 2);
            hw_log2_EF            : integer_array := (5, 4, 3);
            NUM_REGS_IFM_REG_FILE : natural       := 32;             -- W' max (conv0 and conv1)
            NUM_REGS_W_REG_FILE   : natural       := 24;             -- p*S = 8*3 = 24
            ADDR_4K_CFG           : natural       := 4042            -- First Address of the reserved space for config. parameters.
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            NL_start    : in std_logic;
            NL_ready    : out std_logic;
            NL_finished : out std_logic
        );
    end component;

begin

    clk <= not clk after clk_period / 2;

    inst_TOP_UUT : TOP
    generic map(
        X                     => X,
        Y                     => Y,
        hw_log2_r             => (0, 1, 2),
        hw_log2_EF            => (5, 4, 3),
        NUM_REGS_IFM_REG_FILE => NUM_REGS_IFM_REG_FILE, -- W' max (conv0 and conv1)
        NUM_REGS_W_REG_FILE   => NUM_REGS_W_REG_FILE,   -- p*S = 8*3 = 24
        ADDR_4K_CFG           => ADDR_4K_CFG
    )
    port map(
        clk         => clk,
        reset       => reset,
        NL_start    => NL_start_tb,
        NL_ready    => NL_ready_tb,
        NL_finished => NL_finished_tb
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        reset <= '0';

        wait for clk_period * 10;
        NL_start_tb <= '1';
        wait for clk_period;
        NL_start_tb <= '0';
        wait;
    end process;

end architecture;
