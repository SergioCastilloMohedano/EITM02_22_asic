library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity ADDER_TREE is
    generic (
        -- HW Parameters, at synthesis time.
        X : natural := X_PKG
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        r : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- From NoC
        ofmap_p           : in psum_array(0 to (X_PKG - 1));
        PISO_Buffer_start : in std_logic;

        -- To PISO Buffer
        ofmap_p_1           : out ofmap_p_array (0 to (X_PKG - 1));
        ofmap_p_2           : out ofmap_p_array (0 to ((X_PKG/2) - 1));
        ofmap_p_4           : out ofmap_p_array (0 to ((X_PKG/4) - 1));
        PISO_Buffer_start_1 : out std_logic;
        PISO_Buffer_start_2 : out std_logic;
        PISO_Buffer_start_4 : out std_logic
    );
end ADDER_TREE;

architecture behavioral of ADDER_TREE is

    -- SIGNAL DEFINITIONS
    -- Input Branch
    signal ofmap_p_bus_0 : ofmap_p_array (0 to (X_PKG - 1));

    -- r = 1 Branch
    signal ofmap_p_bus_1 : ofmap_p_array (0 to (X_PKG - 1));

    -- r /= 1 Branch
    signal ofmap_p_bus_2 : ofmap_p_array (0 to (X_PKG - 1));

    -- Adders 1st Stage
    signal ofmap_p_add_1_in_1 : ofmap_p_array (0 to ((X_PKG/4) - 1)); -- set r = 1
    signal ofmap_p_add_2_in_1 : ofmap_p_array (0 to ((X_PKG/4) - 1)); -- set r = 2
    signal ofmap_p_add_1_in_2 : ofmap_p_array (0 to ((X_PKG/4) - 1)); -- set r = 3
    signal ofmap_p_add_2_in_2 : ofmap_p_array (0 to ((X_PKG/4) - 1)); -- set r = 4
    signal ofmap_p_add_1_out  : ofmap_p_array (0 to ((X_PKG/4) - 1));
    signal ofmap_p_add_2_out  : ofmap_p_array (0 to ((X_PKG/4) - 1));

    -- Regs 1st Stage
    signal ofmap_p_add_1_out_reg : ofmap_p_array (0 to ((X_PKG/4) - 1));
    signal ofmap_p_add_2_out_reg : ofmap_p_array (0 to ((X_PKG/4) - 1));

    -- r = 2 Branch
    signal ofmap_p_bus_2_1 : ofmap_p_array (0 to ((X_PKG/4) - 1));
    signal ofmap_p_bus_2_2 : ofmap_p_array (0 to ((X_PKG/4) - 1));

    -- Adder 2nd Stage
    signal ofmap_p_add_3_in_1 : ofmap_p_array (0 to ((X_PKG/4) - 1));
    signal ofmap_p_add_3_in_2 : ofmap_p_array (0 to ((X_PKG/4) - 1));

    signal ofmap_p_add_3_out : ofmap_p_array (0 to ((X_PKG/4) - 1));

    -- Regs 2nd Stage (r = 4 Branch)
    signal ofmap_p_add_3_out_reg : ofmap_p_array (0 to ((X_PKG/4) - 1));

    -- PISO Buffer Start Signals
    signal PISO_Buffer_start_reg_1, PISO_Buffer_start_next_1 : std_logic;
    signal PISO_Buffer_start_reg_2, PISO_Buffer_start_next_2 : std_logic;

    -- Other Signals
    type sign_array is array (0 to (X_PKG - 1)) of std_logic_vector (((OFMAP_P_BITWIDTH - PSUM_BITWIDTH) - 1) downto 0);
    signal sign_extension : sign_array;
    signal r_tmp          : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

begin

    -- Input
    loop_0 : for i in 0 to (X_PKG - 1) generate
        sign_extension(i) <= (others => ofmap_p(i)(ofmap_p(i)'length - 1));
        ofmap_p_bus_0(i)  <= sign_extension(i) & ofmap_p(i);
    end generate loop_0;

    -- Demux - Stage 1
    ofmap_p_bus_1 <= ofmap_p_bus_0 when (r_tmp = 1) else (others => (others => '0'));
    ofmap_p_bus_2 <= ofmap_p_bus_0 when (r_tmp /= 1) else (others => (others => '0'));

    -- Splitting Bus
    ofmap_p_add_1_in_1 <= ofmap_p_bus_2 (0 to ((X_PKG/4) - 1));
    ofmap_p_add_2_in_1 <= ofmap_p_bus_2 ((X_PKG/4) to ((X_PKG/2) - 1));
    ofmap_p_add_1_in_2 <= ofmap_p_bus_2 ((X_PKG/2) to (((3 * X_PKG)/4) - 1));
    ofmap_p_add_2_in_2 <= ofmap_p_bus_2 (((3 * X_PKG)/4) to (X_PKG - 1));

    -- Adders Stage 1
    loop_adders_stage_1 : for i in 0 to ((X_PKG/4) - 1) generate
        ofmap_p_add_1_out(i) <= std_logic_vector(signed(ofmap_p_add_1_in_1(i)) + signed(ofmap_p_add_1_in_2(i)));
        ofmap_p_add_2_out(i) <= std_logic_vector(signed(ofmap_p_add_2_in_1(i)) + signed(ofmap_p_add_2_in_2(i)));
    end generate loop_adders_stage_1;

    -- Register Buses - Stage 1
    REG_PROC_1 : process (clk, reset)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                ofmap_p_add_1_out_reg <= (others => (others => '0'));
                ofmap_p_add_2_out_reg <= (others => (others => '0'));
            else
                ofmap_p_add_1_out_reg <= ofmap_p_add_1_out;
                ofmap_p_add_2_out_reg <= ofmap_p_add_2_out;
            end if;
        end if;
    end process;

    -- Demux 2
    ofmap_p_bus_2_1    <= ofmap_p_add_1_out_reg when (r_tmp = 2) else (others => (others => '0'));
    ofmap_p_add_3_in_1 <= ofmap_p_add_1_out_reg when (r_tmp /= 2) else (others => (others => '0'));

    -- Demux 3
    ofmap_p_bus_2_2    <= ofmap_p_add_2_out_reg when (r_tmp = 2) else (others => (others => '0'));
    ofmap_p_add_3_in_2 <= ofmap_p_add_2_out_reg when (r_tmp /= 2) else (others => (others => '0'));

    -- Adder Stage 2
    loop_adders_stage_2 : for i in 0 to ((X_PKG/4) - 1) generate
        ofmap_p_add_3_out(i) <= std_logic_vector(signed(ofmap_p_add_3_in_1(i)) + signed(ofmap_p_add_3_in_2(i)));
    end generate loop_adders_stage_2;

    -- Register Bus - Stage 2
    REG_PROC_2 : process (clk, reset)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                ofmap_p_add_3_out_reg <= (others => (others => '0'));
            else
                ofmap_p_add_3_out_reg <= ofmap_p_add_3_out;
            end if;
        end if;
    end process;

    -- PISO_Buffer_start -------------------------
    PISO_Buffer_start_next_1 <= PISO_Buffer_start;
    PISO_Buffer_start_next_2 <= PISO_Buffer_start_reg_1;

    PISO_REGS_PROC: process (clk, reset)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                PISO_Buffer_start_reg_1 <= '0';
                PISO_Buffer_start_reg_2 <= '0';
            else
                PISO_Buffer_start_reg_1 <= PISO_Buffer_start_next_1;
                PISO_Buffer_start_reg_2 <= PISO_Buffer_start_next_2;
            end if;
        end if;
    end process;

    PISO_Buffer_start_1 <= PISO_Buffer_start;
    PISO_Buffer_start_2 <= PISO_Buffer_start_reg_1;
    PISO_Buffer_start_4 <= PISO_Buffer_start_reg_2;
    ----------------------------------------------

    -- PORT Assignations
    ofmap_p_1 <= ofmap_p_bus_1; -- r = 1 (size X)
    ofmap_p_2 <= ofmap_p_bus_2_1 & ofmap_p_bus_2_2; -- r = 2 (size X/2)
    ofmap_p_4 <= ofmap_p_add_3_out_reg; -- r = 4 (size X/4)
    r_tmp     <= to_integer(unsigned(r));


end architecture;