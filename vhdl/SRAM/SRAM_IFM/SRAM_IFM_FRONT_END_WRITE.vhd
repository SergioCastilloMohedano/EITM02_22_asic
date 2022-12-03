library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_IFM_FRONT_END_WRITE is
    port (
        clk         : in std_logic;
        is_pooling  : in std_logic;
        en_w_IFM    : in std_logic;
        pooling_ack : in std_logic;
        pooling_IFM : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        rn_IFM      : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        -- Back-End (BE) Interface Ports
        ifm_BE_w : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        en_w     : out std_logic;
        WE_BE    : out std_logic
    );
end SRAM_IFM_FRONT_END_WRITE;

architecture dataflow of SRAM_IFM_FRONT_END_WRITE is

    signal WE_tmp       : std_logic;
    signal en_w_tmp     : std_logic;
    signal ifm_w_tmp    : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal en_w_IFM_tmp : std_logic;

begin

    en_w_IFM_tmp <= en_w_IFM when rising_edge(clk);
    WE_tmp       <= pooling_ack when is_pooling = '1' else en_w_IFM_tmp;
    ifm_w_tmp    <= pooling_IFM when is_pooling = '1' else rn_IFM;
    en_w_tmp     <= (en_w_IFM_tmp or en_w_IFM);

    -- PORT Assignations
    ifm_BE_w <= ifm_w_tmp;
    en_w     <= en_w_tmp;
    WE_BE    <= WE_tmp;

end architecture;