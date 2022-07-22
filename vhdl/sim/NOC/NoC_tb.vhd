library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;
use IEEE.math_real."log2";

entity NOC_tb is
end NOC_tb;

architecture sim of NOC_tb is

    constant clk_hz     : integer := 100e6;
    constant clk_period : time    := 1 sec / clk_hz;

    constant X            : natural := 32;
    constant Y            : natural := 3;
    constant M_cap        : natural := 16;
    constant C_cap        : natural := 3;
    constant RS           : natural := 3;
    constant HW           : natural := 32;
    constant HW_p         : natural := HW + 2;
    constant EF           : natural := HW;
    constant EF_log2      : natural := natural(log2(real(EF)));
    constant r            : natural := X/EF; -- X/E
    constant r_log2       : natural := natural(log2(real(r)));
    constant p            : natural := 8;
    constant t            : natural := 1; -- it must always be 1
    constant M_div_pt     : natural := M_cap/(p * t); --M/p*t
    constant HYP_BITWIDTH : natural := 8;

    signal clk   : std_logic := '1';
    signal reset : std_logic := '1';

    signal NL_start_tb     : std_logic := '0';
    signal NL_ready_tb     : std_logic;
    signal NL_finished_tb  : std_logic;
    signal M_cap_tb        : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_cap, HYP_BITWIDTH));
    signal C_cap_tb        : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(C_cap, HYP_BITWIDTH));
    signal r_tb            : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(r, HYP_BITWIDTH));
    signal p_tb            : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(p, HYP_BITWIDTH));
    signal RS_tb           : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(RS, HYP_BITWIDTH));
    signal HW_p_tb         : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW_p, HYP_BITWIDTH));
    signal HW_tb           : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW, HYP_BITWIDTH));
    signal M_div_pt_tb     : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_div_pt, HYP_BITWIDTH));
    signal NoC_ACK_flag_tb : std_logic                     := '0';
    signal r_log2_tb       : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(r_log2, HYP_BITWIDTH));
    signal EF_log2_tb      : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(EF_log2, HYP_BITWIDTH));

    component TOP is
        generic (
            -- HW Parameters, at shyntesis time.
            X          : natural range 0 to 255 := 32;
            Y          : natural range 0 to 255 := 3;
            hw_log2_r  : integer_array          := (0, 1, 2);
            hw_log2_EF : integer_array          := (5, 4, 3)
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            NL_start    : in std_logic;
            NL_ready    : out std_logic;
            NL_finished : out std_logic;

            -- Signals Below Shall be coming from within the accelerator later on. ----
            M_cap        : in std_logic_vector (7 downto 0);
            C_cap        : in std_logic_vector (7 downto 0);
            r            : in std_logic_vector (7 downto 0);
            p            : in std_logic_vector (7 downto 0);
            RS           : in std_logic_vector (7 downto 0);
            HW_p         : in std_logic_vector (7 downto 0);
            HW           : in std_logic_vector (7 downto 0);
            M_div_pt     : in std_logic_vector (7 downto 0);
            NoC_ACK_flag : in std_logic;
            EF_log2      : in std_logic_vector (7 downto 0);
            r_log2       : in std_logic_vector (7 downto 0)
            ---------------------------------------------------------------------------
        );
    end component;

begin

    clk <= not clk after clk_period / 2;

    inst_TOP_UUT : TOP
    generic map(
        X => X,
        Y => Y
    )
    port map(
        clk          => clk,
        reset        => reset,
        NL_start     => NL_start_tb,
        NL_ready     => NL_ready_tb,
        NL_finished  => NL_finished_tb,
        M_cap        => M_cap_tb,
        C_cap        => C_cap_tb,
        r            => r_tb,
        p            => p_tb,
        RS           => RS_tb,
        HW_p         => HW_p_tb,
        HW           => HW_tb,
        M_div_pt     => M_div_pt_tb,
        NoC_ACK_flag => NoC_ACK_flag_tb,
        EF_log2      => EF_log2_tb,
        r_log2       => r_log2_tb
    );

    NOC_ACK_PROC : process
    begin
        NoC_ACK_flag_tb <= '0';
        wait for 20 us;
        NoC_ACK_flag_tb <= '1';
        wait for clk_period;
    end process;

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