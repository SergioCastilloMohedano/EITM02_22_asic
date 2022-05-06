library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOP is
    port (
        clk : in std_logic;
        rst : in std_logic;
        -- ..
    );
end TOP;

architecture structural of TOP is

    -- SIGNAL DEFINITIONS
    -- component 1 signals
    -- component 2 signals
    -- ...

    -- COMPONENT DECLARATIONS
    component SYSTEM_CONTROLLER is
        port(clk                : in std_logic;
             reset              : in std_logic;
             -- ...
            );
    end component;

    component WEIGHTS_BIASES_SRAM_WRAPPER
    port(clk                : in std_logic;
         reset              : in std_logic;
         -- ...
        );
    end component;

    component ACTIVATIONS_SRAM_WRAPPER
    port(clk                : in std_logic;
         reset              : in std_logic;
         -- ...
        );
    end component;

    component OFMAP_SRAM_WRAPPER
    port(clk                : in std_logic;
         reset              : in std_logic;
         -- ...
        );
    end component;

begin

end architecture;