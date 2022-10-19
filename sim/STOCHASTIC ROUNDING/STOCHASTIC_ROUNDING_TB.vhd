library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;
use IEEE.math_real.all;

entity STOCHASTIC_ROUNDING_tb is
end STOCHASTIC_ROUNDING_tb;

architecture sim of STOCHASTIC_ROUNDING_tb is

    constant clk_hz     : integer := 50e6;
    constant clk_period : time    := 1 sec / clk_hz;

    constant ws        : natural := OFMAP_BITWIDTH;
    constant fl        : natural := 8;
    constant ws_sr     : natural := 8;
    constant fl_sr     : natural := 3;
    constant residuals : natural := fl - fl_sr;

    signal clk          : std_logic := '1';
    signal reset_tb     : std_logic := '1';
    signal value_in_tb  : std_logic_vector((ws - 1) downto 0);
    signal value_out_tb : std_logic_vector ((ws_sr - 1) downto 0);
    signal enable_sr_tb : std_logic := '0';

    signal in_tmp_1     : std_logic_vector(13 downto 0);
    signal in_tmp_2     : std_logic_vector((ws - in_tmp_1'length - 1) downto 0);

    component SR is
        generic (
            ws        : natural := ws; -- bitwidth of input value -- 26 fpga, 32 asic
            fl        : natural := fl; -- length of fractional part of input value
            ws_sr     : natural := ws_sr; -- bitwidth of output value
            fl_sr     : natural := fl_sr; -- length of fractional part of output value
            residuals : natural := residuals -- fl - fl_sr;
        );
        port (
            clk       : in std_logic;
            reset     : in std_logic;
            value_in  : in std_logic_vector ((ws - 1) downto 0);
            value_out : out std_logic_vector ((ws_sr - 1) downto 0);
            enable_sr : in std_logic -- enabling reading from ofmap means we can start stochastic rounding
        );
    end component;

    component LFSR is
        generic (
            g_Num_Bits : integer := 14
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

    clk <= not clk after clk_period / 2;

    inst_SR_UUT : SR
    generic map(
        ws        => ws, -- bitwidth of input value -- 26 fpga, 32 asic
        fl        => fl, -- length of fractional part of input value
        ws_sr     => ws_sr, -- bitwidth of output value
        fl_sr     => fl_sr, -- length of fractional part of output value
        residuals => residuals -- fl - fl_sr;
    )
    port map(
        clk       => clk,
        reset     => reset_tb,
        value_in  => value_in_tb,
        value_out => value_out_tb,
        enable_sr => enable_sr_tb
    );

    inst_LFSR : LFSR
    generic map(
        g_Num_Bits => 14)
    port map(
        i_Clk       => clk,
        i_Enable    => '1',
        i_Seed_DV   => '0',
        i_Seed_Data => (others => '0'),
        o_LFSR_Data => in_tmp_1,
        o_LFSR_Done => open
    );

    in_tmp_2 <= (others => in_tmp_1(in_tmp_1'length - 1));
    value_in_tb <= in_tmp_2 & in_tmp_1;

    SEQUENCER_PROC : process

        -- impure function rand_slv(len : integer) return std_logic_vector is
        --     variable seed1, seed2 : integer := 0;
        --     variable seed2 : integer := 10;
        --     variable r : real;
        --     variable slv : std_logic_vector(len - 1 downto 0);
        -- begin
        --     for i in slv'range loop
        --         uniform(seed1, seed2, r);
        --         slv(i) := '1' when r > 0.5 else '0';
        --     end loop;
        --     return slv;
        -- end function;

        -- variable I : integer := 0;

    begin

        reset_tb <= '1';

        wait for clk_period * 3;

        reset_tb <= '0';

        wait for clk_period * 10;

        enable_sr_tb <= '1';

        -- I := 0;    
        -- L1: loop
        --     exit L1 when I = 100;
        --     value_in_tb <= rand_slv(ws);
        --     wait for clk_period;
        --     I := I + 1;
        -- end loop;

        -- wait for clk_period;

        wait for clk_period*1000;

        enable_sr_tb <= '0';
        wait;
    end process;

end architecture;