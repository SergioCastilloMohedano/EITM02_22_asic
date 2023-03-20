library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB_WRAPPER_BLOCK is
    port (
        clk      : in std_logic;
        A_8K_1   : in std_logic_vector(12 downto 0);
        CSN_8K_1 : in std_logic;
        D_8K_1   : in std_logic_vector (31 downto 0);
        Q_8K_1   : out std_logic_vector (31 downto 0);
        WEN_8K_1 : in std_logic;
        A_8K_2   : in std_logic_vector(12 downto 0);
        CSN_8K_2 : in std_logic;
        D_8K_2   : in std_logic_vector (31 downto 0);
        Q_8K_2   : out std_logic_vector (31 downto 0);
        WEN_8K_2 : in std_logic;
        A_4K     : in std_logic_vector(11 downto 0);
        CSN_4K   : in std_logic;
        D_4K     : in std_logic_vector (31 downto 0);
        Q_4K     : out std_logic_vector (31 downto 0);
        WEN_4K   : in std_logic;
        INITN    : in std_logic
    );
end SRAM_WB_WRAPPER_BLOCK;

architecture structural of SRAM_WB_WRAPPER_BLOCK is

    signal A_8K_1_tmp   : std_logic_vector(12 downto 0);
    signal A_8K_2_tmp   : std_logic_vector(12 downto 0);
    signal A_4K_tmp     : std_logic_vector(11 downto 0);
    signal CSN_8K_1_tmp : std_logic;
    signal CSN_8K_2_tmp : std_logic;
    signal CSN_4K_tmp   : std_logic;
    signal D_8K_1_tmp   : std_logic_vector (31 downto 0);
    signal D_8K_2_tmp   : std_logic_vector (31 downto 0);
    signal D_4K_tmp     : std_logic_vector (31 downto 0);
    signal Q_8K_1_tmp   : std_logic_vector (31 downto 0);
    signal Q_8K_2_tmp   : std_logic_vector (31 downto 0);
    signal Q_4K_tmp     : std_logic_vector (31 downto 0);
    signal WEN_8K_1_tmp : std_logic;
    signal WEN_8K_2_tmp : std_logic;
    signal WEN_4K_tmp   : std_logic;

--    component ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_1
    component ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper
        port (
            A     : in std_logic_vector(12 downto 0);
            CK    : in std_logic;
            CSN   : in std_logic;
            D     : in std_logic_vector (31 downto 0);
            INITN : in std_logic;
            Q     : out std_logic_vector (31 downto 0);
            WEN   : in std_logic
        );
    end component;

--    component ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_2
--        port (
--            A     : in std_logic_vector(12 downto 0);
--            CK    : in std_logic;
--            CSN   : in std_logic;
--            D     : in std_logic_vector (31 downto 0);
--            INITN : in std_logic;
--            Q     : out std_logic_vector (31 downto 0);
--            WEN   : in std_logic
--        );
--    end component;

    component ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT_wrapper
        port (
            A     : in std_logic_vector(11 downto 0);
            CK    : in std_logic;
            CSN   : in std_logic;
            D     : in std_logic_vector (31 downto 0);
            INITN : in std_logic;
            Q     : out std_logic_vector (31 downto 0);
            WEN   : in std_logic
        );
    end component;

begin

    -- ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_1
--    ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_inst_1 : ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_1 -- (to allow separate .cde read)
    ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_inst_1 : ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper -- (for post-synthesis sim -will be wrong- and power calculations)
    port map(
        A     => A_8K_1,
        CK    => clk,
        CSN   => CSN_8K_1,
        D     => D_8K_1,
        INITN => INITN,
        Q     => Q_8K_1,
        WEN   => WEN_8K_1
    );

    -- ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_2
--    ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_inst_2 : ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_2 -- (to allow separate .cde read)
    ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_inst_2 : ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper -- (for post-synthesis sim -will be wrong- and power calculations)
    port map(
        A     => A_8K_2,
        CK    => clk,
        CSN   => CSN_8K_2,
        D     => D_8K_2,
        INITN => INITN,
        Q     => Q_8K_2,
        WEN   => WEN_8K_2
    );

    -- ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT_wrapper
    ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT_wrapper_inst : ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT_wrapper
    port map(
        A     => A_4K,
        CK    => clk,
        CSN   => CSN_4K,
        D     => D_4K,
        INITN => INITN,
        Q     => Q_4K,
        WEN   => WEN_4K
    );

end architecture;
