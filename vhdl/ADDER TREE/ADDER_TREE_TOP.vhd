library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity ADDER_TREE_TOP is
    generic (
        -- HW Parameters, at synthesis time.
        X : natural := 32
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        r : in std_logic_vector (7 downto 0);

        -- From NoC
        ofmap_p           : in psum_array(0 to (X - 1));
        PISO_Buffer_start : in std_logic;

        -- To OFMAP SRAM
        ofmap : out std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0)
    );
end ADDER_TREE_TOP;

architecture structural of ADDER_TREE_TOP is

    -- SIGNAL DEFINITIONS
    signal ofmap_p_1 : ofmap_p_array (0 to (X - 1));
    signal ofmap_p_2 : ofmap_p_array (0 to ((X/2) - 1));
    signal ofmap_p_4 : ofmap_p_array (0 to ((X/4) - 1));

    signal PISO_Buffer_start_1 : std_logic;
    signal PISO_Buffer_start_2 : std_logic;
    signal PISO_Buffer_start_4 : std_logic;

    -- COMPONENT DECLARATIONS
    component ADDER_TREE is
        generic (
            X : natural := 32
        );
        port (
            clk                 : in std_logic;
            reset               : in std_logic;
            r                   : in std_logic_vector (7 downto 0);
            ofmap_p             : in psum_array(0 to (X - 1));
            PISO_Buffer_start   : in std_logic;
            ofmap_p_1           : out ofmap_p_array (0 to (X - 1));
            ofmap_p_2           : out ofmap_p_array (0 to ((X/2) - 1));
            ofmap_p_4           : out ofmap_p_array (0 to ((X/4) - 1));
            PISO_Buffer_start_1 : out std_logic;
            PISO_Buffer_start_2 : out std_logic;
            PISO_Buffer_start_4 : out std_logic
        );
    end component;

    component PISO_BUFFER_TOP is
        generic (
            X : natural := 32
        );
        port (
            clk                 : in std_logic;
            reset               : in std_logic;
            r                   : in std_logic_vector (7 downto 0);
            PISO_Buffer_start_1 : in std_logic;
            PISO_Buffer_start_2 : in std_logic;
            PISO_Buffer_start_4 : in std_logic;
            ofmap_p_1           : in ofmap_p_array (0 to (X - 1));
            ofmap_p_2           : in ofmap_p_array (0 to ((X/2) - 1));
            ofmap_p_4           : in ofmap_p_array (0 to ((X/4) - 1));
            ofmap               : out std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0)
        );
    end component;

begin

    -- ADDER TREE
    ADDER_TREE_inst : ADDER_TREE
    generic map(
        X => X
    )
    port map(
        clk                 => clk,
        reset               => reset,
        r                   => r,
        PISO_Buffer_start   => PISO_Buffer_start,
        ofmap_p             => ofmap_p,
        ofmap_p_1           => ofmap_p_1,
        ofmap_p_2           => ofmap_p_2,
        ofmap_p_4           => ofmap_p_4,
        PISO_Buffer_start_1 => PISO_Buffer_start_1,
        PISO_Buffer_start_2 => PISO_Buffer_start_2,
        PISO_Buffer_start_4 => PISO_Buffer_start_4
    );

    -- PISO BUFFER
    PISO_BUFFER_TOP_inst : PISO_BUFFER_TOP
    generic map(
        X => X
    )
    port map(
        clk                 => clk,
        reset               => reset,
        r                   => r,
        PISO_Buffer_start_1 => PISO_Buffer_start_1,
        PISO_Buffer_start_2 => PISO_Buffer_start_2,
        PISO_Buffer_start_4 => PISO_Buffer_start_4,
        ofmap_p_1           => ofmap_p_1,
        ofmap_p_2           => ofmap_p_2,
        ofmap_p_4           => ofmap_p_4,
        ofmap               => ofmap
    );

end architecture;