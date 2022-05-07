library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TOP is
    port (
        clk : in std_logic;
        reset : in std_logic
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
             reset              : in std_logic
             -- ...
            );
    end component;

    component WEIGHTS_BIASES_SRAM_INTERFACE
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component ACTIVATIONS_SRAM_INTERFACE
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component OFMAP_SRAM_INTERFACE
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component NOC
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component ADDER_TREE
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component BIAS_ADDITION
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component RELU
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component POOLING
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

    component STOCHASTIC_ROUNDING
    port(clk                : in std_logic;
         reset              : in std_logic
         -- ...
        );
    end component;

begin

    -- SYSTEM CONTROLLER
    SYSTEM_CONTROLLER_inst : SYSTEM_CONTROLLER
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- WEIGHTS BIASES SRAM INTERFACE
    WEIGHTS_BIASES_SRAM_INTERFACE_inst : WEIGHTS_BIASES_SRAM_INTERFACE
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- ACTIVATIONS SRAM INTERFACE
    ACTIVATIONS_SRAM_INTERFACE_inst : ACTIVATIONS_SRAM_INTERFACE
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- OFMAP SRAM INTERFACE
    OFMAP_SRAM_INTERFACE_inst : OFMAP_SRAM_INTERFACE
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- NOC
    NOC_inst : NOC
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- ADDER TREE
    ADDER_TREE_inst : ADDER_TREE
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- BIAS ADDITION
    BIAS_ADDITION_inst : BIAS_ADDITION
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- RELU
    RELU_inst : RELU
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- POOLING
    POOLING_inst : POOLING
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

    -- STOCHASTIC ROUNDING
    STOCHASTIC_ROUNDING_inst : STOCHASTIC_ROUNDING
    port map (
        clk             =>  clk,
        reset           =>  reset
        -- ..
    );

end architecture;