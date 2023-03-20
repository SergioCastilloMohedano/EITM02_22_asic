library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM_BUFFER is
    port (
        -- From Back-End
        -- Port 1 (write)
        A_2K_p1   : in std_logic_vector(13 downto 0);
        CSN_2K_p1 : in std_logic;
        WEN_2K_p1 : in std_logic;
        -- Port 2 (read)
        A_2K_p2    : in std_logic_vector(13 downto 0);
        CSN_2K_p2  : in std_logic;
        -- To WRAPPER
        -- Port 1 (write)
        A_2K_p1_buff   : out std_logic_vector(13 downto 0);
        CSN_2K_p1_buff : out std_logic;
        WEN_2K_p1_buff : out std_logic;
        -- Port 2 (read)
        A_2K_p2_buff    : out std_logic_vector(13 downto 0);
        CSN_2K_p2_buff  : out std_logic;
    );
end SRAM_OFM_BUFFER;

architecture dataflow of SRAM_OFM_BUFFER is
    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************

    --        Kload (ns/pf): 0.5654 (R), 0.7672 (F)
    -- Intrinsic Delay (ns): 0.0211 (R), 0.0165 (F)
    component C8T28SOI_LL_BFX24_P0
        port (
            A     : in std_logic;
            Z     : in std_logic
        );
    end component;

    constant no_of_buffers : natural := 14;

    type A_2K_p1_array is array (0 to (no_of_buffers)) of std_logic_vector(13 downto 0);
    signal A_2K_p1_buff_tmp : A_2K_p1_array;

    type A_2K_p2_array is array (0 to (no_of_buffers)) of std_logic_vector(13 downto 0);
    signal A_2K_p2_buff_tmp : A_2K_p2_array;

    type CSN_2K_p1_array is array (0 to (no_of_buffers)) of std_logic;
    signal CSN_2K_p1_buff_tmp : CSN_2K_p1_array;

    type CSN_2K_p2_array is array (0 to (no_of_buffers)) of std_logic;
    signal CSN_2K_p2_buff_tmp : CSN_2K_p2_array;

    type WEN_2K_p1_array is array (0 to (no_of_buffers)) of std_logic;
    signal WEN_2K_p1_buff_tmp : WEN_2K_p1_array;


    -- *****************************************************
begin
    --------------------------------------
    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************
    -- SINCE GATE-LEVEL SIMULATION (NO P&R) FAILS DUE TO HOLD TIMING VIOLATIONS,
    -- LETS ADD A CHAIN OF INVERTERS TO THE PROBLEMATIC SIGNALS:

    -- A_2K_p1 Buffers
    C8T28SOI_LL_BFX24_P0_A_2K_p1_loop_1 : for i in 0 to (A_2K_p1'length - 1) generate
        C8T28SOI_LL_BFX24_P0_A_2K_p1_loop_2 : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_A_2K_p1_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A_2K_p1 => A_2K_p1_buff_tmp(j)(i),
                Z => A_2K_p1_buff_tmp(j+1)(i)
            );
        end generate C8T28SOI_LL_BFX24_P0_A_2K_p1_loop_2;
        A_2K_p1_buff_tmp(0)(i) <= A(i); -- Connects input i to first buffer of chain i.
    end generate C8T28SOI_LL_BFX24_P0_A_2K_p1_loop_1;

    A_2K_p1_buff <= A_2K_p1_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- A_2K_p2 Buffers
    C8T28SOI_LL_BFX24_P0_A_2K_p2_loop_1 : for i in 0 to (A_2K_p2'length - 1) generate
        C8T28SOI_LL_BFX24_P0_A_2K_p2_loop_2 : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_A_2K_p2_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A_2K_p2 => A_2K_p2_buff_tmp(j)(i),
                Z => A_2K_p2_buff_tmp(j+1)(i)
            );
        end generate C8T28SOI_LL_BFX24_P0_A_2K_p2_loop_2;
        A_2K_p2_buff_tmp(0)(i) <= A(i); -- Connects input i to first buffer of chain i.
    end generate C8T28SOI_LL_BFX24_P0_A_2K_p2_loop_1;

    A_2K_p2_buff <= A_2K_p2_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- CSN_2K_p1 Buffers
        C8T28SOI_LL_BFX24_P0_CSN_2K_p1_loop : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_CSN_2K_p1_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => CSN_2K_p1_buff_tmp(j),
                Z => CSN_2K_p1_buff_tmp(j+1)
            );
        end generate C8T28SOI_LL_BFX24_P0_CSN_2K_p1_loop;

    CSN_2K_p1_buff_tmp(0) <= CSN_2K_p1; -- Connects input to first buffer of chain.
    CSN_2K_p1_buff        <= CSN_2K_p1_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- CSN_2K_p2 Buffers
        C8T28SOI_LL_BFX24_P0_CSN_2K_p2_loop : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_CSN_2K_p2_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => CSN_2K_p2_buff_tmp(j),
                Z => CSN_2K_p2_buff_tmp(j+1)
            );
        end generate C8T28SOI_LL_BFX24_P0_CSN_2K_p2_loop;

    CSN_2K_p2_buff_tmp(0) <= CSN_2K_p2; -- Connects input to first buffer of chain.
    CSN_2K_p2_buff        <= CSN_2K_p2_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- WEN_2K_p1 Buffers
        C8T28SOI_LL_BFX24_P0_WEN_2K_p1_loop : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_WEN_2K_p1_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => WEN_2K_p1_buff_tmp(j),
                Z => WEN_2K_p1_buff_tmp(j+1)
            );
        end generate C8T28SOI_LL_BFX24_P0_WEN_2K_p1_loop;

    WEN_2K_p1_buff_tmp(0) <= WEN_2K_p1; -- Connects input to first buffer of chain.
    WEN_2K_p1_buff        <= WEN_2K_p1_buff

    -- *****************************************************
    -- *****************************************************
    --------------------------------------
end architecture;
