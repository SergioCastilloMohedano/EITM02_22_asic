library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity CEIL_LOG2_DIV is
    generic (
        y : integer range 0 to 8 := 1
    );
    port (
        x : in std_logic_vector (7 downto 0);
        z : out std_logic_vector (7 downto 0)
    );
end CEIL_LOG2_DIV;

architecture dataflow of CEIL_LOG2_DIV is

    signal tmp : std_logic_vector (7 downto 0);

begin

    tmp <= ceil_log2div(x,y);
    z <= tmp;

end architecture;