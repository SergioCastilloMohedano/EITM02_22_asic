library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NOC is
    port (
        clk : in std_logic;
        rst : in std_logic;
        -- ..
    );
end NOC;

architecture structural of NOC is

    -- SIGNAL DEFINITIONS
    -- component 1 signals
    -- component 2 signals
    -- ...

    -- COMPONENT DECLARATIONS
    component PE_ARRAY is
        port(clk                : in std_logic;
             reset              : in std_logic;
             -- ...
            );
    end component;

    component MC_TOP is
        port(clk                : in std_logic;
             reset              : in std_logic;
             -- ...
            );
    end component;

    component MC_Y is
        port(clk                : in std_logic;
             reset              : in std_logic;
             -- ...
            );
    end component;

    component MC_X is
        port(clk                : in std_logic;
             reset              : in std_logic;
             -- ...
            );
    end component;

begin

end architecture;