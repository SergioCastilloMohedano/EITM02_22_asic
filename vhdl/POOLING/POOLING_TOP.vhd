library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity POOLING_TOP is
    generic (
        X : natural := X_PKG
    );
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        M_cap       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_pm      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_f       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_e       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        en_pooling  : in std_logic;
        value_in    : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        value_out   : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        pooling_ack : out std_logic;
        en_w_IFM    : out std_logic
    );
end POOLING_TOP;

architecture structural of POOLING_TOP is

    -- SIGNAL DECLARATIONS
    signal rf_addr        : std_logic_vector(bit_size(X_PKG/2) - 1 downto 0);
    signal we_rf          : std_logic;
    signal re_rf          : std_logic;
    signal r1_r2_ctr      : std_logic;
    signal r3_rf_ctr      : std_logic;
    signal en_out         : std_logic;
    signal en_w_IFM_tmp   : std_logic;
    signal en_w_IFM_tmp_2 : std_logic;

    -- COMPONENT DECLARATIONS
    component POOLING_CTR is
        port (
            clk        : in std_logic;
            reset      : in std_logic;
            en_pooling : in std_logic;
            M_cap      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_pm     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_f      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_e      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            rf_addr    : out std_logic_vector(bit_size(X_PKG/2) - 1 downto 0);
            we_rf      : out std_logic;
            re_rf      : out std_logic;
            r1_r2_ctr  : out std_logic;
            r3_rf_ctr  : out std_logic;
            en_out     : out std_logic
        );
    end component;

    component POOLING is
        generic (
            X : natural := X_PKG
        );
        port (
            clk       : in std_logic;
            reset     : in std_logic;
            value_in  : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            value_out : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            rf_addr   : in std_logic_vector(bit_size(X_PKG/2) - 1 downto 0);
            we_rf     : in std_logic;
            re_rf     : in std_logic;
            r1_r2_ctr : in std_logic;
            r3_rf_ctr : in std_logic;
            en_out    : in std_logic
        );
    end component;

begin

    POOLING_CTR_inst : POOLING_CTR
    port map(
        clk        => clk,
        reset      => reset,
        en_pooling => en_pooling,
        M_cap      => M_cap,
        EF         => EF,
        NoC_pm     => NoC_pm,
        NoC_f      => NoC_f,
        NoC_e      => NoC_e,
        rf_addr    => rf_addr,
        we_rf      => we_rf,
        re_rf      => re_rf,
        r1_r2_ctr  => r1_r2_ctr,
        r3_rf_ctr  => r3_rf_ctr,
        en_out     => en_out
    );

    POOLING_inst : POOLING
    generic map(
        X => X_PKG
    )
    port map(
        clk       => clk,
        reset     => reset,
        value_in  => value_in,
        value_out => value_out,
        rf_addr   => rf_addr,
        we_rf     => we_rf,
        re_rf     => re_rf,
        r1_r2_ctr => r1_r2_ctr,
        r3_rf_ctr => r3_rf_ctr,
        en_out    => en_out
    );

    -- PORT ASSIGNATIONS
    pooling_ack  <= en_out;
    en_w_IFM_tmp_2 <= en_pooling;
    en_w_IFM_tmp <= en_w_IFM_tmp_2 when rising_edge(clk); -- 2cc delay to ifm_en_w signal to align with dataflow
    en_w_IFM     <= en_w_IFM_tmp when rising_edge(clk);

end architecture;