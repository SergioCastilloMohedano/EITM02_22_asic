library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB_FRONT_END_READ is
    port (
        clk            : in std_logic;
        reset          : in std_logic;
        WB_NL_ready    : in std_logic; -- Reads SRAM exactly on those moments in which this signal is '0', when NL is not idle.
        WB_NL_finished : in std_logic; -- WB NL has finished. Do not read SRAM anymore.
        NoC_c          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_pm_bias    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        OFM_NL_Write   : in std_logic;
        READ_CFG       : in std_logic;
        w_out          : out std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
        b_out          : out std_logic_vector (BIAS_BITWIDTH - 1 downto 0);
        cfg_out        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        -- Back-End (BE) Interface Ports
        wb_BE       : in std_logic_vector (BIAS_BITWIDTH - 1 downto 0);
        cfg_BE      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        en_w_read   : out std_logic;
        en_b_read   : out std_logic;
        en_cfg_read : out std_logic;
        NoC_pm_BE   : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
    );
end SRAM_WB_FRONT_END_READ;

architecture dataflow of SRAM_WB_FRONT_END_READ is

    signal NoC_pm_BE_tmp      : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal w_out_tmp          : std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
    signal b_out_tmp          : std_logic_vector (BIAS_BITWIDTH - 1 downto 0);
    signal WB_NL_ready_tmp    : std_logic;
    signal WB_NL_finished_tmp : std_logic;
    signal NoC_c_tmp          : natural;
    signal wb_BE_tmp          : std_logic_vector (BIAS_BITWIDTH - 1 downto 0);
    signal en_w_read_tmp      : std_logic;
    signal en_w_read_tmp_2    : std_logic;
    signal en_w_read_reg      : std_logic;
    signal en_w_read_next     : std_logic;
    signal en_b_read_tmp      : std_logic;
    signal NoC_c_eqz          : std_logic;

begin

    NoC_pm_BE_tmp <= NoC_pm_bias;
    w_out_tmp     <= wb_BE_tmp(BIAS_BITWIDTH - 1 downto (BIAS_BITWIDTH - WEIGHT_BITWIDTH)) when (en_w_read_tmp_2 = '1') else (others => '0'); -- 8 MSBs <3.5>
    b_out_tmp     <= wb_BE_tmp when (en_b_read_tmp = '1') else (others => '0');
    
    NoC_c_eqz <= '1' when (NoC_c_tmp = 0) else '0';

    en_w_read_next <= '1' when ((WB_NL_ready nor WB_NL_finished) = '1') else '0';
    en_w_read_reg_proc : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                en_w_read_reg <= '0';
            else
                en_w_read_reg <= en_w_read_next;
            end if;
        end if;
    end process;
    en_w_read_tmp_2 <= en_w_read_next or en_w_read_reg; --extend ctrl signal 1cc to allow last value from reading pass from going to PE Array.
    en_w_read_tmp   <= en_w_read_next;

    en_b_read_tmp <= '1' when ((NoC_c_eqz and OFM_NL_Write) = '1') else '0';

    -- PORT Assignations
    NoC_pm_BE   <= NoC_pm_BE_tmp;
    w_out       <= w_out_tmp;
    b_out       <= b_out_tmp;
    wb_BE_tmp   <= wb_BE;
    NoC_c_tmp   <= to_integer(unsigned(NoC_c));
    en_w_read   <= en_w_read_tmp;
    en_b_read   <= en_b_read_tmp;
    en_cfg_read <= READ_CFG;
    cfg_out     <= cfg_BE;

end architecture;