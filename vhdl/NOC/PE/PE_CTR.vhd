library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity PE_CTR is
    generic (
        -- HW Parameters, at shyntesis time.
        NUM_REGS_IFM_REG_FILE : natural := 32; -- Emax (conv0 and conv1)
        NUM_REGS_W_REG_FILE   : natural := 24 -- p*S = 8*3 = 24
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- from sys ctrl
        pass_flag : in std_logic;

        -- NoC Internal Signals
        ifm_PE_enable           : in std_logic;
        w_PE_enable             : in std_logic;
        PE_ARRAY_RF_write_start : in std_logic;

        -- PE_CTR signals
        w_addr    : out std_logic_vector(bit_size(NUM_REGS_W_REG_FILE) - 1 downto 0);
        ifm_addr  : out std_logic_vector(bit_size(NUM_REGS_IFM_REG_FILE) - 1 downto 0);
        w_we_rf   : out std_logic;
        ifm_we_rf : out std_logic
    );
end PE_CTR;

architecture behavioral of PE_CTR is
    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle_writing, s_computing);
    signal state_next, state_reg : state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    -- ..

    ---- External Command Signals to the FSMD
    signal PE_ARRAY_RF_write_start_tmp : std_logic;
    signal pass_flag_tmp               : std_logic;

    -------- OUTPUTS --------
    -- -- Internal Control Signals used to control Data Path Operation
    signal NoC_ACK_counter_reg, NoC_ACK_counter_next : std_logic_vector (9 downto 0);

    ---- External Status Signals to indicate status of the FSMD
    -- ..

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal w_addr_reg, w_addr_next     : std_logic_vector (bit_size(NUM_REGS_W_REG_FILE) - 1 downto 0);
    signal ifm_addr_reg, ifm_addr_next : std_logic_vector (bit_size(NUM_REGS_IFM_REG_FILE) - 1 downto 0);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal ifm_PE_enable_tmp : std_logic;
    signal w_PE_enable_tmp   : std_logic;

    ---- Functional Units Intermediate Signals
    -- ..

    ---- Data Outputs
    signal ifm_we_rf_tmp : std_logic;
    signal w_we_rf_tmp   : std_logic;

    -- Intermediate Signals
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
    asmd_ctrl : process (state_reg, pass_flag_tmp, NoC_ACK_counter_reg)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle_writing;
            when s_idle_writing =>
                if pass_flag_tmp = '1' then
                    state_next <= s_computing;
                else
                    state_next <= s_idle_writing;
                end if;
            when s_computing =>
                if NoC_ACK_counter_reg = std_logic_vector(to_unsigned(0, 10)) then
                    state_next <= s_idle_writing;
                else
                    state_next <= s_computing;
                end if;
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
                ifm_addr_reg        <= (others => '0');
                w_addr_reg          <= (others => '0');
                NoC_ACK_counter_reg <= (others => '0');
            else
                ifm_addr_reg        <= ifm_addr_next;
                w_addr_reg          <= w_addr_next;
                NoC_ACK_counter_reg <= NoC_ACK_counter_next;
            end if;
        end if;
    end process;

    -- data path : mux routing and logic
    data_mux : process (state_reg, pass_flag_tmp, PE_ARRAY_RF_write_start_tmp, ifm_PE_enable_tmp, w_PE_enable_tmp, NoC_ACK_counter_reg, w_addr_reg, ifm_addr_reg)
    begin
        case state_reg is
            when s_init                     =>
                ifm_addr_next        <= (others => '0');
                w_addr_next          <= (others => '0');
                NoC_ACK_counter_next <= (others => '0');
                ifm_we_rf_tmp        <= '0';
                w_we_rf_tmp          <= '0';
            when s_idle_writing                =>
                NoC_ACK_counter_next    <= (others => '0');
                NoC_ACK_counter_next(0) <= '1';
                ifm_we_rf_tmp           <= '0';
                w_we_rf_tmp             <= '0';
                if (pass_flag_tmp = '0') then
                    if (PE_ARRAY_RF_write_start_tmp = '1') then
                        if (ifm_PE_enable_tmp = '1') then
                            ifm_addr_next <= std_logic_vector(unsigned(ifm_addr_reg) + 1);
                            ifm_we_rf_tmp <= '1';
                        else
                            ifm_addr_next <= ifm_addr_reg;
                        end if;
                        if (w_PE_enable_tmp = '1') then
                            w_addr_next <= std_logic_vector(unsigned(w_addr_reg) + 1);
                            w_we_rf_tmp <= '1';
                        else
                            w_addr_next <= w_addr_reg;
                        end if;
                    else
                        ifm_addr_next <= ifm_addr_reg;
                        w_addr_next   <= w_addr_reg;
                    end if;
                else
                    ifm_addr_next <= (others => '0');
                    w_addr_next   <= (others => '0');
                end if;
            when s_computing =>
                ifm_addr_next        <= ifm_addr_reg;
                w_addr_next          <= w_addr_reg;
                NoC_ACK_counter_next <= std_logic_vector(unsigned(NoC_ACK_counter_reg) + 1);
                ifm_we_rf_tmp           <= '0';
                w_we_rf_tmp             <= '0';
            when others =>
                ifm_addr_next        <= ifm_addr_reg;
                w_addr_next          <= w_addr_reg;
                NoC_ACK_counter_next <= NoC_ACK_counter_reg;
                ifm_we_rf_tmp           <= '0';
                w_we_rf_tmp             <= '0';
        end case;
    end process;

    -- PORT Assignations
    ifm_addr                    <= ifm_addr_reg;
    w_addr                      <= w_addr_reg;
    ifm_we_rf                   <= ifm_we_rf_tmp;
    w_we_rf                     <= w_we_rf_tmp;
    ifm_PE_enable_tmp           <= ifm_PE_enable;
    w_PE_enable_tmp             <= w_PE_enable;
    PE_ARRAY_RF_write_start_tmp <= PE_ARRAY_RF_write_start;
    pass_flag_tmp               <= pass_flag;

end architecture;