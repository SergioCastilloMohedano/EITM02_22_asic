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
    component PE is
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

    -- PE ARRAY
    PE_ARRAY_X : for i in 0 to 32 generate
        PE_ARRAY_Y : for j in 0 to 2 generate
            PE_inst : PE
            port map (
                clk             =>  clk,
                reset           =>  reset
                -- ..
            );
        end generate PE_ARRAY_Y;
    end generate PE_ARRAY_X;

    -- MC TOP ROW
    MC_TOP_ROW : for i in 0 to 31 generate
        MC_TOP_inst : MC_TOP
        port map (
            clk             =>  clk,
            reset           =>  reset
            -- ..
        );
    end generate MC_TOP_ROW;

    -- MC ARRAY
    MC_X_ROWS : for i in 0 to 31 generate
        MC_X_COLUMNS : for j in 0 to 1 generate
            MC_X_inst : MC_X
            port map (
                clk             =>  clk,
                reset           =>  reset
                -- ..
            );
        end generate MC_X_COLUMNS;
    end generate MC_X_ROWS;

    -- MC Y COLUMN
    MC_Y_COLUMN : for i in 0 to 2 generate
        MC_Y_inst : MC_Y
        port map (
            clk             =>  clk,
            reset           =>  reset
            -- ..
        );
    end generate MC_Y_COLUMN;

end architecture;