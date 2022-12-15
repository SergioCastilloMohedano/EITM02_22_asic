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
use work.thesis_pkg.all;

entity SYS_CTR_TOP is
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
        NoC_pm_bias               : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
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
end SYS_CTR_TOP;

architecture architectural of SYS_CTR_TOP is

    -- COMPONENT DECLARATIONS
    component SYS_CTR_MAIN_NL is
        port (
            clk                       : in std_logic;
            reset                     : in std_logic;
            NL_start                  : in std_logic;
            NL_ready                  : out std_logic;
            NL_finished               : out std_logic;
            M_cap                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            C_cap                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            p                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            c                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            m                         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            rc                        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_ACK_flag              : in std_logic;
            IFM_NL_ready              : in std_logic;
            IFM_NL_finished           : in std_logic;
            WB_NL_ready               : in std_logic;
            WB_NL_finished            : in std_logic;
            IFM_NL_start              : out std_logic;
            WB_NL_start               : out std_logic;
            pass_flag                 : in std_logic;
            OFM_NL_ready              : in std_logic;
            OFM_NL_finished           : in std_logic;
            OFM_NL_start              : out std_logic;
            OFM_NL_NoC_m_cnt_finished : in std_logic;
            CFG_start                 : out std_logic;
            CFG_finished              : in std_logic;
            L                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            layer_finished            : out std_logic
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
            RS             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            p              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            m              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_p            : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            pm             : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            s              : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
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
            HW_p            : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            h_p             : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            w_p             : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
        );
    end component;

    component SYS_CTR_PASS_FLAG is
        port (
            clk             : in std_logic;
            reset           : in std_logic;
            CFG_finished : in std_logic;
            layer_finished : in std_logic;
            r               : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            M_div_pt        : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
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
            OFM_NL_Write              : out std_logic;
            OFM_NL_Read               : out std_logic;
            C_cap                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            M_cap                     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF                        : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            p                         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_c                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_pm                    : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_f                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            NoC_e                     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            shift_PISO                : in std_logic;
            OFM_NL_cnt_finished       : out std_logic;
            OFM_NL_NoC_m_cnt_finished : out std_logic;
            NoC_pm_bias               : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
        );
    end component;

    component SYS_CTR_CFG is
        port (
            clk          : in std_logic;
            reset        : in std_logic;
            CFG_start    : in std_logic;
            CFG_finished : out std_logic;
            cfg          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            L            : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            M_cap        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            C_cap        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            HW           : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            HW_p         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            RS           : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF           : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r            : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            p            : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            M_div_pt     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            EF_log2      : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            r_log2       : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
            is_pooling   : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
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
    signal m_tmp  : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal c_tmp  : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal rc_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

    -- SYS_CTR_WB_NL Intermediate Signals
    signal s_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal pm_tmp          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal r_p_tmp         : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal WB_NL_start_tmp : std_logic;

    -- SYS_CTR_IFM_NL Intermediate Signals
    signal h_p_tmp          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal w_p_tmp          : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal IFM_NL_start_tmp : std_logic;

    -- SYS_CTR_PASS_FLAG Intermediate Signals
    signal pass_flag_tmp : std_logic;
    signal layer_finished_tmp : std_logic;

    -- SYS_CTR_OFM_NL Intermediate Signals
    --    signal NoC_c_tmp        : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal NoC_pm_tmp                    : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal NoC_f_tmp                     : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal NoC_e_tmp                     : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal OFM_NL_start_tmp              : std_logic;
    signal OFM_NL_NoC_m_cnt_finished_tmp : std_logic;

    -- SYS_CTR_CFG Intermediate Signals
    signal CFG_start_tmp    : std_logic;
    signal CFG_finished_tmp : std_logic;
    signal L_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);         
    signal M_cap_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);     
    signal C_cap_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);     
    signal HW_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);        
    signal HW_p_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);      
    signal RS_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);        
    signal EF_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);        
    signal r_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);         
    signal p_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);         
    signal M_div_pt_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);  
    signal EF_log2_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);   
    signal r_log2_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);    
    signal is_pooling_tmp : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    ----------------------------------------------

begin

    -- SYS_CTR_MAIN_NL
    SYS_CTR_MAIN_NL_inst : SYS_CTR_MAIN_NL
    port map(
        clk                       => clk,
        reset                     => reset,
        NL_start                  => NL_start,
        NL_ready                  => NL_ready_tmp,
        NL_finished               => NL_finished_tmp,
        M_cap                     => M_cap_tmp,
        C_cap                     => C_cap_tmp,
        r                         => r_tmp,
        p                         => p_tmp,
        c                         => c_tmp,
        m                         => m_tmp,
        rc                        => rc_tmp,
        NoC_ACK_flag              => NoC_ACK_flag,
        IFM_NL_ready              => IFM_NL_ready_tmp,
        IFM_NL_finished           => IFM_NL_finished_tmp,
        WB_NL_ready               => WB_NL_ready_tmp,
        WB_NL_finished            => WB_NL_finished_tmp,
        IFM_NL_start              => IFM_NL_start_tmp,
        WB_NL_start               => WB_NL_start_tmp,
        pass_flag                 => pass_flag_tmp,
        OFM_NL_ready              => OFM_NL_ready_tmp,
        OFM_NL_finished           => OFM_NL_finished_tmp,
        OFM_NL_start              => OFM_NL_start_tmp,
        OFM_NL_NoC_m_cnt_finished => OFM_NL_NoC_m_cnt_finished_tmp,
        CFG_start                 => CFG_start_tmp,
        CFG_finished              => CFG_finished_tmp,
        L                         => L_tmp,
        layer_finished            => layer_finished_tmp
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
        RS             => RS_tmp,
        p              => p_tmp,
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
        HW_p            => HW_p_tmp,
        h_p             => h_p_tmp,
        w_p             => w_p_tmp
    );

    -- SYS_CTR_PASS_FLAG
    SYS_CTR_PASS_FLAG_inst : SYS_CTR_PASS_FLAG
    port map(
        clk             => clk,
        reset           => reset,
        CFG_finished    => CFG_finished_tmp,
        layer_finished  => layer_finished_tmp,
        r               => r_tmp,
        M_div_pt        => M_div_pt_tmp,
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
        OFM_NL_Write              => OFM_NL_Write,
        OFM_NL_Read               => OFM_NL_Read,
        C_cap                     => C_cap_tmp,
        M_cap                     => M_cap_tmp,
        EF                        => EF_tmp,
        r                         => r_tmp,
        p                         => p_tmp,
        NoC_c                     => NoC_c,
        NoC_pm                    => NoC_pm_tmp,
        NoC_f                     => NoC_f_tmp,
        NoC_e                     => NoC_e_tmp,
        shift_PISO                => shift_PISO,
        OFM_NL_cnt_finished       => OFM_NL_cnt_finished,
        OFM_NL_NoC_m_cnt_finished => OFM_NL_NoC_m_cnt_finished_tmp,
        NoC_pm_bias               => NoC_pm_bias
    );

    SYS_CTR_CFG_ins: SYS_CTR_CFG
        port map (
            clk          => clk,
            reset        => reset,
            CFG_start    => CFG_start_tmp,
            CFG_finished => CFG_finished_tmp,
            cfg          => cfg_in,
            L            => L_tmp,
            M_cap        => M_cap_tmp,
            C_cap        => C_cap_tmp,
            HW           => HW_tmp,
            HW_p         => HW_p_tmp,
            RS           => RS_tmp,
            EF           => EF_tmp,
            r            => r_tmp,
            p            => p_tmp,
            M_div_pt     => M_div_pt_tmp,
            EF_log2      => EF_log2_tmp,
            r_log2       => r_log2_tmp,
            is_pooling   => is_pooling_tmp
    );

    -- PORT Assignations
    NL_ready                  <= NL_ready_tmp;
    NL_finished               <= NL_finished_tmp;
    m                         <= m_tmp;
    c                         <= c_tmp;
    rc                        <= rc_tmp;
    r_p                       <= r_p_tmp;
    pm                        <= pm_tmp;
    s                         <= s_tmp;
    h_p                       <= h_p_tmp;
    w_p                       <= w_p_tmp;
    IFM_NL_ready              <= IFM_NL_ready_tmp;
    IFM_NL_finished           <= IFM_NL_finished_tmp;
    IFM_NL_busy               <= IFM_NL_busy_tmp;
    WB_NL_ready               <= WB_NL_ready_tmp;
    WB_NL_finished            <= WB_NL_finished_tmp;
    WB_NL_busy                <= WB_NL_busy_tmp;
    pass_flag                 <= pass_flag_tmp;
    OFM_NL_NoC_m_cnt_finished <= OFM_NL_NoC_m_cnt_finished_tmp;
    NoC_pm                    <= NoC_pm_tmp;
    NoC_e                     <= NoC_e_tmp;
    NoC_f                     <= NoC_f_tmp;
    M_cap                     <= M_cap_tmp;
    C_cap                     <= C_cap_tmp;
    HW                        <= HW_tmp;
    HW_p                      <= HW_p_tmp;
    RS                        <= RS_tmp;
    EF                        <= EF_tmp;
    r                         <= r_tmp;
    p                         <= p_tmp;
    EF_log2                   <= EF_log2_tmp;
    r_log2                    <= r_log2_tmp;
    is_pooling                <= is_pooling_tmp;
    READ_CFG                  <= CFG_start_tmp;

end architecture;
