library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB_BUFFER is
    port (
        -- From Back-End
        A_8K_1   : in std_logic_vector(12 downto 0);
        A_8K_2   : in std_logic_vector(12 downto 0);
        A_4K     : in std_logic_vector(11 downto 0);
        -- To WRAPPER
        A_8K_1_buff   : out std_logic_vector(12 downto 0);
        A_8K_2_buff   : out std_logic_vector(12 downto 0);
        A_4K_buff     : out std_logic_vector(11 downto 0)
    );
end SRAM_WB_BUFFER;

architecture dataflow of SRAM_WB_BUFFER is
    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************
--    signal A_8K_1_buff_tmp : std_logic_vector(12 downto 0);
--    signal A_8K_2_buff_tmp : std_logic_vector(12 downto 0);
--    signal A_4K_buff_tmp   : std_logic_vector(11 downto 0);

    --        Kload (ns/pf): 0.5654 (R), 0.7672 (F)
    -- Intrinsic Delay (ns): 0.0211 (R), 0.0165 (F)
    component C8T28SOI_LL_BFX24_P0
        port (
            A     : in std_logic;
            Z     : in std_logic
        );
    end component;

    constant no_of_buffers : natural := 14;

    type A_8K_array is array (0 to (no_of_buffers)) of std_logic_vector(12 downto 0);
    signal A_8K_1_buff_tmp : A_8K_array;
    signal A_8K_2_buff_tmp : A_8K_array;

    type A_4K_array is array (0 to (no_of_buffers)) of std_logic_vector(11 downto 0);
    signal A_4K_buff_tmp : A_4K_array;

    -- *****************************************************
begin
    --------------------------------------
    -- *****************************************************
    -- *************** GATE-LEVEL SIMULATION ***************
    -- SINCE GATE-LEVEL SIMULATION (NO P&R) FAILS DUE TO HOLD TIMING VIOLATIONS,
    -- LETS ADD A CHAIN OF INVERTERS TO THE PROBLEMATIC SIGNALS:
--    A_8K_1_buff_tmp <= not(not(not(not(not(not(not(not(not(not(not(not(not(not(A_8K_1))))))))))))));
--    A_8K_2_buff_tmp <= not(not(not(not(not(not(not(not(not(not(not(not(not(not(A_8K_2))))))))))))));
--    A_4K_buff_tmp   <= not(not(not(not(not(not(not(not(not(not(A_4K))))))))));

--    A_8K_1_buff     <= A_8K_1_buff_tmp;
--    A_8K_2_buff     <= A_8K_2_buff_tmp;
--    A_4K_buff       <= A_4K_buff_tmp;

    -- A_8K_1 Buffers
    C8T28SOI_LL_BFX24_P0_A_8K_1_loop_1 : for i in 0 to (A_8K_1'length - 1) generate
        C8T28SOI_LL_BFX24_P0_A_8K_1_loop_2 : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_A_8K_1_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => A_8K_1_buff_tmp(j)(i),
                Z => A_8K_1_buff_tmp(j+1)(i)
            );
        end generate C8T28SOI_LL_BFX24_P0_A_8K_1_loop_2;
        A_8K_1_buff_tmp(0)(i) <= A_8K_1(i); -- Connects input i to first buffer of chain i.
    end generate C8T28SOI_LL_BFX24_P0_A_8K_1_loop_1;

    A_8K_1_buff <= A_8K_1_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- A_8K_2 Buffers
    C8T28SOI_LL_BFX24_P0_A_8K_2_loop_1 : for i in 0 to (A_8K_2'length - 1) generate
        C8T28SOI_LL_BFX24_P0_A_8K_2_loop_2 : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_A_8K_2_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => A_8K_2_buff_tmp(j)(i),
                Z => A_8K_2_buff_tmp(j+1)(i)
            );
        end generate C8T28SOI_LL_BFX24_P0_A_8K_2_loop_2;
        A_8K_2_buff_tmp(0)(i) <= A_8K_2(i); -- Connects input i to first buffer of chain i.
    end generate C8T28SOI_LL_BFX24_P0_A_8K_2_loop_1;

    A_8K_2_buff <= A_8K_2_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- A_4K Buffers
    C8T28SOI_LL_BFX24_P0_A_4K_loop_1 : for i in 0 to (A_4K'length - 1) generate
        C8T28SOI_LL_BFX24_P0_A_4K_loop_2 : for j in 0 to (no_of_buffers - 1) generate
            C8T28SOI_LL_BFX24_P0_A_4K_inst : C8T28SOI_LL_BFX24_P0
            port map(
                A => A_4K_buff_tmp(j)(i),
                Z => A_4K_buff_tmp(j+1)(i)
            );
        end generate C8T28SOI_LL_BFX24_P0_A_4K_loop_2;
        A_4K_buff_tmp(0)(i) <= A_4K(i); -- Connects input i to first buffer of chain i.
    end generate C8T28SOI_LL_BFX24_P0_A_4K_loop_1;

    A_4K_buff <= A_4K_buff_tmp(no_of_buffers); -- Connects output to last buffer's output.

    -- *****************************************************
    -- *****************************************************
    --------------------------------------
end architecture;
