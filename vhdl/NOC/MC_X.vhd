library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity MC_X is
    generic (
        -- HW Parameters, at synthesis time.
        Y_ID      : natural       := 3;
        X_ID      : natural       := 16;
        Y         : natural       := Y_PKG;
        hw_log2_r : integer_array := hw_log2_r_PKG
    );
    port (
        -- config. parameters
        RS      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);        
        EF_log2 : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        C_cap   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r_log2  : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- from sys ctrl
        h_p   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        rc    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        pad   : in natural range 0 to ((2 ** HYP_BITWIDTH) - 1); -- padding (from IFMAP_FRONT_END_READ)

        -- NoC Internal Signals
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
end MC_X;

architecture dataflow of MC_X is

    signal w_x_tmp          : std_logic_vector (WEIGHT_BITWIDTH - 1 downto 0);
    signal w_x_status_tmp   : std_logic;
    signal ifm_x_tmp        : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal ifm_x_status_tmp : std_logic;

    signal w_ifm_x_ctrl       : std_logic;
    signal ifm_x_ctrl_2nd     : std_logic;
    signal ifm_x_ctrl         : std_logic;
    signal ifm_x_ctrl_tmp     : integer;
    signal ifm_x_ctrl_tmp_2     : integer;
    signal w_ifm_x_ctrl_tmp_4 : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal w_ifm_x_ctrl_tmp_3 : integer;
    signal w_ifm_x_ctrl_tmp_2 : integer;
    signal w_ifm_x_ctrl_tmp   : integer;
    signal RS_tmp          : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal C_cap_tmp          : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal EF_log2_tmp        : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal r_log2_tmp         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    signal h_p_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal rc_tmp  : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal rr_tmp  : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    signal Y_tmp    : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal Y_ID_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal X_ID_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    signal mux_in  : hyp_array(0 to hw_log2_r_PKG'length - 1);
    signal mux_out : std_logic_vector((HYP_BITWIDTH - 1) downto 0);
    signal mux_sel : natural range 0 to (hw_log2_r_PKG'length - 1);

begin

    -- 2nd condition for ifmaps (X_ID = h' + (R - (2*pad - 1)) - Y_ID + (rr - 1)*E)
    ifm_x_ctrl_tmp   <= to_integer(shift_left(to_unsigned((rr_tmp - 1), HYP_BITWIDTH), EF_log2_tmp)); -- (rr - 1)*E
    ifm_x_ctrl_tmp_2 <= to_integer(shift_left(to_unsigned((pad), HYP_BITWIDTH), 1)) - 1; -- (2*pad - 1)
    ifm_x_ctrl_2nd   <= '1' when (X_ID_tmp = (h_p_tmp + (RS_tmp - ifm_x_ctrl_tmp_2) - Y_ID_tmp + ifm_x_ctrl_tmp)) else '0';

    -- 3rd condition for ifmaps / 2nd condition for weights ------------
    w_ifm_x_ctrl_tmp_4 <= std_logic_vector(unsigned(rc) + to_unsigned(1, 8)); -- (c + 1)

    -- instantiate logic for dealing with all possible values of log2_r. r = (1, 2, 4) -> log2r = (0, 1, 2)
    gen_CEIL_LOG2_DIV : for i in 0 to hw_log2_r_PKG'length - 1 generate
        inst_CEIL_LOG2_DIV : CEIL_LOG2_DIV
        generic map(
            y => hw_log2_r_PKG(i) -- hw parameter, at synthesis time.
        )
        port map(
            x => w_ifm_x_ctrl_tmp_4,
            z => mux_in(i)
        );
    end generate gen_CEIL_LOG2_DIV;

    p_mux_sel : process (r_log2_tmp)
    begin
        case r_log2_tmp is
            when hw_log2_r_PKG(0) => mux_sel <= 0;
            when hw_log2_r_PKG(1) => mux_sel <= 1;
            when hw_log2_r_PKG(2) => mux_sel <= 2;
            when others       => mux_sel <= 0;
        end case;
    end process p_mux_sel;

    p_mux : mux
    generic map(
        LEN => HYP_BITWIDTH,
        NUM => hw_log2_r_PKG'length
    )
    port map(
        mux_in  => mux_in,
        mux_sel => mux_sel,
        mux_out => mux_out
    );

    w_ifm_x_ctrl_tmp_3 <= to_integer(unsigned(mux_out)) - 1; -- roundup((c+1)/r) - 1
    w_ifm_x_ctrl_tmp_2 <= to_integer(unsigned(shift_left(to_unsigned((w_ifm_x_ctrl_tmp_3), 8), r_log2_tmp))); -- r*( w_ifm_x_ctrl_tmp_3)
    w_ifm_x_ctrl_tmp   <= rc_tmp - w_ifm_x_ctrl_tmp_2 + 1; -- rc - w_ifm_x_ctrl_tmp_2 + 1
    w_ifm_x_ctrl <= '1' when ((w_ifm_x_ctrl_tmp = rr_tmp) and ((0 < (rc_tmp + 1)) and ((rc_tmp + 1) <= C_cap_tmp))) else '0'; -- rc - r*(roundup((rc+1)/r)-1)+1 == rr AND (0<rc+1<=C)
    ---------------------------------------------------------------

    -- ifm pass control (2nd AND 3rd conditions)
    ifm_x_ctrl       <= '1' when (((ifm_x_ctrl_2nd and w_ifm_x_ctrl) = '1') and (ifm_x_enable = '1')) else '0';
    ifm_x_tmp        <= ifm_x_in when (ifm_x_ctrl = '1') else (others => '0');
    ifm_x_status_tmp <= '1' when (ifm_x_ctrl = '1') else '0';

    -- weights pass control
    w_x_tmp        <= w_x_in when ((w_ifm_x_ctrl = '1') and (w_x_enable = '1')) else (others => '0');
    w_x_status_tmp <= '1' when ((w_ifm_x_ctrl = '1') and (w_x_enable = '1')) else '0';

    -- PORT Assignations
    w_x_out      <= w_x_tmp;
    w_x_status   <= w_x_status_tmp;
    ifm_x_out    <= ifm_x_tmp;
    ifm_x_status <= ifm_x_status_tmp;

    RS_tmp      <= to_integer(unsigned(RS));
    EF_log2_tmp <= to_integer(unsigned(EF_log2));
    C_cap_tmp   <= to_integer(unsigned(C_cap));
    rr_tmp      <= to_integer(unsigned(rr));
    r_log2_tmp  <= to_integer(unsigned(r_log2));

    h_p_tmp <= to_integer(unsigned(h_p));
    rc_tmp  <= to_integer(unsigned(rc));

    Y_tmp    <= Y_PKG;
    Y_ID_tmp <= Y_ID;
    X_ID_tmp <= X_ID;

end architecture;
