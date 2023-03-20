library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_IFM_BUFFER is
    port (
        -- From Back-End
        A   : in std_logic_vector(12 downto 0);
        CSN : in std_logic;
        D   : in std_logic_vector (31 downto 0);
        WEN : in std_logic;
        -- To WRAPPER
        A_buff   : out std_logic_vector(12 downto 0);
        CSN_buff : out std_logic;
        D_buff   : out std_logic_vector (31 downto 0);
        WEN_buff : out std_logic
    );
end SRAM_IFM_BUFFER;

architecture dataflow of SRAM_IFM_BUFFER is
    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************
--    signal A_buff_tmp     : std_logic_vector(12 downto 0);
--    signal CSN_buff_tmp   : std_logic;

    --        Kload (ns/pf): 0.5654 (R), 0.7672 (F)
    -- Intrinsic Delay (ns): 0.0211 (R), 0.0165 (F)
    component C8T28SOI_LL_BFX24_P0
        port (
            A     : in std_logic;
            Z     : in std_logic
        );
    end component;

    constant no_of_buffers : natural := 14;

    type A_array is array (0 to (no_of_buffers)) of std_logic_vector(12 downto 0);
    signal A_buff_tmp : A_array;

    type CSN_array is array (0 to (no_of_buffers)) of std_logic;
    signal CSN_buff_tmp : CSN_array;

    type D_array is array (0 to (no_of_buffers)) of std_logic_vector(31 downto 0);
    signal D_buff_tmp : D_array;

    type WEN_array is array (0 to (no_of_buffers)) of std_logic;
    signal WEN_buff_tmp : WEN_array;

    -- *****************************************************
begin
    --------------------------------------
    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************
    -- SINCE GATE-LEVEL SIMULATION (NO P&R) FAILS DUE TO HOLD TIMING VIOLATIONS,
    -- LETS ADD A CHAIN OF INVERTERS TO THE PROBLEMATIC SIGNALS:
--    A_buff_tmp   <= not(not(not(not(not(not(not(not(not(not(not(not(not(not(A))))))))))))));
--    CSN_buff_tmp <= not(not(not(not(not(not(not(not(not(not(not(not(not(not(CSN))))))))))))));
--    A_buff       <= A_buff_tmp;
--    CSN_buff     <= CSN_buff_tmp;

    -- A Buffers
    C8T28SOI_LL_BFX24_P0_A_loop_1 : for i in 0 to (A'length - 1) generate
        C8T28SOI_LL_BFX24_P0_A_loop_2 : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_A_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => A_buff_tmp(j)(i),
                Z => A_buff_tmp(j+1)(i)
            );
        end generate C8T28SOI_LL_BFX24_P0_A_loop_2;
        A_buff_tmp(0)(i) <= A(i); -- Connects input i to first buffer of chain i.
    end generate C8T28SOI_LL_BFX24_P0_A_loop_1;

    A_buff <= A_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- CSN Buffers
        C8T28SOI_LL_BFX24_P0_CSN_loop : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_CSN_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => CSN_buff_tmp(j),
                Z => CSN_buff_tmp(j+1)
            );
        end generate C8T28SOI_LL_BFX24_P0_CSN_loop;

    CSN_buff_tmp(0) <= CSN; -- Connects input to first buffer of chain.
    CSN_buff        <= CSN_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- D Buffers
    C8T28SOI_LL_BFX24_P0_D_loop_1 : for i in 0 to (D'length - 1) generate
        C8T28SOI_LL_BFX24_P0_D_loop_2 : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_D_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => D_buff_tmp(j)(i),
                Z => D_buff_tmp(j+1)(i)
            );
        end generate C8T28SOI_LL_BFX24_P0_D_loop_2;
        D_buff_tmp(0)(i) <= D(i); -- Connects input i to first buffer of chain i.
    end generate C8T28SOI_LL_BFX24_P0_D_loop_1;

    D_buff <= D_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- WEN Buffers
        C8T28SOI_LL_BFX24_P0_WEN_loop : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_WEN_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => WEN_buff_tmp(j),
                Z => WEN_buff_tmp(j+1)
            );
        end generate C8T28SOI_LL_BFX24_P0_WEN_loop;

    WEN_buff_tmp(0) <= WEN; -- Connects input to first buffer of chain.
    WEN_buff        <= WEN_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- *****************************************************
    -- *****************************************************
    --------------------------------------
end architecture;
