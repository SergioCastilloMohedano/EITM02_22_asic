library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity MC_Y_COLUMN_UUT is
    generic (
        Y : natural := 3 -- number of PE Rows in the PE Array
    );
    port (
        -- config. parameters
        HW_p : in std_logic_vector (7 downto 0);
        -- from sys ctrl
        h_p         : in std_logic_vector (7 downto 0);
        r_p         : in std_logic_vector (7 downto 0);
        WB_NL_busy  : in std_logic;
        IFM_NL_busy : in std_logic;

        -- from SRAMs
        ifm_y_in : in std_logic_vector (7 downto 0);
        w_y_in   : in std_logic_vector (7 downto 0);

        ifm_y_out    : out std_logic_vector_array(0 to (Y - 1));
        w_y_out      : out std_logic_vector_array(0 to (Y - 1));
        ifm_y_status : out std_logic_array(0 to (Y - 1));
        w_y_status   : out std_logic_array(0 to (Y - 1))
    );
end MC_Y_COLUMN_UUT;

architecture structural of MC_Y_COLUMN_UUT is

    -- COMPONENT DECLARATIONS
    component MC_Y is
        generic (
            Y_ID : natural := 1;
            Y    : natural := 3
        );
        port (
            -- config. parameters
            HW_p : in std_logic_vector (7 downto 0);
            -- from sys ctrl
            h_p         : in std_logic_vector (7 downto 0);
            r_p         : in std_logic_vector (7 downto 0);
            WB_NL_busy  : in std_logic;
            IFM_NL_busy : in std_logic;

            ifm_y_in     : in std_logic_vector (7 downto 0);
            ifm_y_out    : out std_logic_vector(7 downto 0);
            ifm_y_status : out std_logic;
            w_y_in       : in std_logic_vector (7 downto 0);
            w_y_out      : out std_logic_vector (7 downto 0);
            w_y_status   : out std_logic
        );
    end component;

begin

    gen_MC_Y : for i in 0 to (Y - 1) generate
        UUT_MC_Y : MC_Y
        generic map(
            Y_ID => i + 1,
            Y    => Y
        )
        port map(
            HW_p         => HW_p,
            h_p          => h_p,
            r_p          => r_p,
            WB_NL_busy   => WB_NL_busy,
            IFM_NL_busy  => IFM_NL_busy,
            ifm_y_in     => ifm_y_in,
            ifm_y_out    => ifm_y_out(i),
            ifm_y_status => ifm_y_status(i),
            w_y_in       => w_y_in,
            w_y_out      => w_y_out(i),
            w_y_status   => w_y_status(i)
        );
    end generate gen_MC_Y;

end architecture;