library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity MC_Y is
    generic (
        Y_ID : natural := 1
    );
    port (
        -- config. parameters
        HW_p : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        RS   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        -- from sys ctrl
        h_p         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r_p         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        WB_NL_busy  : in std_logic;
        IFM_NL_busy : in std_logic;

        ifm_y_in     : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        ifm_y_out    : out std_logic_vector(ACT_BITWIDTH - 1 downto 0);
        ifm_y_status : out std_logic;
        w_y_in       : in std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
        w_y_out      : out std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
        w_y_status   : out std_logic
    );
end MC_Y;

architecture dataflow of MC_Y is

    signal w_y_tmp          : std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
    signal w_y_status_tmp   : std_logic;
    signal ifm_y_tmp        : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal ifm_y_status_tmp : std_logic;
    signal w_y_ctrl         : std_logic;
    signal ifm_y_ctrl_up    : std_logic;
    signal ifm_y_ctrl_low   : std_logic;
    signal HW_p_tmp       : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal RS_tmp         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal h_p_tmp        : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal r_p_tmp        : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal Y_ID_tmp       : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

begin

    -- 1st condition for weights
    w_y_ctrl       <= '1' when ((Y_ID_tmp = (r_p_tmp + 1)) and (WB_NL_busy = '1')) else '0';
    w_y_tmp        <= w_y_in when (w_y_ctrl = '1') else (others => '0');
    w_y_status_tmp <= '1' when (w_y_ctrl = '1') else '0';

    -- 1st condition for ifmaps (upper bound)
    ifm_y_ctrl_up <= '1' when ((((Y_ID_tmp - 1) <= h_p_tmp) and (h_p_tmp < (HW_p_tmp - RS_tmp + Y_ID_tmp))) and (IFM_NL_busy = '1')) else '0';
    -- 4th condition for ifmaps (lower bound)
    ifm_y_ctrl_low <= '1' when ((Y_ID_tmp <= RS_tmp) and (IFM_NL_busy = '1')) else '0';

    ifm_y_tmp        <= ifm_y_in when ((ifm_y_ctrl_up = '1') and (ifm_y_ctrl_low = '1')) else (others => '0');
    ifm_y_status_tmp <= '1' when ((ifm_y_ctrl_up = '1') and (ifm_y_ctrl_low = '1')) else '0';


    -- PORT Assignations
    w_y_out      <= w_y_tmp;
    w_y_status   <= w_y_status_tmp;
    ifm_y_out    <= ifm_y_tmp;
    ifm_y_status <= ifm_y_status_tmp;
    HW_p_tmp   <= to_integer(unsigned(HW_p));
    RS_tmp   <= to_integer(unsigned(RS));
    r_p_tmp    <= to_integer(unsigned(r_p));
    h_p_tmp    <= to_integer(unsigned(h_p));
    Y_ID_tmp   <= Y_ID;

end architecture;