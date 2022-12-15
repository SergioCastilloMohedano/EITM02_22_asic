library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity PISO_BUFFER is
    generic (
        -- HW Parameters, at synthesis time.
        X : natural := X_PKG
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- From Adder Tree
        ofmap_p_1 : in ofmap_p_array (0 to (X_PKG - 1));
        ofmap_p_2 : in ofmap_p_array (0 to ((X_PKG/2) - 1));
        ofmap_p_4 : in ofmap_p_array (0 to ((X_PKG/4) - 1));

        -- config. parameters
        r : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        shift       : in std_logic;
        parallel_in : in std_logic;
        j           : in natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

        -- To OFMAP SRAM
        ofmap : out std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0)
    );
end PISO_BUFFER;

architecture behavioral of PISO_BUFFER is

    signal ofmap_buffer_next : ofmap_p_array (0 to (X_PKG - 1));
    signal ofmap_buffer_reg  : ofmap_p_array (0 to (X_PKG - 1 + 1));
    signal ofmap_p_in        : ofmap_p_array (0 to (X_PKG - 1));
    signal r_tmp             : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

begin

    COMB_PROC : process (r_tmp, j, ofmap_p_1, ofmap_p_2, ofmap_p_4, ofmap_buffer_reg)
    begin
        if (r_tmp = 1) then
            ofmap_p_in <= ofmap_p_1;
        elsif (r_tmp = 2) then
            if (j = 1) then
                ofmap_p_in(0 to (X_PKG/2) - 1)   <= ofmap_p_2;
                ofmap_p_in((X_PKG/2) to (X_PKG - 1)) <= ofmap_buffer_reg((X_PKG/2) to (X_PKG - 1));
            elsif (j = 2) then
                ofmap_p_in(0 to (X_PKG/2) - 1)   <= ofmap_buffer_reg(0 to (X_PKG/2) - 1);
                ofmap_p_in((X_PKG/2) to (X_PKG - 1)) <= ofmap_p_2;
            else
                ofmap_p_in(0 to (X_PKG/2) - 1)   <= ofmap_buffer_reg(0 to (X_PKG/2) - 1);
                ofmap_p_in((X_PKG/2) to (X_PKG - 1)) <= ofmap_buffer_reg((X_PKG/2) to (X_PKG - 1));
            end if;
        else -- r = 4
            if (j = 1) then
                ofmap_p_in(0 to (X_PKG/4) - 1)             <= ofmap_p_4;
                ofmap_p_in((X_PKG/4) to (X_PKG/2) - 1)         <= ofmap_buffer_reg((X_PKG/4) to (X_PKG/2) - 1);
                ofmap_p_in((X_PKG/2) to (((3 * X_PKG)/4) - 1)) <= ofmap_buffer_reg((X_PKG/2) to (((3 * X_PKG)/4) - 1));
                ofmap_p_in(((3 * X_PKG)/4) to (X_PKG - 1))     <= ofmap_buffer_reg(((3 * X_PKG)/4) to (X_PKG - 1));

            elsif (j = 2) then
                ofmap_p_in(0 to (X_PKG/4) - 1)             <= ofmap_buffer_reg(0 to (X_PKG/4) - 1);
                ofmap_p_in((X_PKG/4) to (X_PKG/2) - 1)         <= ofmap_p_4;
                ofmap_p_in((X_PKG/2) to (((3 * X_PKG)/4) - 1)) <= ofmap_buffer_reg((X_PKG/2) to (((3 * X_PKG)/4) - 1));
                ofmap_p_in(((3 * X_PKG)/4) to (X_PKG - 1))     <= ofmap_buffer_reg(((3 * X_PKG)/4) to (X_PKG - 1));
            elsif (j = 3) then
                ofmap_p_in(0 to (X_PKG/4) - 1)             <= ofmap_buffer_reg(0 to (X_PKG/4) - 1);
                ofmap_p_in((X_PKG/4) to (X_PKG/2) - 1)         <= ofmap_buffer_reg((X_PKG/4) to (X_PKG/2) - 1);
                ofmap_p_in((X_PKG/2) to (((3 * X_PKG)/4) - 1)) <= ofmap_p_4;
                ofmap_p_in(((3 * X_PKG)/4) to (X_PKG - 1))     <= ofmap_buffer_reg(((3 * X_PKG)/4) to (X_PKG - 1));
            elsif (j = 4) then
                ofmap_p_in(0 to (X_PKG/4) - 1)             <= ofmap_buffer_reg(0 to (X_PKG/4) - 1);
                ofmap_p_in((X_PKG/4) to (X_PKG/2) - 1)         <= ofmap_buffer_reg((X_PKG/4) to (X_PKG/2) - 1);
                ofmap_p_in((X_PKG/2) to (((3 * X_PKG)/4) - 1)) <= ofmap_buffer_reg((X_PKG/2) to (((3 * X_PKG)/4) - 1));
                ofmap_p_in(((3 * X_PKG)/4) to (X_PKG - 1))     <= ofmap_p_4;
            else
                ofmap_p_in(0 to (X_PKG/4) - 1)             <= ofmap_buffer_reg(0 to (X_PKG/4) - 1);
                ofmap_p_in((X_PKG/4) to (X_PKG/2) - 1)         <= ofmap_buffer_reg((X_PKG/4) to (X_PKG/2) - 1);
                ofmap_p_in((X_PKG/2) to (((3 * X_PKG)/4) - 1)) <= ofmap_buffer_reg((X_PKG/2) to (((3 * X_PKG)/4) - 1));
                ofmap_p_in(((3 * X_PKG)/4) to (X_PKG - 1))     <= ofmap_buffer_reg(((3 * X_PKG)/4) to (X_PKG - 1));
            end if;
        end if;
    end process;

    -- PISO Buffer
    ofmap_buffer_reg(X_PKG) <= (others => '0'); -- Input zeroes to last reg. in PISO Buffer.

    PISO_BUFFER_loop : for i in 0 to (X_PKG - 1) generate

        PISO_BUFFER_PROC : process (clk, reset)
        begin
            if rising_edge(clk) then
                if (reset = '1') then
                    ofmap_buffer_reg(X_PKG - 1 - i) <= (others => '0');
                else
                    ofmap_buffer_reg(X_PKG - 1 - i) <= ofmap_buffer_next(X_PKG - 1 - i);
                end if;
            end if;
        end process;

        ofmap_buffer_next(i) <= ofmap_buffer_reg(i + 1) when (shift = '1')       else -- Allows serial shifting.
                                ofmap_p_in(i)           when (parallel_in = '1') else -- Allows parallel inputting.
                                ofmap_buffer_reg(i);                                  -- Holds register values.

    end generate PISO_BUFFER_loop;

    ofmap <= ofmap_buffer_reg(0); -- Output (to OFMAP SRAM)
    r_tmp <= to_integer(unsigned(r));

end architecture;