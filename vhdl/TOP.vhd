library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity TOP is
    generic (
        -- HW Parameters, at synthesis time.
        X                     : natural       := X_PKG; -- Emax of network (conv0 and conv1)
        Y                     : natural       := Y_PKG;
        hw_log2_r             : integer_array := hw_log2_r_PKG;
        hw_log2_EF            : integer_array := hw_log2_EF_PKG;
        NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG;             -- W' max (conv0 and conv1)
        NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE_PKG;             -- p*S = 8*3 = 24
        ADDR_4K_CFG           : natural       := ADDR_4K_CFG_PKG            -- First Address of the reserved space for config. parameters.
    );
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        NL_start    : in std_logic;
        NL_ready    : out std_logic;
        NL_finished : out std_logic
    );
end TOP;

architecture structural of TOP is

    -- SIGNAL DEFINITIONS
    -- SYS_CTR_TOP
    signal NL_ready_tmp        : std_logic;
    signal NL_finished_tmp     : std_logic;
    signal c_tmp               : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal m_tmp               : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal rc_tmp              : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal r_p_tmp             : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal pm_tmp              : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal s_tmp               : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal w_p_tmp             : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal h_p_tmp             : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal IFM_NL_busy_tmp     : std_logic;
    signal WB_NL_ready_tmp     : std_logic;
    signal WB_NL_finished_tmp  : std_logic;
    signal WB_NL_busy_tmp      : std_logic;
    signal pass_flag_tmp       : std_logic;
    signal NoC_c               : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal OFM_NL_Write_tmp    : std_logic;
    signal OFM_NL_Read_tmp     : std_logic;
    signal NoC_pm_bias_tmp     : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal NoC_pm_tmp          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal NoC_e_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal NoC_f_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal READ_CFG_tmp        : std_logic;
    -- cfg -----------------------------------------
    signal M_cap_tmp       : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal C_cap_tmp       : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal r_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal p_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal RS_tmp          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal EF_tmp          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal HW_p_tmp        : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal HW_tmp          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal EF_log2_tmp     : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal r_log2_tmp      : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal is_pooling_tmp  : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    ------------------------------------------------


    -- SRAM_WB
    signal w_tmp   : std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
    signal b_tmp   : std_logic_vector (BIAS_BITWIDTH - 1 downto 0);
    signal cfg_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

    -- SRAM_IFM
    signal ifm_tmp : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal pad_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- To MC_X

    -- PE ARRAY
    signal ofmap_p                   : psum_array(0 to (X_PKG - 1));
    signal PISO_Buffer_start         : std_logic;
    signal NoC_ACK_flag              : std_logic;
    signal shift_PISO                : std_logic;
    signal OFM_NL_cnt_finished       : std_logic;
    signal OFM_NL_NoC_m_cnt_finished : std_logic;

    -- SRAM_OFM
    signal ofmap     : std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);
    signal ofmap_out : std_logic_vector((OFMAP_BITWIDTH - 1) downto 0);

    -- RN
    signal rn_out : std_logic_vector((ACT_BITWIDTH - 1) downto 0);

    -- Pooling
    signal pooling_ack_tmp : std_logic;
    signal pooling_out     : std_logic_vector((ACT_BITWIDTH - 1) downto 0);
    signal en_w_IFM_tmp    : std_logic;
    signal p_en_w_IFM_tmp  : std_logic;

    -- Clock Gating
--    signal clk_cg    : std_logic;
--    signal enable_cg : std_logic;

    -- COMPONENT DECLARATIONS
    component SYS_CTR_TOP is
        port (
            clk                       : in std_logic;
            reset                     : in std_logic;
            NL_start                  : in std_logic;
            NL_ready                  : out std_logic;
            NL_finished               : out std_logic;
            c                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            m                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            rc                        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_p                       : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            pm                        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            s                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            w_p                       : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            h_p                       : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_ACK_flag              : in std_logic;
            IFM_NL_ready              : out std_logic;
            IFM_NL_finished           : out std_logic;
            IFM_NL_busy               : out std_logic;
            WB_NL_ready               : out std_logic;
            WB_NL_finished            : out std_logic;
            WB_NL_busy                : out std_logic;
            pass_flag                 : out std_logic;
            shift_PISO                : in std_logic;
            OFM_NL_cnt_finished       : out std_logic;
            OFM_NL_NoC_m_cnt_finished : out std_logic;
            NoC_c                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            OFM_NL_Write              : out std_logic;
            OFM_NL_Read               : out std_logic;
            NoC_pm_bias               : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- same as NoC_c but taking the non-registered signal (1 cc earlier) so that I avoid 1cc read latency from reading the bias.
            NoC_pm                    : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_f                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_e                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            READ_CFG                  : out std_logic;
            cfg_in                    : in  std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            M_cap                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            C_cap                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            HW                        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            HW_p                      : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            RS                        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF                        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            p                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF_log2                   : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_log2                    : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            is_pooling                : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
        );
    end component;

    component SRAM_WB is
        generic (
            ADDR_4K_CFG : natural := ADDR_4K_CFG_PKG           -- First Address of the reserved space for config. parameters.
        );
        port (
            clk            : in std_logic;
            reset          : in std_logic;
            WB_NL_ready    : in std_logic;
            WB_NL_finished : in std_logic;
            NoC_c          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_pm_bias    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            OFM_NL_Write   : in std_logic;
            READ_CFG       : in std_logic;
            w_out          : out std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
            b_out          : out std_logic_vector (BIAS_BITWIDTH - 1 downto 0);
            cfg_out        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
        );
    end component;

    component SRAM_IFM is
        port (
            clk             : in std_logic;
            reset           : in std_logic;
            h_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            w_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            HW              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            RS              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            IFM_NL_ready    : in std_logic;
            IFM_NL_finished : in std_logic;
            ifm_out         : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            pad             : out natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- To MC_X
            is_pooling      : in std_logic;
            en_w_IFM        : in std_logic;
            pooling_ack     : in std_logic;
            pooling_IFM     : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            rn_IFM          : in std_logic_vector (ACT_BITWIDTH - 1 downto 0)
        );
    end component;

    -- component OFMAP_SRAM is
    component SRAM_OFM is
        port (
            clk                       : in std_logic;
            reset                     : in std_logic;
            NoC_c                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            OFM_NL_cnt_finished       : in std_logic;
            OFM_NL_NoC_m_cnt_finished : in std_logic;
            OFM_NL_Write              : in std_logic;
            OFM_NL_Read               : in std_logic;
            ofmap                     : in std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);
            shift_PISO                : in std_logic;
            bias                      : in std_logic_vector (BIAS_BITWIDTH - 1 downto 0);
            ofm                       : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0)
        );
    end component;

--    component my_CG_MOD is
--    port (
--        ck_in  : in std_logic;
--        enable : in std_logic;
--        ck_out : out std_logic
--        );
--    end component;

    component NOC is
        generic (
            X                     : natural       := X_PKG;
            Y                     : natural       := Y_PKG;
            hw_log2_r             : integer_array := hw_log2_r_PKG;
            hw_log2_EF            : integer_array := hw_log2_EF_PKG;
            NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG; -- W' max (conv0 and conv1)
            NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE_PKG    -- p*S = 8*3 = 24
        );
        port (
            clk               : in std_logic;
            reset             : in std_logic;
            C_cap             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            HW_p              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF                : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF_log2           : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_log2            : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            RS                : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            p                 : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r                 : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            h_p               : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            rc                : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_p               : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            WB_NL_busy        : in std_logic;
            IFM_NL_busy       : in std_logic;
            pass_flag         : in std_logic;
            pad               : in natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- To MC_X
            ifm_sram          : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            w_sram            : in std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
            ofmap_p           : out psum_array(0 to (X_PKG - 1));
            PISO_Buffer_start : out std_logic;
            OFM_NL_Read       : in std_logic
        );
    end component;

    component ADDER_TREE_TOP is
        generic (
            X : natural := X_PKG
        );
        port (
            clk               : in std_logic;
            reset             : in std_logic;
            r                 : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF                : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            ofmap_p           : in psum_array(0 to (X_PKG - 1));
            PISO_Buffer_start : in std_logic;
            ofmap             : out std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);
            NoC_ACK_flag      : out std_logic;
            shift_PISO        : out std_logic
        );
    end component;

    component RN_RELU is
        port (
            value_in  : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
            value_out : out std_logic_vector (ACT_BITWIDTH - 1 downto 0)
        );
    end component;

    component POOLING_TOP is
        generic (
            X : natural := X_PKG
        );
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            M_cap       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_pm      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_f       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_e       : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            en_pooling  : in std_logic;
            value_in    : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            value_out   : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
            pooling_ack : out std_logic;
            en_w_IFM    : out std_logic
        );
    end component;

begin

    -- SYSTEM CONTROLLER
    SYS_CTR_TOP_inst : SYS_CTR_TOP
    port map(
        clk                       => clk,
        reset                     => reset,
        NL_start                  => NL_start,
        NL_ready                  => NL_ready_tmp,
        NL_finished               => NL_finished_tmp,
        c                         => c_tmp,
        m                         => m_tmp,
        rc                        => rc_tmp,
        r_p                       => r_p_tmp,
        pm                        => pm_tmp,
        s                         => s_tmp,
        w_p                       => w_p_tmp,
        h_p                       => h_p_tmp,
        NoC_ACK_flag              => NoC_ACK_flag,
        IFM_NL_ready              => IFM_NL_ready_tmp,
        IFM_NL_finished           => IFM_NL_finished_tmp,
        IFM_NL_busy               => IFM_NL_busy_tmp,
        WB_NL_ready               => WB_NL_ready_tmp,
        WB_NL_finished            => WB_NL_finished_tmp,
        WB_NL_busy                => WB_NL_busy_tmp,
        pass_flag                 => pass_flag_tmp,
        shift_PISO                => shift_PISO,
        OFM_NL_cnt_finished       => OFM_NL_cnt_finished,
        OFM_NL_NoC_m_cnt_finished => OFM_NL_NoC_m_cnt_finished,
        NoC_c                     => NoC_c,
        OFM_NL_Write              => OFM_NL_Write_tmp,
        OFM_NL_Read               => OFM_NL_Read_tmp,
        NoC_pm_bias               => NoC_pm_bias_tmp,
        NoC_pm                    => NoC_pm_tmp,
        NoC_f                     => NoC_f_tmp,
        NoC_e                     => NoC_e_tmp,
        READ_CFG                  => READ_CFG_tmp,
        cfg_in                    => cfg_tmp,
        M_cap                     => M_cap_tmp,
        C_cap                     => C_cap_tmp,
        r                         => r_tmp,
        p                         => p_tmp,
        RS                        => RS_tmp,
        EF                        => EF_tmp,
        HW_p                      => HW_p_tmp,
        HW                        => HW_tmp,
        EF_log2                   => EF_log2_tmp,
        r_log2                    => r_log2_tmp,
        is_pooling                => is_pooling_tmp
    );

    -- SRAM_WB
    SRAM_WB_inst : SRAM_WB
    generic map(
        ADDR_4K_CFG => ADDR_4K_CFG_PKG
    )
    port map(
        clk            => clk,
        reset          => reset,
        WB_NL_ready    => WB_NL_ready_tmp,
        WB_NL_finished => WB_NL_finished_tmp,
        NoC_c          => NoC_c,
        NoC_pm_bias    => NoC_pm_bias_tmp,
        OFM_NL_Write   => OFM_NL_Write_tmp,
        READ_CFG       => READ_CFG_tmp,
        w_out          => w_tmp,
        b_out          => b_tmp,
        cfg_out        => cfg_tmp
    );

    -- SRAM_IFM
    SRAM_IFM_inst : SRAM_IFM
    port map(
        clk             => clk,
        reset           => reset,
        h_p             => h_p_tmp,
        w_p             => w_p_tmp,
        HW              => HW_tmp,
        RS              => RS_tmp,
        IFM_NL_ready    => IFM_NL_ready_tmp,
        IFM_NL_finished => IFM_NL_finished_tmp,
        ifm_out         => ifm_tmp,
        pad             => pad_tmp,
        is_pooling      => is_pooling_tmp(0),
        en_w_IFM        => en_w_IFM_tmp,
        pooling_ack     => pooling_ack_tmp,
        pooling_IFM     => pooling_out,
        rn_IFM          => rn_out

    );

    -- Clock Gating
--    enable_cg <= not(OFM_NL_Read_tmp);

--    my_CG_MOD_inst : my_CG_MOD
--    port map(
--        ck_in  => clk,
--        enable => enable_cg,
--        ck_out => clk_cg
--    );


    -- NOC
    NOC_inst : NOC
    generic map(
        X                     => X_PKG,
        Y                     => Y_PKG,
        hw_log2_r             => hw_log2_r_PKG,
        hw_log2_EF            => hw_log2_EF_PKG,
        NUM_REGS_IFM_REG_FILE => NUM_REGS_IFM_REG_FILE_PKG,
        NUM_REGS_W_REG_FILE   => NUM_REGS_W_REG_FILE_PKG
    )
    port map(
        clk               => clk,
--        clk               => clk_cg,
        reset             => reset,
        C_cap             => C_cap_tmp,
        HW_p              => HW_p_tmp,
        EF                => EF_tmp,
        EF_log2           => EF_log2_tmp,
        r_log2            => r_log2_tmp,
        RS                => RS_tmp,
        p                 => p_tmp,
        r                 => r_tmp,
        h_p               => h_p_tmp,
        rc                => rc_tmp,
        r_p               => r_p_tmp,
        WB_NL_busy        => WB_NL_busy_tmp,
        IFM_NL_busy       => IFM_NL_busy_tmp,
        pass_flag         => pass_flag_tmp,
        pad               => pad_tmp,
        ifm_sram          => ifm_tmp,
        w_sram            => w_tmp,
        ofmap_p           => ofmap_p,
        PISO_Buffer_start => PISO_Buffer_start,
        OFM_NL_Read       => OFM_NL_Read_tmp
    );

    -- ADDER TREE
    ADDER_TREE_TOP_inst : ADDER_TREE_TOP
    generic map(
        X => X_PKG
    )
    port map(
        clk               => clk,
        reset             => reset,
        r                 => r_tmp,
        EF                => EF_tmp,
        ofmap_p           => ofmap_p,
        PISO_Buffer_start => PISO_Buffer_start,
        ofmap             => ofmap,
        NoC_ACK_flag      => NoC_ACK_flag,
        shift_PISO        => shift_PISO
    );

    -- SRAM_OFM
    SRAM_OFM_inst : SRAM_OFM
    port map(
        clk                       => clk,
        reset                     => reset,
        NoC_c                     => NoC_c,
        OFM_NL_cnt_finished       => OFM_NL_cnt_finished,
        OFM_NL_NoC_m_cnt_finished => OFM_NL_NoC_m_cnt_finished,
        OFM_NL_Write              => OFM_NL_Write_tmp,
        OFM_NL_Read               => OFM_NL_Read_tmp,
        ofmap                     => ofmap,
        shift_PISO                => shift_PISO,
        bias                      => b_tmp,
        ofm                       => ofmap_out
    );

    -- Round To Nearest / ReLU
    RN_RELU_inst : RN_RELU
    port map(
        value_in  => ofmap_out,
        value_out => rn_out
    );

    -- POOLING
    POOLING_inst : POOLING_TOP
    generic map(
        X => X_PKG
    )
    port map(
        clk         => clk,
        reset       => reset,
        M_cap       => M_cap_tmp,
        EF          => EF_tmp,
        NoC_pm      => NoC_pm_tmp,
        NoC_f       => NoC_f_tmp,
        NoC_e       => NoC_e_tmp,
        en_pooling  => OFM_NL_Read_tmp,
        value_in    => rn_out,
        value_out   => pooling_out,
        pooling_ack => pooling_ack_tmp,
        en_w_IFM    => p_en_w_IFM_tmp
    );
    en_w_IFM_tmp <= p_en_w_IFM_tmp when (is_pooling_tmp(0) = '1') else OFM_NL_Read_tmp;

    -- PORT Assignations
    NL_ready    <= NL_ready_tmp;
    NL_finished <= NL_finished_tmp;

end architecture;
