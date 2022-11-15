library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity POOLING_TOP is
    generic (
        X : natural := 32
    );
    port (
        clk        : in std_logic;
        reset      : in std_logic;
        M_cap      : in std_logic_vector (7 downto 0);
        EF         : in std_logic_vector (7 downto 0);
        en_pooling : in std_logic;
        value_in   : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        value_out  : out std_logic_vector (COMP_BITWIDTH - 1 downto 0)
    );
end POOLING_TOP;

architecture structural of POOLING_TOP is

    -- SIGNAL DECLARATIONS
    signal rf_addr   : std_logic_vector(bit_size(X/2) - 1 downto 0);
    signal we_rf     : std_logic;
    signal re_rf     : std_logic;
    signal r1_r2_ctr : std_logic;
    signal r3_rf_ctr : std_logic;
    signal en_out    : std_logic;

    -- COMPONENT DECLARATIONS
    component POOLING_CTR is
        port (
            clk        : in std_logic;
            reset      : in std_logic;
            en_pooling : in std_logic;
            M_cap      : in std_logic_vector (7 downto 0);
            EF         : in std_logic_vector (7 downto 0);
            rf_addr    : out std_logic_vector(bit_size(X/2) - 1 downto 0);
            we_rf      : out std_logic;
            re_rf      : out std_logic;
            r1_r2_ctr  : out std_logic;
            r3_rf_ctr  : out std_logic;
            en_out     : out std_logic
        );
    end component;

    component POOLING is
        generic (
            X : natural := X
        );
        port (
            clk       : in std_logic;
            reset     : in std_logic;
            value_in  : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            value_out : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            rf_addr   : in std_logic_vector(bit_size(X/2) - 1 downto 0);
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
        rf_addr    => rf_addr,
        we_rf      => we_rf,
        re_rf      => re_rf,
        r1_r2_ctr  => r1_r2_ctr,
        r3_rf_ctr  => r3_rf_ctr,
        en_out     => en_out
    );

    POOLING_inst : POOLING
    generic map(
        X => X
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
end architecture;