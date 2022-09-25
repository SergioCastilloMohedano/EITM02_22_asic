library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        -- To/From Front-End Read Interface
        WB_NL_ready    : in std_logic;
        WB_NL_finished : in std_logic;
        wb_out         : out std_logic_vector (COMP_BITWIDTH - 1 downto 0)
        -- To/From Front-End Write Interface
        -- ..
    );
end SRAM_WB;

architecture structural of SRAM_WB is

    -- SIGNAL DECLARATIONS
    signal WB_NL_ready_tmp    : std_logic;
    signal WB_NL_finished_tmp : std_logic;
    signal wb_out_tmp         : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal wb_tmp             : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal RE_tmp             : std_logic;
    signal clkb_tmp           : std_logic;
    signal rstb_tmp           : std_logic;
    signal addrb_tmp          : std_logic_vector (16 downto 0);
    signal doutb_tmp          : std_logic_vector (15 downto 0);
    signal enb_tmp            : std_logic;

    -- COMPONENT DECLARATIONS
    component SRAM_WB_FRONT_END_READ is
        port (
            WB_NL_ready    : in std_logic;
            WB_NL_finished : in std_logic;
            wb_out         : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            -- Back-End (BE) Interface Ports
            wb_BE : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            RE_BE : out std_logic
        );
    end component;

    --    component SRAM_WB_FRONT_END_WRITE is
    --    port(clk                : in std_logic;
    --         reset              : in std_logic
    --         -- ...
    --        );
    --    end component;

    component SRAM_WB_BACK_END is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            -- Front-End Interface Ports
            wb_FE : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            RE_FE : in std_logic;
            -- SRAM Wrapper Ports (READ)
            clkb  : out std_logic;
            rstb  : out std_logic;
            addrb : out std_logic_vector (16 downto 0);
            doutb : in std_logic_vector (15 downto 0);
            enb   : out std_logic
            -- SRAM Wrapper Ports (WRITE)
            --        clka : out std_logic;
            --        rsta : out std_logic;
            --        addra : out std_logic_vector (16 downto 0);
            --        dina : in std_logic_vector (15 downto 0);
            --        ena : out std_logic;
            --        wea : out std_logic_vector (0 downto 0)
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

begin

    -- SRAM_WB_FRONT_END_READ
    SRAM_WB_FRONT_END_READ_inst : SRAM_WB_FRONT_END_READ
    port map(
        WB_NL_ready    => WB_NL_ready_tmp,
        WB_NL_finished => WB_NL_finished_tmp,
        wb_out         => wb_out_tmp,
        -- Back-End (BE) Interface Ports
        wb_BE => wb_tmp,
        RE_BE => RE_tmp
    );

    -- SRAM_WB_BACK_END
    SRAM_WB_BACK_END_inst : SRAM_WB_BACK_END
    port map(
        clk   => clk,
        reset => reset,
        wb_FE => wb_tmp,
        RE_FE => RE_tmp,
        clkb  => clkb_tmp,
        rstb  => rstb_tmp,
        addrb => addrb_tmp,
        doutb => doutb_tmp,
        enb   => enb_tmp
    );

    -- blk_mem_gen_1
    blk_mem_gen_1_inst : blk_mem_gen_1
    port map(
        clka      => '0',
        ena       => '0',
        wea => (others => '0'),
        addra => (others => '0'),
        dina => (others => '0'),
        clkb      => clkb_tmp,
        rstb      => rstb_tmp,
        enb       => enb_tmp,
        addrb     => addrb_tmp,
        doutb     => doutb_tmp,
        rsta_busy => open,
        rstb_busy => open
    );

    -- PORT ASSIGNATIONS
    WB_NL_ready_tmp    <= WB_NL_ready;
    WB_NL_finished_tmp <= WB_NL_finished;
    wb_out             <= wb_out_tmp;
end architecture;