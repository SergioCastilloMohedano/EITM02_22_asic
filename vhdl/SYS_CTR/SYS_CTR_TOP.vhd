-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SYS_CTR_TOP.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-05-15
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : This block integrates the Nested Loops for both weights/biases and Input Features Map,
--                  triggers them so that corresponding values of both weights/biases and ifmaps
--                  can be retrieved from SRAM blocks concurrently and also be sent concurrently to the
--                  Multicast Controllers.
--               
--              TBD
--              It needs to be modified to hold for its state when pass is totally loaded into PE Array
--              and wait for computation to be finished. During this time, at some point, Nested Loop
--              for the ifmap outputs of next layer shall be triggered.
-------------------------------------------------------------------------------------------------------
-- Input Signals  :
--         * clk: clock
--         * reset: synchronous, active high.
--         * 
-- Output Signals :
--         * ...
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SYS_CTR_TOP is
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
        NoC_c_bias                : out std_logic_vector (7 downto 0);
        NoC_pm_bias               : out std_logic_vector (7 downto 0)
    );
end SYS_CTR_TOP;

architecture architectural of SYS_CTR_TOP is

    -- COMPONENT DECLARATIONS
    component SYS_CTR_MAIN_NL is
        port (
            clk             : in std_logic;
            reset           : in std_logic;
            NL_start        : in std_logic;
            NL_ready        : out std_logic;
            NL_finished     : out std_logic;
            M_cap           : in std_logic_vector (7 downto 0);
            C_cap           : in std_logic_vector (7 downto 0);
            r               : in std_logic_vector (7 downto 0);
            p               : in std_logic_vector (7 downto 0);
            c               : out std_logic_vector (7 downto 0);
            m               : out std_logic_vector (7 downto 0);
            rc              : out std_logic_vector (7 downto 0);
            NoC_ACK_flag    : in std_logic;
            IFM_NL_ready    : in std_logic;
            IFM_NL_finished : in std_logic;
            WB_NL_ready     : in std_logic;
            WB_NL_finished  : in std_logic;
            IFM_NL_start    : out std_logic;
            WB_NL_start     : out std_logic;
            pass_flag       : in std_logic;
            OFM_NL_ready    : in std_logic;
            OFM_NL_finished : in std_logic;
            OFM_NL_start    : out std_logic
        );
    end component;

    component SYS_CTR_WB_NL is
        port (
            clk            : in std_logic;
            reset          : in std_logic;
            WB_NL_start    : in std_logic;
            WB_NL_ready    : out std_logic;
            WB_NL_finished : out std_logic;
            WB_NL_busy     : out std_logic;
            RS             : in std_logic_vector (7 downto 0);
            p              : in std_logic_vector (7 downto 0);
            m              : in std_logic_vector (7 downto 0);
            r_p            : out std_logic_vector (7 downto 0);
            pm             : out std_logic_vector (7 downto 0);
            s              : out std_logic_vector (7 downto 0)
        );
    end component;

    component SYS_CTR_IFM_NL is
        port (
            clk             : in std_logic;
            reset           : in std_logic;
            IFM_NL_start    : in std_logic;
            IFM_NL_ready    : out std_logic;
            IFM_NL_finished : out std_logic;
            IFM_NL_busy     : out std_logic;
            HW_p            : in std_logic_vector (7 downto 0);
            h_p             : out std_logic_vector (7 downto 0);
            w_p             : out std_logic_vector (7 downto 0)
        );
    end component;

    component SYS_CTR_PASS_FLAG is
        port (
            clk             : in std_logic;
            reset           : in std_logic;
            NL_start        : in std_logic;
            NL_finished     : in std_logic;
            r               : in std_logic_vector (7 downto 0);
            M_div_pt        : in std_logic_vector (7 downto 0);
            WB_NL_finished  : in std_logic;
            IFM_NL_finished : in std_logic;
            pass_flag       : out std_logic
        );
    end component;

    component SYS_CTR_OFM_NL is
        port (
            clk                       : in std_logic;
            reset                     : in std_logic;
            OFM_NL_start              : in std_logic;
            OFM_NL_ready              : out std_logic;
            OFM_NL_finished           : out std_logic;
            OFM_NL_busy               : out std_logic;
            C_cap                     : in std_logic_vector (7 downto 0);
            M_cap                     : in std_logic_vector (7 downto 0);
            EF                        : in std_logic_vector (7 downto 0);
            r                         : in std_logic_vector (7 downto 0);
            p                         : in std_logic_vector (7 downto 0);
            NoC_c                     : out std_logic_vector (7 downto 0);
            NoC_pm                    : out std_logic_vector (7 downto 0);
            NoC_f                     : out std_logic_vector (7 downto 0);
            NoC_e                     : out std_logic_vector (7 downto 0);
            shift_PISO                : in std_logic;
            OFM_NL_cnt_finished       : out std_logic;
            OFM_NL_NoC_m_cnt_finished : out std_logic;
            NoC_c_bias                : out std_logic_vector (7 downto 0);
            NoC_pm_bias               : out std_logic_vector (7 downto 0)
        );
    end component;

    signal NL_ready_tmp    : std_logic;
    signal NL_finished_tmp : std_logic;

    signal WB_NL_ready_tmp     : std_logic;
    signal WB_NL_finished_tmp  : std_logic;
    signal WB_NL_busy_tmp      : std_logic;
    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal IFM_NL_busy_tmp     : std_logic;
    signal OFM_NL_ready_tmp    : std_logic;
    signal OFM_NL_finished_tmp : std_logic;

    -- SYS_CTR_MAIN_NL Intermediate Signals
    signal m_tmp  : std_logic_vector (7 downto 0);
    signal c_tmp  : std_logic_vector (7 downto 0);
    signal rc_tmp : std_logic_vector (7 downto 0);

    -- SYS_CTR_WB_NL Intermediate Signals
    signal s_tmp           : std_logic_vector (7 downto 0);
    signal pm_tmp          : std_logic_vector (7 downto 0);
    signal r_p_tmp         : std_logic_vector (7 downto 0);
    signal WB_NL_start_tmp : std_logic;

    -- SYS_CTR_IFM_NL Intermediate Signals
    signal h_p_tmp          : std_logic_vector (7 downto 0);
    signal w_p_tmp          : std_logic_vector (7 downto 0);
    signal IFM_NL_start_tmp : std_logic;

    -- SYS_CTR_PASS_FLAG Intermediate Signals
    signal pass_flag_tmp : std_logic;
    signal M_div_pt_tmp  : natural range 0 to 255;

    -- SYS_CTR_OFM_NL Intermediate Signals
    --    signal NoC_c_tmp        : std_logic_vector (7 downto 0);
    signal NoC_pm_tmp       : std_logic_vector (7 downto 0);
    signal NoC_f_tmp        : std_logic_vector (7 downto 0);
    signal NoC_e_tmp        : std_logic_vector (7 downto 0);
    signal OFM_NL_start_tmp : std_logic;
    ----------------------------------------------

begin

    -- SYS_CTR_MAIN_NL
    SYS_CTR_MAIN_NL_inst : SYS_CTR_MAIN_NL
    port map(
        clk             => clk,
        reset           => reset,
        NL_start        => NL_start,
        NL_ready        => NL_ready_tmp,
        NL_finished     => NL_finished_tmp,
        M_cap           => M_cap,
        C_cap           => C_cap,
        r               => r,
        p               => p,
        c               => c_tmp,
        m               => m_tmp,
        rc              => rc_tmp,
        NoC_ACK_flag    => NoC_ACK_flag,
        IFM_NL_ready    => IFM_NL_ready_tmp,
        IFM_NL_finished => IFM_NL_finished_tmp,
        WB_NL_ready     => WB_NL_ready_tmp,
        WB_NL_finished  => WB_NL_finished_tmp,
        IFM_NL_start    => IFM_NL_start_tmp,
        WB_NL_start     => WB_NL_start_tmp,
        pass_flag       => pass_flag_tmp,
        OFM_NL_ready    => OFM_NL_ready_tmp,
        OFM_NL_finished => OFM_NL_finished_tmp,
        OFM_NL_start    => OFM_NL_start_tmp
    );
    -- SYS_CTR_WB_NL
    SYS_CTR_WB_NL_inst : SYS_CTR_WB_NL
    port map(
        clk            => clk,
        reset          => reset,
        WB_NL_start    => WB_NL_start_tmp,
        WB_NL_ready    => WB_NL_ready_tmp,
        WB_NL_finished => WB_NL_finished_tmp,
        WB_NL_busy     => WB_NL_busy_tmp,
        RS             => RS,
        p              => p,
        m              => m_tmp,
        r_p            => r_p_tmp,
        pm             => pm_tmp,
        s              => s_tmp
    );

    -- SYS_CTR_IFM_NL
    SYS_CTR_IFM_NL_inst : SYS_CTR_IFM_NL
    port map(
        clk             => clk,
        reset           => reset,
        IFM_NL_start    => IFM_NL_start_tmp,
        IFM_NL_ready    => IFM_NL_ready_tmp,
        IFM_NL_finished => IFM_NL_finished_tmp,
        IFM_NL_busy     => IFM_NL_busy_tmp,
        HW_p            => HW_p,
        h_p             => h_p_tmp,
        w_p             => w_p_tmp
    );

    -- SYS_CTR_PASS_FLAG
    SYS_CTR_PASS_FLAG_inst : SYS_CTR_PASS_FLAG
    port map(
        clk             => clk,
        reset           => reset,
        NL_start        => NL_start,
        NL_finished     => NL_finished_tmp,
        r               => r,
        M_div_pt        => M_div_pt,
        WB_NL_finished  => WB_NL_finished_tmp,
        IFM_NL_finished => IFM_NL_finished_tmp,
        pass_flag       => pass_flag_tmp
    );

    -- SYS_CTR_OFM_NL
    SYS_CTR_CTR_OFM_NL_inst : SYS_CTR_OFM_NL
    port map(
        clk                       => clk,
        reset                     => reset,
        OFM_NL_start              => OFM_NL_start_tmp,
        OFM_NL_ready              => OFM_NL_ready_tmp,
        OFM_NL_finished           => OFM_NL_finished_tmp,
        OFM_NL_busy               => OFM_NL_Busy,
        C_cap                     => C_cap,
        M_cap                     => M_cap,
        EF                        => EF,
        r                         => r,
        p                         => p,
        NoC_c                     => NoC_c,
        NoC_pm                    => NoC_pm_tmp,
        NoC_f                     => NoC_f_tmp,
        NoC_e                     => NoC_e_tmp,
        shift_PISO                => shift_PISO,
        OFM_NL_cnt_finished       => OFM_NL_cnt_finished,
        OFM_NL_NoC_m_cnt_finished => OFM_NL_NoC_m_cnt_finished,
        NoC_c_bias                => NoC_c_bias,
        NoC_pm_bias               => NoC_pm_bias
    );

    -- PORT Assignations
    NL_ready        <= NL_ready_tmp;
    NL_finished     <= NL_finished_tmp;
    m               <= m_tmp;
    c               <= c_tmp;
    rc              <= rc_tmp;
    r_p             <= r_p_tmp;
    pm              <= pm_tmp;
    s               <= s_tmp;
    h_p             <= h_p_tmp;
    w_p             <= w_p_tmp;
    IFM_NL_ready    <= IFM_NL_ready_tmp;
    IFM_NL_finished <= IFM_NL_finished_tmp;
    IFM_NL_busy     <= IFM_NL_busy_tmp;
    WB_NL_ready     <= WB_NL_ready_tmp;
    WB_NL_finished  <= WB_NL_finished_tmp;
    WB_NL_busy      <= WB_NL_busy_tmp;
    pass_flag       <= pass_flag_tmp;

end architecture;