-- LOG:
-- I have to constrain second dimension otherwise I can't simulate (vhdl 2008 implementation is not ready for simulation)
-- Check https://support.xilinx.com/s/article/71725?language=en_US
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package thesis_pkg is

    -- **** TYPE DECLARATIONS ****
    constant ACT_BITWIDTH : natural := 16;
    constant WEIGHT_BITWIDTH : natural := 8;
    constant BIAS_BITWIDTH : natural := 16;
    constant PSUM_BITWIDTH  : natural := 28; -- determines bitwidth of the psum considering worst case scenario accumulations -> ceil(log2(R*S*2^WEIGHT_BITWIDTH*2^ACT_BITWIDTH)) = ceil(27.17) = 28
    constant OFMAP_P_BITWIDTH : natural := 30; -- Bitwidth of Adder Tree -> ceil(log2(r*R*S*(COMP_BITWIDTH^2))) -> r = 4 -> 28 + 2
    constant OFMAP_BITWIDTH : natural := 34; -- determines bitwidth of the ofmap, once all ofmap primitives have been accumulated, for worst case scenario -> max(ceil(log2(Cconv*R*S*COMP_BITWIDTH^2) = 34 , ceil(log2(Cfc*COMP_BITWIDTH^2)))


    constant COMP_BITWIDTH  : natural := 8; -- determines computing resolution of the accelerator

    type weight_array is array (natural range <>) of std_logic_vector(WEIGHT_BITWIDTH - 1 downto 0);
    type weight_2D_array is array (natural range <>) of weight_array;
    type act_array is array (natural range <>) of std_logic_vector(ACT_BITWIDTH - 1 downto 0);
    type act_2D_array is array (natural range <>) of act_array;

    type std_logic_vector_array is array(natural range <>) of std_logic_vector(COMP_BITWIDTH - 1 downto 0);
    type std_logic_vector_2D_array is array(natural range <>) of std_logic_vector_array;
    
    type std_logic_array is array(natural range <>) of std_logic;
    type std_logic_2D_array is array(natural range <>) of std_logic_array;
    type integer_array is array(natural range <>) of integer;
    type psum_array is array(natural range <>) of std_logic_vector(PSUM_BITWIDTH - 1 downto 0);
    type psum_2D_array is array(natural range <>) of psum_array;
    type ofmap_p_array is array (natural range <>) of std_logic_vector(OFMAP_P_BITWIDTH - 1 downto 0);
    type ofmap_array is array (natural range <>) of std_logic_vector(OFMAP_BITWIDTH - 1 downto 0);

    -- **** PROCEDURES DECLARATIONS ****

    -- **** FUNCTIONS DECLARATIONS ****

    --## Compute the total number of bits needed to represent a number in binary.
    --#
    --# Args:
    --#   n: Number to compute size from
    --# Returns:
    --#   Number of bits.
    --# [SOURCE: https://github.com/kevinpt/vhdl-extras]
    function bit_size(n : natural) return natural;

    --## Decoder with variable sized output (power of 2).
    --# Args:
    --#  Sel: Numeric value to decode (range 0 to 2**Sel'length-1)
    --# Returns:
    --#  Decoded (one-hot) representation of Sel.
    --# [SOURCE: https://github.com/kevinpt/vhdl-extras]
    function decode(Sel : unsigned) return std_logic_vector;

    --## Decoder with variable sized output (user specified).
    --# Args:
    --#  Sel:  Numeric value to decode (range 0 to Size-1)
    --#  Size: Number of bits in result (leftmost bits)
    --# Returns:
    --#  Decoded (one-hot) representation of Sel.
    --# [SOURCE: https://github.com/kevinpt/vhdl-extras]
    function decode(Sel : unsigned; Size : positive
    ) return std_logic_vector;

    -- ceil_log2div
    --------------------------------------------------------------------------------------
    -- Division of fixed-point integer by a log2 value, returns ceil of result.
    function ceil_log2div (x : std_logic_vector; y : integer) return std_logic_vector;
    -- Result subtype: std_logic_vector 
    -- Result: Performs a division of "x" over 2^y by
    -- right-shifting "x" by "y" positions. The result signal
    -- has same size has input "x" and is the ceil of the division's
    -- result.
    --------------------------------------------------------------------------------------
    -- **** COMPONENT DECLARATIONS ****


    -- Risign Edge Detector
    component rising_edge_detector
        port (
            clk    : in std_logic;
            reset  : in std_logic;
            input  : in std_logic;
            output : out std_logic
        );
    end component;

    -- Falling Edge Detector
    component falling_edge_detector
        port (
            clk    : in std_logic;
            reset  : in std_logic;
            input  : in std_logic;
            output : out std_logic
        );
    end component falling_edge_detector;

    -- monostable
    --------------------------------------------------------------------------------------
    -- Generates a high level signal at "output" when triggered by "input" for
    -- as many clock cycles as determined by "COUNT".
    --
    -- MODE: Determines when output triggers
    --       '0': output triggers at rising edge of input.
    --       '1': output triggers at falling edge of input.
    -- COUNT: Determines the duration of the asserted output, in clock cycles.
    --       i.e. for a 100MHz clock, a value of 100.000.000 equals a high pulse of 1s.
    --       max allowed value is 4.294.967.295 (32 bits).
    --------------------------------------------------------------------------------------
    component monostable is
        generic (
            MODE  : std_logic := '1';
            COUNT : integer   := 100_000_000
        );
        port (
            clk    : in std_logic;
            reset  : in std_logic;
            input  : in std_logic;
            output : out std_logic
        );
    end component;

    -- Ceil of log2 div
    --------------------------------------------------------------------------------------
    -- Inputs "x", an integer number as std_logic_vector and divides it by 2^y. Being "y"
    -- the other input. Returns the ceil of the result "z" as std_logic_vector.
    -- For example:
    -- x = 5 = 0101
    -- y = 1
    -- z = ceil(5/2^1) = ceil(2.5) = 3 = 0011
    --------------------------------------------------------------------------------------
    component CEIL_LOG2_DIV is
        generic (
            y : integer range 0 to 8 := 1
        );
        port (
            x : in std_logic_vector (7 downto 0);
            z : out std_logic_vector (7 downto 0)
        );
    end component;

    component mux is
        generic (
            LEN : natural := 8; -- Bits in each input (must be 8 due to data type definition being constrained to 8).
            NUM : natural -- Number of inputs
        );
        port (
            mux_in  : in std_logic_vector_array(0 to NUM - 1);
            mux_sel : in natural range 0 to NUM - 1;
            mux_out : out std_logic_vector(LEN - 1 downto 0));
    end component;

end thesis_pkg;

package body thesis_pkg is

    -- **** FUNCTIONS DEFINITIONS ****

    --## Compute the total number of bits needed to represent a number in binary.  [SOURCE: https://github.com/kevinpt/vhdl-extras]
    function bit_size(n          : natural) return natural is
        variable log, residual, base : natural;
    begin
        residual := n;
        base     := 2;
        log      := 0;

        while residual > (base - 1) loop
            residual := residual / base;
            log      := log + 1;
        end loop;

        if n = 0 then
            return 1;
        else
            return log + 1;
        end if;
    end function;

    -- ## Decoder with variable sized output (power of 2)  [SOURCE: https://github.com/kevinpt/vhdl-extras]
    function decode(Sel : unsigned) return std_logic_vector is

        variable result : std_logic_vector(0 to (2 ** Sel'length) - 1);
    begin

        -- generate the one-hot vector from binary encoded Sel
        result                  := (others => '0');
        result(to_integer(Sel)) := '1';
        return result;
    end function;

    --## Decoder with variable sized output (user specified)  [SOURCE: https://github.com/kevinpt/vhdl-extras]
    function decode(Sel : unsigned; Size : positive)
        return std_logic_vector is

        variable full_result : std_logic_vector(0 to (2 ** Sel'length) - 1);
    begin
        -- assert Size <= 2 ** Sel'length
        -- report "Decoder output size: " & integer'image(Size)
        --     & " is too big for the selection vector"
        --     severity failure;

        full_result := decode(Sel);
        return full_result(0 to Size - 1);
    end function;

    -- ceil_log2div
    function ceil_log2div (x : std_logic_vector; y : integer) return std_logic_vector is
        variable tmp        : std_logic_vector ((x'left + y) downto x'right);
        variable zeroes     : std_logic_vector (y - 1 downto 0) := (others => '0');
        variable IW         : std_logic_vector (x'left + y downto x'right + y);
        variable FW         : std_logic_vector (x'right + y - 1 downto x'right);
        variable result     : unsigned (x'left downto x'right);
        variable result_tmp : unsigned (x'left downto x'right);
    begin
        tmp := x & zeroes;
        tmp := std_logic_vector(shift_right(unsigned(tmp), y));
        IW  := zeroes & tmp (x'left downto x'right + y);
        FW  := tmp (x'right + y - 1 downto x'right);

        if to_integer(unsigned(FW)) > 0 then
            result_tmp := resize (unsigned(IW) + to_unsigned(1, IW'length), result'length);
        else
            result_tmp := resize (unsigned(IW), result'length);
        end if;

        if y = 0 then
            result := unsigned(x);
        else
            result := result_tmp;
        end if;

        return std_logic_vector(result);

    end function ceil_log2div;
end thesis_pkg;

------------------------------------------------------------------------------
-- Component rising edge detector
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rising_edge_detector is

    port (
        clk    : in std_logic;
        reset  : in std_logic;
        input  : in std_logic;
        output : out std_logic
    );
end rising_edge_detector;

architecture behavioral of rising_edge_detector is
    signal r_input : std_logic := '0';

begin
    reg : process (clk, reset)
    begin
        if reset = '1' then
            r_input <= '0';
        elsif rising_edge(clk) then
            r_input <= input;
        end if;
    end process;

    output <= '1' when input = '1' and r_input = '0' else '0';
end behavioral;
------------------------------------------------------------------------------
-- Component falling edge detector
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity falling_edge_detector is

    port (
        clk    : in std_logic;
        reset  : in std_logic;
        input  : in std_logic;
        output : out std_logic
    );
end falling_edge_detector;

architecture behavioral of falling_edge_detector is
    signal r_input : std_logic := '0';
begin
    reg : process (clk, reset)
    begin
        if reset = '1' then
            r_input <= '0';
        elsif rising_edge(clk) then
            r_input <= input;
        end if;
    end process;
    output <= not input and r_input;
end behavioral;

------------------------------------------------------------------------------
-- Component monostable
------------------------------------------------------------------------------
-- MODE: Determines when output triggers
--       '0': output triggers at rising edge of input.
--       '1': output triggers at falling edge of input.
-- COUNT: Determines the number of clock cycles the output is going to remain high.
--       i.e. for a 100MHz clock, a value of 100.000.000 equals a high pulse of 1s.
--       max allowed value is 4.294.967.295
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity monostable is
    generic (
        MODE  : std_logic := '1';
        COUNT : integer   := 100_000_000
    );
    port (
        clk    : in std_logic;
        reset  : in std_logic;
        input  : in std_logic;
        output : out std_logic
    );
end monostable;

architecture behavioral of monostable is

    -- Risign Edge Detector
    component rising_edge_detector
        port (
            clk    : in std_logic;
            reset  : in std_logic;
            input  : in std_logic;
            output : out std_logic
        );
    end component;

    -- Falling Edge Detector
    component falling_edge_detector
        port (
            clk    : in std_logic;
            reset  : in std_logic;
            input  : in std_logic;
            output : out std_logic
        );
    end component falling_edge_detector;

    signal md             : std_logic := MODE;
    signal rising_output  : std_logic;
    signal falling_output : std_logic;
    signal src            : std_logic;
    signal r_cnt          : std_logic_vector (31 downto 0) := std_logic_vector(to_unsigned(COUNT, 32));
    signal tmp_cnt        : std_logic_vector (31 downto 0);
    signal tmp_output     : std_logic;

    type fsmd_state_type is (idle, delay);
    signal state_reg, state_next : fsmd_state_type;

begin

    red_ins : rising_edge_detector
    port map(
        clk    => clk,
        reset  => reset,
        input  => input,
        output => rising_output
    );

    fed_ins : falling_edge_detector
    port map(
        clk    => clk,
        reset  => reset,
        input  => input,
        output => falling_output
    );

    -- state and data registers
    process (clk, reset)
    begin
        if (reset = '1') then
            state_reg <= idle;
            r_cnt     <= std_logic_vector(to_unsigned(COUNT, 32));
        elsif (clk'event and clk = '1') then
            state_reg <= state_next;
            r_cnt     <= tmp_cnt;
        end if;
    end process;

    -- next-state logic & data path functional units/routing
    process (state_reg, src, r_cnt, md)
    begin
        tmp_output <= '0';
        tmp_cnt    <= r_cnt;
        src        <= '0';
        case state_reg is
            when idle =>
                if md = '0' then
                    src <= rising_output;
                else
                    src <= falling_output;
                end if;
                if src = '1' then
                    state_next <= delay;
                else
                    state_next <= idle;
                end if;
            when delay =>
                tmp_output <= '1';
                if ((unsigned(r_cnt) - 1) /= 0) then
                    tmp_cnt    <= (std_logic_vector(unsigned(r_cnt) - (to_unsigned(1, 32))));
                    state_next <= delay;
                else
                    tmp_cnt    <= std_logic_vector(to_unsigned(COUNT, 32));
                    state_next <= idle;
                end if;
        end case;
    end process;

    output <= tmp_output;

end behavioral;

------------------------------------------------------------------------------
-- Ceil of log 2 div
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity CEIL_LOG2_DIV is
    generic (
        y : integer range 0 to 8 := 1
    );
    port (
        x : in std_logic_vector (7 downto 0);
        z : out std_logic_vector (7 downto 0)
    );
end CEIL_LOG2_DIV;

architecture dataflow of CEIL_LOG2_DIV is

    signal tmp : std_logic_vector (7 downto 0);

begin

    tmp <= ceil_log2div(x, y);
    z   <= tmp;

end architecture;

------------------------------------------------------------------------------
-- Generic MUX
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity mux is
    generic (
        LEN : natural := 8; -- Bits in each input (must be 8 due to data type definition being constrained to 8).
        NUM : natural); -- Number of inputs
    port (
        mux_in  : in std_logic_vector_array(0 to NUM - 1) := (others => (others => '0'));
        mux_sel : in natural range 0 to NUM - 1;
        mux_out : out std_logic_vector(LEN - 1 downto 0));
end entity;

architecture syn of mux is
begin
    mux_out <= mux_in(mux_sel);
end architecture;