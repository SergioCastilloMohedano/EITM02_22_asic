library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity RN_RELU is
    port (
        value_in  : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
        value_out : out std_logic_vector (ACT_BITWIDTH - 1 downto 0)
    );
end RN_RELU;

architecture dataflow of RN_RELU is

    -- signal declarations

    signal value_relu  : signed (OFMAP_BITWIDTH - 1 downto 0);
    signal value_round : signed (OFMAP_BITWIDTH - 1 downto 0);
    signal value_trunc : signed (ACT_BITWIDTH - 1 downto 0);
    signal rounding    : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal rounding_s    : signed (ACT_BITWIDTH - 1 downto 0);

begin

    -- ReLU:
    value_relu <= (others => '0') when (signed(value_in) < 0) else  -- ReLU
                      signed(value_in);

    -- Rounding:
    -- ofmap: 34<21.13>, act: 16<8.8>   (BW.<I.F>)
    -- ofmap:  II IIII IIII IIII IIII IIIF FFFF FFFF FFFF
    -- act:    -- ---- ---- ---I IIII IIIF FFFF FFF- ----
    --                                   (13 - 8): ↑
    -- value_round <= value_relu + "10000";
    rounding    <= "0000000000010000";
    rounding_s <= signed(rounding);
    value_round <= (value_relu + rounding_s) when (value_relu > 0) else
                    value_relu;

    -- Truncation:
    -- min_16b = -2^(16 - 1)    = -32768 = b01111...1111;
    -- max_16b = 2^(16 - 1) - 1 =  32767 = b10000...0000;
--    value_trunc <= to_signed(32767, value_trunc'length) when (value_round > to_signed(32767, value_round'length)) else
--                   value_round(20 downto 5);
      value_trunc <= value_round(20 downto 5);

    value_out <= std_logic_vector(value_trunc);

end architecture;
