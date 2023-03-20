library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity my_CG_MOD is
    port (
        ck_in  : in std_logic;
        enable : in std_logic;
        ck_out : out std_logic
    );
end my_CG_MOD;

architecture behavioral of my_CG_MOD is

--    signal clk_in_n     : std_logic;
--    signal enable_latch : std_logic;

    component C8T28SOI_LLP1_CNHLSX24_P0 is
    port (
        CP : in std_logic;
        E  : in std_logic;
        TE : in std_logic;
        Q  : out std_logic
        );
    end component;

begin

    C8T28SOI_LLP_CNHLSX24_P0_inst : C8T28SOI_LLP1_CNHLSX24_P0
    port map (
        CP => ck_in,
        E  => enable,
        TE => '0',
        Q  => ck_out
    );

--    clk_in_n <= not ck_in;

--    process (clk_in_n, enable) is
--    begin
--        if (clk_in_n = '1') then
--            enable_latch <= enable;
--        end if;
--    end process;

--    ck_out <= ck_in and enable_latch;

end architecture;
