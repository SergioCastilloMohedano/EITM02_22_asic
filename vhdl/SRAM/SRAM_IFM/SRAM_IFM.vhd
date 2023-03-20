library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_IFM is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        -- To/From Front-End Read Interface
        h_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        w_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        HW              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        RS              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        IFM_NL_ready    : in std_logic;
        IFM_NL_finished : in std_logic;
        ifm_out         : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        pad             : out natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- To MC_X
        -- To/From Front-End Write Interface
        is_pooling  : in std_logic;
        en_w_IFM    : in std_logic;
        pooling_ack : in std_logic;
        pooling_IFM : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        rn_IFM      : in std_logic_vector (ACT_BITWIDTH - 1 downto 0)
    );
end SRAM_IFM;

architecture structural of SRAM_IFM is

    -- SIGNAL DECLARATIONS
    signal h_p_tmp             : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal w_p_tmp             : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal HW_tmp              : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal ifm_out_tmp         : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal ifm_r_tmp           : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal RE_tmp              : std_logic;
    signal ifm_w_tmp           : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal en_w_tmp            : std_logic;
    signal WE_tmp              : std_logic;
    signal A_tmp               : std_logic_vector (12 downto 0);
    signal CSN_tmp             : std_logic;
    signal D_tmp               : std_logic_vector (31 downto 0);
    signal INITN_tmp           : std_logic;
    signal Q_tmp               : std_logic_vector (31 downto 0);
    signal WEN_tmp             : std_logic;

    -- *****************************
    -- *** GATE-LEVEL SIMULATION ***
    signal A_buff_tmp   : std_logic_vector(12 downto 0);
    signal CSN_buff_tmp : std_logic;
    signal D_buff_tmp   : std_logic_vector (31 downto 0);
    signal WEN_buff_tmp : std_logic;
    -- *****************************
    -- *****************************

    -- COMPONENT DECLARATIONS
    component SRAM_IFM_FRONT_END_READ is
        port (
            h_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            w_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            HW              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            RS              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            IFM_NL_ready    : in std_logic;
            IFM_NL_finished : in std_logic;
            ifm_out         : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            pad             : out natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- To MC_X
            -- Back-End (BE) Interface Ports
            ifm_BE_r : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            RE_BE    : out std_logic
        );
    end component;

    component SRAM_IFM_FRONT_END_WRITE is
        port (
            clk         : in std_logic;
            is_pooling  : in std_logic;
            en_w_IFM    : in std_logic;
            pooling_ack : in std_logic;
            pooling_IFM : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            rn_IFM      : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            -- Back-End (BE) Interface Ports
            ifm_BE_w : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            en_w     : out std_logic;
            WE_BE    : out std_logic
        );
    end component;

    component SRAM_IFM_BACK_END is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- Front-End Interface Ports (READ)
            ifm_FE_r : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            RE_FE    : in std_logic;
            -- Front-End Interface Ports (WRITE)
            ifm_FE_w : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            en_w     : in std_logic;
            WE_FE    : in std_logic;
            -- SRAM Wrapper Ports (ASIC)
            A     : out std_logic_vector(12 downto 0);
            CSN   : out std_logic;
            D     : out std_logic_vector (31 downto 0);
            INITN : out std_logic;
            Q     : in std_logic_vector (31 downto 0);
            WEN   : out std_logic
        );
    end component;

    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************
    component SRAM_IFM_BUFFER is
        port (
            -- From Back-End
            A   : in std_logic_vector(12 downto 0);
            CSN : in std_logic;
            D   : in std_logic_vector (31 downto 0);
            WEN : in std_logic;
            -- To WRAPPER
            A_buff   : out std_logic_vector(12 downto 0);
            CSN_buff : out std_logic;
            D_buff   : out std_logic_vector (31 downto 0);
            WEN_buff : out std_logic
        );
    end component;

    attribute preserve : boolean;
    attribute preserve of SRAM_IFM_BUFFER : component is true;

    -- *****************************************************
    -- *****************************************************

--    component ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_3
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

begin

    -- SRAM_IFM_FRONT_END_READ
    SRAM_IFM_FRONT_END_READ_inst : SRAM_IFM_FRONT_END_READ
    port map(
        h_p             => h_p_tmp,
        w_p             => w_p_tmp,
        HW              => HW_tmp,
        RS              => RS,
        IFM_NL_ready    => IFM_NL_ready_tmp,
        IFM_NL_finished => IFM_NL_finished_tmp,
        ifm_out         => ifm_out_tmp,
        pad             => pad,
        -- Back-End (BE) Interface Ports
        ifm_BE_r => ifm_r_tmp,
        RE_BE    => RE_tmp
    );

    -- SRAM_IFM_FRONT_END_WRITE
    SRAM_IFM_FRONT_END_WRITE_inst : SRAM_IFM_FRONT_END_WRITE
    port map(
        clk         => clk,
        is_pooling  => is_pooling,
        en_w_IFM    => en_w_IFM,
        pooling_ack => pooling_ack,
        pooling_IFM => pooling_IFM,
        rn_IFM      => rn_IFM,
        ifm_BE_w    => ifm_w_tmp,
        en_w        => en_w_tmp,
        WE_BE       => WE_tmp
    );

    -- SRAM_IFM_BACK_END
    SRAM_IFM_BACK_END_inst : SRAM_IFM_BACK_END
    port map(
        clk      => clk,
        reset    => reset,
        ifm_FE_r => ifm_r_tmp,
        RE_FE    => RE_tmp,
        ifm_FE_w => ifm_w_tmp,
        en_w     => en_w_tmp,
        WE_FE    => WE_tmp,
        A        => A_tmp,
        CSN      => CSN_tmp,
        D        => D_tmp,
        INITN    => INITN_tmp,
        Q        => Q_tmp,
        WEN      => WEN_tmp
    );

    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************
    SRAM_IFM_BUFFER_inst : SRAM_IFM_BUFFER
    port map(
        A        => A_tmp,
        CSN      => CSN_tmp,
        D        => D_tmp,
        WEN      => WEN_tmp,
        A_buff   => A_buff_tmp,
        CSN_buff => CSN_buff_tmp,
        D_buff   => D_buff_tmp,
        WEN_buff => WEN_buff_tmp
    );
    -- *****************************************************
    -- *****************************************************

    -- ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_3
--    ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_inst_3 : ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_3 -- (to allow separate .cde read)
    ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper_inst_3 : ST_SPHD_HIPERF_8192x32m16_Tlmr_wrapper -- (for post-synthesis sim -will be wrong- and power calculations)
    port map(
        CK    => clk,
    -- *****************************
    -- *** GATE-LEVEL SIMULATION ***
        A     => A_buff_tmp,
        CSN   => CSN_buff_tmp,
        D     => D_buff_tmp,
        WEN   => WEN_buff_tmp,
    -- *****************************
    -- *****************************
--        A     => A_tmp,
--        CSN   => CSN_tmp,
--        D     => D_tmp,
        INITN => INITN_tmp,
        Q     => Q_tmp
--        WEN   => WEN_tmp
    );

    -- PORT ASSIGNATIONS
    h_p_tmp             <= h_p;
    w_p_tmp             <= w_p;
    HW_tmp              <= HW;
    IFM_NL_ready_tmp    <= IFM_NL_ready;
    IFM_NL_finished_tmp <= IFM_NL_finished;
    ifm_out             <= ifm_out_tmp;
end architecture;
