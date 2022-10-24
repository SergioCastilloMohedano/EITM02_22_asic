library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- From Sys Controller
        NoC_c                     : in std_logic_vector (7 downto 0);
        OFM_NL_cnt_finished       : in std_logic; -- reset address back to 0 when all ofmaps of current layer have been processed.
        OFM_NL_NoC_m_cnt_finished : in std_logic;
        OFM_NL_Write              : in std_logic;
        OFM_NL_Read              : in std_logic;

        -- From Adder Tree Top
        ofmap      : in std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);
        shift_PISO : in std_logic; -- (enable signal)

        -- From WB SRAM
        bias : in std_logic_vector (15 downto 0);

        -- To Stochastic Rounding / ReLU Block
        ofm : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0)
    );
end SRAM_OFM;

architecture structural of SRAM_OFM is

    -- SIGNAL DECLARATIONS
    signal addrb_tmp      : std_logic_vector (13 downto 0);
    signal doutb_tmp      : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal enb_tmp        : std_logic;
    signal addra_tmp      : std_logic_vector (13 downto 0);
    signal dina_tmp       : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal ena_tmp        : std_logic;
    signal wea_tmp        : std_logic_vector(0 downto 0);
    signal ofm_acc_tmp    : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal ofm_sum_tmp    : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal en_ofm_in_tmp  : std_logic;
    signal en_ofm_sum_tmp : std_logic;
    signal WE_tmp         : std_logic;
    signal en_ofm_out_tmp : std_logic;
    signal ofm_FE_out_tmp : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);

    -- COMPONENT DECLARATIONS
    component SRAM_OFM_FRONT_END_ACC is
        port (
            -- From Sys. Controller
            OFM_NL_Write : in std_logic;
            NoC_c       : in std_logic_vector (7 downto 0);
            -- From PISO Buffer
            shift_PISO  : in std_logic;
            ofm_in      : in std_logic_vector (OFMAP_P_BITWIDTH - 1 downto 0);
            -- From/To Back-End Interface
            en_ofm_in   : out std_logic;
            en_ofm_sum  : out std_logic;
            WE          : out std_logic;
            ofm_sum     : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            ofm_BE      : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            -- From WB SRAM
            bias        : in std_logic_vector (15 downto 0)
        );
    end component;

    component SRAM_OFM_FRONT_END_OUT is
        port (
            -- From Sys. Controller
            OFM_NL_Read : in std_logic;
            -- From/To Back-End Interface
            en_ofm_out  : out std_logic;
            ofm_BE      : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            ofm         : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0)
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
            addra : out std_logic_vector (13 downto 0);
            dina  : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            ena   : out std_logic;
            wea   : out std_logic_vector (0 downto 0);
            addrb : out std_logic_vector (13 downto 0);
            doutb : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            enb   : out std_logic
        );
    end component;

    component blk_mem_gen_2 is
        port (
            clka      : in std_logic;
            ena       : in std_logic;
            wea       : in std_logic_vector(0 downto 0);
            addra     : in std_logic_vector(13 downto 0);
            dina      : in std_logic_vector(OFMAP_BITWIDTH - 1 downto 0);
            clkb      : in std_logic;
            rstb      : in std_logic;
            enb       : in std_logic;
            addrb     : in std_logic_vector(13 downto 0);
            doutb     : out std_logic_vector(OFMAP_BITWIDTH - 1 downto 0);
            rsta_busy : out std_logic;
            rstb_busy : out std_logic
        );
    end component;

begin

    -- SRAM_OFM_FRONT_END_ACC
    SRAM_OFM_FRONT_END_ACC_inst : SRAM_OFM_FRONT_END_ACC
    port map(
        OFM_NL_Write => OFM_NL_Write,
        NoC_c       => NoC_c,
        shift_PISO  => shift_PISO,
        ofm_in      => ofmap,
        en_ofm_in   => en_ofm_in_tmp,
        en_ofm_sum  => en_ofm_sum_tmp,
        WE          => WE_tmp,
        ofm_sum     => ofm_sum_tmp,
        ofm_BE      => ofm_acc_tmp,
        bias        => bias
    );

    -- SRAM_OFM_FRONT_END_OUT
    SRAM_OFM_FRONT_END_OUT_inst : SRAM_OFM_FRONT_END_OUT
    port map (
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
        addra                     => addra_tmp,
        dina                      => dina_tmp,
        ena                       => ena_tmp,
        wea                       => wea_tmp,
        addrb                     => addrb_tmp,
        doutb                     => doutb_tmp,
        enb                       => enb_tmp
    );

    -- blk_mem_gen_2
    blk_mem_gen_2_inst : blk_mem_gen_2
    port map(
        clka      => clk,
        ena       => ena_tmp,
        wea       => wea_tmp,
        addra     => addra_tmp,
        dina      => dina_tmp,
        clkb      => clk,
        rstb      => reset,
        enb       => enb_tmp,
        addrb     => addrb_tmp,
        doutb     => doutb_tmp,
        rsta_busy => open,
        rstb_busy => open
    );

    -- PORT ASSIGNATIONS
    -- ..

end architecture;