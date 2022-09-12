library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_WB_NL_tb is
end SYS_CTR_WB_NL_tb;

architecture sim of SYS_CTR_WB_NL_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    constant RS : natural := 3;
    constant p : natural := 8;
    constant m : natural := 0;
    constant HYP_BITWIDTH : natural := 8;

    signal clk : std_logic := '1';
    signal reset : std_logic := '1';

    signal WB_NL_start_in_tb : std_logic := '0';
    signal WB_NL_ready_out_tb : std_logic := '0';
    signal WB_NL_finished_out_tb : std_logic := '0';
    signal RS_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(RS, HYP_BITWIDTH));
    signal p_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(p, HYP_BITWIDTH));
    signal m_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(m, HYP_BITWIDTH));
    signal r_p_out_tb : std_logic_vector (7 downto 0);
    signal pm_out_tb : std_logic_vector (7 downto 0);
    signal s_out_tb : std_logic_vector (7 downto 0);

    component SYS_CTR_WB_NL is
    port(clk                : in std_logic;
         reset              : in std_logic;
         WB_NL_start : in std_logic;
         WB_NL_ready : out std_logic;
         WB_NL_finished : out std_logic;
         RS : in std_logic_vector (7 downto 0);
         p : in std_logic_vector (7 downto 0);
         m : in std_logic_vector (7 downto 0);
         r_p : out std_logic_vector (7 downto 0);
         pm : out std_logic_vector (7 downto 0);
         s : out std_logic_vector (7 downto 0)
    );
   end component;

begin

    clk <= not clk after clk_period / 2;

    DUT : SYS_CTR_WB_NL
    port map (
        clk => clk,
        reset => reset,
        WB_NL_start => WB_NL_start_in_tb,
        WB_NL_ready => WB_NL_ready_out_tb,
        WB_NL_finished => WB_NL_finished_out_tb,
        RS => RS_in_tb,
        p => p_in_tb,
        m => m_in_tb,
        r_p => r_p_out_tb,
        pm => pm_out_tb,
        s => s_out_tb
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        reset <= '0';

        wait for clk_period * 10;
        WB_NL_start_in_tb <= '1';
        wait for clk_period;
        WB_NL_start_in_tb <= '0';

        wait;
    end process;

end architecture;