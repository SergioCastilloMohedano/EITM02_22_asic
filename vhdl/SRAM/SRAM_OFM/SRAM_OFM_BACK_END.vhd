library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_OFM_BACK_END is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        -- From Sys. Controller
        OFM_NL_cnt_finished       : in std_logic;
        OFM_NL_NoC_m_cnt_finished : in std_logic;
        -- From/To Front-End Acc. Interface
        ofm_FE_acc : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
        ofm_sum    : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
        en_ofm_in  : in std_logic;
        en_ofm_sum : in std_logic;
        WE         : in std_logic;
        -- From/To Front-End Output Interface
        ofm_FE_out : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
        en_ofm_out : in std_logic;
        -- SRAM Wrapper Ports
        INITN          : out std_logic;
        OFM_WRITE_BUSY : out std_logic;
        OFM_READ_BUSY  : out std_logic;
        OFM_READ_FINISHED : out std_logic;
        -- Port 1 (write)
        A_2K_p1   : out std_logic_vector(13 downto 0);
        CSN_2K_p1 : out std_logic;
        D_2K_p1   : out std_logic_vector (31 downto 0);
        WEN_2K_p1 : out std_logic;
        -- Port 2 (read)
        A_2K_p2   : out std_logic_vector(13 downto 0);
        CSN_2K_p2 : out std_logic;
        Q_2K_p2   : in std_logic_vector (31 downto 0)
    );
end SRAM_OFM_BACK_END;

architecture behavioral of SRAM_OFM_BACK_END is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_OFM_Write, s_OFM_Read, s_finished);
    signal state_next, state_reg : state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    -- ..

    ---- External Command Signals to the FSMD
    signal OFM_NL_cnt_finished_tmp : std_logic;
    signal en_ofm_in_tmp           : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal OFM_WRITE_BUSY_tmp : std_logic;
    signal OFM_READ_BUSY_tmp  : std_logic;
    signal OFM_READ_FINISHED_tmp  : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal addr_ofm_write_reg, addr_ofm_write_next : unsigned (13 downto 0);
    signal addr_ofm_read_reg, addr_ofm_read_next   : unsigned (13 downto 0);

    signal initn_reg, initn_next         : std_logic;
    signal initn_cnt_reg, initn_cnt_next : unsigned (1 downto 0);


    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal WE_tmp                        : std_logic;
    signal OFM_NL_NoC_m_cnt_finished_tmp : std_logic;

    ---- Functional Units Intermediate Signals
    signal addr_ofm_write_out : unsigned (13 downto 0);
    signal addr_ofm_write_tmp : unsigned (13 downto 0);
    signal addr_ofm_read_out  : unsigned (13 downto 0);

    signal initn_out     : std_logic;
    signal initn_cnt_out : unsigned (1 downto 0);


    ---- Data Outputs
    signal ofm_sum_tmp    : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal ofm_FE_out_tmp : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal A_2K_p1_tmp    : unsigned (13 downto 0);
    signal D_2K_p1_tmp    : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal CSN_2K_p1_tmp  : std_logic;
    signal WEN_2K_p1_tmp  : std_logic;
    signal A_2K_p2_tmp    : unsigned (13 downto 0);
    signal CSN_2K_p2_tmp  : std_logic;

    -- Data Inputs
    signal ofm_FE_in_tmp : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);

    -- Other signals
    signal sign_extension : std_logic_vector (OFMAP_BITWIDTH - 32 - 1 downto 0);

begin

    -- control path : state register
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

    -- control path : next state logic
    asmd_ctrl : process (state_reg, en_ofm_in_tmp, OFM_NL_cnt_finished_tmp, OFM_NL_NoC_m_cnt_finished_tmp)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if en_ofm_in_tmp = '1' then
                    state_next <= s_OFM_Write;
                else
                    state_next <= s_idle;
                end if;
            when s_OFM_Write =>
                if OFM_NL_cnt_finished_tmp = '1' then
                    state_next <= s_OFM_Read;
                else
                    state_next <= s_OFM_Write;
                end if;
            when s_OFM_Read =>
                if (OFM_NL_NoC_m_cnt_finished_tmp = '0') then
                    state_next <= s_OFM_Read;
                else
                    state_next <= s_finished;
                end if;
            when s_finished =>
                state_next <= s_idle;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    OFM_WRITE_BUSY_tmp <= '1' when (state_reg = s_OFM_Write) else '0';
    OFM_READ_BUSY_tmp  <= '1' when (state_reg = s_OFM_Read)  else '0';
    OFM_READ_FINISHED_tmp <= '1' when (state_reg = s_finished) else '0';

    -- data path : data registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                addr_ofm_write_reg <= (others => '0');
                addr_ofm_read_reg  <= (others => '0');

                initn_cnt_reg <= (others => '0');
                initn_reg     <= '1';
            else
                addr_ofm_write_reg <= addr_ofm_write_next;
                addr_ofm_read_reg  <= addr_ofm_read_next;

                initn_cnt_reg <= initn_cnt_next;
                initn_reg     <= initn_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    addr_ofm_write_tmp <= (others => '0') when (OFM_NL_NoC_m_cnt_finished_tmp = '1') else addr_ofm_write_reg + 1;
    addr_ofm_write_out <= addr_ofm_write_tmp when (WE_tmp = '1') else addr_ofm_write_reg;

    addr_ofm_read_out <= (others => '0') when (OFM_NL_NoC_m_cnt_finished_tmp = '1') else (addr_ofm_read_reg + 1);


    initn_cnt_out <= initn_cnt_reg when initn_cnt_reg = "11" else initn_cnt_reg + "1";
    initn_out     <= '1' when initn_cnt_reg = "00" else
                     '1' when initn_cnt_reg = "11" else
                     '0';
                
    -- data path : status (inputs to control path to modify next state logic)
    -- ..

    -- data path : outputs
    A_2K_p1_tmp   <= addr_ofm_write_reg;
    D_2K_p1_tmp   <= ofm_FE_in_tmp;
    CSN_2K_p1_tmp <= en_ofm_in_tmp;
    WEN_2K_p1_tmp <= WE_tmp;

    A_2K_p2_tmp <= addr_ofm_write_next when (state_reg = s_OFM_Write) else
        addr_ofm_read_reg when (state_reg = s_OFM_Read) else
        (others => '0');

    sign_extension <= (others => Q_2K_p2(31));
    ofm_FE_out_tmp <= (sign_extension & Q_2K_p2) when ((state_reg = s_OFM_Read) or (state_reg = s_finished)) else (others => '0');
    ofm_sum_tmp    <= (sign_extension & Q_2K_p2) when (state_reg = s_OFM_Write) else (others                              => '0');
    CSN_2K_p2_tmp  <= en_ofm_sum when (state_reg = s_OFM_Write) else
        en_ofm_out when (state_reg = s_OFM_Read) else
        '0';

    -- data path : mux routing
    data_mux : process (state_reg, addr_ofm_write_reg, addr_ofm_write_out, addr_ofm_read_reg, addr_ofm_read_out, initn_cnt_reg, initn_reg, initn_cnt_out, initn_out)
    begin
        case state_reg is
            when s_init                    =>
                addr_ofm_write_next <= (others => '0');
                addr_ofm_read_next  <= (others => '0');

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;
            when s_idle                    =>
                addr_ofm_write_next <= addr_ofm_write_reg;
                addr_ofm_read_next  <= addr_ofm_read_reg;

                initn_cnt_next <= initn_cnt_out;
                initn_next     <= initn_out;
            when s_OFM_Write =>
                addr_ofm_write_next <= addr_ofm_write_out;
                addr_ofm_read_next  <= addr_ofm_read_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;
            when s_OFM_Read =>
                addr_ofm_write_next <= addr_ofm_write_reg;
                addr_ofm_read_next  <= addr_ofm_read_out;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;
            when s_finished                =>
                addr_ofm_write_next <= (others => '0');
                addr_ofm_read_next  <= (others => '0');

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;
            when others                    =>
                addr_ofm_write_next <= addr_ofm_write_reg;
                addr_ofm_read_next  <= addr_ofm_read_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;
        end case;
    end process;

    -- PORT Assignations
    WE_tmp                        <= WE;
    ofm_FE_in_tmp                 <= ofm_FE_acc;
    en_ofm_in_tmp                 <= en_ofm_in;
    OFM_NL_cnt_finished_tmp       <= OFM_NL_cnt_finished;
    OFM_NL_NoC_m_cnt_finished_tmp <= OFM_NL_NoC_m_cnt_finished;
    ofm_sum                       <= ofm_sum_tmp;
    ofm_FE_out                    <= ofm_FE_out_tmp;
    A_2K_p1                       <= std_logic_vector(A_2K_p1_tmp);
    D_2K_p1                       <= D_2K_p1_tmp(31 downto 0);
    CSN_2K_p1                     <= not(CSN_2K_p1_tmp);
    WEN_2K_p1                     <= not(WEN_2K_p1_tmp);
    A_2K_p2                       <= std_logic_vector(A_2K_p2_tmp);
    CSN_2K_p2                     <= not(CSN_2K_p2_tmp);
    INITN                         <= INITN_reg;
    OFM_WRITE_BUSY                <= OFM_WRITE_BUSY_tmp;
    OFM_READ_BUSY                 <= OFM_READ_BUSY_tmp;
    OFM_READ_FINISHED             <= OFM_READ_FINISHED_tmp;

end architecture;
