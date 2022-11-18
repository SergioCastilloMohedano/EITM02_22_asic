-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SRAM_IFM_BACK_END.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-06-25
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : Input Features Map SRAM BACK-End Interface
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

entity SRAM_IFM_BACK_END is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Front-End Interface Ports (READ)
        ifm_FE_r : out std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        RE_FE    : in std_logic; -- Read Enable, active high

        -- Front-End Interface Ports (WRITE)
        ifm_FE_w : in std_logic_vector (COMP_BITWIDTH - 1 downto 0);
        en_w     : in std_logic;
        WE_FE    : in std_logic;

        -- SRAM Wrapper Ports (READ)
        addrb : out std_logic_vector (14 downto 0);
        doutb : in std_logic_vector (31 downto 0);
        enb   : out std_logic;

        -- SRAM Wrapper Ports (WRITE)
        addra : out std_logic_vector (14 downto 0);
        dina  : out std_logic_vector (31 downto 0);
        ena   : out std_logic;
        wea   : out std_logic_vector (3 downto 0)
    );
end SRAM_IFM_BACK_END;

architecture behavioral of SRAM_IFM_BACK_END is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_0, s_1, s_2, s_3, s_write, s_finished);
    signal state_next, state_reg : state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    -- ..

    ---- External Command Signals to the FSMD
    signal RE_tmp : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    -- ..

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal addr_r_reg, addr_r_next   : unsigned (14 downto 0);
    signal addr_w_reg, addr_w_next   : unsigned (14 downto 0);
    signal wea_reg, wea_next         : std_logic_vector (3 downto 0);
    signal wea_cnt_reg, wea_cnt_next : unsigned (2 downto 0);
    signal dina_tmp                  : std_logic_vector (31 downto 0);
    signal dina_zeroes               : std_logic_vector (31 downto 0) := (others => '0');

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    -- ..

    ---- Functional Units Intermediate Signals
    signal wea_cnt_out, wea_cnt_tmp : unsigned (2 downto 0);

    ---- Data Outputs
    signal ifm_FE_tmp : std_logic_vector (COMP_BITWIDTH - 1 downto 0);
    signal enb_tmp    : std_logic;

    -- SRAM_IFM_BACK_END Intermediate Signals
    signal doutb_tmp : std_logic_vector (31 downto 0);

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
    asmd_ctrl : process (state_reg, RE_tmp, en_w)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if (RE_tmp = '1') then
                    state_next <= s_0;
                else
                    if (en_w = '1') then
                        state_next <= s_write;
                    else
                        state_next <= s_idle;
                    end if;
                end if;
            when s_0 =>
                state_next <= s_1;
            when s_1 =>
                state_next <= s_2;
            when s_2 =>
                state_next <= s_3;
            when s_3 =>
                if (RE_tmp = '1') then
                    state_next <= s_0;
                else
                    state_next <= s_idle;
                end if;
            when s_write =>
                if (en_w = '1') then
                    state_next <= s_write;
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

    -- data path : data registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                addr_r_reg  <= (others => '0');
                addr_w_reg  <= (others => '0');
                wea_reg     <= "1000";
                wea_cnt_reg <= (others => '0');

            else
                addr_r_reg  <= addr_r_next;
                addr_w_reg  <= addr_w_next;
                wea_reg     <= wea_next;
                wea_cnt_reg <= wea_cnt_next;
            end if;
        end if;
    end process;

    -- data path : out logic
    enb_tmp <= '1' when (RE_tmp = '1') and ((state_reg = s_idle) or (state_reg = s_3)) else '0';

    -- data path : functional units
    wea_cnt_tmp <= (others => '0') when wea_cnt_reg = 3 else wea_cnt_reg + to_unsigned(1, wea_cnt_reg'length);
    wea_cnt_out <= wea_cnt_tmp when WE_FE = '1' else wea_cnt_reg;

    wea_next <= wea_reg(0) & wea_reg(3 downto 1) when (WE_FE = '1') else wea_reg;

    with wea_reg select dina_tmp <=
        ifm_FE_w & dina_zeroes(23 downto 0)                             when "1000",
        dina_zeroes(31 downto 24) & ifm_FE_w & dina_zeroes(15 downto 0) when "0100",
        dina_zeroes(31 downto 16) & ifm_FE_w & dina_zeroes(7 downto 0)  when "0010",
        dina_zeroes(31 downto 8)  & ifm_FE_w                            when "0001",
        (others => '0')                                                 when others;

    -- data path : mux routing
    data_mux : process (state_reg, doutb_tmp, addr_r_reg, wea_cnt_reg, wea_cnt_out, addr_w_reg, WE_FE)
    begin
        case state_reg is
            when s_init            =>
                ifm_FE_tmp  <= (others => '0');
                addr_r_next <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

            when s_idle            =>
                ifm_FE_tmp  <= (others => '0');
                addr_r_next <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

            when s_0 =>
                ifm_FE_tmp  <= doutb_tmp (31 downto 24);
                addr_r_next <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

            when s_1 =>
                ifm_FE_tmp  <= doutb_tmp (23 downto 16);
                addr_r_next <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

            when s_2 =>
                ifm_FE_tmp  <= doutb_tmp (15 downto 8);
                addr_r_next <= addr_r_reg + 1;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

            when s_3 =>
                ifm_FE_tmp  <= doutb_tmp (7 downto 0);
                addr_r_next <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

            when s_write           =>
                ifm_FE_tmp  <= (others => '0');
                addr_r_next <= addr_r_reg;

                wea_cnt_next <= wea_cnt_out;

                if ((wea_cnt_reg = 3) and (WE_FE = '1')) then
                    addr_w_next <= addr_w_reg + 1;
                else
                    addr_w_next <= addr_w_reg;
                end if;

            when s_finished        =>
                ifm_FE_tmp  <= (others => '0');
                addr_r_next <= (others => '0');

                wea_cnt_next <= (others => '0');
                addr_w_next  <= (others => '0');
            when others            =>
                ifm_FE_tmp  <= (others => '0');
                addr_r_next <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

        end case;
    end process;

    -- PORT Assignations
    RE_tmp    <= RE_FE;
    addrb     <= std_logic_vector(addr_r_reg);
    enb       <= enb_tmp;
    doutb_tmp <= doutb;
    ifm_FE_r  <= ifm_FE_tmp;

    addra <= std_logic_vector(addr_w_reg);
    dina  <= dina_tmp;
    ena   <= en_w;
    wea   <= wea_reg;


    end architecture;