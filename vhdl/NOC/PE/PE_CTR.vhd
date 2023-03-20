library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity PE_CTR is
    generic (
        -- HW Parameters, at synthesis time.
        Y_ID                  : natural       := 1;
        X_ID                  : natural       := 1;
        NUM_REGS_IFM_REG_FILE : natural       := NUM_REGS_IFM_REG_FILE_PKG;  -- W' max (conv0 and conv1)
        NUM_REGS_W_REG_FILE   : natural       := NUM_REGS_W_REG_FILE_PKG -- p*S = 8*3 = 24
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        -- config. parameters
        HW_p : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        RS   : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        p    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r    : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);

        -- from sys ctrl
        pass_flag : in std_logic;

        -- NoC Internal Signals
        ifm_PE_enable           : in std_logic;
        w_PE_enable             : in std_logic;
        PE_ARRAY_RF_write_start : in std_logic;

        -- PE_CTR signals
        w_addr            : out std_logic_vector(bit_size(NUM_REGS_W_REG_FILE_PKG) - 1 downto 0);
        ifm_addr          : out std_logic_vector(bit_size(NUM_REGS_IFM_REG_FILE_PKG) - 1 downto 0);
        w_we_rf           : out std_logic;
        ifm_we_rf         : out std_logic;
        reset_acc         : out std_logic;
        inter_PE_acc      : out std_logic;
        re_rf             : out std_logic;
        PISO_Buffer_start : out std_logic;

        -- Clock Gating
        is_stalling  : out std_logic
    );
end PE_CTR;

architecture behavioral of PE_CTR is
    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle_writing, s_intra_PE_acc, s_inter_PE_acc, s_hold, s_reset_acc, s_stall, s_finished);
    signal state_next, state_reg : state_type;

    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal start_inter_PE_acc                      : std_logic;
    signal intra_cnt_done_reg, intra_cnt_done_next : std_logic;
    signal inter_cnt_done_tmp_1                    : std_logic;
    signal inter_cnt_done_tmp_2                    : std_logic;
    signal inter_cnt_done                          : std_logic;
    signal hold_cnt_done                           : std_logic;
    signal j_cnt_done                              : std_logic;
    signal j_cnt_done_tmp_1                        : std_logic;
    signal j_cnt_done_tmp_2                        : std_logic;
    signal stall_cnt_done                          : std_logic;

    ---- External Command Signals to the FSMD
    signal PE_ARRAY_RF_write_start_tmp : std_logic;
    signal pass_flag_tmp               : std_logic;
    signal stall_cnt                   : integer;

    -------- OUTPUTS --------
    ----- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    signal reset_acc_tmp         : std_logic;
    signal inter_PE_acc_tmp      : std_logic;
    signal re_rf_tmp             : std_logic; -- avoids reading from RF when they are being writen.
    signal PISO_BUffer_start_tmp : std_logic; -- 040323

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    signal w_addr_write_reg, w_addr_write_next       : std_logic_vector (bit_size(NUM_REGS_W_REG_FILE_PKG) - 1 downto 0);
    signal ifm_addr_write_reg, ifm_addr_write_next   : std_logic_vector (bit_size(NUM_REGS_IFM_REG_FILE_PKG) - 1 downto 0);
    signal w_addr_read_reg, w_addr_read_next         : natural range 0 to (NUM_REGS_W_REG_FILE_PKG);
    signal ifm_addr_read_reg, ifm_addr_read_next     : natural range 0 to (NUM_REGS_IFM_REG_FILE_PKG);
    signal intra_w_p_reg, intra_w_p_next             : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal intra_s_reg, intra_s_next                 : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal intra_p_reg, intra_p_next                 : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal inter_r_p_reg, inter_r_p_next             : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal hold_cnt_reg, hold_cnt_next               : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal j_cnt_reg, j_cnt_next                     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal stall_cnt_reg, stall_cnt_next             : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- External Control Signals used to control Data Path Operation (they do NOT modify next state outcome)
    signal ifm_PE_enable_tmp : std_logic;
    signal w_PE_enable_tmp   : std_logic;
    signal HW_p_tmp          : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal EF_tmp            : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal RS_tmp            : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal p_tmp             : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal r_tmp             : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Functional Units Intermediate Signals
    signal intra_s_out           : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal intra_w_p_out         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal intra_w_p_out_tmp     : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal intra_p_out           : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal intra_p_out_tmp       : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal w_addr_read_out       : natural range 0 to (NUM_REGS_W_REG_FILE_PKG);
    signal w_addr_read_out_tmp   : natural range 0 to (NUM_REGS_W_REG_FILE_PKG);
    signal ifm_addr_read_out     : natural range 0 to (NUM_REGS_IFM_REG_FILE_PKG);
    signal ifm_addr_read_out_tmp : natural range 0 to (NUM_REGS_IFM_REG_FILE_PKG);
    signal inter_r_p_out_1       : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal inter_r_p_out_2       : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal inter_r_p_out         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal hold_cnt_out          : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal j_cnt_out             : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal j_cnt_out_tmp         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal stall_cnt_out         : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Data Outputs
    signal ifm_we_rf_tmp : std_logic;
    signal w_we_rf_tmp   : std_logic;
    signal ifm_addr_tmp  : std_logic_vector (bit_size(NUM_REGS_IFM_REG_FILE_PKG) - 1 downto 0);
    signal w_addr_tmp    : std_logic_vector (bit_size(NUM_REGS_W_REG_FILE_PKG) - 1 downto 0);

    -- Intermediate Signals
    signal ifm_addr_read_tmp : natural range 0 to (NUM_REGS_IFM_REG_FILE_PKG - 1);
    signal w_addr_read_tmp   : natural range 0 to (NUM_REGS_W_REG_FILE_PKG - 1);

    -- Other Signals
    constant RF_READ_LATENCY       : natural := 2; -- Register Files read latency, in clock cycles
    signal reset_acc_delay         : std_logic_vector(0 to RF_READ_LATENCY - 1);
    signal inter_PE_acc_delay      : std_logic_vector(0 to RF_READ_LATENCY - 1);
    signal PISO_BUffer_start_delay : std_logic_vector(0 to RF_READ_LATENCY - 1); -- 040323

    -- Clock Gating
    signal is_stalling_tmp : std_logic;

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
    asmd_ctrl : process (state_reg, pass_flag_tmp, intra_s_reg, intra_cnt_done_reg, inter_cnt_done, hold_cnt_done, j_cnt_done, stall_cnt_done, RS_tmp)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle_writing;
                is_stalling_tmp  <= '0'; -- Clock Gating Control
            when s_idle_writing =>
                if pass_flag_tmp = '1' then
                    state_next <= s_intra_PE_acc;
                else
                    state_next <= s_idle_writing;
                end if;
                is_stalling_tmp  <= '0'; -- Clock Gating Control
            when s_intra_PE_acc =>
                if (intra_s_reg = (RS_tmp - 1)) then
                    state_next <= s_inter_PE_acc;
                else
                    state_next <= s_intra_PE_acc;
                end if;
                is_stalling_tmp  <= '0'; -- Clock Gating Control
            when s_inter_PE_acc =>
                if (inter_cnt_done = '1') then
                    if (Y_ID = 1) then
                        state_next <= s_reset_acc;
                    else
                        state_next <= s_hold;
                    end if;
                else
                    state_next <= s_inter_PE_acc;
                end if;
                is_stalling_tmp  <= '0'; -- Clock Gating Control
            when s_hold =>
                if (hold_cnt_done = '1') then
                    if (j_cnt_done = '1') then
                        state_next <= s_stall;
                        is_stalling_tmp  <= '1'; -- Clock Gating Control
                    else
                        state_next <= s_intra_PE_acc;
                        is_stalling_tmp  <= '0'; -- Clock Gating Control
                    end if;
                else
                    state_next <= s_hold;
                    is_stalling_tmp  <= '0'; -- Clock Gating Control
                end if;
            when s_reset_acc =>
                if (j_cnt_done = '1') then
                    state_next <= s_stall;
                    is_stalling_tmp  <= '1'; -- Clock Gating Control
                else
                    state_next <= s_intra_PE_acc;
                    is_stalling_tmp  <= '0'; -- Clock Gating Control
                end if;
            when s_stall =>
                if (stall_cnt_done = '1') then
                    if (intra_cnt_done_reg = '1') then
                        state_next <= s_finished;
                    else
                        state_next <= s_intra_PE_acc;
                    end if;
                    is_stalling_tmp  <= '0'; -- Clock Gating Control
                else
                    state_next <= s_stall;
                    is_stalling_tmp  <= '1'; -- Clock Gating Control
                end if;
            when s_finished =>
                state_next <= s_idle_writing;
                is_stalling_tmp  <= '0'; -- Clock Gating Control
            when others =>
                state_next <= s_init;
                is_stalling_tmp  <= '0'; -- Clock Gating Control
        end case;
    end process;

    -- control path : input logic
    stall_cnt <= (EF_tmp - 1) - RS_tmp - RS_tmp + 1;

    -- control path : output logic
--    reset_acc_tmp    <= '1' when ((state_reg = s_reset_acc) or ((state_reg = s_inter_PE_acc) and (Y_ID /= 1))) else '0';
--    inter_PE_acc_tmp <= '1' when (state_reg = s_inter_PE_acc) else '0';
    -- ** Clock Gating **
--    is_stalling_tmp  <= '1' when state_reg = s_stall else '0';
    PISO_BUffer_start_tmp <= '1' when ((state_reg = s_reset_acc) and (Y_ID = 1) and (X_ID = 1)) else '0'; -- 040323
    reset_acc_tmp         <= '1' when ((state_reg = s_reset_acc) or (state_reg = s_init) or (state_reg = s_idle_writing) or ((state_reg = s_inter_PE_acc) and (Y_ID /= 1))) else '0';
    inter_PE_acc_tmp      <= '1' when ((state_reg = s_inter_PE_acc) or (state_reg = s_idle_writing) or (state_reg = s_init)) else '0';
    re_rf_tmp             <= '0' when state_reg = s_idle_writing else '1';

    ifm_addr_tmp <= ifm_addr_write_reg when state_reg = s_idle_writing else
        std_logic_vector(to_unsigned(ifm_addr_read_tmp, bit_size(NUM_REGS_IFM_REG_FILE_PKG))) when state_reg = s_intra_PE_acc else
        (others => '0');
    w_addr_tmp <= w_addr_write_reg when state_reg = s_idle_writing else
        std_logic_vector(to_unsigned(w_addr_read_tmp, bit_size(NUM_REGS_W_REG_FILE_PKG))) when state_reg = s_intra_PE_acc else
        (others => '0');

    -- data path : data registers
    data_reg : process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                ifm_addr_write_reg  <= (others => '0');
                w_addr_write_reg    <= (others => '0');
                intra_cnt_done_reg  <= '0';
                intra_s_reg         <= 0;
                intra_w_p_reg       <= 0;
                intra_p_reg         <= 0;
                ifm_addr_read_reg   <= 0;
                w_addr_read_reg     <= 0;
                inter_r_p_reg       <= 0;
                hold_cnt_reg        <= 0;
                stall_cnt_reg       <= 0;
                j_cnt_reg           <= 0;
            else
                ifm_addr_write_reg  <= ifm_addr_write_next;
                w_addr_write_reg    <= w_addr_write_next;
                intra_cnt_done_reg  <= intra_cnt_done_next;
                intra_s_reg         <= intra_s_next;
                intra_w_p_reg       <= intra_w_p_next;
                intra_p_reg         <= intra_p_next;
                ifm_addr_read_reg   <= ifm_addr_read_next;
                w_addr_read_reg     <= w_addr_read_next;
                inter_r_p_reg       <= inter_r_p_next;
                hold_cnt_reg        <= hold_cnt_next;
                stall_cnt_reg       <= stall_cnt_next;
                j_cnt_reg           <= j_cnt_next;
            end if;
        end if;
    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    -- Inner Intra NL -------------------------------------
    intra_s_out <= intra_s_reg + 1 when (intra_s_reg < (RS_tmp - 1)) else 0;

    intra_w_p_out_tmp <= intra_w_p_reg + 1 when (intra_w_p_reg < (HW_p_tmp - RS_tmp)) else 0;
    intra_w_p_out     <= intra_w_p_out_tmp when (intra_s_reg = (RS_tmp - 1)) else intra_w_p_reg;

    intra_p_out_tmp <= intra_p_reg + 1 when (intra_p_reg < (p_tmp - 1)) else 0;
    intra_p_out     <= intra_p_out_tmp when (intra_w_p_reg = (HW_p_tmp - RS_tmp) and (intra_s_reg = (RS_tmp - 1))) else intra_p_reg;
    -------------------------------------------------------

    -- Read Addr Ctrl Logic -------------------------------
    ifm_addr_read_tmp <= (ifm_addr_read_reg + intra_s_reg);
    w_addr_read_tmp   <= (w_addr_read_reg + intra_s_reg);

    w_addr_read_out_tmp <= (RS_tmp + w_addr_read_reg) when ((intra_w_p_reg = (HW_p_tmp - RS_tmp)) and (intra_s_reg = (RS_tmp - 1))) else w_addr_read_reg;
    w_addr_read_out     <= 0 when ((intra_p_reg = (p_tmp - 1)) and (intra_w_p_reg = (HW_p_tmp - RS_tmp)) and (intra_s_reg = (RS_tmp - 1))) else w_addr_read_out_tmp;

    ifm_addr_read_out_tmp <= (1 + ifm_addr_read_reg) when (intra_s_reg = (RS_tmp - 1)) else ifm_addr_read_reg;
    ifm_addr_read_out     <= 0 when (intra_w_p_reg = (HW_p_tmp - RS_tmp) and (intra_s_reg = (RS_tmp - 1))) else ifm_addr_read_out_tmp;
    -------------------------------------------------------

    -- Inner Inter Counter --------------------------------
    inter_r_p_out_1 <= inter_r_p_reg + 1 when (inter_r_p_reg < (RS_tmp - Y_ID - 1)) else 0;
    inter_r_p_out_2 <= inter_r_p_reg + 1 when (inter_r_p_reg < (RS_tmp - Y_ID)) else 0;

    with Y_ID select inter_r_p_out <=
        inter_r_p_out_1 when 1,
        inter_r_p_out_2 when others;
    -------------------------------------------------------

    -- Hold Counter ---------------------------------------
    hold_cnt_out <= hold_cnt_reg + 1 when (hold_cnt_reg < (Y_ID - 2)) else 0;
    -------------------------------------------------------

    -- Stall Counter --------------------------------------
    j_cnt_out_tmp <= j_cnt_reg + 1 when ((inter_cnt_done ='1') and (state_reg = s_inter_PE_acc)) else j_cnt_reg;
    j_cnt_out <= j_cnt_out_tmp when (j_cnt_reg < (r_tmp)) else j_cnt_reg;

    stall_cnt_out <= stall_cnt_reg + 1 when (stall_cnt_reg < stall_cnt) else 0;
    -------------------------------------------------------

    -- data path : status (inputs to control path to modify next state logic)
    intra_cnt_done_next <= '1' when ((intra_s_reg = (RS_tmp - 1)) and (intra_w_p_reg = (HW_p_tmp - RS_tmp)) and (intra_p_reg = (p_tmp - 1))) else
                           '0' when state_reg = s_finished else
                           intra_cnt_done_reg;

    inter_cnt_done_tmp_1 <= '1' when (inter_r_p_reg = (RS_tmp - Y_ID - 1)) else '0';
    inter_cnt_done_tmp_2 <= '1' when (inter_r_p_reg = (RS_tmp - Y_ID)) else '0';

    with Y_ID select inter_cnt_done <=
        inter_cnt_done_tmp_1 when 1,
        inter_cnt_done_tmp_2 when others;

    hold_cnt_done <= '1' when (hold_cnt_reg = (Y_ID - 2)) else '0';

    j_cnt_done_tmp_1 <= '1' when ((j_cnt_reg = (r_tmp)) and (state_reg = s_reset_acc)) else '0';
    j_cnt_done_tmp_2 <= '1' when ((j_cnt_reg = (r_tmp)) and (state_reg = s_hold)) else '0';

    with Y_ID select j_cnt_done <=
        j_cnt_done_tmp_1 when 1,
        j_cnt_done_tmp_2 when others;

    stall_cnt_done <= '1' when (stall_cnt_reg = stall_cnt) else '0';

    -- data path : mux routing and logic
    data_mux : process (state_reg, pass_flag_tmp, PE_ARRAY_RF_write_start_tmp, ifm_PE_enable_tmp, w_PE_enable_tmp, w_addr_write_reg, ifm_addr_write_reg, intra_s_reg, intra_w_p_reg, intra_p_reg, intra_s_out, intra_w_p_out, intra_p_out, w_addr_read_reg, ifm_addr_read_reg, w_addr_read_out, ifm_addr_read_out, inter_r_p_reg, inter_r_p_out, hold_cnt_reg, hold_cnt_out, stall_cnt_reg, stall_cnt_out, j_cnt_reg, j_cnt_out)
    begin
        case state_reg is
            when s_init =>

                ifm_addr_write_next <= (others => '0');
                w_addr_write_next   <= (others => '0');
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= 0;
                intra_w_p_next     <= 0;
                intra_p_next       <= 0;
                w_addr_read_next   <= 0;
                ifm_addr_read_next <= 0;

                inter_r_p_next <= 0;

                hold_cnt_next <= 0;

                j_cnt_next <= 0;

                stall_cnt_next <= 0;

            when s_idle_writing =>

                ifm_we_rf_tmp <= '0';
                w_we_rf_tmp   <= '0';
                if (pass_flag_tmp = '0') then
                    if (PE_ARRAY_RF_write_start_tmp = '1') then
                        if (ifm_PE_enable_tmp = '1') then
                            ifm_addr_write_next <= std_logic_vector(unsigned(ifm_addr_write_reg) + 1);
                            ifm_we_rf_tmp       <= '1';
                        else
                            ifm_addr_write_next <= ifm_addr_write_reg;
                        end if;
                        if (w_PE_enable_tmp = '1') then
                            w_addr_write_next <= std_logic_vector(unsigned(w_addr_write_reg) + 1);
                            w_we_rf_tmp       <= '1';
                        else
                            w_addr_write_next <= w_addr_write_reg;
                        end if;
                    else
                        ifm_addr_write_next <= ifm_addr_write_reg;
                        w_addr_write_next   <= w_addr_write_reg;
                    end if;
                else
                    ifm_addr_write_next <= (others => '0');
                    w_addr_write_next   <= (others => '0');
                end if;

                intra_s_next       <= intra_s_reg;
                intra_w_p_next     <= intra_w_p_reg;
                intra_p_next       <= intra_p_reg;
                w_addr_read_next   <= w_addr_read_reg;
                ifm_addr_read_next <= ifm_addr_read_reg;

                inter_r_p_next <= inter_r_p_reg;

                hold_cnt_next <= hold_cnt_reg;

                j_cnt_next <= 0;

                stall_cnt_next <= stall_cnt_reg;

            when s_intra_PE_acc =>

                ifm_addr_write_next <= ifm_addr_write_reg;
                w_addr_write_next   <= w_addr_write_reg;
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= intra_s_out;
                intra_w_p_next     <= intra_w_p_out;
                intra_p_next       <= intra_p_out;
                w_addr_read_next   <= w_addr_read_out;
                ifm_addr_read_next <= ifm_addr_read_out;

                inter_r_p_next <= inter_r_p_reg;

                hold_cnt_next <= hold_cnt_reg;

                j_cnt_next <= j_cnt_reg;

                stall_cnt_next <= stall_cnt_reg;

            when s_inter_PE_acc =>

                ifm_addr_write_next <= ifm_addr_write_reg;
                w_addr_write_next   <= w_addr_write_reg;
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= intra_s_reg;
                intra_w_p_next     <= intra_w_p_reg;
                intra_p_next       <= intra_p_reg;
                w_addr_read_next   <= w_addr_read_reg;
                ifm_addr_read_next <= ifm_addr_read_reg;

                inter_r_p_next <= inter_r_p_out;

                hold_cnt_next <= hold_cnt_reg;

                j_cnt_next <= j_cnt_out;

                stall_cnt_next <= stall_cnt_reg;

            when s_hold =>

                ifm_addr_write_next <= ifm_addr_write_reg;
                w_addr_write_next   <= w_addr_write_reg;
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= intra_s_reg;
                intra_w_p_next     <= intra_w_p_reg;
                intra_p_next       <= intra_p_reg;
                w_addr_read_next   <= w_addr_read_reg;
                ifm_addr_read_next <= ifm_addr_read_reg;

                inter_r_p_next <= inter_r_p_reg;

                hold_cnt_next <= hold_cnt_out;

                j_cnt_next <= j_cnt_reg;

                stall_cnt_next <= stall_cnt_reg;

            when s_reset_acc =>

                ifm_addr_write_next <= ifm_addr_write_reg;
                w_addr_write_next   <= w_addr_write_reg;
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= intra_s_reg;
                intra_w_p_next     <= intra_w_p_reg;
                intra_p_next       <= intra_p_reg;
                w_addr_read_next   <= w_addr_read_reg;
                ifm_addr_read_next <= ifm_addr_read_reg;

                inter_r_p_next <= inter_r_p_reg;

                hold_cnt_next <= hold_cnt_reg;

                j_cnt_next <= j_cnt_reg;

                stall_cnt_next <= stall_cnt_reg;

            when s_stall =>

                ifm_addr_write_next <= ifm_addr_write_reg;
                w_addr_write_next   <= w_addr_write_reg;
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= intra_s_reg;
                intra_w_p_next     <= intra_w_p_reg;
                intra_p_next       <= intra_p_reg;
                w_addr_read_next   <= w_addr_read_reg;
                ifm_addr_read_next <= ifm_addr_read_reg;

                inter_r_p_next <= inter_r_p_reg;

                hold_cnt_next <= hold_cnt_reg;

                j_cnt_next <= j_cnt_reg;

                stall_cnt_next <= stall_cnt_out;

            when s_finished =>

                ifm_addr_write_next <= (others => '0');
                w_addr_write_next   <= (others => '0');
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= 0;
                intra_w_p_next     <= 0;
                intra_p_next       <= 0;
                w_addr_read_next   <= 0;
                ifm_addr_read_next <= 0;

                inter_r_p_next <= 0;

                hold_cnt_next <= 0;

                j_cnt_next <= 0;

                stall_cnt_next <= 0;

            when others =>

                ifm_addr_write_next <= ifm_addr_write_reg;
                w_addr_write_next   <= w_addr_write_reg;
                ifm_we_rf_tmp       <= '0';
                w_we_rf_tmp         <= '0';

                intra_s_next       <= intra_s_reg;
                intra_w_p_next     <= intra_w_p_reg;
                intra_p_next       <= intra_p_reg;
                w_addr_read_next   <= w_addr_read_reg;
                ifm_addr_read_next <= ifm_addr_read_reg;

                inter_r_p_next <= inter_r_p_reg;

                hold_cnt_next <= hold_cnt_reg;

                j_cnt_next <= j_cnt_reg;

                stall_cnt_next <= stall_cnt_reg;

        end case;
    end process;

    -- PORT Assignations
    ifm_addr                    <= ifm_addr_tmp;
    w_addr                      <= w_addr_tmp;
    ifm_we_rf                   <= ifm_we_rf_tmp;
    w_we_rf                     <= w_we_rf_tmp;
    ifm_PE_enable_tmp           <= ifm_PE_enable;
    w_PE_enable_tmp             <= w_PE_enable;
    PE_ARRAY_RF_write_start_tmp <= PE_ARRAY_RF_write_start;
    pass_flag_tmp               <= pass_flag;
    HW_p_tmp                    <= to_integer(unsigned(HW_p));
    EF_tmp                      <= to_integer(unsigned(EF));
    RS_tmp                      <= to_integer(unsigned(RS));
    p_tmp                       <= to_integer(unsigned(p));
    r_tmp                       <= to_integer(unsigned(r));
    inter_PE_acc                <= inter_PE_acc_delay(inter_PE_acc_delay'high);
    reset_acc                   <= reset_acc_delay(reset_acc_delay'high);
    re_rf                       <= re_rf_tmp;
    is_stalling                 <= is_stalling_tmp;
    PISO_Buffer_start           <= PISO_Buffer_start_delay(PISO_Buffer_start_delay'high); -- 040323

    -- Other Logic
    -- Introduces 2cc delay to the PE control signals, to synchronize them w.r.t. RFs read latency.
    process (clk, reset) is
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                inter_PE_acc_delay      <= (others => '0');
                reset_acc_delay         <= (others => '0');
                PISO_BUffer_start_delay <= (others => '0');
            else
                inter_PE_acc_delay      <= inter_PE_acc_tmp & inter_PE_acc_delay(0 to inter_PE_acc_delay'high - 1); -- Shift right
                reset_acc_delay         <= reset_acc_tmp & reset_acc_delay(0 to reset_acc_delay'high - 1); -- Shift right
                PISO_Buffer_start_delay <= PISO_Buffer_start_tmp & PISO_Buffer_start_delay(0 to PISO_Buffer_start_delay'high - 1); -- Shift right 040323
            end if;
        end if;
    end process;

end architecture;
