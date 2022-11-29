library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB_ROUTER is
    port (
        A_8K_1   : out std_logic_vector(12 downto 0);
        CSN_8K_1 : out std_logic;
        D_8K_1   : out std_logic_vector (31 downto 0);
        Q_8K_1   : in std_logic_vector (31 downto 0);
        WEN_8K_1 : out std_logic;
        A_8K_2   : out std_logic_vector(12 downto 0);
        CSN_8K_2 : out std_logic;
        D_8K_2   : out std_logic_vector (31 downto 0);
        Q_8K_2   : in std_logic_vector (31 downto 0);
        WEN_8K_2 : out std_logic;
        A_4K     : out std_logic_vector(11 downto 0);
        CSN_4K   : out std_logic;
        D_4K     : out std_logic_vector (31 downto 0);
        Q_4K     : in std_logic_vector (31 downto 0);
        WEN_4K   : out std_logic
    );
end SRAM_WB_ROUTER;

architecture structural of SRAM_WB_ROUTER is

begin


end architecture;