library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity MC_rr_tb is
end MC_rr_tb;

architecture sim of MC_rr_tb is

    constant X : positive range 1 to 32 := 32;
    constant X_ID : positive range 1 to X := 32;
    constant hw_log2_EF : integer_array := (5, 4, 3);

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;
    signal clk : std_logic := '1';

    signal EF_log2_tb : std_logic_vector (7 downto 0) := (others => '0');
    signal rr_tb : std_logic_vector (7 downto 0);
    signal i : integer range 0 to (hw_log2_EF'length - 1) := 0;

    -- COMPONENT DECLARATIONS
    component MC_rr is
    generic (
        -- HW Parameters, at synthesis time.
        X_ID : natural := 1;
        hw_log2_EF : integer_array := (5,4,3)  -- log2(32, 16, 8)
    );
    port (
        -- config. parameters
        EF_log2 : in std_logic_vector (7 downto 0);

        -- NoC Internal Signals
        rr : out std_logic_vector (7 downto 0)
    );
    end component;

begin

    clk <= not clk after clk_period / 2;

    UUT_MC_rr : MC_rr
    generic map (
        X_ID => X_ID,
        hw_log2_EF => hw_log2_EF
    )
    port map (
        -- config. parameters
        EF_log2 => EF_log2_tb,
--        r => r_tb,
        rr => rr_tb
    );

    EF_log2_tb <= std_logic_vector(to_unsigned(hw_log2_EF(i),8));

    SEQUENCER_PROC : process
    begin

        wait for clk_period * 10;

        if (i < hw_log2_EF'length - 1) then
            i <= i + 1;
        else
            i <= 0;
        end if;

    end process;

end architecture;