library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM_ROUTER is
    port (
            -- From/To Back-End Interface
            OFM_WRITE_BUSY    : in std_logic;
            OFM_READ_BUSY     : in std_logic;
            OFM_READ_FINISHED : in std_logic;
            -- Port 1 (write)
            A_2K_p1   : in std_logic_vector(13 downto 0);
            CSN_2K_p1 : in std_logic;
            D_2K_p1   : in std_logic_vector (31 downto 0);
            WEN_2K_p1 : in std_logic;
            -- Port 2 (read)
            A_2K_p2   : in std_logic_vector(13 downto 0);
            CSN_2K_p2 : in std_logic;
            Q_2K_p2   : out std_logic_vector (31 downto 0);
            -- To SRAM #1
            A_2K_p1_1   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_1 : out std_logic;
            D_2K_p1_1   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_1 : out std_logic;
            A_2K_p2_1   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_1 : out std_logic;
            Q_2K_p2_1   : in std_logic_vector (31 downto 0);
            -- To SRAM #2
            A_2K_p1_2   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_2 : out std_logic;
            D_2K_p1_2   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_2 : out std_logic;
            A_2K_p2_2   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_2 : out std_logic;
            Q_2K_p2_2   : in std_logic_vector (31 downto 0);
            -- To SRAM #3
            A_2K_p1_3   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_3 : out std_logic;
            D_2K_p1_3   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_3 : out std_logic;
            A_2K_p2_3   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_3 : out std_logic;
            Q_2K_p2_3   : in std_logic_vector (31 downto 0);
            -- To SRAM #4
            A_2K_p1_4   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_4 : out std_logic;
            D_2K_p1_4   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_4 : out std_logic;
            A_2K_p2_4   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_4 : out std_logic;
            Q_2K_p2_4   : in std_logic_vector (31 downto 0);
            -- To SRAM #5
            A_2K_p1_5   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_5 : out std_logic;
            D_2K_p1_5   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_5 : out std_logic;
            A_2K_p2_5   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_5 : out std_logic;
            Q_2K_p2_5   : in std_logic_vector (31 downto 0);
            -- To SRAM #6
            A_2K_p1_6   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_6 : out std_logic;
            D_2K_p1_6   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_6 : out std_logic;
            A_2K_p2_6   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_6 : out std_logic;
            Q_2K_p2_6   : in std_logic_vector (31 downto 0);
            -- To SRAM #7
            A_2K_p1_7   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_7 : out std_logic;
            D_2K_p1_7   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_7 : out std_logic;
            A_2K_p2_7   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_7 : out std_logic;
            Q_2K_p2_7   : in std_logic_vector (31 downto 0);
            -- To SRAM #8
            A_2K_p1_8   : out std_logic_vector(10 downto 0);
            CSN_2K_p1_8 : out std_logic;
            D_2K_p1_8   : out std_logic_vector (31 downto 0);
            WEN_2K_p1_8 : out std_logic;
            A_2K_p2_8   : out std_logic_vector(10 downto 0);
            CSN_2K_p2_8 : out std_logic;
            Q_2K_p2_8   : in std_logic_vector (31 downto 0)
    );
end SRAM_OFM_ROUTER;

architecture structural of SRAM_OFM_ROUTER is

    signal A_2K_p1_tmp : unsigned (13 downto 0);
    signal A_2K_p2_tmp : unsigned (13 downto 0);

begin

    p1_write_process : process(A_2K_p1, A_2K_p1_tmp, CSN_2K_p1, WEN_2K_p1, D_2K_p1)
    begin
        if (unsigned(A_2K_p1) < 2048) then
            A_2K_p1_tmp <= unsigned(A_2K_p1);
            A_2K_p1_1   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= CSN_2K_p1;
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= WEN_2K_p1;
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= D_2K_p1;
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= (others => '0');

        elsif (unsigned(A_2K_p1) >= 2048) and (unsigned(A_2K_p1) < 2048*2) then
            A_2K_p1_tmp <= unsigned(A_2K_p1) - 2048;
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= CSN_2K_p1;
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= WEN_2K_p1;
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= D_2K_p1;
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= (others => '0');

        elsif (unsigned(A_2K_p1) >= 2048*2) and (unsigned(A_2K_p1) < 2048*3) then
            A_2K_p1_tmp <= unsigned(A_2K_p1) - 2048*2;
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= CSN_2K_p1;
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= WEN_2K_p1;
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= D_2K_p1;
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= (others => '0');

        elsif (unsigned(A_2K_p1) >= 2048*3) and (unsigned(A_2K_p1) < 2048*4) then
            A_2K_p1_tmp <= unsigned(A_2K_p1) - 2048*3;
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= CSN_2K_p1;
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= WEN_2K_p1;
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= D_2K_p1;
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= (others => '0');

        elsif (unsigned(A_2K_p1) >= 2048*4) and (unsigned(A_2K_p1) < 2048*5) then
            A_2K_p1_tmp <= unsigned(A_2K_p1) - 2048*4;
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= CSN_2K_p1;
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= WEN_2K_p1;
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= D_2K_p1;
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= (others => '0');

        elsif (unsigned(A_2K_p1) >= 2048*5) and (unsigned(A_2K_p1) < 2048*6) then
            A_2K_p1_tmp <= unsigned(A_2K_p1) - 2048*5;
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= CSN_2K_p1;
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= WEN_2K_p1;
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= D_2K_p1;
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= (others => '0');

        elsif (unsigned(A_2K_p1) >= 2048*6) and (unsigned(A_2K_p1) < 2048*7) then
            A_2K_p1_tmp <= unsigned(A_2K_p1) - 2048*6;
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= CSN_2K_p1;
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= WEN_2K_p1;
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= D_2K_p1;
            D_2K_p1_8 <= (others => '0');

        elsif (unsigned(A_2K_p1) >= 2048*7) and (unsigned(A_2K_p1) < 2048*8) then
            A_2K_p1_tmp <= unsigned(A_2K_p1) - 2048*7;
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= std_logic_vector(A_2K_p1_tmp(10 downto 0));

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= CSN_2K_p1;

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= WEN_2K_p1;

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= D_2K_p1;

        else
            A_2K_p1_tmp <= (others => '0');
            A_2K_p1_1   <= (others => '0');
            A_2K_p1_2   <= (others => '0');
            A_2K_p1_3   <= (others => '0');
            A_2K_p1_4   <= (others => '0');
            A_2K_p1_5   <= (others => '0');
            A_2K_p1_6   <= (others => '0');
            A_2K_p1_7   <= (others => '0');
            A_2K_p1_8   <= (others => '0');

            CSN_2K_p1_1 <= '1';
            CSN_2K_p1_2 <= '1';
            CSN_2K_p1_3 <= '1';
            CSN_2K_p1_4 <= '1';
            CSN_2K_p1_5 <= '1';
            CSN_2K_p1_6 <= '1';
            CSN_2K_p1_7 <= '1';
            CSN_2K_p1_8 <= '1';

            WEN_2K_p1_1 <= '1';
            WEN_2K_p1_2 <= '1';
            WEN_2K_p1_3 <= '1';
            WEN_2K_p1_4 <= '1';
            WEN_2K_p1_5 <= '1';
            WEN_2K_p1_6 <= '1';
            WEN_2K_p1_7 <= '1';
            WEN_2K_p1_8 <= '1';

            D_2K_p1_1 <= (others => '0');
            D_2K_p1_2 <= (others => '0');
            D_2K_p1_3 <= (others => '0');
            D_2K_p1_4 <= (others => '0');
            D_2K_p1_5 <= (others => '0');
            D_2K_p1_6 <= (others => '0');
            D_2K_p1_7 <= (others => '0');
            D_2K_p1_8 <= (others => '0');

        end if;
    end process;

    p2_read_process : process(A_2K_p2, A_2K_p2_tmp, CSN_2K_p2)
    begin
        if (unsigned(A_2K_p2) < 2048) then
            A_2K_p2_tmp <= unsigned(A_2K_p2);
            A_2K_p2_1   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= CSN_2K_p2;
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= '1';


        elsif (unsigned(A_2K_p2) >= 2048) and (unsigned(A_2K_p2) < 2048*2) then
            A_2K_p2_tmp <= unsigned(A_2K_p2) - 2048;
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= CSN_2K_p2;
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= '1';

        elsif (unsigned(A_2K_p2) >= 2048*2) and (unsigned(A_2K_p2) < 2048*3) then
            A_2K_p2_tmp <= unsigned(A_2K_p2) - 2048*2;
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= CSN_2K_p2;
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= '1';

        elsif (unsigned(A_2K_p2) >= 2048*3) and (unsigned(A_2K_p2) < 2048*4) then
            A_2K_p2_tmp <= unsigned(A_2K_p2) - 2048*3;
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= CSN_2K_p2;
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= '1';

        elsif (unsigned(A_2K_p2) >= 2048*4) and (unsigned(A_2K_p2) < 2048*5) then
            A_2K_p2_tmp <= unsigned(A_2K_p2) - 2048*4;
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= CSN_2K_p2;
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= '1';

        elsif (unsigned(A_2K_p2) >= 2048*5) and (unsigned(A_2K_p2) < 2048*6) then
            A_2K_p2_tmp <= unsigned(A_2K_p2) - 2048*5;
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= CSN_2K_p2;
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= '1';

        elsif (unsigned(A_2K_p2) >= 2048*6) and (unsigned(A_2K_p2) < 2048*7) then
            A_2K_p2_tmp <= unsigned(A_2K_p2) - 2048*6;
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= CSN_2K_p2;
            CSN_2K_p2_8 <= '1';

        elsif (unsigned(A_2K_p2) >= 2048*7) and (unsigned(A_2K_p2) < 2048*8) then
            A_2K_p2_tmp <= unsigned(A_2K_p2) - 2048*7;
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= std_logic_vector(A_2K_p2_tmp(10 downto 0));

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= CSN_2K_p2;

        else
            A_2K_p2_tmp <= (others => '0');
            A_2K_p2_1   <= (others => '0');
            A_2K_p2_2   <= (others => '0');
            A_2K_p2_3   <= (others => '0');
            A_2K_p2_4   <= (others => '0');
            A_2K_p2_5   <= (others => '0');
            A_2K_p2_6   <= (others => '0');
            A_2K_p2_7   <= (others => '0');
            A_2K_p2_8   <= (others => '0');

            CSN_2K_p2_1 <= '1';
            CSN_2K_p2_2 <= '1';
            CSN_2K_p2_3 <= '1';
            CSN_2K_p2_4 <= '1';
            CSN_2K_p2_5 <= '1';
            CSN_2K_p2_6 <= '1';
            CSN_2K_p2_7 <= '1';
            CSN_2K_p2_8 <= '1';

        end if;
    end process;


    q_out_process : process(A_2K_p1, A_2K_p2, Q_2K_p2_1, Q_2K_p2_2, Q_2K_p2_3, Q_2K_p2_4, Q_2K_p2_5, Q_2K_p2_6, Q_2K_p2_7, Q_2K_p2_8, OFM_WRITE_BUSY, OFM_READ_BUSY, OFM_READ_FINISHED)
    begin
        if (OFM_WRITE_BUSY = '1') then
            if    (unsigned(A_2K_p1) <  2048) then
                Q_2K_p2 <= Q_2K_p2_1;

            elsif (unsigned(A_2K_p1) >= 2048)   and (unsigned(A_2K_p1) < 2048*2) then
                Q_2K_p2 <= Q_2K_p2_2;

            elsif (unsigned(A_2K_p1) >= 2048*2) and (unsigned(A_2K_p1) < 2048*3) then
                Q_2K_p2 <= Q_2K_p2_3;

            elsif (unsigned(A_2K_p1) >= 2048*3) and (unsigned(A_2K_p1) < 2048*4) then
                Q_2K_p2 <= Q_2K_p2_4;

            elsif (unsigned(A_2K_p1) >= 2048*4) and (unsigned(A_2K_p1) < 2048*5) then
                Q_2K_p2 <= Q_2K_p2_5;

            elsif (unsigned(A_2K_p1) >= 2048*5) and (unsigned(A_2K_p1) < 2048*6) then
                Q_2K_p2 <= Q_2K_p2_6;

            elsif (unsigned(A_2K_p1) >= 2048*6) and (unsigned(A_2K_p1) < 2048*7) then
                Q_2K_p2 <= Q_2K_p2_7;

            elsif (unsigned(A_2K_p1) >= 2048*7) and (unsigned(A_2K_p1) < 2048*8) then
                Q_2K_p2 <= Q_2K_p2_8;

            else
                Q_2K_p2 <= (others => '0');

            end if;

        elsif (OFM_READ_BUSY = '1') then

	    if    (unsigned(A_2K_p2) <  2048 + 1) then
                Q_2K_p2 <= Q_2K_p2_1;

            elsif (unsigned(A_2K_p2) >= 2048 + 1)   and (unsigned(A_2K_p2) < 2048*2 + 1) then
                Q_2K_p2 <= Q_2K_p2_2;

            elsif (unsigned(A_2K_p2) >= 2048*2 + 1) and (unsigned(A_2K_p2) < 2048*3 + 1) then
                Q_2K_p2 <= Q_2K_p2_3;

            elsif (unsigned(A_2K_p2) >= 2048*3 + 1) and (unsigned(A_2K_p2) < 2048*4 + 1) then
                Q_2K_p2 <= Q_2K_p2_4;

            elsif (unsigned(A_2K_p2) >= 2048*4 + 1) and (unsigned(A_2K_p2) < 2048*5 + 1) then
                Q_2K_p2 <= Q_2K_p2_5;

            elsif (unsigned(A_2K_p2) >= 2048*5 + 1) and (unsigned(A_2K_p2) < 2048*6 + 1) then
                Q_2K_p2 <= Q_2K_p2_6;

            elsif (unsigned(A_2K_p2) >= 2048*6 + 1) and (unsigned(A_2K_p2) < 2048*7 + 1) then
                Q_2K_p2 <= Q_2K_p2_7;

            elsif (unsigned(A_2K_p2) >= 2048*7 + 1) and (unsigned(A_2K_p2) < 2048*8 + 1) then
                Q_2K_p2 <= Q_2K_p2_8;

            else
                Q_2K_p2 <= (others => '0');

            end if;
        elsif (OFM_READ_FINISHED = '1') then
            Q_2K_p2 <= Q_2K_p2_8;

        else
            Q_2K_p2 <= (others => '0');

        end if;
    end process;

end architecture;
