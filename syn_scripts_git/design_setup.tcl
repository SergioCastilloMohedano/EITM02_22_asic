puts "\n\n\n design_setup.tcl \n\n\n"

set DESIGN TOP_LU_PADS

set RTL "/home/radiocad/se5616ca-s/thesis/WORK/EITM02_22_asic"

set_attribute script_search_path $SYNT_SCRIPT /

set_attribute init_hdl_search_path $RTL /

set_attribute init_lib_search_path { \
/usr/hidden/cmp/s28v15a/C28SOI_SC_8_CLK_LL/5.3-08.81/libs \
/usr/hidden/cmp/s28v15a/C28SOI_SC_8_CORE_LL/5.1-11.81/libs \
/usr/hidden/cmp/mem2016.s28/SPHD_HIPERF_160523__146640/3.3.a-00@20160524.0/libs \
/usr/hidden/cmp/mem2016.s28/DPHD_HIPERF_160523__146639/2.3.a-00@20160524.0/libs \
/usr/hidden/cmp/mem2015.s28/SPHD_HIPERF_151009__141457/3.2-00@20151009.0/libs \
/home/radiocad/se5616ca-s/thesis/LU_PADS_DIG_2020 \
} /

#SPHD_HIPERF_160523 -> 8Kx32 SP
#DPHD_HIPERF_160523 -> 2Kx32 DP
#SPHD_HIPERF_151009 -> 4Kx32 SP

###############################################################
## Library setup
###############################################################

set_attribute library { \
C28SOI_SC_8_CLK_LL_tt28_1.00V_0.00V_0.00V_0.00V_25C.lib \
C28SOI_SC_8_CORE_LL_tt28_1.00V_0.00V_0.00V_0.00V_25C.lib \
SPHD_HIPERF_160523_tt28_1.00V_25C_RCTYP.lib \
DPHD_HIPERF_160523_tt28_1.00V_25C_RCTYP.lib \
SPHD_HIPERF_151009_tt28_1.00V_25C_RCTYP.lib \
LU_PADS.lib \
} /

set_attribute lef_library { \
/usr/hidden/cmp/s28v15a/Foundation_Cadence_TechnoKit_cmos028FDSOI_6U1x_2T8x_LB/3.4-02/LEF/technology.lef \
/usr/hidden/cmp/s28v15a/Foundation_Cadence_TechnoKit_cmos028FDSOI_6U1x_2T8x_LB/3.4-02/LEF/viarule_generate.lef \
/usr/hidden/cmp/s28v15a/Foundation_Cadence_TechnoKit_cmos028FDSOI_6U1x_2T8x_LB/3.4-02/LEF/sites.lef \
/usr/hidden/cmp/s28v15a/Foundation_Cadence_TechnoKit_cmos028FDSOI_6U1x_2T8x_LB/3.4-02/LEF/lib_property.lef \
/usr/hidden/cmp/s28v15a/C28SOI_SC_8_CLK_LL/5.3-08.81/CADENCE/LEF/C28SOI_SC_8_CLK_LL_soc.lef \
/usr/hidden/cmp/s28v15a/C28SOI_SC_8_CORE_LL/5.1-11.81/CADENCE/LEF/C28SOI_SC_8_CORE_LL_soc.lef \
/usr/hidden/cmp/s28v15a/C28SOI_SC_8_PR_LL/5.4-00.80/CADENCE/LEF/C28SOI_SC_8_PR_LL_soc.lef \
/usr/hidden/cmp/mem2016.s28/SPHD_HIPERF_160523__146640/3.3.a-00@20160524.0/CADENCE/LEF/SPHD_HIPERF_160523_soc.lef \
/usr/hidden/cmp/mem2016.s28/DPHD_HIPERF_160523__146639/2.3.a-00@20160524.0/CADENCE/LEF/DPHD_HIPERF_160523_soc.lef \
/usr/hidden/cmp/mem2015.s28/SPHD_HIPERF_151009__141457/3.2-00@20151009.0/CADENCE/LEF/SPHD_HIPERF_151009_soc.lef \
/home/radiocad/se5616ca-s/thesis/LU_PADS_DIG_2020/LU_PADS.lef \
} /

# put all your design files here
set Design_Files_VHDL "${RTL}/vhdl/PKG/THESIS_PKG.vhd \
                       ${RTL}/vhdl/TOP_LU_PADS.vhd \
                       ${RTL}/vhdl/TOP.vhd \
                       ${RTL}/vhdl/SYS_CTR/SYS_CTR_TOP.vhd \
                       ${RTL}/vhdl/SYS_CTR/SYS_CTR_MAIN_NL.vhd \
                       ${RTL}/vhdl/SYS_CTR/SYS_CTR_WB_NL.vhd \
                       ${RTL}/vhdl/SYS_CTR/SYS_CTR_IFM_NL.vhd \
                       ${RTL}/vhdl/SYS_CTR/SYS_CTR_OFM_NL.vhd \
                       ${RTL}/vhdl/SYS_CTR/SYS_CTR_PASS_FLAG.vhd \
                       ${RTL}/vhdl/SYS_CTR/SYS_CTR_CFG.vhd \
                       ${RTL}/vhdl/NOC/NOC.vhd \
                       ${RTL}/vhdl/NOC/MC_rr.vhd \
                       ${RTL}/vhdl/NOC/MC_X.vhd \
                       ${RTL}/vhdl/NOC/MC_Y.vhd \
                       ${RTL}/vhdl/NOC/PE/PE.vhd \
                       ${RTL}/vhdl/NOC/PE/PE_CTR.vhd \
                       ${RTL}/vhdl/NOC/PE/REG_FILE_ACT.vhd \
                       ${RTL}/vhdl/NOC/PE/REG_FILE_WEIGHT.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_IFM/SRAM_IFM.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_IFM/SRAM_IFM_FRONT_END_READ.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_IFM/SRAM_IFM_FRONT_END_WRITE.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_IFM/SRAM_IFM_BACK_END.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_WB/SRAM_WB.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_WB/SRAM_WB_FRONT_END_READ.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_WB/SRAM_WB_BACK_END.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_WB/SRAM_WB_WRAPPER_BLOCK.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_OFM/SRAM_OFM.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_OFM/SRAM_OFM_FRONT_END_ACC.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_OFM/SRAM_OFM_FRONT_END_OUT.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_OFM/SRAM_OFM_BACK_END.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_OFM/SRAM_OFM_WRAPPER_BLOCK.vhd \
                       ${RTL}/vhdl/SRAM/SRAM_OFM/SRAM_OFM_ROUTER.vhd \
                       ${RTL}/vhdl/ADDER_TREE/ADDER_TREE_TOP.vhd \
                       ${RTL}/vhdl/ADDER_TREE/ADDER_TREE.vhd \
                       ${RTL}/vhdl/ADDER_TREE/PISO_BUFFER_TOP.vhd \
                       ${RTL}/vhdl/ADDER_TREE/PISO_BUFFER.vhd \
                       ${RTL}/vhdl/ADDER_TREE/PISO_BUFFER_CTR.vhd \
                       ${RTL}/vhdl/RN_RELU/RN_RELU.vhd \
                       ${RTL}/vhdl/POOLING/POOLING_TOP.vhd \
                       ${RTL}/vhdl/POOLING/POOLING_CTR.vhd \
                       ${RTL}/vhdl/POOLING/POOLING.vhd"

set Design_Files_verilog "${RTL}/verilog/SRAM/SPHD_HIPERF_160523_8192x32/SPHD_HIPERF_160523_wrapper_syn.v \
                          ${RTL}/verilog/SRAM/DPHD_HIPERF_160523_2048x32/DPHD_HIPERF_160523_wrapper.v \
                          ${RTL}/verilog/SRAM/SPHD_HIPERF_151009_4096x32/SPHD_HIPERF_151009_wrapper.v"

# Missing TOP_Pads files!!!!


set SYN_EFF medium
set MAP_EFF medium
set OPT_EFF medium 


set_attribute syn_generic_effort ${SYN_EFF};

set_attribute syn_map_effort ${MAP_EFF};

set_attribute syn_opt_effort ${OPT_EFF};

set_attribute information_level 6


