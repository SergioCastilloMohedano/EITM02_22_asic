library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity MC_Y_COLUMN_tb is
end MC_Y_COLUMN_tb;

architecture sim of MC_Y_COLUMN_tb is

    constant clk_hz     : integer := 100e6;
    constant clk_period : time    := 1 sec / clk_hz;

    constant X            : natural := 32;
    constant Y            : natural := 3;
    constant M_cap        : natural := 32;
    constant C_cap        : natural := 16;
    constant RS           : natural := 3;
    constant HW           : natural := 16;
    constant HW_p         : natural := HW + 2;
    constant EF           : natural := HW;
    constant r            : natural := X/EF; -- X/E
    constant p            : natural := 8;
    constant t            : natural := 1; -- it must always be 1
    constant M_div_pt     : natural := M_cap/(p * t); --M/p*t
    constant HYP_BITWIDTH : natural := 8;

    signal clk   : std_logic := '1';
    signal reset : std_logic := '1';

    signal NL_start_tb    : std_logic := '0';
    signal NL_ready_tb    : std_logic;
    signal NL_finished_tb : std_logic;
    signal M_cap_tb       : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_cap, HYP_BITWIDTH));
    signal C_cap_tb       : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(C_cap, HYP_BITWIDTH));
    signal r_tb           : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(r, HYP_BITWIDTH));
    signal p_tb           : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(p, HYP_BITWIDTH));
    signal RS_tb          : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(RS, HYP_BITWIDTH));
    signal HW_p_tb        : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW_p, HYP_BITWIDTH));
    signal HW_tb          : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW, HYP_BITWIDTH));
    signal m_tb           : std_logic_vector (7 downto 0);
    signal c_tb           : std_logic_vector (7 downto 0);
    signal rc_tb          : std_logic_vector (7 downto 0);
    signal h_p_tb         : std_logic_vector (7 downto 0);
    signal w_p_tb         : std_logic_vector (7 downto 0);
    signal r_p_tb         : std_logic_vector (7 downto 0);
    signal pm_tb          : std_logic_vector (7 downto 0);
    signal s_tb           : std_logic_vector (7 downto 0);
    signal M_div_pt_tb    : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_div_pt, HYP_BITWIDTH));

    signal NoC_ACK_flag_tb : std_logic := '0';

    signal IFM_NL_ready_tb    : std_logic;
    signal IFM_NL_finished_tb : std_logic;
    signal IFM_NL_busy_tb     : std_logic;
    signal WB_NL_ready_tb     : std_logic;
    signal WB_NL_finished_tb  : std_logic;
    signal WB_NL_busy_tb      : std_logic;

    signal ifm_tb : std_logic_vector (7 downto 0);
    signal wb_tb  : std_logic_vector (7 downto 0);

    signal w_status_tb   : std_logic_array(0 to (Y - 1));
    signal ifm_status_tb : std_logic_array(0 to (Y - 1));
    signal w_mc_tb       : std_logic_vector_array(0 to (Y - 1));
    signal ifm_mc_tb     : std_logic_vector_array(0 to (Y - 1));

    signal h_p_tb_reg         : std_logic_vector (7 downto 0);
    signal r_p_tb_reg         : std_logic_vector (7 downto 0);
    signal IFM_NL_busy_tb_reg : std_logic;
    signal WB_NL_busy_tb_reg  : std_logic;

    component SYS_CTR_NL is
        port (
            clk             : in std_logic;
            reset           : in std_logic;
            NL_start        : in std_logic;
            NL_ready        : out std_logic;
            NL_finished     : out std_logic;
            M_cap           : in std_logic_vector (7 downto 0);
            C_cap           : in std_logic_vector (7 downto 0);
            r               : in std_logic_vector (7 downto 0);
            p               : in std_logic_vector (7 downto 0);
            RS              : in std_logic_vector (7 downto 0);
            HW_p            : in std_logic_vector (7 downto 0);
            m               : out std_logic_vector (7 downto 0);
            c               : out std_logic_vector (7 downto 0);
            rc              : out std_logic_vector (7 downto 0);
            r_p             : out std_logic_vector (7 downto 0);
            pm              : out std_logic_vector (7 downto 0);
            s               : out std_logic_vector (7 downto 0);
            h_p             : out std_logic_vector (7 downto 0);
            w_p             : out std_logic_vector (7 downto 0);
            M_div_pt        : in std_logic_vector (7 downto 0);
            NoC_ACK_flag    : in std_logic;
            IFM_NL_ready    : out std_logic;
            IFM_NL_finished : out std_logic;
            IFM_NL_busy     : out std_logic;
            WB_NL_ready     : out std_logic;
            WB_NL_finished  : out std_logic;
            WB_NL_busy      : out std_logic
        );
    end component;

    component SRAM_IFM is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- To/From Front-End Read Interface
            h_p             : in std_logic_vector (7 downto 0);
            w_p             : in std_logic_vector (7 downto 0);
            HW              : in std_logic_vector (7 downto 0);
            IFM_NL_ready    : in std_logic;
            IFM_NL_finished : in std_logic;
            ifm_out         : out std_logic_vector (7 downto 0)
            -- To/From Front-End Write Interface
            -- ..
        );
    end component;

    component SRAM_WB is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- To/From Front-End Read Interface
            WB_NL_ready    : in std_logic;
            WB_NL_finished : in std_logic;
            wb_out         : out std_logic_vector (7 downto 0)
            -- To/From Front-End Write Interface
            -- ..
        );
    end component;

    component MC_Y_COLUMN_UUT is
        generic (
            Y : natural range 0 to 255 := Y -- number of PE Rows in the PE Array
        );
        port (
            -- config. parameters
            HW_p : in std_logic_vector (7 downto 0);
            -- from sys ctrl
            h_p         : in std_logic_vector (7 downto 0);
            r_p         : in std_logic_vector (7 downto 0);
            WB_NL_busy  : in std_logic;
            IFM_NL_busy : in std_logic;
            -- from SRAMs
            ifm_y_in : in std_logic_vector (7 downto 0);
            w_y_in   : in std_logic_vector (7 downto 0);

            ifm_y_status : out std_logic_array(0 to (Y - 1));
            w_y_status   : out std_logic_array(0 to (Y - 1));
            ifm_y_out    : out std_logic_vector_array(0 to (Y - 1));
            w_y_out      : out std_logic_vector_array(0 to (Y - 1))
        );
    end component;

begin

    clk <= not clk after clk_period / 2;

    inst_MC_Y_COLUMN_UUT : MC_Y_COLUMN_UUT
    port map(
        HW_p         => HW_p_tb,
        h_p          => h_p_tb_reg,
        r_p          => r_p_tb_reg,
        IFM_NL_busy  => IFM_NL_busy_tb_reg,
        WB_NL_busy   => WB_NL_busy_tb_reg,
        ifm_y_in     => ifm_tb,
        w_y_in       => wb_tb,
        ifm_y_out    => ifm_mc_tb,
        w_y_out      => w_mc_tb,
        ifm_y_status => ifm_status_tb,
        w_y_status   => w_status_tb
    );

    inst_SYS_CTR_NL : SYS_CTR_NL
    port map(
        clk             => clk,
        reset           => reset,
        NL_start        => NL_start_tb,
        NL_ready        => NL_ready_tb,
        NL_finished     => NL_finished_tb,
        M_cap           => M_cap_tb,
        C_cap           => C_cap_tb,
        r               => r_tb,
        p               => p_tb,
        RS              => RS_tb,
        HW_p            => HW_p_tb,
        m               => m_tb,
        c               => c_tb,
        rc              => rc_tb,
        r_p             => r_p_tb,
        pm              => pm_tb,
        s               => s_tb,
        h_p             => h_p_tb,
        w_p             => w_p_tb,
        M_div_pt        => M_div_pt_tb,
        NoC_ACK_flag    => NoC_ACK_flag_tb,
        IFM_NL_ready    => IFM_NL_ready_tb,
        IFM_NL_finished => IFM_NL_finished_tb,
        IFM_NL_busy     => IFM_NL_busy_tb,
        WB_NL_ready     => WB_NL_ready_tb,
        WB_NL_finished  => WB_NL_finished_tb,
        WB_NL_busy      => WB_NL_busy_tb
    );

    inst_SRAM_IFM : SRAM_IFM
    port map(
        clk             => clk,
        reset           => reset,
        h_p             => h_p_tb,
        w_p             => w_p_tb,
        HW              => HW_tb,
        IFM_NL_ready    => IFM_NL_ready_tb,
        IFM_NL_finished => IFM_NL_finished_tb,
        ifm_out         => ifm_tb
    );

    inst_SRAM_WB : SRAM_WB
    port map(
        clk            => clk,
        reset          => reset,
        WB_NL_ready    => WB_NL_ready_tb,
        WB_NL_finished => WB_NL_finished_tb,
        wb_out         => wb_tb
    );

    -- process to register sys ctrl. parameters, as they need 1 clk delay
    -- as to account with the 1clk delay generated from the memories.
    REG_PROC : process (clk)
    begin
        if rising_edge(clk) then
            h_p_tb_reg         <= h_p_tb;
            r_p_tb_reg         <= r_p_tb;
            IFM_NL_busy_tb_reg <= IFM_NL_busy_tb;
            WB_NL_busy_tb_reg  <= WB_NL_busy_tb;
        end if;
    end process;

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