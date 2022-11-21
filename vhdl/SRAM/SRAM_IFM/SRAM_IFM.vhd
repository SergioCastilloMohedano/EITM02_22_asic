library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_IFM is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        -- To/From Front-End Read Interface
        h_p             : in std_logic_vector (7 downto 0);
        w_p             : in std_logic_vector (7 downto 0);
        HW              : in std_logic_vector (7 downto 0);
        RS              : in std_logic_vector (7 downto 0);
        IFM_NL_ready    : in std_logic;
        IFM_NL_finished : in std_logic;
        ifm_out         : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        -- To/From Front-End Write Interface
        is_pooling  : in std_logic;
        en_w_IFM    : in std_logic;
        pooling_ack : in std_logic;
        pooling_IFM : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        sr_IFM      : in std_logic_vector (COMP_BITWIDTH - 1 downto 0)
    );
end SRAM_IFM;

architecture structural of SRAM_IFM is

    -- SIGNAL DECLARATIONS
    signal h_p_tmp             : std_logic_vector (7 downto 0);
    signal w_p_tmp             : std_logic_vector (7 downto 0);
    signal HW_tmp              : std_logic_vector (7 downto 0);
    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal ifm_out_tmp         : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal ifm_r_tmp           : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal RE_tmp              : std_logic;
    signal addrb_tmp           : std_logic_vector (11 downto 0);
    signal doutb_tmp           : std_logic_vector (31 downto 0);
    signal enb_tmp             : std_logic;
    signal ena_tmp             : std_logic;
    signal wea_tmp             : std_logic_vector (3 downto 0);
    signal addra_tmp           : std_logic_vector(11 downto 0);
    signal dina_tmp            : std_logic_vector(31 downto 0);
    signal ifm_w_tmp           : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal en_w_tmp            : std_logic;
    signal WE_tmp              : std_logic;

    -- COMPONENT DECLARATIONS
    component SRAM_IFM_FRONT_END_READ is
        port (
            h_p             : in std_logic_vector (7 downto 0);
            w_p             : in std_logic_vector (7 downto 0);
            HW              : in std_logic_vector (7 downto 0);
            RS              : in std_logic_vector (7 downto 0);
            IFM_NL_ready    : in std_logic;
            IFM_NL_finished : in std_logic;
            ifm_out         : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            -- Back-End (BE) Interface Ports
            ifm_BE_r : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            RE_BE    : out std_logic
        );
    end component;

    component SRAM_IFM_FRONT_END_WRITE is
        port (
            clk         : in std_logic;
            is_pooling  : in std_logic;
            en_w_IFM    : in std_logic;
            pooling_ack : in std_logic;
            pooling_IFM : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            sr_IFM      : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            -- Back-End (BE) Interface Ports
            ifm_BE_w : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            en_w     : out std_logic;
            WE_BE    : out std_logic
        );
    end component;

    component SRAM_IFM_BACK_END is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- Front-End Interface Ports (READ)
            ifm_FE_r : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            RE_FE    : in std_logic;
            -- Front-End Interface Ports (WRITE)
            ifm_FE_w : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            en_w     : in std_logic;
            WE_FE    : in std_logic;
            -- SRAM Wrapper Ports (READ)
            addrb : out std_logic_vector (11 downto 0);
            doutb : in std_logic_vector (31 downto 0);
            enb   : out std_logic;
            -- SRAM Wrapper Ports (WRITE)
            addra : out std_logic_vector (11 downto 0);
            dina  : out std_logic_vector (31 downto 0);
            ena   : out std_logic;
            wea   : out std_logic_vector (3 downto 0)
        );
    end component;

    component blk_mem_gen_0 is
        port (
            clka      : in std_logic;
            ena       : in std_logic;
            wea       : in std_logic_vector(3 downto 0);
            addra     : in std_logic_vector(11 downto 0);
            dina      : in std_logic_vector(31 downto 0);
            clkb      : in std_logic;
            rstb      : in std_logic;
            enb       : in std_logic;
            addrb     : in std_logic_vector(11 downto 0);
            doutb     : out std_logic_vector(31 downto 0);
            rsta_busy : out std_logic;
            rstb_busy : out std_logic
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
        sr_IFM      => sr_IFM,
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
        addrb    => addrb_tmp,
        doutb    => doutb_tmp,
        enb      => enb_tmp,
        ena      => ena_tmp,
        wea      => wea_tmp,
        addra    => addra_tmp,
        dina     => dina_tmp
    );

    -- blk_mem_gen_0
    blk_mem_gen_0_inst : blk_mem_gen_0
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
    h_p_tmp             <= h_p;
    w_p_tmp             <= w_p;
    HW_tmp              <= HW;
    IFM_NL_ready_tmp    <= IFM_NL_ready;
    IFM_NL_finished_tmp <= IFM_NL_finished;
    ifm_out             <= ifm_out_tmp;
end architecture;