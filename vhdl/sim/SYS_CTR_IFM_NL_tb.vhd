library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_IFM_NL_tb is
end SYS_CTR_IFM_NL_tb;

architecture sim of SYS_CTR_IFM_NL_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    constant HW_p : natural := 32;
    constant HYP_BITWIDTH : natural := 8;

    signal clk : std_logic := '1';
    signal reset : std_logic := '1';

    signal IFM_NL_start_in_tb : std_logic := '0';
    signal IFM_NL_ready_out_tb : std_logic := '0';
    signal IFM_NL_finished_out_tb : std_logic := '0';
    signal HW_p_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW_p, HYP_BITWIDTH));
    signal h_p_out_tb : std_logic_vector (7 downto 0);
    signal w_p_out_tb : std_logic_vector (7 downto 0);

    component SYS_CTR_IFM_NL is
    port(clk                : in std_logic;
         reset              : in std_logic;
         IFM_NL_start : in std_logic;
         IFM_NL_ready : out std_logic;
         IFM_NL_finished : out std_logic;
         HW_p : in std_logic_vector (7 downto 0);
         h_p : out std_logic_vector (7 downto 0);
         w_p : out std_logic_vector (7 downto 0)
    );
   end component;

begin

    clk <= not clk after clk_period / 2;

    DUT : SYS_CTR_IFM_NL
    port map (
        clk => clk,
        reset => reset,
        IFM_NL_start => IFM_NL_start_in_tb,
        IFM_NL_ready => IFM_NL_ready_out_tb,
        IFM_NL_finished => IFM_NL_finished_out_tb,
        HW_p => HW_p_in_tb,
        h_p => h_p_out_tb,
        w_p => w_p_out_tb
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        reset <= '0';

        wait for clk_period * 10;
        IFM_NL_start_in_tb <= '1';
        wait for clk_period;
        IFM_NL_start_in_tb <= '0';

        wait;
    end process;

end architecture;