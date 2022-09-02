library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity PISO_BUFFER_TOP is
    generic (
        -- HW Parameters, at synthesis time.
        X : natural := 32
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        r  : in std_logic_vector (7 downto 0);
        EF : in std_logic_vector (7 downto 0);

        -- From Adder Tree
        PISO_Buffer_start_1 : in std_logic;
        PISO_Buffer_start_2 : in std_logic;
        PISO_Buffer_start_4 : in std_logic;
        ofmap_p_1           : in ofmap_p_array (0 to (X - 1));
        ofmap_p_2           : in ofmap_p_array (0 to ((X/2) - 1));
        ofmap_p_4           : in ofmap_p_array (0 to ((X/4) - 1));

        -- To OFMAP SRAM
        ofmap : out std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0)
    );
end PISO_BUFFER_TOP;

architecture structural of PISO_BUFFER_TOP is

    -- SIGNAL DEFINITIONS
    -- PISO Buffer CTR to PISO BUFFER
    signal shift       : std_logic;
    signal parallel_in : std_logic;
    signal j_tmp       : natural range 0 to 255;

    -- Other Signals
    constant RF_READ_LATENCY : natural := 2; -- Register Files read latency, in clock cycles
    type j_array is array (0 to RF_READ_LATENCY - 1) of natural range 0 to 255;
    signal j_delay : j_array;

    -- COMPONENT DECLARATIONS
    component PISO_BUFFER is
        generic (
            X : natural := 32
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            ofmap_p_1   : in ofmap_p_array (0 to (X - 1));
            ofmap_p_2   : in ofmap_p_array (0 to ((X/2) - 1));
            ofmap_p_4   : in ofmap_p_array (0 to ((X/4) - 1));
            r           : in std_logic_vector (7 downto 0);
            shift       : in std_logic;
            parallel_in : in std_logic;
            j           : in natural;
            ofmap       : out std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0)
        );
    end component;

    component PISO_BUFFER_CTR is
        generic (
            X : natural := 32
        );
        port (
            clk                 : in std_logic;
            reset               : in std_logic;
            r                   : in std_logic_vector (7 downto 0);
            EF                  : in std_logic_vector (7 downto 0);
            PISO_Buffer_start_1 : in std_logic;
            PISO_Buffer_start_2 : in std_logic;
            PISO_Buffer_start_4 : in std_logic;
            shift               : out std_logic;
            parallel_in         : out std_logic;
            j                   : out natural range 0 to 255
        );
    end component;

begin

    -- PISO BUFFER
    PISO_BUFFER_inst : PISO_BUFFER
    generic map(
        X => X
    )
    port map(
        clk         => clk,
        reset       => reset,
        ofmap_p_1   => ofmap_p_1,
        ofmap_p_2   => ofmap_p_2,
        ofmap_p_4   => ofmap_p_4,
        r           => r,
        shift       => shift,
        parallel_in => parallel_in,
        j           => j_tmp,
        ofmap       => ofmap
    );

    -- PISO BUFFER CTR
    PISO_BUFFER_CTR_inst : PISO_BUFFER_CTR
    generic map(
        X => X
    )
    port map(
        clk                 => clk,
        reset               => reset,
        r                   => r,
        EF                  => EF,
        PISO_Buffer_start_1 => PISO_Buffer_start_1,
        PISO_Buffer_start_2 => PISO_Buffer_start_2,
        PISO_Buffer_start_4 => PISO_Buffer_start_4,
        shift               => shift,
        parallel_in         => parallel_in,
        j                   => j_tmp
    );

end architecture;