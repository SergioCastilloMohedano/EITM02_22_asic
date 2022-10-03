library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity TOP is
    generic (
        -- HW Parameters, at synthesis time.
        X                     : natural       := 32; -- Emax of network (conv0 and conv1)
        Y                     : natural       := 3;
        hw_log2_r             : integer_array := (0, 1, 2);
        hw_log2_EF            : integer_array := (5, 4, 3);
        NUM_REGS_IFM_REG_FILE : natural       := 32; -- Emax (conv0 and conv1)
        NUM_REGS_W_REG_FILE   : natural       := 24; -- p*S = 8*3 = 24
        EOM_ADDR_WB_SRAM      : natural       := 82329 -- End Of Memory Address of the WB SRAM, this is where first bias value is stored, in decreasing order of addresses.
    );
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        NL_start    : in std_logic;
        NL_ready    : out std_logic;
        NL_finished : out std_logic;

        -- Signals Below Shall be coming from within the accelerator later on. ----
        M_cap    : in std_logic_vector (7 downto 0);
        C_cap    : in std_logic_vector (7 downto 0);
        r        : in std_logic_vector (7 downto 0);
        p        : in std_logic_vector (7 downto 0);
        RS       : in std_logic_vector (7 downto 0);
        EF       : in std_logic_vector (7 downto 0);
        HW_p     : in std_logic_vector (7 downto 0);
        HW       : in std_logic_vector (7 downto 0);
        M_div_pt : in std_logic_vector (7 downto 0);
        --        NoC_ACK_flag : in std_logic;
        EF_log2 : in std_logic_vector (7 downto 0);
        r_log2  : in std_logic_vector (7 downto 0)
        ---------------------------------------------------------------------------
    );
end TOP;

architecture structural of TOP is

    -- SIGNAL DEFINITIONS
    -- SYS_CTR_TOP
    signal NL_ready_tmp        : std_logic;
    signal NL_finished_tmp     : std_logic;
    signal c_tmp               : std_logic_vector (7 downto 0);
    signal m_tmp               : std_logic_vector (7 downto 0);
    signal rc_tmp              : std_logic_vector (7 downto 0);
    signal r_p_tmp             : std_logic_vector (7 downto 0);
    signal pm_tmp              : std_logic_vector (7 downto 0);
    signal s_tmp               : std_logic_vector (7 downto 0);
    signal w_p_tmp             : std_logic_vector (7 downto 0);
    signal h_p_tmp             : std_logic_vector (7 downto 0);
    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal IFM_NL_busy_tmp     : std_logic;
    signal WB_NL_ready_tmp     : std_logic;
    signal WB_NL_finished_tmp  : std_logic;
    signal WB_NL_busy_tmp      : std_logic;
    signal pass_flag_tmp       : std_logic;
    signal NoC_c               : std_logic_vector (7 downto 0);
    signal OFM_NL_busy_tmp     : std_logic;
    signal NoC_c_bias_tmp      : std_logic_vector (7 downto 0);
    signal NoC_pm_bias_tmp      : std_logic_vector (7 downto 0);

    -- SRAM_WB
    signal w_tmp : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal b_tmp : std_logic_vector (15 downto 0);

    -- SRAM_IFM
    signal ifm_tmp : std_logic_vector (COMP_BITWIDTH - 1 downto 0);

    -- PE ARRAY
    signal ofmap_p                   : psum_array(0 to (X - 1));
    signal PISO_Buffer_start         : std_logic;
    signal NoC_ACK_flag              : std_logic;
    signal shift_PISO                : std_logic;
    signal OFM_NL_cnt_finished       : std_logic;
    signal OFM_NL_NoC_m_cnt_finished : std_logic;

    -- SRAM_OFM
    signal ofmap : std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);

    -- COMPONENT DECLARATIONS
    component SYS_CTR_TOP is
        port (
            clk                       : in std_logic;
            reset                     : in std_logic;
            NL_start                  : in std_logic;
            NL_ready                  : out std_logic;
            NL_finished               : out std_logic;
            M_cap                     : in std_logic_vector (7 downto 0);
            C_cap                     : in std_logic_vector (7 downto 0);
            r                         : in std_logic_vector (7 downto 0);
            p                         : in std_logic_vector (7 downto 0);
            RS                        : in std_logic_vector (7 downto 0);
            HW_p                      : in std_logic_vector (7 downto 0);
            EF                        : in std_logic_vector (7 downto 0);
            c                         : out std_logic_vector (7 downto 0);
            m                         : out std_logic_vector (7 downto 0);
            rc                        : out std_logic_vector (7 downto 0);
            r_p                       : out std_logic_vector (7 downto 0);
            pm                        : out std_logic_vector (7 downto 0);
            s                         : out std_logic_vector (7 downto 0);
            w_p                       : out std_logic_vector (7 downto 0);
            h_p                       : out std_logic_vector (7 downto 0);
            M_div_pt                  : in std_logic_vector (7 downto 0);
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
            NoC_c                     : out std_logic_vector (7 downto 0);
            OFM_NL_Busy               : out std_logic;
            NoC_c_bias                : out std_logic_vector (7 downto 0); -- same as NoC_c but taking the non-registered signal (1 cc earlier) so that I avoid 1cc read latency from reading the bias.
            NoC_pm_bias               : out std_logic_vector (7 downto 0)  -- same as NoC_pm but...
        );
    end component;

    component SRAM_WB is
        generic (
            EOM_ADDR_WB_SRAM : natural := 82329 -- End Of Memory Address of the WB SRAM, this is where first bias value is stored, in decreasing order of addresses.
        );
        port (
            clk            : in std_logic;
            reset          : in std_logic;
            WB_NL_ready    : in std_logic;
            WB_NL_finished : in std_logic;
            NoC_c_bias     : in std_logic_vector (7 downto 0);
            NoC_pm_bias    : in std_logic_vector (7 downto 0);
            OFM_NL_Busy    : in std_logic;
            w_out          : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            b_out          : out std_logic_vector (15 downto 0)
        );
    end component;

    component SRAM_IFM is
        port (
            clk             : in std_logic;
            reset           : in std_logic;
            h_p             : in std_logic_vector (7 downto 0);
            w_p             : in std_logic_vector (7 downto 0);
            HW              : in std_logic_vector (7 downto 0);
            RS              : in std_logic_vector (7 downto 0);
            IFM_NL_ready    : in std_logic;
            IFM_NL_finished : in std_logic;
            ifm_out         : out std_logic_vector (COMP_BITWIDTH - 1 downto 0)
        );
    end component;

    -- component OFMAP_SRAM is
    component SRAM_OFM is
        port (
            clk                       : in std_logic;
            reset                     : in std_logic;
            NoC_c                     : in std_logic_vector (7 downto 0);
            OFM_NL_cnt_finished       : in std_logic;
            OFM_NL_NoC_m_cnt_finished : in std_logic;
            ofmap                     : in std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);
            shift_PISO                : in std_logic;
            OFM_NL_Busy               : in std_logic;
            bias                      : in std_logic_vector (15 downto 0)
        );
    end component;

    component NOC is
        generic (
            X                     : natural       := X;
            Y                     : natural       := Y;
            hw_log2_r             : integer_array := hw_log2_r;
            hw_log2_EF            : integer_array := hw_log2_EF;
            NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE; -- Emax (conv0 and conv1)
            NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE -- p*S = 8*3 = 24
        );
        port (
            clk               : in std_logic;
            reset             : in std_logic;
            C_cap             : in std_logic_vector (7 downto 0);
            HW_p              : in std_logic_vector (7 downto 0);
            EF                : in std_logic_vector (7 downto 0);
            EF_log2           : in std_logic_vector (7 downto 0);
            r_log2            : in std_logic_vector (7 downto 0);
            RS                : in std_logic_vector (7 downto 0);
            p                 : in std_logic_vector (7 downto 0);
            r                 : in std_logic_vector (7 downto 0);
            h_p               : in std_logic_vector (7 downto 0);
            rc                : in std_logic_vector (7 downto 0);
            r_p               : in std_logic_vector (7 downto 0);
            WB_NL_busy        : in std_logic;
            IFM_NL_busy       : in std_logic;
            pass_flag         : in std_logic;
            ifm_sram          : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            w_sram            : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            ofmap_p           : out psum_array(0 to (X - 1));
            PISO_Buffer_start : out std_logic
        );
    end component;

    component ADDER_TREE_TOP is
        generic (
            X : natural := X
        );
        port (
            clk               : in std_logic;
            reset             : in std_logic;
            r                 : in std_logic_vector (7 downto 0);
            EF                : in std_logic_vector (7 downto 0);
            ofmap_p           : in psum_array(0 to (X - 1));
            PISO_Buffer_start : in std_logic;
            ofmap             : out std_logic_vector((OFMAP_P_BITWIDTH - 1) downto 0);
            NoC_ACK_flag      : out std_logic;
            shift_PISO        : out std_logic
        );
    end component;

    -- component RELU is
    -- port(clk                : in std_logic;
    --      reset              : in std_logic
    --      -- ...
    --     );
    -- end component;

    -- component POOLING is
    -- port(clk                : in std_logic;
    --      reset              : in std_logic
    --      -- ...
    --     );
    -- end component;

    -- component STOCHASTIC_ROUNDING is
    -- port(clk                : in std_logic;
    --      reset              : in std_logic
    --      -- ...
    --     );
    -- end component;

begin

    -- SYSTEM CONTROLLER
    SYS_CTR_TOP_inst : SYS_CTR_TOP
    port map(
        clk                       => clk,
        reset                     => reset,
        NL_start                  => NL_start,
        NL_ready                  => NL_ready_tmp,
        NL_finished               => NL_finished_tmp,
        M_cap                     => M_cap,
        C_cap                     => C_cap,
        r                         => r,
        p                         => p,
        RS                        => RS,
        HW_p                      => HW_p,
        EF                        => EF,
        c                         => c_tmp,
        m                         => m_tmp,
        rc                        => rc_tmp,
        r_p                       => r_p_tmp,
        pm                        => pm_tmp,
        s                         => s_tmp,
        w_p                       => w_p_tmp,
        h_p                       => h_p_tmp,
        M_div_pt                  => M_div_pt,
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
        OFM_NL_Busy               => OFM_NL_Busy_tmp,
        NoC_c_bias                => NoC_c_bias_tmp,
        NoC_pm_bias               => NoC_pm_bias_tmp
    );

    -- SRAM_WB
    SRAM_WB_inst : SRAM_WB
    generic map(
        EOM_ADDR_WB_SRAM => EOM_ADDR_WB_SRAM
    )
    port map(
        clk            => clk,
        reset          => reset,
        WB_NL_ready    => WB_NL_ready_tmp,
        WB_NL_finished => WB_NL_finished_tmp,
        NoC_c_bias     => NoC_c_bias_tmp,
        NoC_pm_bias    => NoC_pm_bias_tmp,
        OFM_NL_Busy    => OFM_NL_Busy_tmp,
        w_out          => w_tmp,
        b_out          => b_tmp
    );

    -- SRAM_IFM
    SRAM_IFM_inst : SRAM_IFM
    port map(
        clk             => clk,
        reset           => reset,
        h_p             => h_p_tmp,
        w_p             => w_p_tmp,
        HW              => HW,
        RS              => RS,
        IFM_NL_ready    => IFM_NL_ready_tmp,
        IFM_NL_finished => IFM_NL_finished_tmp,
        ifm_out         => ifm_tmp
    );

    -- NOC
    NOC_inst : NOC
    generic map(
        X                     => X,
        Y                     => Y,
        hw_log2_r             => hw_log2_r,
        hw_log2_EF            => hw_log2_EF,
        NUM_REGS_IFM_REG_FILE => NUM_REGS_IFM_REG_FILE,
        NUM_REGS_W_REG_FILE   => NUM_REGS_W_REG_FILE
    )
    port map(
        clk               => clk,
        reset             => reset,
        C_cap             => C_cap,
        HW_p              => HW_p,
        EF                => EF,
        EF_log2           => EF_log2,
        r_log2            => r_log2,
        RS                => RS,
        p                 => p,
        r                 => r,
        h_p               => h_p_tmp,
        rc                => rc_tmp,
        r_p               => r_p_tmp,
        WB_NL_busy        => WB_NL_busy_tmp,
        IFM_NL_busy       => IFM_NL_busy_tmp,
        pass_flag         => pass_flag_tmp,
        ifm_sram          => ifm_tmp,
        w_sram            => w_tmp,
        ofmap_p           => ofmap_p,
        PISO_Buffer_start => PISO_Buffer_start
    );

    -- ADDER TREE
    ADDER_TREE_TOP_inst : ADDER_TREE_TOP
    generic map(
        X => X
    )
    port map(
        clk               => clk,
        reset             => reset,
        r                 => r,
        EF                => EF,
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
        ofmap                     => ofmap,
        shift_PISO                => shift_PISO,
        OFM_NL_Busy               => OFM_NL_Busy_tmp,
        bias                      => b_tmp
    );

    -- -- RELU
    -- RELU_inst : RELU
    -- port map (
    --     clk             =>  clk,
    --     reset           =>  reset
    --     -- ..
    -- );

    -- -- POOLING
    -- POOLING_inst : POOLING
    -- port map (
    --     clk             =>  clk,
    --     reset           =>  reset
    --     -- ..
    -- );

    -- -- STOCHASTIC ROUNDING
    -- STOCHASTIC_ROUNDING_inst : STOCHASTIC_ROUNDING
    -- port map (
    --     clk             =>  clk,
    --     reset           =>  reset
    --     -- ..
    -- );

    -- PORT Assignations
    NL_ready    <= NL_ready_tmp;
    NL_finished <= NL_finished_tmp;
end architecture;