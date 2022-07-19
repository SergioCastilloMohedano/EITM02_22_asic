-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SRAM_READ_tb.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-07-05
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : ..
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SRAM_READ_tb is
end SRAM_READ_tb;

architecture sim of SRAM_READ_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    constant X : natural := 32;
    constant M_cap : natural := 32;
    constant C_cap : natural := 16;
    constant RS : natural := 3;
    constant HW : natural := 16;
    constant HW_p : natural := HW + 2;
    constant EF : natural := HW;
    constant r : natural := X/EF; -- X/E
    constant p : natural := 8;
    constant t : natural := 1; -- it must always be 1
    constant M_div_pt : natural := M_cap/(p*t); --M/p*t
    constant HYP_BITWIDTH : natural := 8;

    signal clk : std_logic := '1';
    signal reset : std_logic := '1';

    signal NL_start_tb : std_logic := '0';
    signal NL_ready_tb : std_logic;
    signal NL_finished_tb : std_logic;
    signal M_cap_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_cap, HYP_BITWIDTH));
    signal C_cap_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(C_cap, HYP_BITWIDTH));
    signal r_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(r, HYP_BITWIDTH));
    signal p_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(p, HYP_BITWIDTH));
    signal RS_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(RS, HYP_BITWIDTH));
    signal HW_p_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW_p, HYP_BITWIDTH));
    signal HW_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(HW, HYP_BITWIDTH));
    signal m_tb : std_logic_vector (7 downto 0);
    signal c_tb : std_logic_vector (7 downto 0);
    signal rc_tb : std_logic_vector (7 downto 0);
    signal h_p_tb : std_logic_vector (7 downto 0);
    signal w_p_tb : std_logic_vector (7 downto 0);
    signal r_p_tb : std_logic_vector (7 downto 0);
    signal pm_tb : std_logic_vector (7 downto 0);
    signal s_tb : std_logic_vector (7 downto 0);
    signal M_div_pt_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_div_pt, HYP_BITWIDTH));

    signal NoC_ACK_flag_tb : std_logic := '0';

    signal IFM_NL_ready_tb : std_logic;
    signal IFM_NL_finished_tb : std_logic;
    signal WB_NL_ready_tb : std_logic;
    signal WB_NL_finished_tb : std_logic;

    signal ifm_out_tb : std_logic_vector (7 downto 0);
    signal wb_out_tb : std_logic_vector (15 downto 0);

    component SYS_CTR_NL is
    port (
        clk : in std_logic;
        reset : in std_logic;
        NL_start : in std_logic;
        NL_ready : out std_logic;
        NL_finished : out std_logic;
        M_cap : in std_logic_vector (7 downto 0);
        C_cap : in std_logic_vector (7 downto 0);
        r : in std_logic_vector (7 downto 0);
        p : in std_logic_vector (7 downto 0);
        RS : in std_logic_vector (7 downto 0);
        HW_p : in std_logic_vector (7 downto 0);
        m : out std_logic_vector (7 downto 0);
        c : out std_logic_vector (7 downto 0);
        rc : out std_logic_vector (7 downto 0);
        r_p : out std_logic_vector (7 downto 0);
        pm : out std_logic_vector (7 downto 0);
        s : out std_logic_vector (7 downto 0);
        h_p : out std_logic_vector (7 downto 0);
        w_p : out std_logic_vector (7 downto 0);
        M_div_pt : in std_logic_vector (7 downto 0);
        NoC_ACK_flag : in std_logic;
        IFM_NL_ready : out std_logic;
        IFM_NL_finished : out std_logic;
        WB_NL_ready : out std_logic;
        WB_NL_finished : out std_logic
    );
   end component;

    component SRAM_IFM is
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
    end component;

    component SRAM_WB is
    port (
        clk : in std_logic;
        reset : in std_logic;
        -- To/From Front-End Read Interface
        WB_NL_ready : in std_logic;
        WB_NL_finished : in std_logic;
        wb_out : out std_logic_vector (15 downto 0)
        -- To/From Front-End Write Interface
        -- ..
    );
    end component;
begin

    clk <= not clk after clk_period / 2;

    DUT_SYS_CTR_NL : SYS_CTR_NL
    port map (
        clk => clk,
        reset => reset,
        NL_start => NL_start_tb,
        NL_ready => NL_ready_tb,
        NL_finished => NL_finished_tb,
        M_cap => M_cap_tb,
        C_cap => C_cap_tb,
        r => r_tb,
        p => p_tb,
        RS => RS_tb,
        HW_p => HW_p_tb,
        m => m_tb,
        c => c_tb,
        rc => rc_tb,
        r_p => r_p_tb,
        pm => pm_tb,
        s => s_tb,
        h_p => h_p_tb,
        w_p => w_p_tb,
        M_div_pt => M_div_pt_tb,
        NoC_ACK_flag => NoC_ACK_flag_tb,
        IFM_NL_ready => IFM_NL_ready_tb,
        IFM_NL_finished => IFM_NL_finished_tb,
        WB_NL_ready => WB_NL_ready_tb,
        WB_NL_finished => WB_NL_finished_tb
    );

    DUT_SRAM_IFM : SRAM_IFM
    port map (
        clk => clk,
        reset => reset,
        h_p => h_p_tb,
        w_p => w_p_tb,
        HW => HW_tb,
        IFM_NL_ready => IFM_NL_ready_tb,
        IFM_NL_finished => IFM_NL_finished_tb,
        ifm_out => ifm_out_tb
    );

    DUT_SRAM_WB : SRAM_WB
    port map (
        clk => clk,
        reset => reset,
        WB_NL_ready => WB_NL_ready_tb,
        WB_NL_finished => WB_NL_finished_tb,
        wb_out => wb_out_tb
    );

    NOC_ACK_PROC : process
    begin
        NoC_ACK_flag_tb <= '0';
        wait for 20 us;
        NoC_ACK_flag_tb <= '1';
        wait for clk_period;
    end process;

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        reset <= '0';

        wait for clk_period * 10;
        NL_start_tb <= '1';
        wait for clk_period;
        NL_start_tb <= '0';
        wait;
    end process;

--    RE_BE_ASSERT_PROC : process
--    begin
--        assert RE_BE_tb = '1' report "Read Enabled" severity warning;
--        wait;
--    end process;

end architecture;