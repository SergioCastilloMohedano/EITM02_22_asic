library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_WB_NL is
    port (
        clk : in std_logic;
        reset : in std_logic
        -- ..
    );
end SYS_CTR_WB_NL;

architecture rtl of SYS_CTR_WB_NL is

    -- Define enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_0);
    signal state_next, state_reg: state_type;

    signal WB_NL_ready : std_logic;

begin

    -- control path : state register
    process(clk, reset)
    begin
        if reset = '1' then
            state_reg <= s_init;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;

    -- control path : next state logic
    process(state_reg) -- add more signals to sensitivity list...architecture
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                -- ...
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    WB_NL_ready <= '1' when state_reg = s_idle else '0';

end architecture;