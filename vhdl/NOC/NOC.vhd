library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity NOC is
    generic (
        -- HW Parameters, at synthesis time.
        X                     : natural       := X_PKG;
        Y                     : natural       := Y_PKG;
        hw_log2_r             : integer_array := hw_log2_r_PKG;
        hw_log2_EF            : integer_array := hw_log2_EF_PKG;
        NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG; -- W' max (conv0 and conv1)
        NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE_PKG -- p*S = 8*3 = 24
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        C_cap   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        HW_p    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF_log2 : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r_log2  : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        RS      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        p       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- from sys ctrl
        h_p           : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        rc            : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r_p           : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        WB_NL_busy    : in std_logic;
        IFM_NL_busy   : in std_logic;
        pass_flag     : in std_logic;
        pad           : in natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- To MC_X

        -- from SRAMs
        ifm_sram : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        w_sram   : in std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);

        -- Ofmap Primitives Output Registers (To Adder Tree)
        ofmap_p           : out psum_array(0 to (X_PKG - 1));
        PISO_Buffer_start : out std_logic;

        -- Clock Gating
        OFM_NL_Read     : in std_logic
    );
end NOC;

architecture structural of NOC is

    -- SIGNAL DEFINITIONS
    -- MC_Y to MC_X
    signal ifm_enable_y_to_x : std_logic_array(0 to (Y_PKG - 1));
    signal ifm_y_to_x        : act_array(0 to (Y_PKG - 1));
    signal w_enable_y_to_x   : std_logic_array(0 to (Y_PKG - 1));
    signal w_y_to_x          : weight_array(0 to (Y_PKG - 1));

    -- MC_X to PE
    signal ifm_x_to_PE        : act_2D_array(0 to (X_PKG - 1))(0 to (Y_PKG - 1));
    signal ifm_status_x_to_PE : std_logic_2D_array(0 to (X_PKG - 1))(0 to (Y_PKG - 1));
    signal w_x_to_PE          : weight_2D_array(0 to (X_PKG - 1))(0 to (Y_PKG - 1));
    signal w_status_x_to_PE   : std_logic_2D_array(0 to (X_PKG - 1))(0 to (Y_PKG - 1));

    -- MC_rr to MC_X
    signal rr_tmp : hyp_array(0 to (X_PKG - 1));

    -- Internal PE Array Signals
    signal psum_inter_array : psum_2D_array(0 to (X_PKG - 1))(0 to (Y_PKG));
    signal psum_out_array   : psum_array(0 to (X_PKG - 1));

    -- PE to Adder Tree
    signal ofmap_p_reg, ofmap_p_next : psum_array(0 to (X_PKG - 1));
    signal ofmap_p_done_array        : std_logic_2D_array(0 to (X_PKG - 1))(0 to (Y_PKG - 1));
    signal PISO_Buffer_start_array   : std_logic_2D_array(0 to (X_PKG - 1))(0 to (Y_PKG - 1));

    -- Delay Signals
    signal h_p_reg         : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal r_p_reg         : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal rc_reg          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal IFM_NL_busy_reg : std_logic;
    signal WB_NL_busy_reg  : std_logic;
    signal pass_flag_reg   : std_logic;

    -- Other Signals
    signal PE_ARRAY_RF_write_start : std_logic; -- triggers writing state within all PEs.

    -- Clock Gating
    signal OFM_NL_Read_reg : std_logic;

    -- COMPONENT DECLARATIONS
    component PE is
        generic (
            -- HW Parameters, at synthesis time.
            Y_ID                  : natural       := 3;
            X_ID                  : natural       := 16;
            Y                     : natural       := Y_PKG;
            X                     : natural       := X_PKG;
            NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG; -- Emax (conv0 and conv1)
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
            pass_flag     : in std_logic;
            OFM_NL_Read   : in std_logic;


            -- NoC Internal Signals
            ifm_PE                  : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            ifm_PE_enable           : in std_logic;
            w_PE                    : in std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
            w_PE_enable             : in std_logic;
            psum_in                 : in std_logic_vector (PSUM_BITWIDTH - 1 downto 0);
            psum_out                : out std_logic_vector (PSUM_BITWIDTH - 1 downto 0);
            PE_ARRAY_RF_write_start : in std_logic;
            ofmap_p_done            : out std_logic;
            PISO_Buffer_start       : out std_logic -- 040323
        );
    end component;

    -- component MC_FC is
    --     port (
    --         -- ...
    --     );
    -- end component;

    component MC_Y is
        generic (
            Y_ID : natural := 1
        );
        port (
            HW_p         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            RS           : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            h_p          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_p          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            WB_NL_busy   : in std_logic;
            IFM_NL_busy  : in std_logic;
            ifm_y_in     : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            ifm_y_out    : out std_logic_vector(ACT_BITWIDTH - 1 downto 0);
            ifm_y_status : out std_logic;
            w_y_in       : in std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
            w_y_out      : out std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
            w_y_status   : out std_logic
        );
    end component;

    component MC_X is
        generic (
            Y_ID      : natural       := 3;
            X_ID      : natural       := 16;
            Y         : natural       := Y_PKG;
            hw_log2_r : integer_array := hw_log2_r_PKG
        );
        port (
            RS           : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF_log2      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            C_cap        : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_log2       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            h_p          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            rc           : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            pad          : in natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- padding (from IFMAP_FRONT_END_READ)
            rr           : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            ifm_x_enable : in std_logic;
            ifm_x_in     : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            ifm_x_out    : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            ifm_x_status : out std_logic;
            w_x_enable   : in std_logic;
            w_x_in       : in std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
            w_x_out      : out std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
            w_x_status   : out std_logic
        );
    end component;

    component MC_rr is
        generic (
            X_ID       : natural       := 1;
            hw_log2_EF : integer_array := hw_log2_EF_PKG
        );
        port (
            EF_log2 : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            rr      : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
        );
    end component;

begin

    -- PE ARRAY
    PE_ARRAY_X_loop : for i in 0 to (X_PKG - 1) generate
        PE_ARRAY_Y_loop : for k in 0 to (Y_PKG - 1) generate
            PE_inst : PE
            generic map(
                Y_ID                  => k + 1,
                X_ID                  => i + 1,
                Y                     => Y_PKG,
                X                     => X_PKG,
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
                pass_flag               => pass_flag_reg,
                OFM_NL_Read             => OFM_NL_Read_reg,
                ifm_PE                  => ifm_x_to_PE(i)(k),
                ifm_PE_enable           => ifm_status_x_to_PE(i)(k),
                w_PE                    => w_x_to_PE(i)(k),
                w_PE_enable             => w_status_x_to_PE(i)(k),
                psum_in                 => psum_inter_array(i)(Y_PKG - 1 - k),
                psum_out                => psum_inter_array(i)(Y_PKG - k),
                PE_ARRAY_RF_write_start => PE_ARRAY_RF_write_start,
                ofmap_p_done            => ofmap_p_done_array(i)(k),
                PISO_Buffer_start       => PISO_Buffer_start_array(i)(k) -- 040323
            );
        end generate PE_ARRAY_Y_loop;
        psum_out_array(i)      <= psum_inter_array(i)(Y_PKG); -- Connect psum output of top PEs to the output of the PE Array.
        psum_inter_array(i)(0) <= (others => '0'); -- Connect psum input of bottom PEs to zero.
    end generate PE_ARRAY_X_loop;

    -- -- MC FC ROW
    -- MC_FC_ROW_loop : for i in 0 to (X - 1) generate
    --     MC_FC_inst : MC_FC
    --     port map(
    --         -- ..
    --     );
    -- end generate MC_FC_ROW_loop;

    -- MC ARRAY
    MC_X_COLUMNS_loop : for i in 0 to (X_PKG - 1) generate
        MC_X_ROWS_loop : for j in 0 to (Y_PKG - 1) generate
            MC_X_inst : MC_X
            generic map(
                Y_ID      => j + 1,
                X_ID      => i + 1,
                Y         => Y_PKG,
                hw_log2_r => hw_log2_r_PKG
            )
            port map(
                RS           => RS,
                EF_log2      => EF_log2,
                C_cap        => C_cap,
                r_log2       => r_log2,
                h_p          => h_p_reg,
                rc           => rc_reg,
                pad          => pad,
                rr           => rr_tmp(i),
                ifm_x_enable => ifm_enable_y_to_x(j),
                ifm_x_in     => ifm_y_to_x(j),
                ifm_x_out    => ifm_x_to_PE(i)(j),
                ifm_x_status => ifm_status_x_to_PE(i)(j),
                w_x_enable   => w_enable_y_to_x(j),
                w_x_in       => w_y_to_x(j),
                w_x_out      => w_x_to_PE(i)(j),
                w_x_status   => w_status_x_to_PE(i)(j)
            );
        end generate MC_X_ROWS_loop;
    end generate MC_X_COLUMNS_loop;

    -- MC Y COLUMN
    MC_Y_COLUMN_loop : for i in 0 to (Y_PKG - 1) generate
        MC_Y_inst : MC_Y
        generic map(
            Y_ID => i + 1
        )
        port map(
            HW_p         => HW_p,
            RS           => RS,
            h_p          => h_p_reg,
            r_p          => r_p_reg,
            WB_NL_busy   => WB_NL_busy_reg,
            IFM_NL_busy  => IFM_NL_busy_reg,
            ifm_y_in     => ifm_sram,
            ifm_y_out    => ifm_y_to_x(i),
            ifm_y_status => ifm_enable_y_to_x(i),
            w_y_in       => w_sram,
            w_y_out      => w_y_to_x(i),
            w_y_status   => w_enable_y_to_x(i)
        );
    end generate MC_Y_COLUMN_loop;

    -- MC rr ROW
    MC_rr_ROW_loop : for i in 0 to (X_PKG - 1) generate
        MC_rr_inst : MC_rr
        generic map(
            X_ID       => i + 1,
            hw_log2_EF => hw_log2_EF_PKG
        )
        port map(
            EF_log2 => EF_log2,
            rr      => rr_tmp(i)
        );
    end generate MC_rr_ROW_loop;

    -- process to register sys ctrl. parameters, as they need 1 clk delay
    -- as to account with the 1clk read latency from the memories.
    REG_PROC : process (clk)
    begin
        if rising_edge(clk) then
            h_p_reg         <= h_p;
            r_p_reg         <= r_p;
            rc_reg          <= rc;
            IFM_NL_busy_reg <= IFM_NL_busy;
            WB_NL_busy_reg  <= WB_NL_busy;
            pass_flag_reg   <= pass_flag;
            OFM_NL_Read_reg <= OFM_NL_Read;
        end if;
    end process;

    -- Process to register ofmap primitives coming from the PE Array, to be send to the Adder Tree.
    OFMAP_REG_GEN : for i in 0 to (X_PKG - 1) generate
        OFMAP_REG_PROC : process (clk, reset)
        begin
            if rising_edge(clk) then
                if (reset = '1') then
                    ofmap_p_reg(i) <= (others => '0');
                else
                    if (ofmap_p_done_array(i)(0) = '1') then -- ofmap_p_done of PE(i,1) acts as clock enable of ofmap_p reg.
                        ofmap_p_reg(i) <= ofmap_p_next(i);
                    end if;
--                    ofmap_p_reg(i) <= ofmap_p_next(i);
                end if;
            end if;
        end process;

--        OFMAP_NEXT_PROC : process (ofmap_p_done_array(i)(0))
--        begin
--            if (ofmap_p_done_array(i)(0) = '1') then
--                ofmap_p_next(i) <= psum_out_array(i);
--            else
--                ofmap_p_next(i) <= (others => '0');
--            end if;
--        end process;
    end generate OFMAP_REG_GEN;

    -- PORT Assignations
    PE_ARRAY_RF_write_start <= '1' when ((IFM_NL_busy_reg = '1') or (WB_NL_busy_reg = '1')) else '0'; -- triggers writing state within all PEs.
    ofmap_p_next            <= psum_out_array; -- register ofmap primitives from the PE Array.
    ofmap_p                 <= ofmap_p_reg;
--    PISO_Buffer_start       <= ofmap_p_done_array(0)(0); -- triggers parallel input.
    PISO_Buffer_start       <= PISO_Buffer_start_array(0)(0); -- triggers parallel input. 040323

end architecture;
