library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity MC_rr is
    generic (
        -- HW Parameters, at synthesis time.
        X_ID       : natural       := 1;
        hw_log2_EF : integer_array := hw_log2_EF_PKG -- log2(32, 16, 8)
    );
    port (
        -- config. parameters
        EF_log2 : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- NoC Internal Signals
        rr : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
    );
end MC_rr;

architecture dataflow of MC_rr is

    signal EF_log2_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    signal mux_in  : hyp_array (0 to hw_log2_EF_PKG'length - 1);
    signal mux_out : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
    signal mux_sel : natural range 0 to (hw_log2_EF_PKG'length - 1);
    signal rr_tmp  : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

begin

    -- instantiate logic for dealing with all possible values of log2_EF. EF = (32, 16, 8) -> log2_EF = (5, 4, 3)
    gen_CEIL_LOG2_DIV : for i in 0 to hw_log2_EF_PKG'length - 1 generate
        inst_CEIL_LOG2_DIV : CEIL_LOG2_DIV
        generic map(
            y => hw_log2_EF_PKG(i) -- hw parameter, at synthesis time.
        )
        port map(
            x => std_logic_vector(to_unsigned((X_ID), 8)),
            z => mux_in(i)
        );
    end generate gen_CEIL_LOG2_DIV;

    -- mux_sel_p : process (EF_log2_tmp)
    -- begin
    --     mux_sel_loop : for i in 0 to hw_log2_EF_PKG'length - 1 loop
    --         if (EF_log2_tmp = hw_log2_EF_PKG(i)) then
    --             mux_sel <= i;
    --         else
    --             mux_sel <= 0;
    --         end if;
    --     end loop;
    -- end procesS;

    p_mux_sel : process (EF_log2_tmp)
    begin
        case EF_log2_tmp is
            when hw_log2_EF_PKG(0) => mux_sel <= 0;
            when hw_log2_EF_PKG(1) => mux_sel <= 1;
            when hw_log2_EF_PKG(2) => mux_sel <= 2;
            when others            => mux_sel        <= 0;
        end case;
    end process p_mux_sel;

    p_mux : mux
    generic map(
        LEN => HYP_BITWIDTH,
        NUM => hw_log2_EF_PKG'length
    )
    port map(
        mux_in  => mux_in,
        mux_sel => mux_sel,
        mux_out => mux_out
    );

    rr_tmp <= std_logic_vector(unsigned(mux_out));

    -- PORT Assignations
    EF_log2_tmp <= to_integer(unsigned(EF_log2));
    rr          <= rr_tmp;

end architecture;