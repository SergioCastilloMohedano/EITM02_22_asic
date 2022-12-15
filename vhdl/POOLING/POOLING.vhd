library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity POOLING is
    generic (
        X : natural := X_PKG
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- ofmap in/out
        value_in  : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        value_out : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);

        -- from pooling ctr
        rf_addr   : in std_logic_vector(bit_size(X_PKG/2) - 1 downto 0);
        we_rf     : in std_logic;
        re_rf     : in std_logic;
        r1_r2_ctr : in std_logic;
        r3_rf_ctr : in std_logic;
        en_out    : in std_logic
    );
end POOLING;

architecture dataflow of POOLING is

    -- SIGNAL DECLARATIONS
    signal r1_reg, r2_reg, r3_reg    : signed(ACT_BITWIDTH - 1 downto 0);
    signal r1_next, r2_next, r3_next : signed(ACT_BITWIDTH - 1 downto 0);
    signal rd_data_tmp               : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal max_1                     : signed(ACT_BITWIDTH - 1 downto 0);
    signal max_2                     : signed(ACT_BITWIDTH - 1 downto 0);
    signal rf_in                     : signed(ACT_BITWIDTH - 1 downto 0);
    signal value_out_tmp             : signed(ACT_BITWIDTH - 1 downto 0);

    -- COMPONENT DECLARATIONS
    component REG_FILE_ACT is
        generic (
            REGISTER_INPUTS : boolean := false;
            NUM_REGS        : natural := X_PKG/2
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            clear       : in std_logic;
            reg_sel     : in unsigned (bit_size(NUM_REGS) - 1 downto 0);
            we          : in std_logic;
            wr_data     : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            re          : in std_logic;
            rd_data     : out std_logic_vector (ACT_BITWIDTH - 1 downto 0)
        );
    end component;

begin

    REG_FILE_pooling_inst : REG_FILE_ACT
    generic map(
        REGISTER_INPUTS => false,
        NUM_REGS        => X_PKG/2 -- half of biggest E of layers' network
    )
    port map(
        clk         => clk,
        reset       => reset,
        clear       => '0',
        reg_sel     => unsigned(rf_addr),
        we          => we_rf,
        wr_data     => std_logic_vector(rf_in),
        re          => re_rf,
        rd_data     => rd_data_tmp
    );

    data_regs : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                r1_reg <= (others => '0');
                r2_reg <= (others => '0');
                r3_reg <= (others => '0');
            else
                r1_reg <= r1_next;
                r2_reg <= r2_next;
                r3_reg <= r3_next;
            end if;
        end if;
    end process;

    r1_next <= signed(value_in) when r1_r2_ctr = '0' else r1_reg;
    r2_next <= signed(value_in) when r1_r2_ctr = '1' else r2_reg;

    max_1 <= maximum(r1_reg, r2_reg);

    r3_next <= max_1 when r3_rf_ctr = '1' else (others => '0');
    rf_in   <= max_1 when r3_rf_ctr = '0' else (others => '0');

    max_2         <= maximum(r3_reg, signed(rd_data_tmp));
    value_out_tmp <= max_2 when (en_out = '1') else (others => '0');

    -- PORT Assignations
    value_out <= std_logic_vector(value_out_tmp);

end architecture;