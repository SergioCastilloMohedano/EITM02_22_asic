library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB is
    generic (
        -- HW Parameters, at synthesis time.
        EOM_ADDR_WB_SRAM : natural := 82329 -- End Of Memory Address of the WB SRAM, this is where first bias value is stored, in decreasing order of addresses.
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;
        -- Sys. Ctr. Signals
        WB_NL_ready    : in std_logic;
        WB_NL_finished : in std_logic;
        NoC_c          : in std_logic_vector (7 downto 0);
        NoC_pm_bias    : in std_logic_vector (7 downto 0);
        OFM_NL_Write   : in std_logic;
        -- Front-End Read Interface
        w_out : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        b_out : out std_logic_vector (15 downto 0)
        -- Front-End Write Interface
        -- ..
    );
end SRAM_WB;

architecture structural of SRAM_WB is

    -- SIGNAL DECLARATIONS
    signal WB_NL_ready_tmp    : std_logic;
    signal WB_NL_finished_tmp : std_logic;
    signal w_out_tmp          : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal b_out_tmp          : std_logic_vector (15 downto 0);
    signal wb_tmp             : std_logic_vector (15 downto 0);
    signal en_w_read_tmp      : std_logic;
    signal en_b_read_tmp      : std_logic;
    signal NoC_pm_tmp         : std_logic_vector (7 downto 0);

    signal addrb_tmp : std_logic_vector (16 downto 0);
    signal doutb_tmp : std_logic_vector (15 downto 0);
    signal enb_tmp   : std_logic;

    signal A_8K_1_tmp   : std_logic_vector(12 downto 0);
    signal CSN_8K_1_tmp : std_logic;
    signal D_8K_1_tmp   : std_logic_vector (31 downto 0);
    signal Q_8K_1_tmp   : std_logic_vector (31 downto 0);
    signal WEN_8K_1_tmp : std_logic;
    signal A_8K_2_tmp   : std_logic_vector(12 downto 0);
    signal CSN_8K_2_tmp : std_logic;
    signal D_8K_2_tmp   : std_logic_vector (31 downto 0);
    signal Q_8K_2_tmp   : std_logic_vector (31 downto 0);
    signal WEN_8K_2_tmp : std_logic;
    signal A_4K_tmp     : std_logic_vector(11 downto 0);
    signal CSN_4K_tmp   : std_logic;
    signal D_4K_tmp     : std_logic_vector (31 downto 0);
    signal Q_4K_tmp     : std_logic_vector (31 downto 0);
    signal WEN_4K_tmp   : std_logic;
    signal INITN_tmp    : std_logic;

    -- COMPONENT DECLARATIONS
    component SRAM_WB_FRONT_END_READ is
        port (
            clk            : in std_logic;
            reset          : in std_logic;
            WB_NL_ready    : in std_logic;
            WB_NL_finished : in std_logic;
            NoC_c          : in std_logic_vector (7 downto 0);
            NoC_pm_bias    : in std_logic_vector (7 downto 0);
            OFM_NL_Write   : in std_logic;
            w_out          : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            b_out          : out std_logic_vector (15 downto 0);
            -- Back-End (BE) Interface Ports
            wb_BE     : in std_logic_vector (15 downto 0);
            en_w_read : out std_logic;
            en_b_read : out std_logic;
            NoC_pm_BE : out std_logic_vector (7 downto 0)
        );
    end component;

    --    component SRAM_WB_FRONT_END_WRITE is
    --    port(clk                : in std_logic;
    --         reset              : in std_logic
    --         -- ...
    --        );
    --    end component;

    component SRAM_WB_BACK_END is
        generic (
            EOM_ADDR_WB_SRAM : natural := 82329 -- End Of Memory Address of the WB SRAM, this is where first bias value is stored, in decreasing order of addresses.
        );
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- Front-End Interface Ports
            wb_FE     : out std_logic_vector (15 downto 0);
            en_w_read : in std_logic;
            en_b_read : in std_logic;
            NoC_pm_FE : in std_logic_vector (7 downto 0);
            -- SRAM Wrapper Ports (READ)
            addrb : out std_logic_vector (16 downto 0);
            doutb : in std_logic_vector (15 downto 0);
            enb   : out std_logic
            -- SRAM Wrapper Ports (WRITE)
            -- addra : out std_logic_vector (16 downto 0);
            -- dina : in std_logic_vector (15 downto 0);
            -- ena : out std_logic;
            -- wea : out std_logic_vector (0 downto 0)
        );
    end component;

    component SRAM_WB_BACK_END_ASIC is
        generic (
            -- HW Parameters, at synthesis time.
            ADDR_4K_CFG : natural := 4042 -- First Address of the reserved space for config. parameters.
        );
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- Front-End Interface Ports
            wb_FE     : out std_logic_vector (15 downto 0);
            en_w_read : in std_logic;
            en_b_read : in std_logic;
            NoC_pm_FE : in std_logic_vector (7 downto 0);
            -- SRAM Block Wrapper Ports (ASIC)
            A_8K_1   : out std_logic_vector(12 downto 0);
            CSN_8K_1 : out std_logic;
            D_8K_1   : out std_logic_vector (31 downto 0);
            Q_8K_1   : in std_logic_vector (31 downto 0);
            WEN_8K_1 : out std_logic;
            A_8K_2   : out std_logic_vector(12 downto 0);
            CSN_8K_2 : out std_logic;
            D_8K_2   : out std_logic_vector (31 downto 0);
            Q_8K_2   : in std_logic_vector (31 downto 0);
            WEN_8K_2 : out std_logic;
            A_4K     : out std_logic_vector(11 downto 0);
            CSN_4K   : out std_logic;
            D_4K     : out std_logic_vector (31 downto 0);
            Q_4K     : in std_logic_vector (31 downto 0);
            WEN_4K   : out std_logic;
            INITN    : out std_logic
        );
    end component;

    component blk_mem_gen_1 is
        port (
            clka      : in std_logic;
            ena       : in std_logic;
            wea       : in std_logic_vector (0 downto 0);
            addra     : in std_logic_vector(16 downto 0);
            dina      : in std_logic_vector(15 downto 0);
            clkb      : in std_logic;
            rstb      : in std_logic;
            enb       : in std_logic;
            addrb     : in std_logic_vector(16 downto 0);
            doutb     : out std_logic_vector(15 downto 0);
            rsta_busy : out std_logic;
            rstb_busy : out std_logic
        );
    end component;

    component SRAM_WB_WRAPPER_BLOCK is
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
    end component;

begin

    -- SRAM_WB_FRONT_END_READ
    SRAM_WB_FRONT_END_READ_inst : SRAM_WB_FRONT_END_READ
    port map(
        clk            => clk,
        reset          => reset,
        WB_NL_ready    => WB_NL_ready_tmp,
        WB_NL_finished => WB_NL_finished_tmp,
        NoC_c          => NoC_c,
        NoC_pm_bias    => NoC_pm_bias,
        OFM_NL_Write   => OFM_NL_Write,
        w_out          => w_out_tmp,
        b_out          => b_out_tmp,
        -- Back-End (BE) Interface Ports
        wb_BE     => wb_tmp,
        en_w_read => en_w_read_tmp,
        en_b_read => en_b_read_tmp,
        NoC_pm_BE => NoC_pm_tmp
    );

    -- SRAM_WB_BACK_END
    SRAM_WB_BACK_END_inst : SRAM_WB_BACK_END
    generic map(
        EOM_ADDR_WB_SRAM => EOM_ADDR_WB_SRAM
    )
    port map(
        clk       => clk,
        reset     => reset,
        wb_FE     => wb_tmp,
        en_w_read => en_w_read_tmp,
        en_b_read => en_b_read_tmp,
        NoC_pm_FE => NoC_pm_tmp,
        addrb     => addrb_tmp,
        doutb     => doutb_tmp,
        enb       => enb_tmp
    );

    -- SRAM_WB_BACK_END_asic
    SRAM_WB_BACK_END_asic_inst : SRAM_WB_BACK_END_ASIC
    generic map(
        ADDR_4K_CFG => 4042
    )
    port map(
        clk       => clk,
        reset     => reset,
        wb_FE     => wb_tmp,
        en_w_read => en_w_read_tmp,
        en_b_read => en_b_read_tmp,
        NoC_pm_FE => NoC_pm_tmp,
        A_8K_1    => A_8K_1_tmp,
        CSN_8K_1  => CSN_8K_1_tmp,
        D_8K_1    => open, --D_8K_1_tmp,
        Q_8K_1    => Q_8K_1_tmp,
        WEN_8K_1  => open, --WEN_8K_1_tmp,
        A_8K_2    => A_8K_2_tmp,
        CSN_8K_2  => CSN_8K_2_tmp,
        D_8K_2    => open, --D_8K_2_tmp,
        Q_8K_2    => Q_8K_2_tmp,
        WEN_8K_2  => open, --WEN_8K_2_tmp,
        A_4K      => A_4K_tmp,
        CSN_4K    => CSN_4K_tmp,
        D_4K      => open, --D_4K_tmp,
        Q_4K      => Q_4K_tmp,
        WEN_4K    => open, --WEN_4K_tmp,
        INITN     => INITN_tmp
    );

    -- blk_mem_gen_1
    blk_mem_gen_1_inst : blk_mem_gen_1
    port map(
        clka      => clk,
        ena       => '0',
        wea => (others => '0'),
        addra => (others => '0'),
        dina => (others => '0'),
        clkb      => clk,
        rstb      => reset,
        enb       => enb_tmp,
        addrb     => addrb_tmp,
        doutb     => doutb_tmp,
        rsta_busy => open,
        rstb_busy => open
    );

    -- SRAM_WB_WRAPPER_BLOCK
    SRAM_WB_WRAPPER_BLOCK_inst : SRAM_WB_WRAPPER_BLOCK
    port map(
        clk      => clk,
        A_8K_1   => A_8K_1_tmp,
        CSN_8K_1 => CSN_8K_1_tmp,
        D_8K_1   => (others => '0'), --D_8K_1_tmp,
        Q_8K_1   => Q_8K_1_tmp,
        WEN_8K_1 => '0', --WEN_8K_1_tmp,
        A_8K_2   => A_8K_2_tmp,
        CSN_8K_2 => CSN_8K_2_tmp,
        D_8K_2   => (others => '0'), --D_8K_2_tmp,
        Q_8K_2   => Q_8K_2_tmp,
        WEN_8K_2 => '0', --WEN_8K_2_tmp,
        A_4K     => A_4K_tmp,
        CSN_4K   => CSN_4K_tmp,
        D_4K     => (others => '0'), --D_4K_tmp,
        Q_4K     => Q_4K_tmp,
        WEN_4K   => '0', --WEN_4K_tmp,
        INITN    => INITN_tmp
    );

    -- PORT ASSIGNATIONS
    WB_NL_ready_tmp    <= WB_NL_ready;
    WB_NL_finished_tmp <= WB_NL_finished;
    w_out              <= w_out_tmp;
    b_out              <= b_out_tmp;

end architecture;