library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- From Sys Controller
        NoC_c                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        OFM_NL_cnt_finished       : in std_logic; -- reset address back to 0 when all ofmaps of current layer have been processed.
        OFM_NL_NoC_m_cnt_finished : in std_logic;
        OFM_NL_Write              : in std_logic;
        OFM_NL_Read               : in std_logic;

        -- From Adder Tree Top
        ofmap      : in std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);
        shift_PISO : in std_logic; -- (enable signal)

        -- From WB SRAM
        bias : in std_logic_vector (BIAS_BITWIDTH - 1 downto 0);

        -- To Round To Nearest / ReLU Block
        ofm : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0)
    );
end SRAM_OFM;

architecture structural of SRAM_OFM is

    -- SIGNAL DECLARATIONS
    signal ofm_acc_tmp        : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal ofm_sum_tmp        : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal en_ofm_in_tmp      : std_logic;
    signal en_ofm_sum_tmp     : std_logic;
    signal WE_tmp             : std_logic;
    signal en_ofm_out_tmp     : std_logic;
    signal ofm_FE_out_tmp     : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal OFM_WRITE_BUSY_tmp : std_logic;
    signal OFM_READ_BUSY_tmp  : std_logic;
    signal OFM_READ_FINISHED_tmp : std_logic;


    -- Port 1 (write)
    signal A_2K_p1   : std_logic_vector(13 downto 0);
    signal CSN_2K_p1 : std_logic;
    signal D_2K_p1   : std_logic_vector (31 downto 0);
    signal WEN_2K_p1 : std_logic;
    -- Port 2 (read)
    signal A_2K_p2   : std_logic_vector(13 downto 0);
    signal CSN_2K_p2 : std_logic;
    signal Q_2K_p2   : std_logic_vector (31 downto 0);

    signal INITN : std_logic;

    -- COMPONENT DECLARATIONS
    component SRAM_OFM_FRONT_END_ACC is
        port (
            -- From Sys. Controller
            OFM_NL_Write : in std_logic;
            NoC_c        : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            -- From PISO Buffer
            shift_PISO : in std_logic;
            ofm_in     : in std_logic_vector (OFMAP_P_BITWIDTH - 1 downto 0);
            -- From/To Back-End Interface
            en_ofm_in  : out std_logic;
            en_ofm_sum : out std_logic;
            WE         : out std_logic;
            ofm_sum    : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            ofm_BE     : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            -- From WB SRAM
            bias : in std_logic_vector (BIAS_BITWIDTH - 1 downto 0)
        );
    end component;

    component SRAM_OFM_FRONT_END_OUT is
        port (
            -- From Sys. Controller
            OFM_NL_Read : in std_logic;
            -- From/To Back-End Interface
            en_ofm_out : out std_logic;
            ofm_BE     : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            ofm        : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0)
        );
    end component;

    component SRAM_OFM_BACK_END is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- From Sys. Controller
            OFM_NL_cnt_finished       : in std_logic;
            OFM_NL_NoC_m_cnt_finished : in std_logic;
            -- From/To Front-End Acc. Interface
            ofm_FE_acc : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            ofm_sum    : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            en_ofm_in  : in std_logic;
            en_ofm_sum : in std_logic;
            WE         : in std_logic;
            -- From/To Front-End Output Interface
            ofm_FE_out : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            en_ofm_out : in std_logic;
            -- SRAM Wrapper Ports
            OFM_WRITE_BUSY : out std_logic;
            OFM_READ_BUSY  : out std_logic;
            OFM_READ_FINISHED : out std_logic;
            INITN          : out std_logic;
            -- Port 1 (write)
            A_2K_p1   : out std_logic_vector(13 downto 0);
            CSN_2K_p1 : out std_logic;
            D_2K_p1   : out std_logic_vector (31 downto 0);
            WEN_2K_p1 : out std_logic;
            -- Port 2 (read)
            A_2K_p2    : out std_logic_vector(13 downto 0);
            CSN_2K_p2  : out std_logic;
            Q_2K_p2    : in std_logic_vector (31 downto 0)
        );
    end component;

    component SRAM_OFM_WRAPPER_BLOCK
        port (
            clk            : in std_logic;
            INITN          : in std_logic;
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
            Q_2K_p2   : out std_logic_vector (31 downto 0)
        );
    end component;

begin

    -- SRAM_OFM_FRONT_END_ACC
    SRAM_OFM_FRONT_END_ACC_inst : SRAM_OFM_FRONT_END_ACC
    port map(
        OFM_NL_Write => OFM_NL_Write,
        NoC_c        => NoC_c,
        shift_PISO   => shift_PISO,
        ofm_in       => ofmap,
        en_ofm_in    => en_ofm_in_tmp,
        en_ofm_sum   => en_ofm_sum_tmp,
        WE           => WE_tmp,
        ofm_sum      => ofm_sum_tmp,
        ofm_BE       => ofm_acc_tmp,
        bias         => bias
    );

    -- SRAM_OFM_FRONT_END_OUT
    SRAM_OFM_FRONT_END_OUT_inst : SRAM_OFM_FRONT_END_OUT
    port map(
        OFM_NL_Read => OFM_NL_Read,
        en_ofm_out  => en_ofm_out_tmp,
        ofm_BE      => ofm_FE_out_tmp,
        ofm         => ofm
    );
    -- SRAM_OFM_BACK_END
    SRAM_OFM_BACK_END_inst : SRAM_OFM_BACK_END
    port map(
        clk                       => clk,
        reset                     => reset,
        OFM_NL_cnt_finished       => OFM_NL_cnt_finished,
        OFM_NL_NoC_m_cnt_finished => OFM_NL_NoC_m_cnt_finished,
        ofm_FE_acc                => ofm_acc_tmp,
        ofm_sum                   => ofm_sum_tmp,
        en_ofm_in                 => en_ofm_in_tmp,
        en_ofm_sum                => en_ofm_sum_tmp,
        WE                        => WE_tmp,
        ofm_FE_out                => ofm_FE_out_tmp,
        en_ofm_out                => en_ofm_out_tmp,
        OFM_WRITE_BUSY            => OFM_WRITE_BUSY_tmp,
        OFM_READ_BUSY             => OFM_READ_BUSY_tmp,
        OFM_READ_FINISHED         => OFM_READ_FINISHED_tmp,
        INITN                     => INITN,
        A_2K_p1                   => A_2K_p1,
        CSN_2K_p1                 => CSN_2K_p1,
        D_2K_p1                   => D_2K_p1,
        WEN_2K_p1                 => WEN_2K_p1,
        A_2K_p2                   => A_2K_p2,
        CSN_2K_p2                 => CSN_2K_p2,
        Q_2K_p2                   => Q_2K_p2
    );

    -- SRAM_OFM_WRAPPER_BLOCK
    SRAM_OFM_WRAPPER_BLOCK_inst : SRAM_OFM_WRAPPER_BLOCK
    port map(
        clk            => clk,
        INITN          => INITN,
        OFM_WRITE_BUSY => OFM_WRITE_BUSY_tmp,
        OFM_READ_BUSY  => OFM_READ_BUSY_tmp,
        OFM_READ_FINISHED => OFM_READ_FINISHED_tmp,
        A_2K_p1        => A_2K_p1,
        CSN_2K_p1      => CSN_2K_p1,
        D_2K_p1        => D_2K_p1,
        WEN_2K_p1      => WEN_2K_p1,
        A_2K_p2        => A_2K_p2,
        CSN_2K_p2      => CSN_2K_p2,
        Q_2K_p2        => Q_2K_p2
    );

    -- PORT ASSIGNATIONS
    -- ..

end architecture;
