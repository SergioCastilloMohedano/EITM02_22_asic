library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.thesis_pkg.all;

entity pooling_tb is
    --  Port ( );
end pooling_tb;

architecture structural of pooling_tb is

    component POOLING_TOP is
        generic (
            X : natural := 32
        );
        port (
            clk        : in std_logic;
            reset      : in std_logic;
            M_cap      : in std_logic_vector (7 downto 0);
            EF         : in std_logic_vector (7 downto 0);
            en_pooling : in std_logic;
            value_in   : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
            value_out  : out std_logic_vector (COMP_BITWIDTH - 1 downto 0)
        );
    end component;

    constant period : time := 10 ns;

    constant X                     : natural       := 32;
    constant M_cap                 : natural       := 4;
    constant EF                    : natural       := 6;
    constant HYP_BITWIDTH          : natural       := 8;

    signal clk   : std_logic := '1';
    signal reset : std_logic;

    signal M_cap_tb : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(M_cap, HYP_BITWIDTH));
    signal EF_tb    : std_logic_vector (7 downto 0) := std_logic_vector(to_unsigned(EF, HYP_BITWIDTH));
    signal en_pooling_tb : std_logic;
    signal value_in_tb : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal value_out_tb : std_logic_vector (COMP_BITWIDTH - 1 downto 0);


begin

    uut : POOLING_TOP
    generic map(
        X => X
    )
    port map(
        clk        => clk,
        reset      => reset,
        M_cap      => M_cap_tb,
        EF         => EF_tb,
        en_pooling => en_pooling_tb,
        value_in   => value_in_tb,
        value_out  => value_out_tb
    );

    clk <= not(clk) after (period/2); -- 100 MHz

    stim_proc : process

        variable tmp          : integer range -256 to 255; -- 9 bits
        variable read_cnt     : integer := 0;
        variable v_CWLINE     : line;
        -- variable v_OLINE      : line;
        variable v_CW         : std_logic_vector(COMP_BITWIDTH-1 downto 0);
  
        variable iCW : integer := 0;
  
        file pooling_file : text;
        file outf1 : text;

        -- Declaration of Pooling Array [ExFxM].
        -- The first element of the array is sent first, in a column-wise fashion,
        type pooling_Array is array ((EF*EF*M_cap) downto 0) of std_logic_vector((COMP_BITWIDTH-1) downto 0);
        variable pArray : pooling_Array;

        -- Declaration of Array Elements where output will be stored, column-wise.
        -- type outArray is array ((EF*EF*M_cap)/2 downto 0) of std_logic_vector ((COMP_BITWIDTH-1) downto 0);
        -- variable O1 : outArray;
  
     begin
  
        file_open(pooling_file, "C:\Users\sergi\Cloud Services\Google Drive - LTH\LTH-MSOC\2\EITM02 - Master Thesis\Work\2_RTL\sim\POOLING\pooling_tb.txt",  read_mode);
  
        -- Fill Pooling Array
        while not endfile(pooling_file) loop
           while (iCW <= (EF*EF*M_cap)) loop
              readline(pooling_file, v_CWLINE);
              read(v_CWLINE, v_CW);
              pArray((EF*EF*M_cap)-iCW) := v_CW;
              iCW := iCW + 1;
           end loop;
        end loop;
        iCW := 0;
  
        -- 0. reset initially set to 1 for 100 ns.
        reset <= '1';
        en_pooling_tb <= '0';
        value_in_tb <= (others => '0');
  
        wait for 10*period;
        reset <= '0';
  
        -- 1. Set en_pooling_tb to 1, in order to init operation.
        wait for 2*period;
        en_pooling_tb <= '1';
  
        wait for period;               -- wait 1 clk to Synchronize input stream with control flow

        -- 2. As soon as en_pooling_tb is asserted, we start inputing values.
        for i in 0 to (EF*EF*M_cap) loop
            value_in_tb <= pArray((EF*EF*M_cap)-i);
            wait for (period);
        end loop;

        en_pooling_tb <= '0';


        -- -- 4.1. Read Output
        -- while (read_cnt <= (EF*EF*M_cap)/2) loop
        --     for j in 0 to COMP_BITWIDTH-1 loop
        --         wait for (period/2);
        --         O1((EF*EF*M_cap)/2-read_cnt)(j) := value_out_tb;
        --         wait for (period/2);
        --     end loop;
        --     read_cnt := read_cnt + 1;
        -- end loop;
        -- read_cnt := 0;
        
        -- -- 4.2. Generating Output File
        -- file_open(outf1, "ofm_1.txt", write_mode);

        -- for j in 0 to 783 loop
  
        --     tmp := to_integer(signed(O1((EF*EF*M_cap)/2-j)));
        --     write(v_OLINE, tmp);
        --     writeline(outf1, v_OLINE);
  
        --     -- Uncomment to get binary values instead
        --     -- write(v_OLINE, O1((EF*EF*M_cap)/2-j), right, out_WIDTH);
        --     -- writeline(outf1, v_OLINE);
        -- end loop;
        -- file_close(outf1);

        file_close(pooling_file);
  
        wait;
  
    end process;
  
end structural;
  