library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SRAM_IFM is
    port (
        clk : in std_logic;
        reset : in std_logic;
        -- To/From Front-End Read Interface
        h_p : in std_logic_vector (7 downto 0);
        w_p : in std_logic_vector (7 downto 0);
        HW : in std_logic_vector (7 downto 0);
        IFM_NL_ready : in std_logic;
        IFM_NL_finished : in std_logic;
        ifm_out : out std_logic_vector (7 downto 0)
        -- To/From Front-End Write Interface
        -- ..
    );
end SRAM_IFM;

architecture structural of SRAM_IFM is

    -- SIGNAL DECLARATIONS
    signal h_p_tmp : std_logic_vector (7 downto 0);
    signal w_p_tmp : std_logic_vector (7 downto 0);
    signal HW_tmp : std_logic_vector (7 downto 0);
    signal IFM_NL_ready_tmp : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal ifm_out_tmp : std_logic_vector (7 downto 0);
    signal ifm_tmp : std_logic_vector (7 downto 0);
    signal RE_tmp : std_logic;
    signal clkb_tmp : std_logic;
    signal rstb_tmp : std_logic;
    signal addrb_tmp : std_logic_vector (14 downto 0);
    signal doutb_tmp : std_logic_vector (31 downto 0);
    signal enb_tmp : std_logic;

    -- COMPONENT DECLARATIONS
    component SRAM_IFM_FRONT_END_READ is
    port(
        h_p : in std_logic_vector (7 downto 0);
        w_p : in std_logic_vector (7 downto 0);
        HW : in std_logic_vector (7 downto 0);
        IFM_NL_ready : in std_logic;
        IFM_NL_finished : in std_logic;
        ifm_out : out std_logic_vector (7 downto 0);
        -- Back-End (BE) Interface Ports
        ifm_BE : in std_logic_vector (7 downto 0);
        RE_BE : out std_logic
        );
    end component;

--    component SRAM_IFM_FRONT_END_WRITE is
--    port(clk                : in std_logic;
--         reset              : in std_logic
--         -- ...
--        );
--    end component;

    component SRAM_IFM_BACK_END is
    port(clk : in std_logic;
         reset : in std_logic;
        -- Front-End Interface Ports
         ifm_FE : out std_logic_vector (7 downto 0);
         RE_FE : in std_logic;
        -- SRAM Wrapper Ports (READ)
         clkb : out std_logic;
         rstb : out std_logic;
         addrb : out std_logic_vector (14 downto 0);
         doutb : in std_logic_vector (31 downto 0);
         enb : out std_logic
        -- SRAM Wrapper Ports (WRITE)
--        clka : out std_logic;
--        rsta : out std_logic;
--        addra : out std_logic_vector (14 downto 0);
--        dina : in std_logic_vector (31 downto 0);
--        ena : out std_logic;
--        wea : out std_logic_vector (3 downto 0)
        );
    end component;

    component blk_mem_gen_0 is
    port(clka : in std_logic;
         ena : in std_logic;
         wea : in std_logic_vector(3 downto 0);
         addra : in std_logic_vector(14 downto 0);
         dina : in std_logic_vector(31 downto 0);
         clkb : in std_logic;
         rstb : in std_logic;
         enb : in std_logic;
         addrb : in std_logic_vector(14 downto 0);
         doutb : out std_logic_vector(31 downto 0);
         rsta_busy : out std_logic;
         rstb_busy : out std_logic
        );
    end component;

begin

    -- SRAM_IFM_FRONT_END_READ
    SRAM_IFM_FRONT_END_READ_inst : SRAM_IFM_FRONT_END_READ
    port map (
        h_p => h_p_int,
        w_p => w_p_int,
        HW => HW_int,
        IFM_NL_ready => IFM_NL_ready_int,
        IFM_NL_finished => IFM_NL_finished_int,
        ifm_out => ifm_out_int,
        -- Back-End (BE) Interface Ports
        ifm_BE => ifm_int,
        RE_BE => RE_int
    );

    -- SRAM_IFM_BACK_END
    SRAM_IFM_BACK_END_inst : SRAM_IFM_BACK_END
    port map (
        clk => clk,
        reset => reset,
        ifm_FE => ifm_int,
        RE_FE => RE_int,
        clkb => clkb_int,
        rstb => rstb_int,
        addrb => addrb_int,
        doutb => doutb_int,
        enb => enb_int
    );

    -- blk_mem_gen_0
    blk_mem_gen_0_inst : blk_mem_gen_0
    port map (
        clka => '0',
        ena => '0',
        wea => (others => '0'),
        addra => (others => '0'),
        dina => (others => '0'),
        clkb => clkb_int,
        rstb => rstb_int,
        enb => enb_int,
        addrb => addrb_int,
        doutb => doutb_int,
        rsta_busy => open,
        rstb_busy => open
    );

    -- PORT ASSIGNATIONS
    h_p_tmp <= h_p;
    w_p_tmp <= w_p;
    HW_tmp <= HW;
    IFM_NL_ready_tmp <= IFM_NL_ready;
    IFM_NL_finished_tmp <= IFM_NL_finished;
    ifm_out <= ifm_out_int;


end architecture;