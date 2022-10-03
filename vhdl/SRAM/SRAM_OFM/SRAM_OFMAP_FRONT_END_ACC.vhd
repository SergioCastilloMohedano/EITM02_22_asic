library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM_FRONT_END_ACC is
    port (
        -- From Sys. Controller
        OFM_NL_Busy : in std_logic;
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
end SRAM_OFM_FRONT_END_ACC;

architecture dataflow of SRAM_OFM_FRONT_END_ACC is

    signal ofm_BE_tmp       : natural;
    signal ofm_BE_tmp_2     : natural;
    signal ofm_in_tmp       : natural;
    signal ofm_sum_tmp      : natural;
    signal NoC_c_tmp        : natural;
    signal en_ofm_in_tmp    : std_logic;
    signal en_ofm_sum_tmp   : std_logic;
    signal WE_tmp           : std_logic;
    signal NoC_c_nez        : std_logic;
    signal ofm_adder_in_tmp : natural;
    signal ofm_in_tmp_delay : natural;
    signal bias_tmp         : natural;

begin

    NoC_c_nez <= '0' when (NoC_c_tmp = 0) else '1'; --nez: not equal to zero

    ofm_BE_tmp_2 <= ofm_in_tmp   when (NoC_c_nez = '0') else (ofm_in_tmp + ofm_sum_tmp);
    ofm_BE_tmp   <= ofm_BE_tmp_2 when (NoC_c_nez = '1') else (ofm_BE_tmp_2 + bias_tmp);

    en_ofm_in_tmp  <= OFM_NL_Busy;
    en_ofm_sum_tmp <= NoC_c_nez;
    WE_tmp         <= shift_PISO;

    -- PORT Assignations
    ofm_BE      <= std_logic_vector(to_unsigned(ofm_BE_tmp, ofm_BE'length));
    ofm_in_tmp  <= to_integer(unsigned(ofm_in));
    ofm_sum_tmp <= to_integer(unsigned(ofm_sum));
    NoC_c_tmp   <= to_integer(unsigned(NoC_c));
    en_ofm_in   <= en_ofm_in_tmp;
    en_ofm_sum  <= en_ofm_sum_tmp;
    WE          <= WE_tmp;
    bias_tmp    <= to_integer(unsigned(bias));

end architecture;