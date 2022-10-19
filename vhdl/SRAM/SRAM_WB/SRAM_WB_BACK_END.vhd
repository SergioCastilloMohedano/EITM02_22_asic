-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SRAM_WB_BACK_END.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-07-04
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : Weights & Biases SRAM BACK-End Interface
-------------------------------------------------------------------------------------------------------
-- Input Signals  :
--         * clk: clock
--         * reset: synchronous, active high.
--         * ...
-- Output Signals :
--         * ...
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_WB_BACK_END is
    generic (
        -- HW Parameters, at synthesis time.
        EOM_ADDR_WB_SRAM : natural := 82329 -- End Of Memory Address of the WB SRAM, this is where first bias value is stored, in decreasing order of addresses.
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;
        -- Front-End Interface Ports
        wb_FE     : out std_logic_vector (15 downto 0);
        en_w_read : in std_logic;
        en_b_read : in std_logic;
        NoC_pm_FE : in std_logic_vector (7 downto 0);
        -- SRAM Wrapper Ports (READ)
        addrb : out std_logic_vector (16 downto 0);
        doutb : in std_logic_vector (15 downto 0);
        enb   : out std_logic
        -- SRAM Wrapper Ports (WRITE)
        --        addra : out std_logic_vector (16 downto 0);
        --        dina : in std_logic_vector (15 downto 0);
        --        ena : out std_logic;
        --        wea : out std_logic_vector (0 downto 0)
    );
end SRAM_WB_BACK_END;

architecture behavioral of SRAM_WB_BACK_END is

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
    signal addr_b_read_reg  : unsigned (16 downto 0);
    signal addr_b_read_next : unsigned (16 downto 0);
    signal addr_w_read_reg  : unsigned (16 downto 0);
    signal addr_w_read_next : unsigned (16 downto 0);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    -- ..

    ---- Functional Units Intermediate Signals
    signal addr_b_read_out : unsigned (16 downto 0);
    signal addr_w_read_out : unsigned (16 downto 0);
    signal NoC_pm_next     : natural;
    signal NoC_pm_reg      : natural;

    ---- Data Outputs
    signal wb_FE_tmp : std_logic_vector (15 downto 0);
    signal enb_tmp   : std_logic;
    signal addrb_tmp : unsigned (16 downto 0);

    -- SRAM_WB_BACK_END Intermediate Signals
    signal doutb_tmp : std_logic_vector (15 downto 0);

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
    addrb_tmp <= addr_w_read_next when (en_w_read_tmp = '1') else
                 addr_b_read_next when (en_b_read_tmp = '1') else
                 (others => '0');

    enb_tmp   <= (en_w_read_tmp OR en_b_read_tmp);
    --------------------------------------

    ------------- DATA PATH --------------
    -- Data Path : Data Registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                addr_w_read_reg <= (others => '0');
                addr_b_read_reg <= to_unsigned(EOM_ADDR_WB_SRAM, 17);
            else
                addr_w_read_reg <= addr_w_read_next;
                addr_b_read_reg <= addr_b_read_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    addr_w_read_out <= (addr_w_read_reg + 1) when (state_reg = s_read_w) else addr_w_read_reg;

    -- Bias addresses start at the last memory position, and decreases as pm increases from 0 to M - 1.
    -- No need to set bias for different layers, since address decreases with changes in NoC_pm value.
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
    addr_b_read_out <= (addr_b_read_reg - 1) when ((NoC_pm_next /= NoC_pm_reg) and (en_b_read_tmp = '1')) else addr_b_read_reg;

    -- data path : status (inputs to control path to modify next state logic)
    -- ..

    -- data path : mux routing
    data_mux : process (state_reg, doutb_tmp, addr_w_read_reg, addr_b_read_reg, addr_w_read_out, addr_b_read_out)
        begin
        case state_reg is
            when s_init =>
                wb_FE_tmp        <= (others => '0');
                addr_w_read_next <= addr_w_read_reg;
                addr_b_read_next <= addr_b_read_reg;
            when s_idle =>
                wb_FE_tmp        <= (others => '0');
                addr_w_read_next <= addr_w_read_reg;
                addr_b_read_next <= addr_b_read_reg;
            when s_read_w =>
                wb_FE_tmp        <= doutb_tmp;
                addr_w_read_next <= addr_w_read_out;
                addr_b_read_next <= addr_b_read_reg;
            when s_read_b =>
                wb_FE_tmp        <= doutb_tmp;
                addr_w_read_next <= addr_w_read_reg;
                addr_b_read_next <= addr_b_read_out;
            when others =>
                wb_FE_tmp        <= (others => '0');
                addr_w_read_next <= addr_w_read_reg;
                addr_b_read_next <= addr_b_read_reg;
            end case;
        end process;
    --------------------------------------

    -- PORT Assignations
    en_w_read_tmp <= en_w_read;
    en_b_read_tmp <= en_b_read;
    doutb_tmp     <= doutb;
    addrb         <= std_logic_vector(addrb_tmp);
    enb           <= enb_tmp;
    wb_FE         <= wb_FE_tmp;
    NoC_pm_next   <= to_integer(unsigned(NoC_pm_FE));

end architecture;