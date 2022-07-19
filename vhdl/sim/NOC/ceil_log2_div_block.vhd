library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity CEIL_LOG2_DIV_BLOCK is
     generic (
         log2r : integer_array := (0, 1, 2, 3)  -- array with all possible "log2r" values of the accelerator.
     );
    port (
        x : in std_logic_vector (7 downto 0);
        z : out std_logic_vector_array(0 to log2r'length-1)
    );
end CEIL_LOG2_DIV_BLOCK;

architecture structural of CEIL_LOG2_DIV_BLOCK is

    -- COMPONENT DECLARATION
    component CEIL_LOG2_DIV IS
    generic (
        y : integer := 1
    );
    port (
        x : in std_logic_vector (7 downto 0);
        z : out std_logic_vector (7 downto 0)
    );
    end component;


begin


--    gen_CEIL_LOG2_DIV : for i in 0 to log2r'length-1 generate
--    gen_CEIL_LOG2_DIV : for i in 0 to 4-1 generate
    gen_CEIL_LOG2_DIV : for i in 0 to log2r'length-1 generate
        UUT_CEIL_LOG2_DIV : CEIL_LOG2_DIV
        generic map (
            y => log2r(i)
        )
        port map (
            x => x,
            z => z(i)
        );
    end generate gen_CEIL_LOG2_DIV;

end architecture;