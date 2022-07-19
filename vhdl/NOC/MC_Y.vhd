library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MC_Y is
    generic (
        Y_ID : natural range 0 to 255 := 1;
        Y : natural  range 0 to 255 := 3
    );
    port (
        -- config. parameters
        HW_p : in std_logic_vector (7 downto 0);
        -- from sys ctrl
        h_p : in std_logic_vector (7 downto 0);
        r_p : in std_logic_vector (7 downto 0);
        WB_NL_busy : in std_logic;
        IFM_NL_busy : in std_logic;

        ifm_in : in std_logic_vector (7 downto 0);
        ifm_out : out std_logic_vector(7 downto 0);
        ifm_status : out std_logic;
        w_in : in std_logic_vector (7 downto 0);
        w_out : out std_logic_vector (7 downto 0);
        w_status : out std_logic
    );
end MC_Y;

architecture dataflow of MC_Y is

    signal w_tmp : std_logic_vector (7 downto 0);
    signal w_status_tmp : std_logic;
    signal ifm_tmp : std_logic_vector (7 downto 0);
    signal ifm_status_tmp : std_logic;
    signal w_ctrl : std_logic;
    signal ifm_ctrl : std_logic;
    signal HW_p_tmp : natural range 0 to 255;
    signal h_p_tmp : natural range 0 to 255;
    signal r_p_tmp : natural range 0 to 255;
    signal Y_tmp : natural range 0 to 255;
    signal Y_ID_tmp : natural range 0 to 255;

begin

    -- 1st condition for weights
    w_ctrl <= '1' when ((Y_ID_tmp = (r_p_tmp + 1)) AND (WB_NL_busy = '1')) else '0';
    w_tmp <= w_in when (w_ctrl ='1') else (others => '0');
    w_status_tmp <= '1' when (w_ctrl ='1') else '0';

    -- 1st condition for ifmaps
    ifm_ctrl <= '1' when ((((Y_ID_tmp - 1) <= h_p_int) AND (h_p_tmp < (HW_p_tmp - Y_tmp + Y_ID_int))) AND (IFM_NL_busy = '1')) else '0';
    ifm_tmp <= ifm_in when (ifm_ctrl = '1') else (others => '0');
    ifm_status_tmp <= '1' when (ifm_ctrl = '1') else '0';

    -- PORT Assignations
    w_out <= w_int;
    w_status <= w_status_int;
    ifm_out <= ifm_int;
    ifm_status <= ifm_status_int;
    HW_p_tmp <= to_integer(unsigned(HW_p));
    r_p_tmp <= to_integer(unsigned(r_p));
    h_p_tmp <= to_integer(unsigned(h_p));
    Y_tmp <= Y;
    Y_ID_tmp <= Y_ID;

end architecture;