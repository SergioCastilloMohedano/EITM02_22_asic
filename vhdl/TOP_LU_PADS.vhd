library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity TOP_LU_PADS is
    port (
        clk_p         : in std_logic;
        reset_p       : in std_logic;
        NL_start_p    : in std_logic;
        NL_ready_p    : out std_logic;
        NL_finished_p : out std_logic
    );
end TOP_LU_PADS;

architecture structural of TOP_LU_PADS is

    component PAD_SIGNAL_IN_ESD    -- input PAD
    port (
        PAD     : in std_logic;
        PADCORE : out std_logic
    );
    end component;

    component PAD_SIGNAL_OUT_ESD    -- output PAD
    port (
        PAD     : out std_logic;
        PADCORE : in std_logic
    );
    end component;

    component TOP is
    generic (
        X                     : natural       := X_PKG;
        Y                     : natural       := Y_PKG;
        hw_log2_r             : integer_array := hw_log2_r_PKG;
        hw_log2_EF            : integer_array := hw_log2_EF_PKG;
        NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG;
        NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE_PKG;
        ADDR_4K_CFG           : natural       := ADDR_4K_CFG_PKG
    );
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        NL_start    : in std_logic;
        NL_ready    : out std_logic;
        NL_finished : out std_logic
        );
    end component;

    signal clk_i         : std_logic;
    signal reset_i       : std_logic;
    signal NL_start_i    : std_logic;
    signal NL_ready_i    : std_logic;
    signal NL_finished_i : std_logic;

begin

    -- INPUT PADS
    InPad_clk_inst : PAD_SIGNAL_IN_ESD
    port map (
        PAD     => clk_p,
        PADCORE => clk_i
    );

    InPad_reset_inst : PAD_SIGNAL_IN_ESD
    port map (
        PAD     => reset_p,
        PADCORE => reset_i
    );

    InPad_NL_start_inst : PAD_SIGNAL_IN_ESD
    port map (
        PAD     => NL_start_p,
        PADCORE => NL_start_i
    );

    -- OUTPUT PADS
    OutPad_NL_ready_inst : PAD_SIGNAL_OUT_ESD
    port map (
        PAD     => NL_ready_p,
        PADCORE => NL_ready_i
    );

    OutPad_NL_finished_inst : PAD_SIGNAL_OUT_ESD
    port map (
        PAD     => NL_finished_p,
        PADCORE => NL_finished_i
    );

    TOP_inst : TOP
    generic map(
        X                     => X_PKG,
        Y                     => Y_PKG,
        hw_log2_r             => hw_log2_r_PKG,
        hw_log2_EF            => hw_log2_EF_PKG,
        NUM_REGS_IFM_REG_FILE => NUM_REGS_IFM_REG_FILE_PKG,
        NUM_REGS_W_REG_FILE   => NUM_REGS_W_REG_FILE_PKG,
        ADDR_4K_CFG           => ADDR_4K_CFG_PKG
    )
    port map(
        clk         => clk_i,
        reset       => reset_i,
        NL_start    => NL_start_i,
        NL_ready    => NL_ready_i,
        NL_finished => NL_finished_i
    );

end structural;
