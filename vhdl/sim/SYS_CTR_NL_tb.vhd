library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_NL_tb is
end SYS_CTR_NL_tb;

architecture sim of SYS_CTR_NL_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    constant M_cap : natural := 16;
    constant C_cap : natural := 3;
    constant r : natural := 1; -- X/E
    constant p : natural := 8;
    constant RS : natural := 3;
    constant HW_p : natural := 34;
    constant M_div_pt : natural := M_cap/(p*1); --M/p*t
    constant HYP_BITWIDTH : natural := 8;

    signal clk : std_logic := '1';
    signal reset : std_logic := '1';

    signal NL_start_in_tb : std_logic := '0';
    signal NL_ready_out_tb : std_logic := '0';
    signal NL_finished_out_tb : std_logic := '0';
    signal M_cap_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_cap, HYP_BITWIDTH));
    signal C_cap_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(C_cap, HYP_BITWIDTH));
    signal r_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(r, HYP_BITWIDTH));
    signal p_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(p, HYP_BITWIDTH));
    signal RS_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(RS, HYP_BITWIDTH));
    signal HW_p_in_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW_p, HYP_BITWIDTH));
    signal m_out_tb : std_logic_vector (7 downto 0);
    signal c_out_tb : std_logic_vector (7 downto 0);
    signal rc_out_tb : std_logic_vector (7 downto 0);
    signal h_p_out_tb : std_logic_vector (7 downto 0);
    signal w_p_out_tb : std_logic_vector (7 downto 0);
    signal r_p_out_tb : std_logic_vector (7 downto 0);
    signal pm_out_tb : std_logic_vector (7 downto 0);
    signal s_out_tb : std_logic_vector (7 downto 0);
    signal M_div_pt_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_div_pt, HYP_BITWIDTH));

    component SYS_CTR_NL is
    port (
        clk : in std_logic;
        reset : in std_logic;
        NL_start : in std_logic;
        NL_ready : out std_logic;
        NL_finished : out std_logic;
        M_cap : in std_logic_vector (7 downto 0);
        C_cap : in std_logic_vector (7 downto 0);
        r : in std_logic_vector (7 downto 0);
        p : in std_logic_vector (7 downto 0);
        RS : in std_logic_vector (7 downto 0);
        HW_p : in std_logic_vector (7 downto 0);
        m : out std_logic_vector (7 downto 0);
        c : out std_logic_vector (7 downto 0);
        rc : out std_logic_vector (7 downto 0);
        r_p : out std_logic_vector (7 downto 0);
        pm : out std_logic_vector (7 downto 0);
        s : out std_logic_vector (7 downto 0);
        h_p : out std_logic_vector (7 downto 0);
        w_p : out std_logic_vector (7 downto 0);
        M_div_pt : in std_logic_vector (7 downto 0)
    );
   end component;

begin

    clk <= not clk after clk_period / 2;

    DUT : SYS_CTR_NL
    port map (
        clk => clk,
        reset => reset,
        NL_start => NL_start_in_tb,
        NL_ready => NL_ready_out_tb,
        NL_finished => NL_finished_out_tb,
        M_cap => M_cap_in_tb,
        C_cap => C_cap_in_tb,
        r => r_in_tb,
        p => p_in_tb,
        RS => RS_in_tb,
        HW_p => HW_p_in_tb,
        m => m_out_tb,
        c => c_out_tb,
        rc => rc_out_tb,
        r_p => r_p_out_tb,
        pm => pm_out_tb,
        s => s_out_tb,
        h_p => h_p_out_tb,
        w_p => w_p_out_tb,
        M_div_pt => M_div_pt_tb
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        reset <= '0';

        wait for clk_period * 10;
        NL_start_in_tb <= '1';
        wait for clk_period;
        NL_start_in_tb <= '0';

        wait;
    end process;

end architecture;