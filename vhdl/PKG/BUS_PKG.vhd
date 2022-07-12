-- LOG:
-- I have to constrain second dimension otherwise I can't simulate (vhdl 2008 implementation is not ready for simulation)
-- Check https://support.xilinx.com/s/article/71725?language=en_US

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package bus_pkg is
        type std_logic_vector_array is array(natural range <>) of std_logic_vector(7 downto 0);
        type std_logic_array is array(natural range <>) of std_logic;
end package;