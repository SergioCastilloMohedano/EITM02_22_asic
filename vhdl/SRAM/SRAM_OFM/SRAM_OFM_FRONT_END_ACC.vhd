library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM_FRONT_END_ACC is
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
end SRAM_OFM_FRONT_END_ACC;

architecture dataflow of SRAM_OFM_FRONT_END_ACC is

    signal ofm_BE_tmp : signed (OFMAP_BITWIDTH - 1 downto 0);
    signal ofm_BE_tmp_2 : signed (OFMAP_BITWIDTH - 1 downto 0);
    signal ofm_BE_tmp_3 : signed (OFMAP_BITWIDTH - 1 downto 0);
    signal sign_extension : signed (OFMAP_BITWIDTH - OFMAP_P_BITWIDTH - 1 downto 0);
    signal acc_addition : signed (OFMAP_BITWIDTH - 1 downto 0);
    signal ofm_in_tmp : signed (OFMAP_P_BITWIDTH - 1 downto 0);
    signal ofm_sum_tmp : signed (OFMAP_BITWIDTH - 1 downto 0);
    signal NoC_c_tmp        : natural;
    signal en_ofm_in_tmp    : std_logic;
    signal en_ofm_sum_tmp   : std_logic;
    signal WE_tmp           : std_logic;
    signal NoC_c_nez        : std_logic;
    signal bias_tmp         : signed (BIAS_BITWIDTH - 1 downto 0);

    -- Bias rounding
    -- bias 16<3.13> & ofmap 34<10+(3+8).(5+8)> = 34<21.13>
    -- Align binary point: 13 - (8+5) = 0 
    -- Operands already aligned, hence there is no need to round the bias
    -- Otherwise, Round To Nearest the corresponding LSBs of fractional part of bias, and disregard them.

begin

    NoC_c_nez <= '0' when (NoC_c_tmp = 0) else '1'; --nez: not equal to zero

    sign_extension <= (others => ofm_in_tmp(ofm_in_tmp'length - 1));
    acc_addition <= (ofm_in_tmp + ofm_sum_tmp);
    ofm_BE_tmp_3 <= (sign_extension & ofm_in_tmp) when (NoC_c_nez = '0') else acc_addition; -- acc.
    ofm_BE_tmp_2 <= ofm_BE_tmp_3 when (NoC_c_nez = '1') else (ofm_BE_tmp_3 + bias_tmp); -- bias (no alignment needed)

    -- Although it's very unlikely, since the word's length of memory is 32 bits and
    -- OFMAP_BITWIDTH = 34, it might happen that ofmap value may be higher(lower) than max(min)
    -- possible representable value in 32 bit fixed-point format. In which case truncation is
    -- applied to the 34b fixed-point value up(down) to the max(min) value in 32b fixed-point.
    -- min_32b = -2^(32 - 1)    = -2147483648 = b01111...1111;
    -- max_32b = 2^(32 - 1) - 1 =  2147483647 = b10000...0000;
    ofm_BE_tmp <= to_signed(-2147483648, ofm_BE_tmp'length) when (ofm_BE_tmp_2 < to_signed(-2147483648, ofm_BE_tmp_2'length)) else
                  to_signed(2147483647, ofm_BE_tmp'length)  when (ofm_BE_tmp_2 > to_signed(2147483647, ofm_BE_tmp_2'length)) else
                  ofm_BE_tmp_2;

    en_ofm_in_tmp  <= OFM_NL_Write;
    en_ofm_sum_tmp <= NoC_c_nez;
    WE_tmp         <= shift_PISO;

    -- PORT Assignations
    ofm_BE      <= std_logic_vector(ofm_BE_tmp);
    ofm_in_tmp  <= signed(ofm_in);
    ofm_sum_tmp <= signed(ofm_sum);
    NoC_c_tmp   <= to_integer(unsigned(NoC_c));
    en_ofm_in   <= en_ofm_in_tmp;
    en_ofm_sum  <= en_ofm_sum_tmp;
    WE          <= WE_tmp;

    bias_tmp   <= signed(bias);

end architecture;
