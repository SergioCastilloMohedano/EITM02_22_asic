library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM_WRAPPER_BLOCK is
    port (
        clk               : in std_logic;
        INITN             : in std_logic;
        OFM_WRITE_BUSY    : in std_logic;
        OFM_READ_BUSY     : in std_logic;
        OFM_READ_FINISHED : in std_logic;
        -- Port 1 (write)
        A_2K_p1   : in std_logic_vector(13 downto 0);
        CSN_2K_p1 : in std_logic;
        D_2K_p1   : in std_logic_vector (31 downto 0);
        WEN_2K_p1 : in std_logic;
        -- Port 2 (read)
        A_2K_p2    : in std_logic_vector(13 downto 0);
        CSN_2K_p2  : in std_logic;
        Q_2K_p2    : out std_logic_vector (31 downto 0)
    );
end SRAM_OFM_WRAPPER_BLOCK;

architecture structural of SRAM_OFM_WRAPPER_BLOCK is

    -- SIGNALS DECLARATIONS
    signal Q_2K_p2_tmp : std_logic_vector (31 downto 0);

    -- To SRAM #1
    signal A_2K_p1_1   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_1 : std_logic;
    signal D_2K_p1_1   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_1 : std_logic;
    signal A_2K_p2_1   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_1 : std_logic;
    signal Q_2K_p2_1   : std_logic_vector (31 downto 0);
    -- To SRAM #2
    signal A_2K_p1_2   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_2 : std_logic;
    signal D_2K_p1_2   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_2 : std_logic;
    signal A_2K_p2_2   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_2 : std_logic;
    signal Q_2K_p2_2   : std_logic_vector (31 downto 0);
    -- To SRAM #3
    signal A_2K_p1_3   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_3 : std_logic;
    signal D_2K_p1_3   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_3 : std_logic;
    signal A_2K_p2_3   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_3 : std_logic;
    signal Q_2K_p2_3   : std_logic_vector (31 downto 0);
    -- To SRAM #4
    signal A_2K_p1_4   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_4 : std_logic;
    signal D_2K_p1_4   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_4 : std_logic;
    signal A_2K_p2_4   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_4 : std_logic;
    signal Q_2K_p2_4   : std_logic_vector (31 downto 0);
    -- To SRAM #5
    signal A_2K_p1_5   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_5 : std_logic;
    signal D_2K_p1_5   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_5 : std_logic;
    signal A_2K_p2_5   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_5 : std_logic;
    signal Q_2K_p2_5   : std_logic_vector (31 downto 0);
    -- To SRAM #6
    signal A_2K_p1_6   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_6 : std_logic;
    signal D_2K_p1_6   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_6 : std_logic;
    signal A_2K_p2_6   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_6 : std_logic;
    signal Q_2K_p2_6   : std_logic_vector (31 downto 0);
    -- To SRAM #7
    signal A_2K_p1_7   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_7 : std_logic;
    signal D_2K_p1_7   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_7 : std_logic;
    signal A_2K_p2_7   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_7 : std_logic;
    signal Q_2K_p2_7   : std_logic_vector (31 downto 0);
    -- To SRAM #8
    signal A_2K_p1_8   : std_logic_vector(10 downto 0);
    signal CSN_2K_p1_8 : std_logic;
    signal D_2K_p1_8   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1_8 : std_logic;
    signal A_2K_p2_8   : std_logic_vector(10 downto 0);
    signal CSN_2K_p2_8 : std_logic;
    signal Q_2K_p2_8   : std_logic_vector (31 downto 0);

    -- COMPONENTS DECLARATIONS
    component ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
        port (
            INITN : in std_logic;
            A1    : in std_logic_vector(10 downto 0);
            CK1   : in std_logic;
            CSN1  : in std_logic;
            D1    : in std_logic_vector (31 downto 0);
            Q1    : out std_logic_vector (31 downto 0);
            WEN1  : in std_logic;
            A2    : in std_logic_vector(10 downto 0);
            CK2   : in std_logic;
            CSN2  : in std_logic;
            D2    : in std_logic_vector (31 downto 0);
            Q2    : out std_logic_vector (31 downto 0);
            WEN2  : in std_logic
        );
    end component;

    component SRAM_OFM_ROUTER
        port (
            -- From/To Back-End Interface
            OFM_WRITE_BUSY    : in std_logic;
            OFM_READ_BUSY     : in std_logic;
            OFM_READ_FINISHED : in std_logic;
           -- Port 1 (write)
            A_2K_p1   : in std_logic_vector(13 downto 0);
            CSN_2K_p1 : in std_logic;
            D_2K_p1   : in std_logic_vector (31 downto 0);
            WEN_2K_p1 : in std_logic;
            -- Port 2 (read)
            A_2K_p2   : in std_logic_vector(13 downto 0);
            CSN_2K_p2 : in std_logic;
            Q_2K_p2   : out std_logic_vector (31 downto 0);
            -- To SRAM #1
            A_2K_p1_1   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_1 : out std_logic;
            D_2K_p1_1   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_1 : out std_logic;
            A_2K_p2_1   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_1 : out std_logic;
            Q_2K_p2_1   : in std_logic_vector (31 downto 0);
            -- To SRAM #2
            A_2K_p1_2   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_2 : out std_logic;
            D_2K_p1_2   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_2 : out std_logic;
            A_2K_p2_2   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_2 : out std_logic;
            Q_2K_p2_2   : in std_logic_vector (31 downto 0);
            -- To SRAM #3
            A_2K_p1_3   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_3 : out std_logic;
            D_2K_p1_3   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_3 : out std_logic;
            A_2K_p2_3   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_3 : out std_logic;
            Q_2K_p2_3   : in std_logic_vector (31 downto 0);
            -- To SRAM #4
            A_2K_p1_4   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_4 : out std_logic;
            D_2K_p1_4   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_4 : out std_logic;
            A_2K_p2_4   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_4 : out std_logic;
            Q_2K_p2_4   : in std_logic_vector (31 downto 0);
            -- To SRAM #5
            A_2K_p1_5   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_5 : out std_logic;
            D_2K_p1_5   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_5 : out std_logic;
            A_2K_p2_5   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_5 : out std_logic;
            Q_2K_p2_5   : in std_logic_vector (31 downto 0);
            -- To SRAM #6
            A_2K_p1_6   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_6 : out std_logic;
            D_2K_p1_6   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_6 : out std_logic;
            A_2K_p2_6   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_6 : out std_logic;
            Q_2K_p2_6   : in std_logic_vector (31 downto 0);
            -- To SRAM #7
            A_2K_p1_7   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_7 : out std_logic;
            D_2K_p1_7   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_7 : out std_logic;
            A_2K_p2_7   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_7 : out std_logic;
            Q_2K_p2_7   : in std_logic_vector (31 downto 0);
            -- To SRAM #8
            A_2K_p1_8   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_8 : out std_logic;
            D_2K_p1_8   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_8 : out std_logic;
            A_2K_p2_8   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_8 : out std_logic;
            Q_2K_p2_8   : in std_logic_vector (31 downto 0)
        );
    end component;

begin

    -- SRAM_OFM_ROUTER
    SRAM_OFM_ROUTER_inst : SRAM_OFM_ROUTER
    port map(
        OFM_WRITE_BUSY => OFM_WRITE_BUSY,
        OFM_READ_BUSY  => OFM_READ_BUSY,
        OFM_READ_FINISHED => OFM_READ_FINISHED,
        A_2K_p1        => A_2K_p1,
        CSN_2K_p1      => CSN_2K_p1,
        D_2K_p1        => D_2K_p1,
        WEN_2K_p1      => WEN_2K_p1,
        A_2K_p2        => A_2K_p2,
        CSN_2K_p2      => CSN_2K_p2,
        Q_2K_p2        => Q_2K_p2_tmp,
        A_2K_p1_1      => A_2K_p1_1,
        CSN_2K_p1_1    => CSN_2K_p1_1,
        D_2K_p1_1      => D_2K_p1_1,
        WEN_2K_p1_1    => WEN_2K_p1_1,
        A_2K_p2_1      => A_2K_p2_1,
        CSN_2K_p2_1    => CSN_2K_p2_1,
        Q_2K_p2_1      => Q_2K_p2_1,
        A_2K_p1_2      => A_2K_p1_2,
        CSN_2K_p1_2    => CSN_2K_p1_2,
        D_2K_p1_2      => D_2K_p1_2,
        WEN_2K_p1_2    => WEN_2K_p1_2,
        A_2K_p2_2      => A_2K_p2_2,
        CSN_2K_p2_2    => CSN_2K_p2_2,
        Q_2K_p2_2      => Q_2K_p2_2,
        A_2K_p1_3      => A_2K_p1_3,
        CSN_2K_p1_3    => CSN_2K_p1_3,
        D_2K_p1_3      => D_2K_p1_3,
        WEN_2K_p1_3    => WEN_2K_p1_3,
        A_2K_p2_3      => A_2K_p2_3,
        CSN_2K_p2_3    => CSN_2K_p2_3,
        Q_2K_p2_3      => Q_2K_p2_3,
        A_2K_p1_4      => A_2K_p1_4,
        CSN_2K_p1_4    => CSN_2K_p1_4,
        D_2K_p1_4      => D_2K_p1_4,
        WEN_2K_p1_4    => WEN_2K_p1_4,
        A_2K_p2_4      => A_2K_p2_4,
        CSN_2K_p2_4    => CSN_2K_p2_4,
        Q_2K_p2_4      => Q_2K_p2_4,
        A_2K_p1_5      => A_2K_p1_5,
        CSN_2K_p1_5    => CSN_2K_p1_5,
        D_2K_p1_5      => D_2K_p1_5,
        WEN_2K_p1_5    => WEN_2K_p1_5,
        A_2K_p2_5      => A_2K_p2_5,
        CSN_2K_p2_5    => CSN_2K_p2_5,
        Q_2K_p2_5      => Q_2K_p2_5,
        A_2K_p1_6      => A_2K_p1_6,
        CSN_2K_p1_6    => CSN_2K_p1_6,
        D_2K_p1_6      => D_2K_p1_6,
        WEN_2K_p1_6    => WEN_2K_p1_6,
        A_2K_p2_6      => A_2K_p2_6,
        CSN_2K_p2_6    => CSN_2K_p2_6,
        Q_2K_p2_6      => Q_2K_p2_6,
        A_2K_p1_7      => A_2K_p1_7,
        CSN_2K_p1_7    => CSN_2K_p1_7,
        D_2K_p1_7      => D_2K_p1_7,
        WEN_2K_p1_7    => WEN_2K_p1_7,
        A_2K_p2_7      => A_2K_p2_7,
        CSN_2K_p2_7    => CSN_2K_p2_7,
        Q_2K_p2_7      => Q_2K_p2_7,
        A_2K_p1_8      => A_2K_p1_8,
        CSN_2K_p1_8    => CSN_2K_p1_8,
        D_2K_p1_8      => D_2K_p1_8,
        WEN_2K_p1_8    => WEN_2K_p1_8,
        A_2K_p2_8      => A_2K_p2_8,
        CSN_2K_p2_8    => CSN_2K_p2_8,
        Q_2K_p2_8      => Q_2K_p2_8
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_1 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_1,
        CK1   => clk,
        CSN1  => CSN_2K_p1_1,
        D1    => D_2K_p1_1,
        Q1    => open,
        WEN1  => WEN_2K_p1_1,
        A2    => A_2K_p2_1,
        CK2   => clk,
        CSN2  => CSN_2K_p2_1,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_1,
        WEN2  => '1'
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_2 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_2,
        CK1   => clk,
        CSN1  => CSN_2K_p1_2,
        D1    => D_2K_p1_2,
        Q1    => open,
        WEN1  => WEN_2K_p1_2,
        A2    => A_2K_p2_2,
        CK2   => clk,
        CSN2  => CSN_2K_p2_2,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_2,
        WEN2  => '1'
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_3 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_3,
        CK1   => clk,
        CSN1  => CSN_2K_p1_3,
        D1    => D_2K_p1_3,
        Q1    => open,
        WEN1  => WEN_2K_p1_3,
        A2    => A_2K_p2_3,
        CK2   => clk,
        CSN2  => CSN_2K_p2_3,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_3,
        WEN2  => '1'
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_4 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_4,
        CK1   => clk,
        CSN1  => CSN_2K_p1_4,
        D1    => D_2K_p1_4,
        Q1    => open,
        WEN1  => WEN_2K_p1_4,
        A2    => A_2K_p2_4,
        CK2   => clk,
        CSN2  => CSN_2K_p2_4,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_4,
        WEN2  => '1'
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_5 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_5,
        CK1   => clk,
        CSN1  => CSN_2K_p1_5,
        D1    => D_2K_p1_5,
        Q1    => open,
        WEN1  => WEN_2K_p1_5,
        A2    => A_2K_p2_5,
        CK2   => clk,
        CSN2  => CSN_2K_p2_5,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_5,
        WEN2  => '1'
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_6 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_6,
        CK1   => clk,
        CSN1  => CSN_2K_p1_6,
        D1    => D_2K_p1_6,
        Q1    => open,
        WEN1  => WEN_2K_p1_6,
        A2    => A_2K_p2_6,
        CK2   => clk,
        CSN2  => CSN_2K_p2_6,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_6,
        WEN2  => '1'
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_7 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_7,
        CK1   => clk,
        CSN1  => CSN_2K_p1_7,
        D1    => D_2K_p1_7,
        Q1    => open,
        WEN1  => WEN_2K_p1_7,
        A2    => A_2K_p2_7,
        CK2   => clk,
        CSN2  => CSN_2K_p2_7,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_7,
        WEN2  => '1'
    );

    ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper_inst_8 : ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper
    port map(
        INITN => INITN,
        A1    => A_2K_p1_8,
        CK1   => clk,
        CSN1  => CSN_2K_p1_8,
        D1    => D_2K_p1_8,
        Q1    => open,
        WEN1  => WEN_2K_p1_8,
        A2    => A_2K_p2_8,
        CK2   => clk,
        CSN2  => CSN_2K_p2_8,
        D2 => (others => '0'),
        Q2    => Q_2K_p2_8,
        WEN2  => '1'
    );
    -- PORT ASSIGNATIONS
    Q_2K_p2 <= Q_2K_p2_tmp;

end architecture;
