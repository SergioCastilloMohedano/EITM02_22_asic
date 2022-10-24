library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SR is
    generic (
        ws        : natural := OFMAP_BITWIDTH; -- bitwidth of input value -- 26 fpga, 32 asic
        fl        : natural := 8; -- length of fractional part of input value
        ws_sr     : natural := 8; -- bitwidth of output value
        fl_sr     : natural := 3; -- length of fractional part of output value
        residuals : natural := 5  -- fl - fl_sr;
    );
    port (
        clk       : in std_logic;
        reset     : in std_logic;
        value_in  : in std_logic_vector ((ws - 1) downto 0);
        value_out : out std_logic_vector ((ws_sr - 1) downto 0);
        enable_sr : in std_logic -- enabling reading from ofmap means we can start stochastic rounding
    );
end SR;

architecture dataflow of SR is

    -- signal declarations
    signal w_LFSR_Data     : std_logic_vector(residuals - 1 downto 0);
    signal value_out_add   : signed ((ws - 1) downto 0); 
    signal value_out_shift : signed ((ws - 1) downto 0); 
    signal value_out_tmp   : signed ((ws_sr - 1) downto 0);
    signal max_sr          : signed ((ws_sr - 1) downto 0);
    -- signal min_sr          : signed ((ws_sr - 1) downto 0);

    -- component declarations
    component LFSR is
        generic (
            g_Num_Bits : integer := residuals
        );
        port (
            i_Clk    : in std_logic;
            i_Enable : in std_logic;

            -- Optional Seed Value
            i_Seed_DV   : in std_logic;
            i_Seed_Data : in std_logic_vector(g_Num_Bits - 1 downto 0);

            o_LFSR_Data : out std_logic_vector(g_Num_Bits - 1 downto 0);
            o_LFSR_Done : out std_logic
        );
    end component;

begin

    max_sr <= shift_left(to_signed(1, ws_sr), ws_sr - 1) - 1; -- "0111...11" (2^(ws_sr - 1) - 1) * 2^(-fl_sr)
    -- min_sr <= shift_left(to_signed(1, 1), ws_sr); -- "100...00" 2^(ws_sr - 1 - fl_sr)

    inst_LFSR : LFSR
    generic map(
        g_Num_Bits => residuals)
    port map(
        i_Clk       => clk,
        i_Enable    => enable_sr,
        i_Seed_DV   => '0',
        i_Seed_Data => (others => '0'),
        o_LFSR_Data => w_LFSR_Data,
        o_LFSR_Done => open
    );

    value_out_add <= signed(w_LFSR_Data) + signed(value_in);

    value_out_shift <= shift_right(value_out_add, residuals);

    value_out_tmp <= (others => '0') when (value_out_shift < 0) else  -- ReLU
                     max_sr          when (value_out_shift >= max_sr) else
                     value_out_shift(((ws - fl) - (ws_sr - fl_sr) - residuals - 1) downto 0);

    value_out <= std_logic_vector(value_out_tmp);

end architecture;