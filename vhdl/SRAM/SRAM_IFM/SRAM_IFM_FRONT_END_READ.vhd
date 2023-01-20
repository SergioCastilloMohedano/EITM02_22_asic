library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_IFM_FRONT_END_READ is
    port (
        h_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        w_p             : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        HW              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        RS              : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        IFM_NL_ready    : in std_logic; -- Reads SRAM exactly on those moments in which this signal is '0', when NL is not idle.
        IFM_NL_finished : in std_logic; -- IFM NL has finished. Do not read SRAM anymore.
        ifm_out         : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        pad             : out natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- To MC_X
        -- Back-End (BE) Interface Ports
        ifm_BE_r : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        RE_BE    : out std_logic -- Read Enable, active high
    );
end SRAM_IFM_FRONT_END_READ;

architecture dataflow of SRAM_IFM_FRONT_END_READ is

    signal IFM_NL_ready_tmp    : std_logic;
    signal IFM_NL_finished_tmp : std_logic;

    signal h_p_tmp   : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal w_p_tmp   : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal HW_tmp    : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal pad_tmp   : natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- p = padding = (-1+RS)/2.
    signal h_ctrl    : std_logic;
    signal w_ctrl    : std_logic;

    signal ifm_out_tmp  : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal ifm_BE_r_tmp : std_logic_vector (ACT_BITWIDTH - 1 downto 0);

    signal RE_BE_tmp : std_logic;

begin

    pad_tmp      <= to_integer(shift_right((unsigned(RS) - to_unsigned(1, 8)), 1)); -- padding = (-1 + RS)/2
    h_ctrl       <= '1' when ((h_p_tmp < pad_tmp) or (h_p_tmp > (HW_tmp - 1 + pad_tmp))) else '0';
    w_ctrl       <= '1' when ((w_p_tmp < pad_tmp) or (w_p_tmp > (HW_tmp - 1 + pad_tmp))) else '0';

    ifm_out_tmp <= ifm_BE_r_tmp;
    RE_BE_tmp   <= '1' when (((not(h_ctrl or w_ctrl)) and (IFM_NL_ready_tmp nor IFM_NL_finished_tmp)) = '1') else '0';

    -- PORT Assignations
    h_p_tmp             <= to_integer(unsigned(h_p));
    w_p_tmp             <= to_integer(unsigned(w_p));
    HW_tmp              <= to_integer(unsigned(HW));
    IFM_NL_ready_tmp    <= IFM_NL_ready;
    IFM_NL_finished_tmp <= IFM_NL_finished;
    ifm_BE_r_tmp        <= ifm_BE_r;
    ifm_out             <= ifm_out_tmp;
    RE_BE               <= RE_BE_tmp;
    pad                 <= pad_tmp;

end architecture;