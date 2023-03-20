library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity PE is
    generic (
        -- HW Parameters, at synthesis time.
        Y_ID                  : natural       := 3;
        X_ID                  : natural       := 16;
        Y                     : natural       := Y_PKG;
        X                     : natural       := X_PKG;
        NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG; -- W' max (conv0 and conv1)
        NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE_PKG -- p*S = 8*3 = 24
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        HW_p : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        RS   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        p    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- from sys ctrl
        pass_flag   : in std_logic;
        OFM_NL_Read : in std_logic;

        -- NoC Internal Signals
        ifm_PE                  : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        ifm_PE_enable           : in std_logic;
        w_PE                    : in std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
        w_PE_enable             : in std_logic;
        psum_in                 : in std_logic_vector (PSUM_BITWIDTH - 1 downto 0); -- ceil(log2(R*S*2^8*2^16)) = 27.17 = 28
        psum_out                : out std_logic_vector (PSUM_BITWIDTH - 1 downto 0);
        PE_ARRAY_RF_write_start : in std_logic;
        ofmap_p_done            : out std_logic; -- control signal that acknowledges the ofmap is already computed (ONLY to be used when Y_ID = 1, else leave it "open").
        PISO_Buffer_start       : out std_logic -- 040323
    );
end PE;

architecture structural of PE is

    -- SIGNAL DEFINITIONS
    -- PE_CTR to REG_FILE_ifm
    signal ifm_rf_addr : std_logic_vector(bit_size(NUM_REGS_IFM_REG_FILE_PKG) - 1 downto 0);
    signal ifm_we_rf   : std_logic;
    signal re_rf       : std_logic; -- it also connects to REG_FILE

    -- PE_CTR to REG_FILE
    signal w_rf_addr : std_logic_vector(bit_size(NUM_REGS_W_REG_FILE_PKG) - 1 downto 0);
    signal w_we_rf   : std_logic;

    -- Multiplier Signals
    signal ifm_mult         : std_logic_vector(ACT_BITWIDTH - 1 downto 0);
    signal w_mult           : std_logic_vector(WEIGHT_BITWIDTH - 1 downto 0);
    signal mult_out         : signed(PSUM_BITWIDTH - 1 downto 0);
    signal mult_result      : signed((ACT_BITWIDTH + WEIGHT_BITWIDTH) - 1 downto 0);
    signal sign_extension   : signed((PSUM_BITWIDTH - (ACT_BITWIDTH + WEIGHT_BITWIDTH)) - 1 downto 0);

    -- Adder Signals
    signal adder_in_1 : signed(PSUM_BITWIDTH - 1 downto 0);
    signal adder_in_2 : signed(PSUM_BITWIDTH - 1 downto 0);
    signal adder_out  : signed(PSUM_BITWIDTH - 1 downto 0);

    -- MUX control Signals
    signal inter_PE_acc : std_logic;
    signal reset_acc    : std_logic;

    -- psum registers Signals
    signal in_psum_reg      : signed(PSUM_BITWIDTH - 1 downto 0);
    signal accumulator_reg  : signed(PSUM_BITWIDTH - 1 downto 0);
    signal accumulator_next : signed(PSUM_BITWIDTH - 1 downto 0);

    -- Clock Gating
    signal is_stalling_tmp : std_logic;
    signal enable_cg       : std_logic;
    signal clk_cg          : std_logic;

    -- To PISO Buffer
    signal PISO_Buffer_start_tmp : std_logic; -- 040323

    -- COMPONENT DECLARATIONS
    component REG_FILE_ACT is
        generic (
            REGISTER_INPUTS : boolean := true;
            NUM_REGS        : natural := NUM_REGS_IFM_REG_FILE_PKG;
            BITWIDTH        : natural := ACT_BITWIDTH
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            clear       : in std_logic;
            reg_sel     : in unsigned (bit_size(NUM_REGS) - 1 downto 0);
            we          : in std_logic;
            wr_data     : in std_logic_vector (BITWIDTH - 1 downto 0);
            re          : in std_logic;
            rd_data     : out std_logic_vector (BITWIDTH - 1 downto 0)
        );
    end component;

    component REG_FILE_WEIGHT is
        generic (
            REGISTER_INPUTS : boolean := true;
            NUM_REGS        : natural := NUM_REGS_W_REG_FILE_PKG;
            BITWIDTH        : natural := WEIGHT_BITWIDTH
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            clear       : in std_logic;
            reg_sel     : in unsigned (bit_size(NUM_REGS) - 1 downto 0);
            we          : in std_logic;
            wr_data     : in std_logic_vector (BITWIDTH - 1 downto 0);
            re          : in std_logic;
            rd_data     : out std_logic_vector (BITWIDTH - 1 downto 0)
        );
    end component;


    component PE_CTR is
        generic (
            -- HW Parameters, at synthesis time.
            Y_ID                  : natural       := Y_ID;
            X_ID                  : natural       := X_ID;
            NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG;
            NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE_PKG
        );
        port (
            clk   : in std_logic;
            reset : in std_logic;

            -- config. parameters
            HW_p : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            RS   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            p    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

            -- from sys ctrl
            pass_flag : in std_logic;

            -- NoC Internal Signals
            ifm_PE_enable           : in std_logic;
            w_PE_enable             : in std_logic;
            PE_ARRAY_RF_write_start : in std_logic;

            -- PE_CTR signals
            w_addr            : out std_logic_vector(bit_size(NUM_REGS_W_REG_FILE_PKG) - 1 downto 0);
            ifm_addr          : out std_logic_vector(bit_size(NUM_REGS_IFM_REG_FILE_PKG) - 1 downto 0);
            w_we_rf           : out std_logic;
            ifm_we_rf         : out std_logic;
            reset_acc         : out std_logic;
            inter_PE_acc      : out std_logic;
            re_rf             : out std_logic;
            PISO_Buffer_start : out std_logic;

            -- Clock Gating
            is_stalling  : out std_logic
        );
    end component;

    component my_CG_MOD is
    port (
        ck_in  : in std_logic;
        enable : in std_logic;
        ck_out : out std_logic
        );
    end component;

begin

    REG_FILE_ifm_inst : REG_FILE_ACT
    generic map(
        REGISTER_INPUTS => true,
        NUM_REGS        => NUM_REGS_IFM_REG_FILE_PKG, -- W' max (conv0 and conv1)
        BITWIDTH        => ACT_BITWIDTH
    )
    port map(
--        clk         => clk,
        clk         => clk_cg,
        reset       => reset,
        clear       => '0',
        reg_sel     => unsigned(ifm_rf_addr),
        we          => ifm_we_rf,
        wr_data     => ifm_PE,
        re          => re_rf,
        rd_data     => ifm_mult
    );

    REG_FILE_w_inst : REG_FILE_WEIGHT
    generic map(
        REGISTER_INPUTS => true,
        NUM_REGS        => NUM_REGS_W_REG_FILE_PKG, -- p*S = 8*3 = 24
        BITWIDTH        => WEIGHT_BITWIDTH
    )
    port map(
--        clk         => clk,
        clk         => clk_cg,
        reset       => reset,
        clear       => '0',
        reg_sel     => unsigned(w_rf_addr),
        we          => w_we_rf,
        wr_data     => w_PE,
        re          => re_rf,
        rd_data     => w_mult
    );

    PE_CTR_inst : PE_CTR
    generic map(
        Y_ID                  => Y_ID,
        X_ID                  => X_ID,
        NUM_REGS_IFM_REG_FILE => NUM_REGS_IFM_REG_FILE_PKG,
        NUM_REGS_W_REG_FILE   => NUM_REGS_W_REG_FILE_PKG
    )
    port map(
        clk                     => clk,
        reset                   => reset,
        HW_p                    => HW_p,
        EF                      => EF,
        RS                      => RS,
        p                       => p,
        r                       => r,
        pass_flag               => pass_flag,
        ifm_PE_enable           => ifm_PE_enable,
        w_PE_enable             => w_PE_enable,
        PE_ARRAY_RF_write_start => PE_ARRAY_RF_write_start,
        w_addr                  => w_rf_addr,
        ifm_addr                => ifm_rf_addr,
        w_we_rf                 => w_we_rf,
        ifm_we_rf               => ifm_we_rf,
        reset_acc               => reset_acc,
        inter_PE_acc            => inter_PE_acc,
        re_rf                   => re_rf,
        PISO_Buffer_start       => PISO_Buffer_start_tmp, -- 040323
        is_stalling             => is_stalling_tmp
    );

    -- Clock Gating
    enable_cg_proc : process (OFM_NL_Read, is_stalling_tmp)
    begin
        if ((OFM_NL_Read = '0') and (is_stalling_tmp = '0')) then
            enable_cg <= '1';
        else
            enable_cg <= '0';
        end if;
    end process;
--    enable_cg <= not(not(OFM_NL_Read) and not(is_stalling_tmp));

    my_CG_MOD_inst : my_CG_MOD
    port map(
        ck_in  => clk,
        enable => enable_cg,
        ck_out => clk_cg
    );

    -- MAC Registers
--    REG_PROC : process (clk, reset)
--    begin
--        if rising_edge(clk) then
--            if (reset = '1') then
--                accumulator_reg <= (others => '0');
--                in_psum_reg     <= (others => '0');
--            else
--                accumulator_reg <= accumulator_next; -- Acc. reg.
--                in_psum_reg     <= signed(psum_in); -- In psum reg.
--            end if;
--        end if;
--    end process;

    ACC_REG_PROC : process (clk, reset)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                accumulator_reg <= (others => '0');
            else
                accumulator_reg <= accumulator_next; -- Acc. reg.
            end if;
        end if;
    end process;

-- ****** PSUM REGS (NO REG IN BOTTOM PE) *********
    gen_psum_regs : if (Y_ID /= 3) generate
        PSUM_REG_PROC_REGS : process (clk, reset)
        begin
            if rising_edge(clk) then
                if (reset = '1') then
                    in_psum_reg     <= (others => '0');
                else
                    in_psum_reg     <= signed(psum_in); -- In psum reg.
                end if;
            end if;
        end process;
    end generate;

    gen_psum_Y_ID_3 : if (Y_ID = 3) generate
        in_psum_reg     <= signed(psum_in); -- In psum reg.
    end generate;
-- ************************************************

    -- Combinational Logic --
    -- Multiplier
    mult_result    <= (signed(ifm_mult) * signed(w_mult));
    sign_extension <= (others => mult_result(mult_result'length - 1));
    mult_out       <= sign_extension & mult_result;

    -- Inter-PE Acc. MUX
    adder_in_1 <= mult_out when inter_PE_acc = '0' else in_psum_reg;

    -- Intra-PE Acc. MUX
    adder_in_2 <= accumulator_reg when reset_acc = '0' else (others => '0');

    -- Adder
    adder_out        <= adder_in_1 + adder_in_2;
    accumulator_next <= adder_out;
    -------------------------

    -- PORTS Assignations
    psum_out          <= std_logic_vector(accumulator_reg) when (Y_ID = 1) else std_logic_vector(adder_out); -- registers output only when Y_ID = 1. Instead of creating a new register, use acc_reg.
    ofmap_p_done      <= reset_acc;
    PISO_Buffer_start <= PISO_Buffer_start_tmp; -- 040323

end architecture;
