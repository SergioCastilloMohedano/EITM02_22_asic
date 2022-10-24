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
        addra : out std_logic_vector (13 downto 0);
        dina  : out std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
        ena   : out std_logic;
        wea   : out std_logic_vector (0 downto 0);
        addrb : out std_logic_vector (13 downto 0);
        doutb : in std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
        enb   : out std_logic
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

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal addr_ofm_write_reg, addr_ofm_write_next : unsigned (13 downto 0);
    signal addr_ofm_read_reg, addr_ofm_read_next   : unsigned (13 downto 0);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal WE_tmp                        : std_logic_vector (0 downto 0);
    signal OFM_NL_NoC_m_cnt_finished_tmp : std_logic;

    ---- Functional Units Intermediate Signals
    signal addr_ofm_write_out : unsigned (13 downto 0);
    signal addr_ofm_write_tmp : unsigned (13 downto 0);
    signal addr_ofm_read_out  : unsigned (13 downto 0);

    ---- Data Outputs
    signal ofm_sum_tmp    : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal ofm_FE_out_tmp : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal addra_tmp      : unsigned (13 downto 0);
    signal dina_tmp       : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal ena_tmp        : std_logic;
    signal wea_tmp        : std_logic_vector (0 downto 0);
    signal addrb_tmp      : unsigned (13 downto 0);
    signal enb_tmp        : std_logic;

    signal addr_ofm_write_reg_delay : unsigned (13 downto 0);
    signal ofm_FE_in_tmp_delay      : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);
    signal en_ofm_in_tmp_delay      : std_logic;
    signal WE_tmp_delay             : std_logic_vector (0 downto 0);

    -- Data Inputs
    signal ofm_FE_in_tmp : std_logic_vector (OFMAP_BITWIDTH - 1 downto 0);

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
    -- ..

    -- data path : data registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                addr_ofm_write_reg <= (others => '0');
                addr_ofm_read_reg  <= (others => '0');
            else
                addr_ofm_write_reg <= addr_ofm_write_next;
                addr_ofm_read_reg  <= addr_ofm_read_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    addr_ofm_write_tmp <= (others => '0') when (OFM_NL_NoC_m_cnt_finished_tmp = '1') else addr_ofm_write_reg + 1;
    addr_ofm_write_out <= addr_ofm_write_tmp when (WE_tmp(0) = '1') else addr_ofm_write_reg;

    addr_ofm_read_out <= (others => '0') when (OFM_NL_NoC_m_cnt_finished_tmp = '1') else (addr_ofm_read_reg + 1);

    -- data path : status (inputs to control path to modify next state logic)
    -- ..

    -- data path : outputs
    addra_tmp <= addr_ofm_write_reg;
    dina_tmp  <= ofm_FE_in_tmp;
    ena_tmp   <= en_ofm_in_tmp;
    wea_tmp   <= WE_tmp;

    addrb_tmp <= addr_ofm_write_next when (state_reg = s_OFM_Write) else
                 addr_ofm_read_reg when (state_reg = s_OFM_Read) else
                 (others => '0');
    ofm_FE_out_tmp <= doutb when ((state_reg = s_OFM_Read) or (state_reg = s_finished)) else (others  => '0');
    ofm_sum_tmp    <= doutb when (state_reg = s_OFM_Write) else (others => '0');
    enb_tmp        <= en_ofm_sum when (state_reg = s_OFM_Write) else
                      en_ofm_out when (state_reg = s_OFM_Read) else
                      '0';

    -- data path : mux routing
    data_mux : process (state_reg, addr_ofm_write_reg, addr_ofm_write_out, addr_ofm_read_reg, addr_ofm_read_out)
    begin
        case state_reg is
            when s_init                    =>
                addr_ofm_write_next <= (others => '0');
                addr_ofm_read_next  <= (others => '0');
            when s_idle                    =>
                addr_ofm_write_next <= addr_ofm_write_reg;
                addr_ofm_read_next  <= addr_ofm_read_reg;
            when s_OFM_Write =>
                addr_ofm_write_next <= addr_ofm_write_out;
                addr_ofm_read_next  <= addr_ofm_read_reg;
            when s_OFM_Read =>
                addr_ofm_write_next <= addr_ofm_write_reg;
                addr_ofm_read_next  <= addr_ofm_read_out;
            when s_finished                =>
                addr_ofm_write_next <= (others => '0');
                addr_ofm_read_next  <= (others => '0');
            when others                    =>
                addr_ofm_write_next <= addr_ofm_write_reg;
                addr_ofm_read_next  <= addr_ofm_read_reg;
        end case;
    end process;

    -- PORT Assignations
    WE_tmp(0)                     <= WE;
    ofm_FE_in_tmp                 <= ofm_FE_acc;
    en_ofm_in_tmp                 <= en_ofm_in;
    OFM_NL_cnt_finished_tmp       <= OFM_NL_cnt_finished;
    OFM_NL_NoC_m_cnt_finished_tmp <= OFM_NL_NoC_m_cnt_finished;
    ofm_sum                       <= ofm_sum_tmp;
    ofm_FE_out                    <= ofm_FE_out_tmp;
    addra                         <= std_logic_vector(addra_tmp);
    dina                          <= dina_tmp;
    ena                           <= ena_tmp;
    wea                           <= wea_tmp;
    addrb                         <= std_logic_vector(addrb_tmp);
    enb                           <= enb_tmp;

end architecture;