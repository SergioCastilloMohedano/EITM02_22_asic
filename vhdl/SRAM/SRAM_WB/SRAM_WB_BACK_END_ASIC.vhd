library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB_BACK_END_ASIC is
    generic (
        -- HW Parameters, at synthesis time.
        ADDR_4K_CFG : natural := 4042 -- First Address of the reserved space for config. parameters.
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;
        -- Front-End Interface Ports
        wb_FE     : out std_logic_vector (15 downto 0);
        en_w_read : in std_logic;
        en_b_read : in std_logic;
        NoC_pm_FE : in std_logic_vector (7 downto 0);
        -- SRAM Block Wrapper Ports (ASIC)
        A_8K_1   : out std_logic_vector(12 downto 0);
        CSN_8K_1 : out std_logic;
        D_8K_1   : out std_logic_vector (31 downto 0);
        Q_8K_1   : in std_logic_vector (31 downto 0);
        WEN_8K_1 : out std_logic;
        A_8K_2   : out std_logic_vector(12 downto 0);
        CSN_8K_2 : out std_logic;
        D_8K_2   : out std_logic_vector (31 downto 0);
        Q_8K_2   : in std_logic_vector (31 downto 0);
        WEN_8K_2 : out std_logic;
        A_4K     : out std_logic_vector(11 downto 0);
        CSN_4K   : out std_logic;
        D_4K     : out std_logic_vector (31 downto 0);
        Q_4K     : in std_logic_vector (31 downto 0);
        WEN_4K   : out std_logic;
        INITN    : out std_logic
    );
end SRAM_WB_BACK_END_ASIC;

architecture behavioral of SRAM_WB_BACK_END_ASIC is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_read_b, s_read_w);
    signal state_next, state_reg : state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    -- ..

    ---- External Command Signals to the FSMD
    signal en_w_read_tmp : std_logic;
    signal en_b_read_tmp : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    -- ..

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal addr_block_ctrl_w_reg, addr_block_ctrl_w_next : natural range 0 to 3;
    signal addr_block_w_reg, addr_block_w_next           : unsigned (14 downto 0);
    signal addr_8K_1_w_reg, addr_8K_1_w_next             : unsigned (12 downto 0);
    signal addr_8K_2_w_reg, addr_8K_2_w_next             : unsigned (12 downto 0);
    signal addr_4K_w_reg, addr_4K_w_next                 : unsigned (11 downto 0);

    signal addr_4K_b_ctrl_reg, addr_4K_b_ctrl_next : natural range 0 to 1;
    signal addr_4K_b_reg, addr_4K_b_next           : unsigned (11 downto 0);
    signal NoC_pm_next, NoC_pm_reg                 : natural;

    signal initn_reg, initn_next         : std_logic;
    signal initn_cnt_reg, initn_cnt_next : unsigned (1 downto 0);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    -- ..

    ---- Functional Units Intermediate Signals
    signal addr_block_w_out : unsigned (14 downto 0);
    signal addr_8K_1_w_out  : unsigned (12 downto 0);
    signal addr_8K_2_w_out  : unsigned (12 downto 0);
    signal addr_4K_w_out    : unsigned (11 downto 0);

    signal addr_4K_b_out : unsigned (11 downto 0);

    signal initn_out     : std_logic;
    signal initn_cnt_out : unsigned (1 downto 0);


    ---- Data Outputs
    signal A_8K_1_tmp   : std_logic_vector(12 downto 0);
    signal CSN_8K_1_tmp : std_logic;
    signal D_8K_1_tmp   : std_logic_vector (31 downto 0);
    signal WEN_8K_1_tmp : std_logic;
    signal A_8K_2_tmp   : std_logic_vector(12 downto 0);
    signal CSN_8K_2_tmp : std_logic;
    signal D_8K_2_tmp   : std_logic_vector (31 downto 0);
    signal WEN_8K_2_tmp : std_logic;
    signal A_4K_tmp     : std_logic_vector(11 downto 0);
    signal CSN_4K_tmp   : std_logic;
    signal D_4K_tmp     : std_logic_vector (31 downto 0);
    signal WEN_4K_tmp   : std_logic;
    signal INITN_tmp    : std_logic;
    signal wb_FE_tmp    : std_logic_vector (ACT_BITWIDTH - 1 downto 0);


    -- SRAM_WB_BACK_END Intermediate Signals
    signal en_w_read_tmp_tmp : std_logic;
    signal Q_tmp : std_logic_vector(31 downto 0);
    signal weight_tmp : std_logic_vector (ACT_BITWIDTH - 1 downto 0); -- MSBs zeroes disregarded in front-end read interface
    signal zeroes : std_logic_vector (31 - ACT_BITWIDTH - WEIGHT_BITWIDTH downto 0) := (others => '0');
    signal Q_4K_w_tmp : std_logic_vector (31 downto 0);
    signal Q_4K_b_tmp : std_logic_vector (31 downto 0);
    signal act_tmp : std_logic_vector (ACT_BITWIDTH - 1 downto 0);

begin

    ------------ CONTROL PATH ------------
    -- Control Path : State Register
    asmd_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state_reg <= s_init;
            else
                state_reg <= state_next;
            end if;
        end if;
    end process;

    -- Control Path : Next State Logic
    asmd_ctrl : process (state_reg, en_w_read_tmp, en_b_read_tmp)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if (en_w_read_tmp = '1') then
                    state_next <= s_read_w;
                else
                    if (en_b_read_tmp = '1') then
                        state_next <= s_read_b;
                    else
                        state_next <= s_idle;
                    end if;
                end if;
            when s_read_w =>
                if (en_w_read_tmp = '1') then
                    state_next <= s_read_w;
                else
                    state_next <= s_idle;
                end if;
            when s_read_b =>
                if (en_b_read_tmp = '1') then
                    state_next <= s_read_b;
                else
                    state_next <= s_idle;
                end if;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- Control Path : Input Logic
    -- ..

    -- Control Path : Output Logic

    --------------------------------------

    ------------- DATA PATH --------------
    -- Data Path : Data Registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                addr_block_ctrl_w_reg <= 0;
                addr_block_w_reg      <= (others => '0');
                addr_8K_1_w_reg       <= (others => '0');
                addr_8K_2_w_reg       <= (others => '0');
                addr_4K_w_reg         <= (others => '0');

                addr_4K_b_ctrl_reg <= 0;
                addr_4K_b_reg      <= to_unsigned((ADDR_4K_CFG - 1), 12);

                initn_cnt_reg <= (others => '0');
                initn_reg     <= '0';

            else
                addr_block_ctrl_w_reg <= addr_block_ctrl_w_next;
                addr_block_w_reg      <= addr_block_w_next;
                addr_8K_1_w_reg       <= addr_8K_1_w_next;
                addr_8K_2_w_reg       <= addr_8K_2_w_next;
                addr_4K_w_reg         <= addr_4K_w_next;

                addr_4K_b_ctrl_reg <= addr_4K_b_ctrl_next;
                addr_4K_b_reg      <= addr_4K_b_next;

                initn_cnt_reg <= initn_cnt_next;
                initn_reg     <= initn_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    addr_block_w_out <= (addr_block_w_reg + 1) when (addr_block_ctrl_w_reg = 3) else addr_block_w_reg;

    addr_8K_1_w_out <= (addr_8K_1_w_reg + 1) when (addr_block_w_reg <= 8191) else addr_8K_1_w_reg;
    addr_8K_2_w_out <= (addr_8K_2_w_reg + 1) when ((addr_block_w_reg > 8191) and (addr_block_w_reg <= 16383)) else addr_8K_1_w_reg;
    addr_4K_w_out <= (addr_4K_w_reg + 1) when (addr_block_w_reg > 16383) else addr_4K_w_reg;

    -- Bias addresses start at the last memory position (before reserved space), and decreases as pm increases from 0 to M - 1.
    -- Address decreases with changes in NoC_pm value.
    pm_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                NoC_pm_reg <= 0;
            else
                NoC_pm_reg <= NoC_pm_next;
            end if;
        end if;
    end process;
    addr_4K_b_ctrl_next <= addr_4K_b_ctrl_reg + 1 when ((NoC_pm_next /= NoC_pm_reg) and (en_b_read_tmp = '1')) else addr_4K_b_ctrl_reg;
    addr_4K_b_out       <= (addr_4K_b_reg - 1) when addr_4K_b_ctrl_reg = 1 else addr_4K_b_reg;

    initn_cnt_out <= initn_cnt_reg when initn_cnt_reg = "10" else initn_cnt_reg + "1";
    initn_out     <= '1' when initn_cnt_reg = "10" else '0';

    -- data path : status (inputs to control path to modify next state logic)
    -- ..

    -- data path : Output Logic
    A_8K_1_tmp <= std_logic_vector(addr_8K_1_w_reg);
    A_8K_2_tmp <= std_logic_vector(addr_8K_2_w_reg);
    A_4K_tmp   <= std_logic_vector(addr_4K_w_reg) when (state_reg = s_read_w) else
                  std_logic_vector(addr_4K_b_reg) when (state_reg = s_read_b) else
                  (others => '0'); -- tbd write cfg

    CSN_8K_1_tmp <= not(en_w_read_tmp) when (addr_block_w_reg <= 8191) else
                    '1';
    CSN_8K_2_tmp <= not(en_w_read_tmp) when ((addr_block_w_reg > 8191) and (addr_block_w_reg <= 16383)) else
                   '1';

    en_w_read_tmp_tmp <= not(en_w_read_tmp) when (addr_block_w_reg > 16383) else
                         '1';
    CSN_4K_tmp <= en_w_read_tmp_tmp when (state_reg = s_read_w) else
                  not(en_b_read_tmp) when (state_reg = s_read_b) else
                 '1'; --tbd write cfg

    Qp : process (addr_block_w_reg, Q_8K_1, Q_8K_2, Q_4K_w_tmp)
    begin
        if (addr_block_w_reg <= 8191) then
            Q_tmp <= Q_8K_1;
        elsif ((addr_block_w_reg > 8191) and (addr_block_w_reg <= 16383)) then
            Q_tmp <= Q_8K_2;
        elsif (addr_block_w_reg > 16383) then
            Q_tmp <= Q_4K_w_tmp;
        else
            Q_tmp <= (others => '0');
        end if;
    end process;

    with addr_block_ctrl_w_reg select weight_tmp <=
        Q_tmp(31 downto 24) & zeroes when 0,
        Q_tmp(23 downto 16) & zeroes when 1,
        Q_tmp(15 downto 8)  & zeroes when 2,
        Q_tmp(7 downto 0)  & zeroes when 3,
        (others => '0')              when others;

    Q_4K_w_tmp <= Q_4K when (state_reg = s_read_w) else
                  (others => '0');
    Q_4K_b_tmp <= Q_4K when (state_reg = s_read_b) else
                  (others => '0');
    -- tbd cfg

    with addr_4K_b_ctrl_reg select act_tmp <=
        Q_4K_b_tmp(31 downto 16) when 0,
        Q_4K_b_tmp(15 downto 0)  when 1,
        (others => '0')          when others;

    wb_FE_tmp <= weight_tmp when (state_reg = s_read_w) else
                 act_tmp    when (state_reg = s_read_b) else
                 (others => '0');


    -- data path : mux routing
    data_mux : process (state_reg)
    begin
        case state_reg is
            when s_init =>
                addr_block_ctrl_w_next <= addr_block_ctrl_w_reg;
                addr_block_w_next      <= addr_block_w_reg;
                addr_8K_1_w_next       <= addr_8K_1_w_reg;
                addr_8K_2_w_next       <= addr_8K_2_w_reg;
                addr_4K_w_next         <= addr_4K_w_reg;

                addr_4K_b_next <= addr_4K_b_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when s_idle =>
                addr_block_ctrl_w_next <= addr_block_ctrl_w_reg;
                addr_block_w_next      <= addr_block_w_reg;
                addr_8K_1_w_next       <= addr_8K_1_w_reg;
                addr_8K_2_w_next       <= addr_8K_2_w_reg;
                addr_4K_w_next         <= addr_4K_w_reg;

                addr_4K_b_next <= addr_4K_b_reg;

                initn_cnt_next <= initn_cnt_out;
                initn_next    <= initn_out;

            when s_read_w =>
                addr_block_ctrl_w_next <= addr_block_ctrl_w_reg + 1;
                addr_block_w_next      <= addr_block_w_out;
                addr_8K_1_w_next       <= addr_8K_1_w_out;
                addr_8K_2_w_next       <= addr_8K_2_w_out;
                addr_4K_w_next         <= addr_4K_w_out;

                addr_4K_b_next <= addr_4K_b_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when s_read_b =>
                addr_block_ctrl_w_next <= addr_block_ctrl_w_reg;
                addr_block_w_next      <= addr_block_w_reg;
                addr_8K_1_w_next       <= addr_8K_1_w_reg;
                addr_8K_2_w_next       <= addr_8K_2_w_reg;
                addr_4K_w_next         <= addr_4K_w_reg;

                addr_4K_b_next <= addr_4K_b_out;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when others =>
                addr_block_ctrl_w_next <= addr_block_ctrl_w_reg;
                addr_block_w_next      <= addr_block_w_reg;
                addr_8K_1_w_next       <= addr_8K_1_w_reg;
                addr_8K_2_w_next       <= addr_8K_2_w_reg;
                addr_4K_w_next         <= addr_4K_w_reg;

                addr_4K_b_next <= addr_4K_b_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

        end case;
    end process;
    --------------------------------------

    -- PORT Assignations
    en_w_read_tmp <= en_w_read;
    en_b_read_tmp <= en_b_read;
    NoC_pm_next   <= to_integer(unsigned(NoC_pm_FE));
    wb_FE         <= wb_FE_tmp;

    A_8K_1    <= A_8K_1_tmp;
    CSN_8K_1  <= CSN_8K_1_tmp;
    D_8K_1    <= D_8K_1_tmp;
    WEN_8K_1  <= WEN_8K_1_tmp;
    A_8K_2    <= A_8K_2_tmp;
    CSN_8K_2  <= CSN_8K_2_tmp;
    D_8K_2    <= D_8K_2_tmp;
    WEN_8K_2  <= WEN_8K_2_tmp;
    A_4K      <= A_4K_tmp;
    CSN_4K    <= CSN_4K_tmp;
    D_4K      <= D_4K_tmp;
    WEN_4K    <= WEN_4K_tmp;
    INITN <= initn_reg;

end architecture;