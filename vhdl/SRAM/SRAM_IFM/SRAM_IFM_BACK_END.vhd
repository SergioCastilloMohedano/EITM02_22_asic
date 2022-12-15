library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SRAM_IFM_BACK_END is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- Front-End Interface Ports (READ)
        ifm_FE_r : out std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        RE_FE    : in std_logic; -- Read Enable, active high

        -- Front-End Interface Ports (WRITE)
        ifm_FE_w : in std_logic_vector (ACT_BITWIDTH - 1 downto 0);
        en_w     : in std_logic;
        WE_FE    : in std_logic;

        -- SRAM Wrapper Ports (ASIC)
        A     : out std_logic_vector(12 downto 0);
        CSN   : out std_logic;
        D     : out std_logic_vector (31 downto 0);
        INITN : out std_logic;
        Q     : in std_logic_vector (31 downto 0);
        WEN   : out std_logic
    );
end SRAM_IFM_BACK_END;

architecture behavioral of SRAM_IFM_BACK_END is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_0, s_1, s_write, s_finished);
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
    signal addr_r_reg, addr_r_next       : unsigned (12 downto 0);
    signal addr_w_reg, addr_w_next       : unsigned (12 downto 0);
    signal buff_reg, buff_next           : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal wea_cnt_reg, wea_cnt_next     : unsigned (1 downto 0);
    signal INITN_reg, INITN_next         : std_logic;
    signal initn_cnt_reg, initn_cnt_next : unsigned (1 downto 0);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    -- ..

    ---- Functional Units Intermediate Signals
    signal wea_cnt_out, wea_cnt_tmp : unsigned (1 downto 0);
    signal WEN_tmp                  : std_logic;
    signal INITN_out                : std_logic;
    signal initn_cnt_out            : unsigned (1 downto 0);

    ---- Data Outputs
    signal ifm_FE_r_tmp          : std_logic_vector (ACT_BITWIDTH - 1 downto 0);
    signal CSN_r, CSN_w, CSN_tmp : std_logic;
    signal A_tmp                 : unsigned (12 downto 0);
    signal Q_tmp                 : std_logic_vector (31 downto 0);

    -- SRAM_IFM_BACK_END Intermediate Signals
    -- ..

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
                addr_r_reg      <= (others => '0');
                addr_w_reg      <= (others => '0');
                buff_reg        <= (others => '0');
                wea_cnt_reg     <= (others => '0');
                INITN_reg       <= '1';
                initn_cnt_reg   <= (others => '0');
            else
                addr_r_reg      <= addr_r_next;
                addr_w_reg      <= addr_w_next;
                buff_reg        <= buff_next;
                wea_cnt_reg     <= wea_cnt_next;
                INITN_reg       <= INITN_next;
                initn_cnt_reg   <= initn_cnt_next;

            end if;
        end if;
    end process;

    -- data path : out logic
    CSN_r <= '0' when (RE_tmp = '1') and ((state_reg = s_idle) or (state_reg = s_1)) else '1';

    CSN_tmp <= CSN_w when (state_reg = s_write) else CSN_r;

    A_tmp <= addr_w_reg when (state_reg = s_write) else addr_r_reg;

    -- data path : functional units
    wea_cnt_tmp <= (others => '0') when wea_cnt_reg = 1 else wea_cnt_reg + to_unsigned(1, wea_cnt_reg'length);
    wea_cnt_out <= wea_cnt_tmp     when WE_FE = '1' else wea_cnt_reg;

    WEN_tmp        <= '0' when ((wea_cnt_reg = 1) and (WE_FE = '1')) else '1';

    buff_next <= ifm_FE_w when ((wea_cnt_reg = "00") and (WE_FE = '1')) else buff_reg;

    initn_cnt_out <= initn_cnt_reg when initn_cnt_reg = "11" else initn_cnt_reg + "1";
    initn_out     <= '1' when initn_cnt_reg = "00" else
                     '1' when initn_cnt_reg = "11" else
                     '0';
        
    -- data path : mux routing
    data_mux : process (state_reg, Q_tmp, addr_r_reg, wea_cnt_reg, wea_cnt_out, addr_w_reg, WE_FE, initn_cnt_reg, initn_reg, initn_cnt_out, initn_out)
    begin
        case state_reg is
            when s_init             =>
                ifm_FE_r_tmp <= (others => '0');
                addr_r_next  <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when s_idle             =>
                ifm_FE_r_tmp <= (others => '0');
                addr_r_next  <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

                initn_cnt_next <= initn_cnt_out;
                initn_next     <= initn_out;

            when s_0 =>
                ifm_FE_r_tmp <= Q_tmp (31 downto 16);
                addr_r_next  <= addr_r_reg + 1;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when s_1 =>
                ifm_FE_r_tmp <= Q_tmp (15 downto 0);
                addr_r_next  <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when s_write            =>
                ifm_FE_r_tmp <= (others => '0');
                addr_r_next  <= addr_r_reg;

                wea_cnt_next <= wea_cnt_out;

                if ((wea_cnt_reg = 1) and (WE_FE = '1')) then
                    addr_w_next <= addr_w_reg + 1;
                else
                    addr_w_next <= addr_w_reg;
                end if;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when s_finished         =>
                ifm_FE_r_tmp <= (others => '0');
                addr_r_next  <= (others => '0');

                wea_cnt_next <= (others => '0');
                addr_w_next  <= (others => '0');

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

            when others             =>
                ifm_FE_r_tmp <= (others => '0');
                addr_r_next  <= addr_r_reg;

                wea_cnt_next <= wea_cnt_reg;
                addr_w_next  <= addr_w_reg;

                initn_cnt_next <= initn_cnt_reg;
                initn_next     <= initn_reg;

        end case;
    end process;

    ---- PORT Assignations
    -- Front End (READ)
    RE_tmp   <= RE_FE;
    ifm_FE_r <= ifm_FE_r_tmp;

    -- Front End (WRITE)
    CSN_w <= not(en_w);

    -- SRAM (ASIC)
    CSN   <= CSN_tmp;
    Q_tmp <= Q;
    A     <= std_logic_vector(A_tmp);
    D     <= buff_reg & ifm_FE_w;
    WEN   <= WEN_tmp;
    INITN <= INITN_reg;

end architecture;
