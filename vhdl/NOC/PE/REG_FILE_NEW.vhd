library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity REG_FILE_WEIGHT is
    generic (
        REGISTER_INPUTS : boolean := true; -- Register the input ports when true
        NUM_REGS        : natural := NUM_REGS_W_REG_FILE_PKG;
        BITWIDTH        : natural := WEIGHT_BITWIDTH
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        clear : in std_logic; -- Initialize all registers to '0'

        -- Addressable external control port
        reg_sel : in unsigned (bit_size(NUM_REGS) - 1 downto 0); -- Register address for write and read (2^4 = 32) 
        we      : in std_logic; -- Write to selected register
        wr_data : in std_logic_vector (BITWIDTH - 1 downto 0); -- Write port
        re      : in std_logic; -- read enable
        rd_data : out std_logic_vector (BITWIDTH - 1 downto 0) -- Read port
    );
end entity;

architecture rtl of REG_FILE_WEIGHT is

    signal registers     : weight_array(0 to (NUM_REGS - 1)); -- Register file contents
    signal reg_sel_reg   : unsigned(reg_sel'range);
    signal we_reg        : std_logic;
    signal wr_data_reg   : std_logic_vector(wr_data'range);
    signal registers_loc : weight_array(registers'range);
    signal re_reg        : std_logic;

begin

    p_ri : if REGISTER_INPUTS generate
        process (clk, reset) is
        begin
            if rising_edge(clk) then
                if reset = '1' then
                    reg_sel_reg <= (others => '0');
                    we_reg      <= '0';
                    wr_data_reg <= (others => '0');
                    re_reg      <= '0';
                else
                    reg_sel_reg <= reg_sel;
                    we_reg      <= we;
                    wr_data_reg <= wr_data;
                    re_reg      <= re;
                end if;
            end if;
        end process;
    end generate;

    p_nri : if not REGISTER_INPUTS generate
        reg_sel_reg <= reg_sel;
        we_reg      <= we;
        wr_data_reg <= wr_data;
        re_reg      <= re;
    end generate;

    process (clk, reset) is
        variable reg_sel_onehot : std_logic_vector(registers'range);
    begin

        if rising_edge(clk) then
            if reset = '1' then
                registers_loc <= (others => (others => '0'));
                rd_data       <= (rd_data'range     => '0');
            else

                reg_sel_onehot := decode(reg_sel_reg, reg_sel_onehot'length);

                -- Write control
                if clear = '1' then
                    registers_loc <= (others => (others => '0'));
                else
                    for i in registers'range loop
                        if we_reg = '1' and reg_sel_onehot(i) = '1' then
                            registers_loc(i) <= wr_data_reg;
                        else -- Not writing
                            registers_loc(i) <= registers_loc(i);
                        end if;
                    end loop;
                end if;

                -- Read control
                for i in registers'range loop
                    if re_reg = '0' then
                        rd_data <= (rd_data'range => '0');
                    else
                        if reg_sel_onehot(i) = '1' then
                            rd_data <= registers_loc(i);
                        end if;
                    end if;
                end loop;
            end if;
        end if;
    end process;

    registers <= registers_loc;

end architecture;
