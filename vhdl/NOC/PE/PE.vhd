library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity PE is
    generic (
        -- HW Parameters, at shyntesis time.
        Y_ID                  : natural range 0 to 255 := 3;
        X_ID                  : natural range 0 to 255 := 16;
        Y                     : natural range 0 to 255 := 3;
        NUM_REGS_IFM_REG_FILE : natural                := 32; -- Emax (conv0 and conv1)
        NUM_REGS_W_REG_FILE   : natural                := 24 -- p*S = 8*3 = 24
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        HW_p : in std_logic_vector (7 downto 0);
        RS   : in std_logic_vector (7 downto 0);
        p    : in std_logic_vector (7 downto 0);

        -- from sys ctrl
        pass_flag : in std_logic;

        -- NoC Internal Signals
        ifm_PE                  : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        ifm_PE_enable           : in std_logic;
        w_PE                    : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        w_PE_enable             : in std_logic;
        psum_in                 : in std_logic_vector (PSUM_BITWIDTH - 1 downto 0); -- log2(R*S*2^8*2P8) = 19.1 = 20
        psum_out                : out std_logic_vector (PSUM_BITWIDTH - 1 downto 0);
        PE_ARRAY_RF_write_start : in std_logic
    );
end PE;

architecture structural of PE is

    -- SIGNAL DEFINITIONS
    -- PE_CTR to REG_FILE_ifm
    signal ifm_rf_addr : std_logic_vector(bit_size(NUM_REGS_IFM_REG_FILE) - 1 downto 0);
    signal ifm_we_rf   : std_logic;

    -- PE_CTR to REG_FILE_w
    signal w_rf_addr : std_logic_vector(bit_size(NUM_REGS_W_REG_FILE) - 1 downto 0);
    signal w_we_rf   : std_logic;

    -- Multiplier Signals
    signal ifm_mult   : std_logic_vector(COMP_BITWIDTH - 1 downto 0);
    signal w_mult     : std_logic_vector(COMP_BITWIDTH - 1 downto 0);
    signal mult_out   : unsigned(PSUM_BITWIDTH - 1 downto 0);
    signal mult_zeros : unsigned((PSUM_BITWIDTH - 2 * COMP_BITWIDTH) - 1 downto 0);

    -- Adder Signals
    signal adder_in_1 : unsigned(PSUM_BITWIDTH - 1 downto 0);
    signal adder_in_2 : unsigned(PSUM_BITWIDTH - 1 downto 0);
    signal adder_out  : unsigned(PSUM_BITWIDTH - 1 downto 0);

    -- MUX control Signals
    signal inter_PE_acc : std_logic;
    signal reset_acc    : std_logic;

    -- psum registers Signals
    signal in_psum_reg                       : unsigned(PSUM_BITWIDTH - 1 downto 0);
    signal accumulator_reg, accumulator_next : unsigned(PSUM_BITWIDTH - 1 downto 0);

    -- COMPONENT DECLARATIONS
    component REG_FILE is
        generic (
            REGISTER_INPUTS : boolean := true;
            NUM_REGS        : natural := 32
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            clear       : in std_logic;
            reg_sel     : in unsigned (bit_size(NUM_REGS) - 1 downto 0);
            we          : in std_logic;
            wr_data     : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            rd_data     : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            registers   : out std_logic_vector_array(0 to (NUM_REGS - 1));
            reg_written : out std_logic_vector(0 to (NUM_REGS - 1))
        );
    end component;

    component PE_CTR is
        generic (
            -- HW Parameters, at shyntesis time.
            Y_ID                  : natural := 3;
            NUM_REGS_IFM_REG_FILE : natural := 32;
            NUM_REGS_W_REG_FILE   : natural := 24
        );
        port (
            clk   : in std_logic;
            reset : in std_logic;

            -- config. parameters
            HW_p : in std_logic_vector (7 downto 0);
            RS   : in std_logic_vector (7 downto 0);
            p    : in std_logic_vector (7 downto 0);

            -- from sys ctrl
            pass_flag : in std_logic;

            -- NoC Internal Signals
            ifm_PE_enable           : in std_logic;
            w_PE_enable             : in std_logic;
            PE_ARRAY_RF_write_start : in std_logic;

            -- PE_CTR signals
            w_addr       : out std_logic_vector(bit_size(NUM_REGS_W_REG_FILE) - 1 downto 0);
            ifm_addr     : out std_logic_vector(bit_size(NUM_REGS_IFM_REG_FILE) - 1 downto 0);
            w_we_rf      : out std_logic;
            ifm_we_rf    : out std_logic;
            reset_acc    : out std_logic;
            inter_PE_acc : out std_logic
        );
    end component;

begin

    REG_FILE_ifm_inst : REG_FILE
    generic map(
        REGISTER_INPUTS => true,
        NUM_REGS        => NUM_REGS_IFM_REG_FILE -- Emax (conv0 and conv1)
    )
    port map(
        clk         => clk,
        reset       => reset,
        clear       => '0',
        reg_sel     => unsigned(ifm_rf_addr),
        we          => ifm_we_rf,
        wr_data     => ifm_PE,
        rd_data     => ifm_mult,
        registers   => open,
        reg_written => open
    );

    REG_FILE_w_inst : REG_FILE
    generic map(
        REGISTER_INPUTS => true,
        NUM_REGS        => NUM_REGS_W_REG_FILE -- p*S = 8*3 = 24
    )
    port map(
        clk         => clk,
        reset       => reset,
        clear       => '0',
        reg_sel     => unsigned(w_rf_addr),
        we          => w_we_rf,
        wr_data     => w_PE,
        rd_data     => w_mult,
        registers   => open,
        reg_written => open
    );

    PE_CTR_inst : PE_CTR
    generic map(
        Y_ID                  => Y_ID,
        NUM_REGS_IFM_REG_FILE => NUM_REGS_IFM_REG_FILE,
        NUM_REGS_W_REG_FILE   => NUM_REGS_W_REG_FILE
    )
    port map(
        clk                     => clk,
        reset                   => reset,
        HW_p                    => HW_p,
        RS                      => RS,
        p                       => p,
        pass_flag               => pass_flag,
        ifm_PE_enable           => ifm_PE_enable,
        w_PE_enable             => w_PE_enable,
        PE_ARRAY_RF_write_start => PE_ARRAY_RF_write_start,
        w_addr                  => w_rf_addr,
        ifm_addr                => ifm_rf_addr,
        w_we_rf                 => w_we_rf,
        ifm_we_rf               => ifm_we_rf,
        reset_acc               => reset_acc,
        inter_PE_acc            => inter_PE_acc
    );

    -- MAC Registers
    REG_PROC : process (clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                accumulator_reg <= (others => '0');
                in_psum_reg     <= (others => '0');
            else
                accumulator_reg <= accumulator_next; -- Acc. reg.
                in_psum_reg     <= unsigned(psum_in); -- In psum reg.
            end if;
        end if;
    end process;

    -- Combinational Logic --
    -- Multiplier
    mult_zeros <= (others => '0');
    mult_out   <= mult_zeros & (unsigned(ifm_mult) * unsigned(w_mult));

    -- Inter-PE Acc. MUX
    adder_in_1 <= mult_out when inter_PE_acc = '0' else in_psum_reg;

    -- Intra-PE Acc. MUX
    adder_in_2 <= accumulator_reg when reset_acc = '0' else (others => '0');

    -- Adder
    adder_out        <= adder_in_1 + adder_in_2;
    accumulator_next <= adder_out;
    -------------------------

    -- PORTS Assignations
    psum_out <= std_logic_vector(adder_out);

end architecture;