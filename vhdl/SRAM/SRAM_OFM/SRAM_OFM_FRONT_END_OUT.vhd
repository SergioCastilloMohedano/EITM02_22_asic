library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM_FRONT_END_OUT is
    port (
        -- From Sys. Controller
        OFM_NL_Read : in std_logic;
        -- From/To Back-End Interface
        en_ofm_out  : out std_logic;
        ofm_BE      : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
        ofm         : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0)
    );
end SRAM_OFM_FRONT_END_OUT;

architecture dataflow of SRAM_OFM_FRONT_END_OUT is

    signal ofm_tmp        : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal en_ofm_out_tmp : std_logic;

begin

    en_ofm_out_tmp <= OFM_NL_Read;
    en_ofm_out     <= en_ofm_out_tmp;
    ofm_tmp        <= ofm_BE;
    ofm            <= ofm_tmp;

end architecture;