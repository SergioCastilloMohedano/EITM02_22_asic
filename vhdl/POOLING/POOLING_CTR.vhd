library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity POOLING_CTR is
    generic (
        X : natural := X_PKG
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- From Sys. Controller
        en_pooling : in std_logic;
        M_cap      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF         : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_pm     : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_f      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        NoC_e      : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- To Pooling Logic.
        rf_addr   : out std_logic_vector(bit_size(X_PKG/2) - 1 downto 0);
        we_rf     : out std_logic;
        re_rf     : out std_logic;
        r1_r2_ctr : out std_logic;
        r3_rf_ctr : out std_logic;
        en_out    : out std_logic
    );
end POOLING_CTR;

architecture behavioral of POOLING_CTR is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_buffering, s_out, s_finished);
    signal state_next, state_reg : state_type;

    ---------- CONTROL PATH SIGNALS ------------
    ------ INPUTS --------
    -- Internal Status Signals from the Data Path
    signal pooling_cnt_done : std_logic;
    signal e_cnt_done       : std_logic;

    ---- External Command Signals to the FSMD
    -- signal en_pooling_reg : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    signal r1_r2_ctr_reg, r1_r2_ctr_next : std_logic;
    signal r3_rf_ctr_reg, r3_rf_ctr_next : std_logic;

    ---- External Status Signals to indicate status of the FSMD
    signal pooling_finished : std_logic;
    signal en_out_tmp       : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal e_cnt_reg, e_cnt_next     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal f_cnt_reg, f_cnt_next     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal m_cnt_reg, m_cnt_next     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal we_rf_reg, we_rf_next     : std_logic;
    signal re_rf_reg, re_rf_next     : std_logic;
    signal rf_addr_reg, rf_addr_next : std_logic_vector(bit_size(X_PKG/2) - 1 downto 0);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal M_cap_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal EF_tmp    : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Functional Units Intermediate Signals
    -- ..

    ---- Data Outputs

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
    asmd_ctrl : process (state_reg, en_pooling, e_cnt_done, pooling_cnt_done)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if (en_pooling = '1') then
                    state_next <= s_buffering;
                else
                    state_next <= s_idle;
                end if;

            when s_buffering =>
                if (e_cnt_done = '1') then
                    state_next <= s_out;
                else
                    state_next <= s_buffering;
                end if;

            when s_out =>
                if (e_cnt_done = '1') then
                    if pooling_cnt_done = '1' then
                        state_next <= s_finished;
                    else
                        state_next <= s_buffering;
                    end if;
                else
                    state_next <= s_out;
                end if;

            when s_finished =>
                state_next <= s_idle;

            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : input logic
    -- en_pooling_reg <= en_pooling when rising_edge(clk);

    -- control path : output logic
    pooling_finished <= '1' when state_reg = s_finished else '0';

    -- data path : functional units (perform necessary arithmetic operations)
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                m_cnt_reg     <= 0;
                f_cnt_reg     <= 0;
                e_cnt_reg     <= 0;
                r1_r2_ctr_reg <= '0';
                r3_rf_ctr_reg <= '0';
                we_rf_reg     <= '0';
                re_rf_reg     <= '0';
                rf_addr_reg   <= (others => '0');
            else
                m_cnt_reg     <= m_cnt_next;
                f_cnt_reg     <= f_cnt_next;
                e_cnt_reg     <= e_cnt_next;
                r1_r2_ctr_reg <= r1_r2_ctr_next;
                r3_rf_ctr_reg <= r3_rf_ctr_next;
                we_rf_reg     <= we_rf_next;
                re_rf_reg     <= re_rf_next;
                rf_addr_reg   <= rf_addr_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    e_cnt_next <= to_integer(unsigned(NoC_e)) when (en_pooling = '1') else 0;
    f_cnt_next <= to_integer(unsigned(NoC_f)) when (en_pooling = '1') else 0;
    m_cnt_next <= to_integer(unsigned(NoC_pm)) when (en_pooling = '1') else 0;

    r1_r2_ctr_next <= not r1_r2_ctr_reg when ((state_reg = s_buffering) or (state_reg = s_out)) else '0';
    r3_rf_ctr_next <= '1' when (state_reg = s_out) else '0';
    rf_addr_next   <= std_logic_vector(shift_right(to_unsigned(e_cnt_reg, rf_addr_reg'length), 1)) when ((state_reg = s_buffering) or (state_reg = s_out)) else (others => '0');

    -- data path : status (inputs to control path to modify next state logic)
    pooling_cnt_done <= '1' when ((m_cnt_reg = (M_cap_tmp - 1)) and (f_cnt_reg = (EF_tmp - 1)) and (e_cnt_reg = (EF_tmp - 1))) else '0';
    e_cnt_done       <= '1' when (e_cnt_reg = (EF_tmp - 1)) else '0';
    en_out_tmp       <= re_rf_reg when rising_edge(clk);

    -- data path : mux routing
    data_mux : process (state_reg, e_cnt_reg)
    begin
        case state_reg is
            when s_init =>
                we_rf_next <= '0';
                re_rf_next <= '0';

            when s_idle =>
                we_rf_next <= '0';
                re_rf_next <= '0';

            when s_buffering =>
                if (to_unsigned(e_cnt_reg, EF'length)(0) = '1') then
                    we_rf_next <= '1';
                else
                    we_rf_next <= '0';
                end if;

                re_rf_next <= '0';

            when s_out =>
                we_rf_next <= '0';

                if (to_unsigned(e_cnt_reg, EF'length)(0) = '1') then
                    re_rf_next <= '1';
                else
                    re_rf_next <= '0';
                end if;

            when s_finished =>
                we_rf_next <= '0';
                re_rf_next <= '0';

            when others =>
                we_rf_next <= '0';
                re_rf_next <= '0';

        end case;
    end process;

    -- PORT Assignations
    r1_r2_ctr <= r1_r2_ctr_reg;
    r3_rf_ctr <= r3_rf_ctr_reg;
    M_cap_tmp <= to_integer(unsigned(M_cap));
    EF_tmp    <= to_integer(unsigned(EF));
    we_rf     <= we_rf_reg;
    re_rf     <= re_rf_reg;
    en_out    <= en_out_tmp;
    rf_addr   <= rf_addr_reg;

end architecture;