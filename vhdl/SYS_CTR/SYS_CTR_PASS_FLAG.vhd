-------------------------------------------------------------------------------------------------------
-- Project        : Memory Efficient Hardware Accelerator for CNN Inference & Training
-- Program        : Master's Thesis in Embedded Electronics Engineering (EEE)
-------------------------------------------------------------------------------------------------------
-- File           : SYS_CTR_PASS_FLAG.vhd
-- Author         : Sergio Castillo Mohedano
-- University     : Lund University
-- Department     : Electrical and Information Technology (EIT)
-- Created        : 2022-05-31
-- Standard       : VHDL-2008
-------------------------------------------------------------------------------------------------------
-- Description    : This block generates a flag that acknowledges the controller that the necessary
--                  parameters to compute a pass have been already handled by the system controller,
--                  meaning that the PE Array is full and cannot allocate more values. At this point,
--                  before continuing, the count holds until the next pass, and computation takes
--                  place.
-------------------------------------------------------------------------------------------------------
-- Input Signals  :
--         * clk: clock
--         * reset: synchronous, active high.
--         * CFG_finished: flag that tells this block that the controller has started the count of the
--       Nested Loops, it triggers the FSM within this block. Active high.
--         * layer_finished: flag indicating end of processing. Evaluated within s_flag state in order to
--       go to s_idle state. Active high.
--         * r: hyperparameter of the Network. Indicates the number of PE Sets that process different
--       input channels within the PE Array.
--         * M_div_pt: parameter that indicates how many passes can the ifmaps be reutilized
--       within the PE Array before having to update them again.
--         * WB_NL_finished: flag indicating that the Nested Loop of the weights/biases has finished.
--         * IFM_NL_finished: flag indicating that the Nested Loop of the ifmaps has finished.
-- Output Signals :
--         * pass_flag: flag that acknowledges the controller that the necessary parameters to
--       compute a pass have been already handled by the system controller, meaning that the
--       PE Array is full and cannot allocate more values.
-------------------------------------------------------------------------------------------------------
-- Revisions      : NA (Git Control)
-------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SYS_CTR_PASS_FLAG is
    port (
        clk : in std_logic;
        reset : in std_logic;
        CFG_finished : in std_logic;
        layer_finished : in std_logic;
        r : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        M_div_pt : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        WB_NL_finished : in std_logic;
        IFM_NL_finished : in std_logic;
        pass_flag : out std_logic
         );
end SYS_CTR_PASS_FLAG;

architecture behavioral of SYS_CTR_PASS_FLAG is

    -- Enumeration type for the states and state_type signals
    type state_type is (s_init, s_idle, s_cnt_1, s_cnt_2, s_flag);
    signal state_next, state_reg: state_type;

    -- ************** FSMD SIGNALS **************
    ------------ CONTROL PATH SIGNALS ------------
    -------- INPUTS --------
    ---- Internal Status Signals from the Data Path
    signal WB_NL_cnt_reg, WB_NL_cnt_next : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);          -- counts iterations of the weights NL.
    signal IFM_NL_cnt_reg, IFM_NL_cnt_next : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);        -- counts iterations of the ifmaps NL.
    signal IFM_pass_cnt_reg, IFM_pass_cnt_next : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);    -- counts how many passes are left until ifmaps NL is triggered again.
    signal IFM_flag_reg, IFM_flag_next : std_logic;                         -- indicates ifmaps NL has run enough times to fill up PE Array entirely.
 
    ---- External Command Signals to the FSMD
    signal CFG_finished_tmp : std_logic;
    signal layer_finished_tmp : std_logic;

    -------- OUTPUTS --------
    ---- Internal Control Signals used to control Data Path Operation
    -- ..

    ---- External Status Signals to indicate status of the FSMD
    -- signal pass_cnt_ready_tmp : std_logic;

    ------------ DATA PATH SIGNALS ------------
    ---- Data Registers Signals
    -- ..

    ---- External Control Signals used to control Data Path Operation
    signal WB_NL_finished_tmp : std_logic;
    signal IFM_NL_finished_tmp : std_logic;
    signal M_div_pt_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    signal r_tmp : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    ---- Functional Units Intermediate Signals
    -- ..
    -- ******************************************

    ---------------- Data Outputs ----------------
    signal pass_flag_tmp : std_logic;

begin

    -- control path : registers
    asmd_reg : process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- state register
                state_reg <= s_init;
                -- control signals registers
                WB_NL_cnt_reg <= 0;
                IFM_NL_cnt_reg <= 0;
                IFM_pass_cnt_reg <= 0;
                IFM_flag_reg <= '0';
            else
                -- state register
                state_reg <= state_next;
                -- control signals registers
                WB_NL_cnt_reg <= WB_NL_cnt_next;
                IFM_NL_cnt_reg <= IFM_NL_cnt_next;
                IFM_pass_cnt_reg <= IFM_pass_cnt_next;
                IFM_flag_reg <= IFM_flag_next;
            end if;
        end if;
    end process;

    -- control path : next state logic
    asmd_ctrl : process(state_reg, CFG_finished_tmp , WB_NL_cnt_reg, IFM_NL_cnt_reg, IFM_pass_cnt_reg, layer_finished_tmp , r_tmp , M_div_pt_tmp , IFM_flag_reg)
    begin
        case state_reg is
            when s_init =>
                state_next <= s_idle;
            when s_idle =>
                if CFG_finished_tmp = '1' then
                    state_next <= s_cnt_1;
                else
                    state_next <= s_idle;
                end if;
            when s_cnt_1 =>
                if (layer_finished_tmp = '1') then
                    state_next <= s_idle;
                else
                    if ((WB_NL_cnt_reg < r_tmp ) OR (IFM_NL_cnt_reg < r_tmp )) then
                        state_next <= s_cnt_1;
                    else
                        state_next <= s_flag;
                    end if;
                end if;
            when s_cnt_2 =>
                if (M_div_pt_tmp < 2) then
                    state_next <= s_cnt_1;
                else
                    if (WB_NL_cnt_reg < r_tmp ) then
                        state_next <= s_cnt_2;
                    else
                        state_next <= s_flag;
                    end if;
                end if;
            when s_flag =>
--                if (layer_finished_tmp = '1') then
--                    state_next <= s_idle;
--                else
                    if (IFM_flag_reg = '0') then
                        state_next <= s_cnt_2;
                    else
                        state_next <= s_cnt_1;
                    end if;
--                end if;
            when others =>
                state_next <= s_init;
        end case;
    end process;

    -- control path : output logic
    -- pass_cnt_ready_tmp <= '1' when state_reg = s_idle else '0';
    pass_flag_tmp <= '1' when state_reg = s_flag else '0';

    -- data path : data registers
--    data_reg : process(clk, reset)
--    begin
--        if rising_edge(clk) then
--            if reset = '1' then
--                else
--            end if;
--        end if;
--    end process;

    -- data path : functional units (perform necessary arithmetic operations)
    -- ..

    -- data path : status (inputs to control path to modify next state logic)
    -- ..

    -- data path : mux routing
    data_mux : process(state_reg, WB_NL_finished_tmp , IFM_NL_finished_tmp , WB_NL_cnt_reg, IFM_NL_cnt_reg, IFM_pass_cnt_reg, r_tmp , M_div_pt_tmp , IFM_flag_reg)

    variable WB_NL_cnt_var : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);
    variable IFM_NL_cnt_var : natural range 0 to ((2 ** HYP_BITWIDTH) - 1);

    begin
        case state_reg is
            when s_init =>
                WB_NL_cnt_next <= WB_NL_cnt_reg;
                IFM_NL_cnt_next <= IFM_NL_cnt_reg;
                IFM_pass_cnt_next <= IFM_pass_cnt_reg;
                IFM_flag_next <= IFM_flag_reg;
            when s_idle =>
                WB_NL_cnt_next <= WB_NL_cnt_reg;
                IFM_NL_cnt_next <= IFM_NL_cnt_reg;
                IFM_pass_cnt_next <= IFM_pass_cnt_reg;
                IFM_flag_next <= IFM_flag_reg;
            when s_cnt_1 =>
                if (WB_NL_finished_tmp = '1') then
                    WB_NL_cnt_var := WB_NL_cnt_reg + 1;
                else
                    WB_NL_cnt_var := WB_NL_cnt_reg;
                end if;

                if (IFM_NL_finished_tmp = '1') then
                    IFM_NL_cnt_var := IFM_NL_cnt_reg + 1;
                else
                    IFM_NL_cnt_var := IFM_NL_cnt_reg;
                end if;

                if ((WB_NL_cnt_reg < r_tmp ) OR (IFM_NL_cnt_reg < r_tmp )) then
                    WB_NL_cnt_next <= WB_NL_cnt_var;
                    IFM_NL_cnt_next <= IFM_NL_cnt_var;
                else
                    WB_NL_cnt_next <= 0;
                    IFM_NL_cnt_next <= 0;
                end if;

                IFM_pass_cnt_next <= IFM_pass_cnt_reg;
                IFM_flag_next <= '0';


            when s_cnt_2 =>
                if (WB_NL_finished_tmp = '1') then
                    WB_NL_cnt_var := WB_NL_cnt_reg + 1;
                else
                    WB_NL_cnt_var := WB_NL_cnt_reg;
                end if;

                if (M_div_pt_tmp < 2) then
                    IFM_flag_next <= '1';
                    IFM_pass_cnt_next <= IFM_pass_cnt_reg;
                    WB_NL_cnt_next <= WB_NL_cnt_reg;
                else
                    if (WB_NL_cnt_reg < r_tmp ) then
                        WB_NL_cnt_next <= WB_NL_cnt_var;
                        IFM_flag_next <= '0';
                        IFM_pass_cnt_next <= IFM_pass_cnt_reg;
                    else
                        WB_NL_cnt_next <= 0;
                        if (IFM_pass_cnt_reg < M_div_pt_tmp - 1 - 1) then
                            IFM_flag_next <= '0';
                            IFM_pass_cnt_next <= IFM_pass_cnt_reg + 1;
                        else
                            IFM_flag_next <= '1';
                            IFM_pass_cnt_next <= 0;
                        end if;
                    end if;
                end if;

                IFM_NL_cnt_next <= IFM_NL_cnt_reg;

            when s_flag =>
                WB_NL_cnt_next <= WB_NL_cnt_reg;
                IFM_NL_cnt_next <= IFM_NL_cnt_reg;
                IFM_pass_cnt_next <= IFM_pass_cnt_reg;
                IFM_flag_next <= IFM_flag_reg;

            when others =>
                WB_NL_cnt_next <= WB_NL_cnt_reg;
                IFM_NL_cnt_next <= IFM_NL_cnt_reg;
                IFM_pass_cnt_next <= IFM_pass_cnt_reg;
                IFM_flag_next <= IFM_flag_reg;

        end case;
    end process;

    -- PORT Assignations
    CFG_finished_tmp <= CFG_finished;
    layer_finished_tmp <= layer_finished;
    r_tmp <= to_integer(unsigned(r));
    M_div_pt_tmp <= to_integer(unsigned(M_div_pt));
    WB_NL_finished_tmp <= WB_NL_finished;
    IFM_NL_finished_tmp <= IFM_NL_finished;
    pass_flag <= pass_flag_tmp ;

end architecture;
