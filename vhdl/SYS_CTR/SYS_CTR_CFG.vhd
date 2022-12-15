library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.thesis_pkg.all;

entity SYS_CTR_CFG is
    port (
        clk          : in std_logic;
        reset        : in std_logic;
        CFG_start    : in std_logic;
        CFG_finished : out std_logic;
        cfg          : in std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        L            : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        M_cap        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        C_cap        : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        HW           : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        HW_p         : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        RS           : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF           : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r            : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        p            : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        M_div_pt     : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        EF_log2      : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        r_log2       : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0);
        is_pooling   : out std_logic_vector ((HYP_BITWIDTH - 1) downto 0)
    );
end entity;

architecture behavioral of SYS_CTR_CFG is

    signal L_tmp            : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(0): # of layers of the network (only conv.)
    signal M_cap_tmp        : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(1): # of output channels
    signal C_cap_tmp        : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(2): # of input channels
    signal HW_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(3): Height/Width of the 2D ifmap (before padding)
    signal HW_p_tmp         : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(4): Height/Width of the 2D ifmap (after padding)
    signal RS_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(5): Height/Width of the 2D weight
    signal EF_tmp           : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(6): Height/Width of the 2D ofmap
    signal r_tmp            : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(7): # of PE Sets that process different input channels in the PE array
    signal p_tmp            : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(8): # of weight channels processed by a PE Set (temporal mapping)
    signal M_div_pt_tmp     : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(9): (M/p*t)
    signal EF_log2_tmp      : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(10)
    signal r_log2_tmp       : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(11)
    signal is_pooling_tmp   : std_logic_vector ((HYP_BITWIDTH - 1) downto 0); -- buffer(12): '1' if there is pooling after convolution, '0' if there is not

    signal cfg_buffer_next, cfg_buffer_reg     : hyp_array((NUM_OF_PARAMS_PKG - 1) downto 0);
    signal CFG_start_reg, CFG_start_next       : std_logic;
    signal CFG_finished_tmp                    : std_logic;
    signal cfg_cnt_reg, cfg_cnt_next           : natural range 0 to NUM_OF_PARAMS_PKG;
    signal lock_layer_reg, lock_layer_next     : std_logic;
    signal cfg_layer_reg, cfg_layer_next       : std_logic_vector ((HYP_BITWIDTH - 1) downto 0);


begin

    process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                cfg_buffer_reg   <= (others => (others => '0'));
                CFG_start_reg    <= '0';
                lock_layer_reg   <= '0';
                cfg_layer_reg    <= (others => '0');
                cfg_cnt_reg      <= 0;
            else
                cfg_buffer_reg   <= cfg_buffer_next;
                CFG_start_reg    <= CFG_start_next; -- cfg_start delayed 1clk to synchronise it with sram_wb 1clk read latency
                lock_layer_reg   <= lock_layer_next;
                cfg_layer_reg    <= cfg_layer_next;
                cfg_cnt_reg      <= cfg_cnt_next;
            end if;
        end if;
    end process;
    
    p_buff_cfg : process (cfg, CFG_start_reg, cfg_buffer_reg, cfg_cnt_reg, lock_layer_reg, CFG_start)
    begin
        if CFG_start_reg = '1' then
            if (cfg_cnt_reg = 0) then
                if (CFG_start = '1') then
		        cfg_buffer_next((NUM_OF_PARAMS_PKG - 1) downto 1) <= cfg & cfg_buffer_reg((NUM_OF_PARAMS_PKG - 1) downto 2);
		        cfg_cnt_next                 <= cfg_cnt_reg + 1;
		else
		        cfg_buffer_next((NUM_OF_PARAMS_PKG - 1) downto 1) <= cfg_buffer_reg((NUM_OF_PARAMS_PKG - 1) downto 1);
		        cfg_cnt_next                 <= cfg_cnt_reg;
		end if;
	        cfg_buffer_next(0)           <= cfg; -- first cfg. parameter arriving is # of layers, stays unchanged on buff_reg(0).
	        CFG_finished_tmp             <= '0';
	        lock_layer_next              <= lock_layer_reg;

            elsif (cfg_cnt_reg <= NUM_OF_PARAMS_PKG) then
                cfg_buffer_next(0)           <= cfg_buffer_reg(0);

                if (cfg_cnt_reg = NUM_OF_PARAMS_PKG) then
                    cfg_buffer_next((NUM_OF_PARAMS_PKG - 1) downto 1) <= cfg_buffer_reg((NUM_OF_PARAMS_PKG - 1) downto 1);
                    cfg_cnt_next                 <= 1;
                else
                    cfg_buffer_next((NUM_OF_PARAMS_PKG - 1) downto 1) <= cfg & cfg_buffer_reg((NUM_OF_PARAMS_PKG - 1) downto 2);
                    cfg_cnt_next                 <= cfg_cnt_reg + 1;
                end if;

                if (cfg_cnt_reg = (NUM_OF_PARAMS_PKG - 2)) then
                    CFG_finished_tmp <= '1';
                else
                    CFG_finished_tmp <= '0';
                end if;

                lock_layer_next              <= '1';

            else
                cfg_buffer_next(0)           <= cfg_buffer_reg(0);
                cfg_buffer_next((NUM_OF_PARAMS_PKG - 1) downto 1) <= cfg_buffer_reg((NUM_OF_PARAMS_PKG - 1) downto 1);
                cfg_cnt_next                 <=  0 ;
                CFG_finished_tmp             <= '0';
                lock_layer_next              <= '1';
            end if;

        else
            cfg_buffer_next(0)           <= cfg_buffer_reg(0);
            cfg_buffer_next((NUM_OF_PARAMS_PKG - 1) downto 1) <= cfg_buffer_reg((NUM_OF_PARAMS_PKG - 1) downto 1);
            if (cfg_cnt_reg = NUM_OF_PARAMS_PKG) then
	        cfg_cnt_next                 <= 1;
            else
                cfg_cnt_next                 <= cfg_cnt_reg;
            end if;
            CFG_finished_tmp             <= '0';
            lock_layer_next              <= lock_layer_reg;
        end if;

    end process;

    -- Lock value of # of layers since it's only read once
    cfg_layer_next <= cfg_buffer_reg(0) when lock_layer_reg = '0' else
                      cfg_layer_reg;

    L_tmp          <= cfg_layer_reg;
    M_cap_tmp      <= cfg_buffer_reg(1);
    C_cap_tmp      <= cfg_buffer_reg(2);
    HW_tmp         <= cfg_buffer_reg(3);
    HW_p_tmp       <= cfg_buffer_reg(4);
    RS_tmp         <= cfg_buffer_reg(5);
    EF_tmp         <= cfg_buffer_reg(6);
    r_tmp          <= cfg_buffer_reg(7);
    p_tmp          <= cfg_buffer_reg(8);
    M_div_pt_tmp   <= cfg_buffer_reg(9);
    EF_log2_tmp    <= cfg_buffer_reg(10);
    r_log2_tmp     <= cfg_buffer_reg(11);
    is_pooling_tmp <= cfg_buffer_reg(12);

    -- PORT ASSIGNATIONS
    CFG_start_next <= CFG_start;
    CFG_finished   <= CFG_finished_tmp;

    L          <= L_tmp;          
    M_cap      <= M_cap_tmp;      
    C_cap      <= C_cap_tmp;      
    HW         <= HW_tmp;         
    HW_p       <= HW_p_tmp;       
    RS         <= RS_tmp;         
    EF         <= EF_tmp;         
    r          <= r_tmp;          
    p          <= p_tmp;          
    M_div_pt   <= M_div_pt_tmp;   
    EF_log2    <= EF_log2_tmp;    
    r_log2     <= r_log2_tmp;     
    is_pooling <= is_pooling_tmp;

end architecture;
