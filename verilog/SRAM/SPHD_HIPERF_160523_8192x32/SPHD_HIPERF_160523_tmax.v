//  
//  
//  ------------------------------------------------------------
//    STMicroelectronics N.V. 2016
//   All rights reserved. Reproduction in whole or part is prohibited  without the written consent of the copyright holder.                                                                                                                                                                                                                                                                                                                           
//    STMicroelectronics RESERVES THE RIGHTS TO MAKE CHANGES WITHOUT  NOTICE AT ANY TIME.
//  STMicroelectronics MAKES NO WARRANTY,  EXPRESSED, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO ANY IMPLIED  WARRANTY OR MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE,  OR THAT THE USE WILL NOT INFRINGE ANY THIRD PARTY PATENT,  COPYRIGHT OR TRADEMARK.
//  STMicroelectronics SHALL NOT BE LIABLE  FOR ANY LOSS OR DAMAGE ARISING FROM THE USE OF ITS LIBRARIES OR  SOFTWARE.
//    STMicroelectronics
//   850, Rue Jean Monnet
//   BP 16 - 38921 Crolles Cedex - France
//   Central R&D / DAIS.
//                                                                                                                                                                                                                                                                                                                                                                             
//    
//  
//  ------------------------------------------------------------
//  
//  
//    User           : jean-francois paillotin
//    Project        : CMP_LUND_160523        
//    Division       : Not known              
//    Creation date  : 24 May 2016            
//    Generator mode : Cut Service            
//    
//    WebGen configuration              : C28SOI_MEM_SRAM_SPHD_HIPERF:781,23:MemConfMAT10/distributed:3.3.a-00
//  
//    HDL C28SOI_ST_SP Compiler version : 2.2@20150309.0 at Mar-09-2015 (PTBL date)                            
//    
//  
//  For more information about the cuts or the generation environment, please
//  refer to files uk.env and ugnGuiSetupDB in directory DESIGN_DATA.
//   
//  
//  


        

/***************************************************************************************************************************************************
--  Description       : Tetramax Model
--  ModelVersion      : 2.2
--  Date              : 09-March-2015
--  Changes Made by   : PS
*****************************************************************************************************************************************************/

/************************************** START OF HEADER *****************************************
   This Header Gives Information about the parameters & options present in the Model
   
   words = 8192
   bits  = 32
   mux   = 16 
   bank = 1
   bit_mask = no
   Redundancy = no
   margin_control = no
   ls_pin = no
   hs_pin = no
   Sleep = Yes
   eswitch = No
   power_supply = Default
   
   --------------------------------------------------------------------------------------------
     Signal Name             | Description       |             Port Mode        | Active When
                             |                   |          r    |  w   | rw    |
   --------------------------------------------------------------------------------------------

    A                           Address                     x      x      na       -
    ATP                         ATP pin                     x      x      na       high
    CK                          Clock	                    x      x      na       posedge
    CSN                         Chip Enable                 x      x      na       low
    D 	                        Data in                     na     x      na       -  
    
    IG                          Input Gate Enable           x      x      na       High     
    INITN                       Initialization Pin          x      x      na       Low
    
     
    
    
    
    Q 	                        Data out	            x      na     na       -
    
    
    
    SCTRLI                      Scan Input (Control)
    SCTRLO                      Scan Output (Control)
    SDLI                        Scan Input (Data-Left)
    SDLO                        Scan Output (Data-Left)
    SDRI                        Scan Input (Data-Right)
    SDRO                        Scan Output (Data-Right)
    SE                          Scan Enable pin            -      -      -       High
    
    
     
    
    
    
    

    STDBY                       Stand-by mode enable        x      x      na       High  
    
    TA                          Bist Address
    TBIST                       Bist Enable Pin             x      x      na       High  
    
    TBYPASS                     Memory Bypass               na     na     na       High
    TCSN                        Bist Chip Select            x      x      na       Low
    TED                         Bist Even Data pin
    
    TOD                         Bist Odd Data Pin
     
     
    TWEN                        Bist Write Enable           na     x      na       Low 
    WEN                         Write Enable                na     x      na       Low 
    

************************************** END OF HEADER ********************************************/



/*------------------------------------------------------------------------------------------
            ST_SPHD_HIPERF_8192x32m16_Tlmr model for Tetramax
-------------------------------------------------------------------------------------------*/

module ST_SPHD_HIPERF_8192x32m16_Tlmr (A, ATP, CK, CSN, D , IG, INITN , Q, SCTRLI,SCTRLO,SDLI,SDLO,SDRI,SDRO,SE,  STDBY ,TA,TBIST, TBYPASS ,TCSN,TED  ,TOD  , TWEN, WEN);



    parameter
        words = 8192,
        bits = 32,
        Addr = 13,
        max_address_bits = 13,
        
        mux = 16,
        Logmux = 4,
        mux_bits=4,
        bank_bits=0,
        RedWords = mux * 2 * 1,
        Rows = words/mux,
        repair_address_width = 9,
        write_margin_size = 2, 
        read_margin_size = 3;

    parameter 
       scanlen_ctrl=17,
    
       scanlen_r= 16,
       scanlen_l= 16;

    parameter
        WordX = {bits{1'bx}},
        WordZ = {bits{1'bz}},
        AddrX = {Addr{1'bx}},
        Word0 = {bits{1'b0}},
        X = 1'bx;
    

//---------------  IN / OUT Declarations -----------

//--------------------------------------------------
//           Global Active (GAC) Pins 
//--------------------------------------------------
 
        input STDBY;
        input INITN;

//--------------------------------------------------
//              FUNCTIONAL Pins 
//--------------------------------------------------
	output [bits-1 : 0] Q;
        
        input CK;
        input CSN, IG, WEN;
        input [bits-1 : 0] D ;
	input [Addr-1 : 0] A;
        

//--------------------------------------------------
//                TEST Mode Pins 
//--------------------------------------------------
        input ATP;
    
    // Scan Flops related pins
        
        input SE;
        input SCTRLI,SDLI,SDRI ;
        output SCTRLO, SDLO, SDRO ;
        
    // Bypass pin
        input TBYPASS;
        
    // BIST Related Pins 
         input TBIST;
         input [Addr-1 :0 ] TA;
         input TCSN,TWEN,TED,TOD; 
         
         

        

        

//----------------------------------------------------
//           Margin Control Related Pins
//----------------------------------------------------
        
        

//----------------------------------------------------
//             Speed Mode Related Pins
//----------------------------------------------------
        
        

//----------------------------------------------------
//              Eswitch Related Pins
//----------------------------------------------------
        
        

       
        
        

//----------------------------------------------------
//           Wire and Reg Declarations
//----------------------------------------------------
        
        wire WEN_bmux;
        wire CK_scff, CK_lock_up_latch;
        wire CK_rw;
        wire [Addr-1 : 0] A_bmux;
        wire [max_address_bits-1 : 0] A_scff_din; 

        
        wire [bits-1 : 0] D_bmux;
        wire [bits-1 : 0] D_scff_out;

        wire [scanlen_ctrl-1 : 0] ctrl_scff_in;
        wire [scanlen_ctrl-1 : 0] ctrl_scff_out; 
        wire [bits-1 : 0] Q_int, Q_CORE; 
        
        wire SCTRLO_temp, SDLO_temp  ,SDRO_temp ;
        
        wire CK_buf;
        

        buf (CK_buf, CK); // while blocking the memory, CK_buf will be forced to 'x' 



	wire SLEEP_buf;
	wire STDBY_buf;
	wire INITN_buf;
	wire CSN_buf;
	wire IG_buf;
	wire WEN_buf;
        wire [bits-1 : 0] D_buf;
        wire [Addr-1 : 0] A_buf;

	wire ATP_buf;
	wire SE_buf;
	wire SCTRLI_buf;
	wire SDLI_buf;
	wire SDRI_buf;
	

        wire TBYPASS_buf;
        wire TBIST_buf;
        wire [Addr-1 : 0] TA_buf;
	wire TCSN_buf;
	wire TWEN_buf;
	wire TED_buf;
	wire TOD_buf;
	


  

//----------------------------------------------------
//              Input Buffers Starts
//----------------------------------------------------
	
        assign SLEEP_buf = 1'b0;
	buf (STDBY_buf, STDBY);
	buf (INITN_buf, INITN);
	buf (CSN_buf, CSN);
	buf (IG_buf, IG);
	buf (WEN_buf, WEN);
        buf (D_buf[0], D[0]);
        buf (D_buf[1], D[1]);
        buf (D_buf[2], D[2]);
        buf (D_buf[3], D[3]);
        buf (D_buf[4], D[4]);
        buf (D_buf[5], D[5]);
        buf (D_buf[6], D[6]);
        buf (D_buf[7], D[7]);
        buf (D_buf[8], D[8]);
        buf (D_buf[9], D[9]);
        buf (D_buf[10], D[10]);
        buf (D_buf[11], D[11]);
        buf (D_buf[12], D[12]);
        buf (D_buf[13], D[13]);
        buf (D_buf[14], D[14]);
        buf (D_buf[15], D[15]);
        buf (D_buf[16], D[16]);
        buf (D_buf[17], D[17]);
        buf (D_buf[18], D[18]);
        buf (D_buf[19], D[19]);
        buf (D_buf[20], D[20]);
        buf (D_buf[21], D[21]);
        buf (D_buf[22], D[22]);
        buf (D_buf[23], D[23]);
        buf (D_buf[24], D[24]);
        buf (D_buf[25], D[25]);
        buf (D_buf[26], D[26]);
        buf (D_buf[27], D[27]);
        buf (D_buf[28], D[28]);
        buf (D_buf[29], D[29]);
        buf (D_buf[30], D[30]);
        buf (D_buf[31], D[31]);
        buf (A_buf[0], A[0]);
        buf (A_buf[1], A[1]);
        buf (A_buf[2], A[2]);
        buf (A_buf[3], A[3]);
        buf (A_buf[4], A[4]);
        buf (A_buf[5], A[5]);
        buf (A_buf[6], A[6]);
        buf (A_buf[7], A[7]);
        buf (A_buf[8], A[8]);
        buf (A_buf[9], A[9]);
        buf (A_buf[10], A[10]);
        buf (A_buf[11], A[11]);
        buf (A_buf[12], A[12]);

	buf (ATP_buf, ATP);
	buf (SE_buf, SE);
	buf (SCTRLI_buf, SCTRLI);
	buf (SDLI_buf, SDLI);
	buf (SDRI_buf, SDRI);
	

        buf (TBYPASS_buf, TBYPASS);
        buf (TBIST_buf, TBIST);
        buf (TA_buf[0], TA[0]);
        buf (TA_buf[1], TA[1]);
        buf (TA_buf[2], TA[2]);
        buf (TA_buf[3], TA[3]);
        buf (TA_buf[4], TA[4]);
        buf (TA_buf[5], TA[5]);
        buf (TA_buf[6], TA[6]);
        buf (TA_buf[7], TA[7]);
        buf (TA_buf[8], TA[8]);
        buf (TA_buf[9], TA[9]);
        buf (TA_buf[10], TA[10]);
        buf (TA_buf[11], TA[11]);
        buf (TA_buf[12], TA[12]);
	buf (TCSN_buf, TCSN);
	buf (TWEN_buf, TWEN);
	buf (TED_buf, TED);
	buf (TOD_buf, TOD);
	

        
          
//----------------------------------------------------
//              Input Buffers Ends
//----------------------------------------------------


/*---------------------------------------------------------------------------
                     Functional Control Unit.
        1) BIST MUXes
        2) Clock generation : CK_scff, CK_rw, CK_lock_up_latch
        3) Output MUX
----------------------------------------------------------------------------*/

ST_SPHD_HIPERF_8192x32m16_Tlmr_INTERFACE IO (

// functional inputs
.A(A_buf),.D(D_buf),.CSN(CSN_buf),.WEN(WEN_buf),.CK(CK_buf),.SE(SE_buf),.TBYPASS(TBYPASS_buf),.IG(IG_buf),.SLEEP(SLEEP_buf),.ATP(ATP_buf),.STDBY(STDBY_buf),.INITN(INITN_buf),

// BIST inputs
.TBIST(TBIST_buf),.TCSN(TCSN_buf),.TA(TA_buf),.TED(TED_buf),.TOD(TOD_buf),.TWEN(TWEN_buf),



// bist mux outputs
.A_bmux(A_bmux),.D_bmux(D_bmux),.WEN_bmux(WEN_bmux),.CSN_scff_din(CSN_scff_din),

// Test Enable signals for Scan flops
.shift_en_inst(shift_en_inst),

// Clocks for Scan flops and "mp" block
.CK_scff(CK_scff),.CK_lock_up_latch(CK_lock_up_latch),.CK_rw(CK_rw),

// Data and Control Scan flops outputs
.D_scff_out(D_scff_out),.BYP_ENint(ctrl_scff_out[16]),

// Q Output from rw and omux blocks
.Q_CORE(Q_CORE), .Q(Q_int), .MEM_EN_inst(MEM_EN_inst)

);

/*---------------------------------------------
        'D' input for Control Scan flops
----------------------------------------------*/

buf (A_scff_din[0], A_bmux[0]);
buf (A_scff_din[1], A_bmux[1]);
buf (A_scff_din[2], A_bmux[2]);
buf (A_scff_din[3], A_bmux[3]);
buf (A_scff_din[4], A_bmux[4]);
buf (A_scff_din[5], A_bmux[5]);
buf (A_scff_din[6], A_bmux[6]);
buf (A_scff_din[7], A_bmux[7]);
buf (A_scff_din[8], A_bmux[8]);
buf (A_scff_din[9], A_bmux[9]);
buf (A_scff_din[10], A_bmux[10]);
buf (A_scff_din[11], A_bmux[11]);
buf (A_scff_din[12], A_bmux[12]);



buf (WEN_scff_din, WEN_bmux);

/*------------------------------------     
        CONTROL SCAN CHAIN
------------------------------------*/



buf  (ctrl_scff_in[0], A_scff_din[12]);
buf  (ctrl_scff_in[1], A_scff_din[11]);
buf  (ctrl_scff_in[2], A_scff_din[10]);
buf  (ctrl_scff_in[3], A_scff_din[9]);
buf  (ctrl_scff_in[4], A_scff_din[8]);
buf  (ctrl_scff_in[5], A_scff_din[7]);
buf  (ctrl_scff_in[6], A_scff_din[6]);
buf  (ctrl_scff_in[7], A_scff_din[5]);
buf  (ctrl_scff_in[8], A_scff_din[4]);
buf  (ctrl_scff_in[9], A_scff_din[0]);
buf  (ctrl_scff_in[10], A_scff_din[1]);
buf  (ctrl_scff_in[11], 1'b0);
buf  (ctrl_scff_in[12], A_scff_din[3]);
buf  (ctrl_scff_in[13], A_scff_din[2]);
buf  (ctrl_scff_in[14], CSN_scff_din);
buf  (ctrl_scff_in[15], WEN_scff_din);
buf  (ctrl_scff_in[16], ctrl_scff_out[16]);

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_0  (.D(ctrl_scff_in[0]), .TI(SCTRLI_buf), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[0]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_1 (.D(ctrl_scff_in[1]), .TI(ctrl_scff_out[0]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[1]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_2 (.D(ctrl_scff_in[2]), .TI(ctrl_scff_out[1]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[2]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_3 (.D(ctrl_scff_in[3]), .TI(ctrl_scff_out[2]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[3]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_4 (.D(ctrl_scff_in[4]), .TI(ctrl_scff_out[3]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[4]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_5 (.D(ctrl_scff_in[5]), .TI(ctrl_scff_out[4]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[5]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_6 (.D(ctrl_scff_in[6]), .TI(ctrl_scff_out[5]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[6]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_7 (.D(ctrl_scff_in[7]), .TI(ctrl_scff_out[6]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[7]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_8 (.D(ctrl_scff_in[8]), .TI(ctrl_scff_out[7]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[8]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_9 (.D(ctrl_scff_in[9]), .TI(ctrl_scff_out[8]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[9]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_10 (.D(ctrl_scff_in[10]), .TI(ctrl_scff_out[9]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[10]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_11 (.D(ctrl_scff_in[11]), .TI(ctrl_scff_out[10]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[11]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_12 (.D(ctrl_scff_in[12]), .TI(ctrl_scff_out[11]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[12]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_13 (.D(ctrl_scff_in[13]), .TI(ctrl_scff_out[12]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[13]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_14 (.D(ctrl_scff_in[14]), .TI(ctrl_scff_out[13]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[14]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_15 (.D(ctrl_scff_in[15]), .TI(ctrl_scff_out[14]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[15]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_ctrl_16 (.D(ctrl_scff_in[16]), .TI(ctrl_scff_out[15]), .TE(shift_en_inst), .CP(CK_scff), .Q(ctrl_scff_out[16]));

ST_SPHD_HIPERF_8192x32m16_Tlmr_lock_up_latch  latch_SCTRLO (.CK(!CK_lock_up_latch), .D(ctrl_scff_out[16]), .Q(SCTRLO_temp));


/*-----------------------------------
        LEFT DATA SCAN CHAIN
------------------------------------*/

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_0 (.D(D_bmux[15]), .TI(SDLI_buf), .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[15])); 


 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_1 (.D(D_bmux[14]),  .TI(D_scff_out[15]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[14]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_2 (.D(D_bmux[13]),  .TI(D_scff_out[14]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[13]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_3 (.D(D_bmux[12]),  .TI(D_scff_out[13]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[12]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_4 (.D(D_bmux[11]),  .TI(D_scff_out[12]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[11]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_5 (.D(D_bmux[10]),  .TI(D_scff_out[11]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[10]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_6 (.D(D_bmux[9]),  .TI(D_scff_out[10]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[9]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_7 (.D(D_bmux[8]),  .TI(D_scff_out[9]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[8]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_8 (.D(D_bmux[7]),  .TI(D_scff_out[8]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[7]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_9 (.D(D_bmux[6]),  .TI(D_scff_out[7]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[6]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_10 (.D(D_bmux[5]),  .TI(D_scff_out[6]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[5]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_11 (.D(D_bmux[4]),  .TI(D_scff_out[5]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[4]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_12 (.D(D_bmux[3]),  .TI(D_scff_out[4]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[3]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_13 (.D(D_bmux[2]),  .TI(D_scff_out[3]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[2]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_14 (.D(D_bmux[1]),  .TI(D_scff_out[2]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[1]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_left_15 (.D(D_bmux[0]),  .TI(D_scff_out[1]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[0])); 

ST_SPHD_HIPERF_8192x32m16_Tlmr_lock_up_latch  latch_SDLO (.CK(!CK_lock_up_latch), .D(D_scff_out[0]), .Q(SDLO_temp)); 




/*-------------------------------------
        RIGHT DATA SCAN CHAIN
--------------------------------------*/

ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_0 (.D(D_bmux[31]), .TI(SDRI_buf), .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[31])); 

 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_1 (.D(D_bmux[30]),  .TI(D_scff_out[31]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[30]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_2 (.D(D_bmux[29]),  .TI(D_scff_out[30]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[29]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_3 (.D(D_bmux[28]),  .TI(D_scff_out[29]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[28]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_4 (.D(D_bmux[27]),  .TI(D_scff_out[28]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[27]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_5 (.D(D_bmux[26]),  .TI(D_scff_out[27]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[26]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_6 (.D(D_bmux[25]),  .TI(D_scff_out[26]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[25]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_7 (.D(D_bmux[24]),  .TI(D_scff_out[25]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[24]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_8 (.D(D_bmux[23]),  .TI(D_scff_out[24]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[23]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_9 (.D(D_bmux[22]),  .TI(D_scff_out[23]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[22]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_10 (.D(D_bmux[21]),  .TI(D_scff_out[22]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[21]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_11 (.D(D_bmux[20]),  .TI(D_scff_out[21]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[20]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_12 (.D(D_bmux[19]),  .TI(D_scff_out[20]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[19]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_13 (.D(D_bmux[18]),  .TI(D_scff_out[19]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[18]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_14 (.D(D_bmux[17]),  .TI(D_scff_out[18]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[17]));
 ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF scff_data_right_15 (.D(D_bmux[16]),  .TI(D_scff_out[17]) , .TE(shift_en_inst), .CP(CK_scff), .Q(D_scff_out[16])); 

ST_SPHD_HIPERF_8192x32m16_Tlmr_lock_up_latch  latch_SDRO (.CK(!CK_lock_up_latch), .D(D_scff_out[16]), .Q(SDRO_temp));














/*--------------------------------------------------------------
        "rw" block : Memory Core read/write functionality
---------------------------------------------------------------*/
ST_SPHD_HIPERF_8192x32m16_Tlmr_rw_inst rw (.MEM_EN_inst(MEM_EN_inst), .CK_rw(CK_rw), .A_bmux(A_bmux), .WEN_bmux(WEN_bmux), .D_bmux(D_bmux), .Q(Q_CORE));  


/*------------------------------------------------------------
        Output Buffers for tmax model
-------------------------------------------------------------*/
  buf (Q[0],Q_int[0]);
buf (Q[1],Q_int[1]);
buf (Q[2],Q_int[2]);
buf (Q[3],Q_int[3]);
buf (Q[4],Q_int[4]);
buf (Q[5],Q_int[5]);
buf (Q[6],Q_int[6]);
buf (Q[7],Q_int[7]);
buf (Q[8],Q_int[8]);
buf (Q[9],Q_int[9]);
buf (Q[10],Q_int[10]);
buf (Q[11],Q_int[11]);
buf (Q[12],Q_int[12]);
buf (Q[13],Q_int[13]);
buf (Q[14],Q_int[14]);
buf (Q[15],Q_int[15]);
buf (Q[16],Q_int[16]);
buf (Q[17],Q_int[17]);
buf (Q[18],Q_int[18]);
buf (Q[19],Q_int[19]);
buf (Q[20],Q_int[20]);
buf (Q[21],Q_int[21]);
buf (Q[22],Q_int[22]);
buf (Q[23],Q_int[23]);
buf (Q[24],Q_int[24]);
buf (Q[25],Q_int[25]);
buf (Q[26],Q_int[26]);
buf (Q[27],Q_int[27]);
buf (Q[28],Q_int[28]);
buf (Q[29],Q_int[29]);
buf (Q[30],Q_int[30]);
buf (Q[31],Q_int[31]);
  
  buf (SCTRLO,SCTRLO_temp);
  buf (SDLO, SDLO_temp);
  buf (SDRO, SDRO_temp);
 





endmodule




//-------------------------------------------------------
//       module definition for INTERFACE
//-------------------------------------------------------

`celldefine
module ST_SPHD_HIPERF_8192x32m16_Tlmr_INTERFACE (
// functional inputs
A,D,CSN,WEN,CK,SE,TBYPASS,IG,SLEEP,ATP,STDBY,INITN,

// BIST inputs
TBIST,TCSN,TA,TED,TOD,TWEN,



// bist mux outputs
A_bmux,D_bmux,WEN_bmux,CSN_scff_din,

// Test Enable signals for Scan flops
shift_en_inst,

// Clocks for Scan flops and "rw" block
CK_scff, CK_lock_up_latch, CK_rw,

// Data and Control Scan flops outputs
D_scff_out,BYP_ENint,

// Q Output from rw and omux blocks
Q_CORE, Q, MEM_EN_inst

);

    parameter max_address_bits = 13;
    parameter Addr = 13;
    parameter bits =32;
    parameter words = 8192;
    parameter repair_address_width = 9;
    

    output [bits-1 : 0] D_bmux;
    output [bits-1 : 0] Q;
    
    output [Addr-1 : 0] A_bmux;
    output WEN_bmux, CSN_scff_din;
// CK_scff is the clock for Scan flops and "mp" block
    output CK_scff, CK_lock_up_latch;
// CK_rw is the clock for Read/Write (rw) block    
    output CK_rw, MEM_EN_inst; 

// Scan enable signal for the scan chain ----
    output shift_en_inst;



// --- functional inputs ----
    input SLEEP,ATP,STDBY,INITN;
    input IG,CK,SE;
    input TBYPASS;
    input [bits-1 : 0] D;
    
    input [Addr-1 : 0] A;
    
    input [Addr-1 : 0] TA;
    input TBIST,TWEN,TCSN,TED,TOD;
    input WEN,CSN;
//---- Output Q of the "mp" block -----
    input [bits-1 : 0] Q_CORE;

//---- 'Q' output of the scan flops -----
    

        input [bits-1 : 0] D_scff_out;
        input BYP_ENint;
    
    

    
    wire initn_pulse_done, DE_temp, supply_ok;
    
    assign initn_pulse_done = 1'b1; 
    assign supply_ok = 1'b1;
    assign DE_temp = 1'b0;
    




//Bist Mux Implementation

and (ATP_TBIST, ATP, TBIST);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim CSN_bistmux (ATP_TBIST, CSN, TCSN, CSN_bmux_temp);
buf (CSN_scff_din, CSN_bmux_temp);

ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim WEN_bistmux (ATP_TBIST, WEN, TWEN, WEN_bmux_temp);


ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim csn_se_mux (SE, CSN_bmux_temp, CSN_bmux_temp, CSN_bmux);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim wen_se_mux (SE, WEN_bmux_temp, WEN_bmux_temp, WEN_bmux);
buf (TBYPASSint, TBYPASS);
buf (SEint, SE);


ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_0 (ATP_TBIST, A[0], TA[0], A_bmux[0]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_1 (ATP_TBIST, A[1], TA[1], A_bmux[1]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_2 (ATP_TBIST, A[2], TA[2], A_bmux[2]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_3 (ATP_TBIST, A[3], TA[3], A_bmux[3]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_4 (ATP_TBIST, A[4], TA[4], A_bmux[4]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_5 (ATP_TBIST, A[5], TA[5], A_bmux[5]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_6 (ATP_TBIST, A[6], TA[6], A_bmux[6]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_7 (ATP_TBIST, A[7], TA[7], A_bmux[7]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_8 (ATP_TBIST, A[8], TA[8], A_bmux[8]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_9 (ATP_TBIST, A[9], TA[9], A_bmux[9]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_10 (ATP_TBIST, A[10], TA[10], A_bmux[10]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_11 (ATP_TBIST, A[11], TA[11], A_bmux[11]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim addr_bistmux_12 (ATP_TBIST, A[12], TA[12], A_bmux[12]);

ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_0 (ATP_TBIST,D[0], TED, D_bmux[0]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_1 (ATP_TBIST,D[1], TOD, D_bmux[1]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_2 (ATP_TBIST,D[2], TED, D_bmux[2]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_3 (ATP_TBIST,D[3], TOD, D_bmux[3]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_4 (ATP_TBIST,D[4], TED, D_bmux[4]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_5 (ATP_TBIST,D[5], TOD, D_bmux[5]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_6 (ATP_TBIST,D[6], TED, D_bmux[6]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_7 (ATP_TBIST,D[7], TOD, D_bmux[7]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_8 (ATP_TBIST,D[8], TED, D_bmux[8]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_9 (ATP_TBIST,D[9], TOD, D_bmux[9]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_10 (ATP_TBIST,D[10], TED, D_bmux[10]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_11 (ATP_TBIST,D[11], TOD, D_bmux[11]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_12 (ATP_TBIST,D[12], TED, D_bmux[12]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_13 (ATP_TBIST,D[13], TOD, D_bmux[13]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_14 (ATP_TBIST,D[14], TED, D_bmux[14]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_15 (ATP_TBIST,D[15], TOD, D_bmux[15]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_16 (ATP_TBIST,D[16], TED, D_bmux[16]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_17 (ATP_TBIST,D[17], TOD, D_bmux[17]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_18 (ATP_TBIST,D[18], TED, D_bmux[18]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_19 (ATP_TBIST,D[19], TOD, D_bmux[19]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_20 (ATP_TBIST,D[20], TED, D_bmux[20]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_21 (ATP_TBIST,D[21], TOD, D_bmux[21]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_22 (ATP_TBIST,D[22], TED, D_bmux[22]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_23 (ATP_TBIST,D[23], TOD, D_bmux[23]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_24 (ATP_TBIST,D[24], TED, D_bmux[24]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_25 (ATP_TBIST,D[25], TOD, D_bmux[25]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_26 (ATP_TBIST,D[26], TED, D_bmux[26]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_27 (ATP_TBIST,D[27], TOD, D_bmux[27]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_28 (ATP_TBIST,D[28], TED, D_bmux[28]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_29 (ATP_TBIST,D[29], TOD, D_bmux[29]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_30 (ATP_TBIST,D[30], TED, D_bmux[30]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim data_bistmux_31 (ATP_TBIST,D[31], TOD, D_bmux[31]);



// ----------------------------------------
// ------- Clock generation start ---------
// ----------------------------------------

and (GAC, INITN, initn_pulse_done, !STDBY, !SLEEP, supply_ok);

// Shift Enable calculation
and (shift_en_inst,SEint, ATP, GAC);

// Capture Enable calculation
and (capt_byp_en_inst, TBYPASSint, !BYP_ENint, !SEint, ATP, GAC);
and (capt_func_en_inst, !TBYPASSint, !SEint, ATP, GAC);

or (shift_or_capt_inst, shift_en_inst, capt_func_en_inst, capt_byp_en_inst);

// Clock Gating Logic
ST_SPHD_HIPERF_8192x32m16_Tlmr_CGCprim cgc_CK_scff (.EN(shift_or_capt_inst), .CK(CK), .CK_gated(CK_scff));

// Clock for lock-up-latch at the end of scan chains... (scan shift mode)
ST_SPHD_HIPERF_8192x32m16_Tlmr_CGCprim cgc_CK_lkp_latch (.EN(shift_en_inst), .CK(CK), .CK_gated(CK_lock_up_latch));

// ----- Memory enable signal

and (MEM_EN_inst_atp1, GAC, ATP, !SEint, !TBYPASSint, !IG, !CSN_bmux, !DE_temp);
and (MEM_EN_inst_atp0, GAC, !ATP, !IG, !CSN, !DE_temp);
or (MEM_EN_inst, MEM_EN_inst_atp1, MEM_EN_inst_atp0);

// ----- Clock generation for "rw" block
ST_SPHD_HIPERF_8192x32m16_Tlmr_CGCprim cgc_CK_rw (.EN(MEM_EN_inst), .CK(CK), .CK_gated(CK_rw));



// -----------------------------------
// ----- Clock generation ends -------
// -----------------------------------

// Inputs to OMUX : Output Q Enable Signal Calculations

// ----- Mem Enable signal -----
ST_SPHD_HIPERF_8192x32m16_Tlmr_DFFprim_blocking dff_mem_en (1'b0, bypass_en, CK_rw, MEM_EN_inst, MEMEN_reg_temp);
and (MEMEN_reg, MEMEN_reg_temp, !bypass_en); // To Avoid 'Z' violations


// ---- bypass enable signal -----
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_se (1'b0, 1'b0, !CK, SEint, SE_lat);


and (bypass_en, TBYPASSint, GAC, ATP, !SE_lat);




/*-------------------------------------------------------------------
        Output MUX : Paths on Output 'Q'
           1) Memory Read path : From "rw" block - Q_CORE
           2) BYPASS path      : From data scff  - D_scff_out
--------------------------------------------------------------------*/
ST_SPHD_HIPERF_8192x32m16_Tlmr_outputmux omux (.Q(Q), .D_scff_out(D_scff_out), .bypass_en(bypass_en), .Q_CORE(Q_CORE), .MEMEN_reg(MEMEN_reg));



endmodule

/*-------------------------------------------------------
        module definition for Output MUX block
--------------------------------------------------------*/

module ST_SPHD_HIPERF_8192x32m16_Tlmr_outputmux ( Q, D_scff_out, bypass_en, Q_CORE, MEMEN_reg);

parameter bits = 32;

input   MEMEN_reg;
input [bits-1:0] Q_CORE;

        input bypass_en;
        input [bits-1 : 0] D_scff_out;


output [bits-1:0] Q;
trireg (medium) [bits-1:0] Q;

ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_0 (MEMEN_reg, Q_CORE[0], Q[0]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_1 (MEMEN_reg, Q_CORE[1], Q[1]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_2 (MEMEN_reg, Q_CORE[2], Q[2]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_3 (MEMEN_reg, Q_CORE[3], Q[3]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_4 (MEMEN_reg, Q_CORE[4], Q[4]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_5 (MEMEN_reg, Q_CORE[5], Q[5]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_6 (MEMEN_reg, Q_CORE[6], Q[6]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_7 (MEMEN_reg, Q_CORE[7], Q[7]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_8 (MEMEN_reg, Q_CORE[8], Q[8]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_9 (MEMEN_reg, Q_CORE[9], Q[9]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_10 (MEMEN_reg, Q_CORE[10], Q[10]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_11 (MEMEN_reg, Q_CORE[11], Q[11]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_12 (MEMEN_reg, Q_CORE[12], Q[12]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_13 (MEMEN_reg, Q_CORE[13], Q[13]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_14 (MEMEN_reg, Q_CORE[14], Q[14]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_15 (MEMEN_reg, Q_CORE[15], Q[15]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_16 (MEMEN_reg, Q_CORE[16], Q[16]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_17 (MEMEN_reg, Q_CORE[17], Q[17]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_18 (MEMEN_reg, Q_CORE[18], Q[18]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_19 (MEMEN_reg, Q_CORE[19], Q[19]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_20 (MEMEN_reg, Q_CORE[20], Q[20]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_21 (MEMEN_reg, Q_CORE[21], Q[21]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_22 (MEMEN_reg, Q_CORE[22], Q[22]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_23 (MEMEN_reg, Q_CORE[23], Q[23]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_24 (MEMEN_reg, Q_CORE[24], Q[24]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_25 (MEMEN_reg, Q_CORE[25], Q[25]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_26 (MEMEN_reg, Q_CORE[26], Q[26]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_27 (MEMEN_reg, Q_CORE[27], Q[27]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_28 (MEMEN_reg, Q_CORE[28], Q[28]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_29 (MEMEN_reg, Q_CORE[29], Q[29]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_30 (MEMEN_reg, Q_CORE[30], Q[30]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim memory_path_31 (MEMEN_reg, Q_CORE[31], Q[31]);

ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_0 (bypass_en, D_scff_out[0], Q[0]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_1 (bypass_en, D_scff_out[1], Q[1]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_2 (bypass_en, D_scff_out[2], Q[2]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_3 (bypass_en, D_scff_out[3], Q[3]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_4 (bypass_en, D_scff_out[4], Q[4]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_5 (bypass_en, D_scff_out[5], Q[5]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_6 (bypass_en, D_scff_out[6], Q[6]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_7 (bypass_en, D_scff_out[7], Q[7]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_8 (bypass_en, D_scff_out[8], Q[8]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_9 (bypass_en, D_scff_out[9], Q[9]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_10 (bypass_en, D_scff_out[10], Q[10]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_11 (bypass_en, D_scff_out[11], Q[11]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_12 (bypass_en, D_scff_out[12], Q[12]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_13 (bypass_en, D_scff_out[13], Q[13]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_14 (bypass_en, D_scff_out[14], Q[14]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_15 (bypass_en, D_scff_out[15], Q[15]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_16 (bypass_en, D_scff_out[16], Q[16]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_17 (bypass_en, D_scff_out[17], Q[17]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_18 (bypass_en, D_scff_out[18], Q[18]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_19 (bypass_en, D_scff_out[19], Q[19]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_20 (bypass_en, D_scff_out[20], Q[20]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_21 (bypass_en, D_scff_out[21], Q[21]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_22 (bypass_en, D_scff_out[22], Q[22]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_23 (bypass_en, D_scff_out[23], Q[23]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_24 (bypass_en, D_scff_out[24], Q[24]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_25 (bypass_en, D_scff_out[25], Q[25]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_26 (bypass_en, D_scff_out[26], Q[26]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_27 (bypass_en, D_scff_out[27], Q[27]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_28 (bypass_en, D_scff_out[28], Q[28]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_29 (bypass_en, D_scff_out[29], Q[29]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_30 (bypass_en, D_scff_out[30], Q[30]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim bypass_path_31 (bypass_en, D_scff_out[31], Q[31]);

endmodule

`endcelldefine

/*----------------------------------------------------------------------------------
        Tetramax DFT Model : module definition for "rw" (read/write) block
-----------------------------------------------------------------------------------*/

`suppress_faults

module ST_SPHD_HIPERF_8192x32m16_Tlmr_rw_inst (MEM_EN_inst, CK_rw, A_bmux, WEN_bmux, D_bmux, Q);
    
    parameter Addr = 13;
    parameter bits = 32;
    parameter words = 8192;
    parameter ConfigFault = 0;

    output [bits-1 : 0] Q;

    input [bits-1 : 0] D_bmux;
    
    input [Addr-1 : 0] A_bmux;
    input CK_rw, WEN_bmux, MEM_EN_inst;
    
    trireg (medium) [Addr-1 : 0] A_gated;
    wire [Addr-1 : 0] A_rw;
    trireg (medium) WEN_rw;
    

// By Using a Switch like this on Address bus, When MEMEN = X, the A_gated will also be 'X' and this will corrupt the Entire Memory array @ posedge of clock

ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_0 (MEM_EN_inst, A_bmux[0], A_gated[0]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_1 (MEM_EN_inst, A_bmux[1], A_gated[1]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_2 (MEM_EN_inst, A_bmux[2], A_gated[2]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_3 (MEM_EN_inst, A_bmux[3], A_gated[3]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_4 (MEM_EN_inst, A_bmux[4], A_gated[4]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_5 (MEM_EN_inst, A_bmux[5], A_gated[5]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_6 (MEM_EN_inst, A_bmux[6], A_gated[6]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_7 (MEM_EN_inst, A_bmux[7], A_gated[7]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_8 (MEM_EN_inst, A_bmux[8], A_gated[8]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_9 (MEM_EN_inst, A_bmux[9], A_gated[9]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_10 (MEM_EN_inst, A_bmux[10], A_gated[10]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_11 (MEM_EN_inst, A_bmux[11], A_gated[11]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_a_12 (MEM_EN_inst, A_bmux[12], A_gated[12]);

ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_0 (1'b0, 1'b0, !CK_rw, A_gated[0], A_rw[0]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_1 (1'b0, 1'b0, !CK_rw, A_gated[1], A_rw[1]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_2 (1'b0, 1'b0, !CK_rw, A_gated[2], A_rw[2]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_3 (1'b0, 1'b0, !CK_rw, A_gated[3], A_rw[3]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_4 (1'b0, 1'b0, !CK_rw, A_gated[4], A_rw[4]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_5 (1'b0, 1'b0, !CK_rw, A_gated[5], A_rw[5]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_6 (1'b0, 1'b0, !CK_rw, A_gated[6], A_rw[6]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_7 (1'b0, 1'b0, !CK_rw, A_gated[7], A_rw[7]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_8 (1'b0, 1'b0, !CK_rw, A_gated[8], A_rw[8]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_9 (1'b0, 1'b0, !CK_rw, A_gated[9], A_rw[9]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_10 (1'b0, 1'b0, !CK_rw, A_gated[10], A_rw[10]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_11 (1'b0, 1'b0, !CK_rw, A_gated[11], A_rw[11]);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_a_12 (1'b0, 1'b0, !CK_rw, A_gated[12], A_rw[12]);

ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim sw_wen (MEM_EN_inst, WEN_bmux, WEN_rw);



// 1-bit Memory Instances

ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp0  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[0]),  .Q(Q[0])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp1  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[1]),  .Q(Q[1])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp2  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[2]),  .Q(Q[2])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp3  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[3]),  .Q(Q[3])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp4  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[4]),  .Q(Q[4])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp5  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[5]),  .Q(Q[5])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp6  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[6]),  .Q(Q[6])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp7  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[7]),  .Q(Q[7])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp8  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[8]),  .Q(Q[8])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp9  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[9]),  .Q(Q[9])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp10  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[10]),  .Q(Q[10])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp11  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[11]),  .Q(Q[11])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp12  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[12]),  .Q(Q[12])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp13  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[13]),  .Q(Q[13])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp14  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[14]),  .Q(Q[14])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp15  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[15]),  .Q(Q[15])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp16  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[16]),  .Q(Q[16])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp17  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[17]),  .Q(Q[17])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp18  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[18]),  .Q(Q[18])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp19  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[19]),  .Q(Q[19])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp20  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[20]),  .Q(Q[20])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp21  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[21]),  .Q(Q[21])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp22  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[22]),  .Q(Q[22])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp23  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[23]),  .Q(Q[23])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp24  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[24]),  .Q(Q[24])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp25  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[25]),  .Q(Q[25])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp26  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[26]),  .Q(Q[26])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp27  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[27]),  .Q(Q[27])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp28  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[28]),  .Q(Q[28])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp29  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[29]),  .Q(Q[29])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp30  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[30]),  .Q(Q[30])); 
ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst mp31  (.CK_rw(CK_rw), .A(A_rw), .WEN_bmux(WEN_rw), .D(D_bmux[31]),  .Q(Q[31])); 

endmodule

/*--------------------------------------------------
                One_Bit_Memory model  
---------------------------------------------------*/

`define readaddrx xfill_async_out_all
/*------------------------------------------------------------------------------------
      When CK_rw -> X, then the following compiler directives will CEM and Q of this module
  Since read clock and write clock are same (CK_rw) for SP memories, the following two compiler directives will give the same functionality
--------------------------------------------------------------------------------------*/  
//`define readclkx xfill_async_out_all
//`define writeclkx xfill_async_out_all

module ST_SPHD_HIPERF_8192x32m16_Tlmr_1b_rw_inst (CK_rw, A, WEN_bmux, D, Q);
    
    parameter bits = 1;
    parameter Addr = 13;
    parameter words = 8192;
    
    output [bits-1:0] Q;
    
    input  [bits-1:0] D;
     
    input WEN_bmux;
    input CK_rw;
    input  [Addr-1:0] A;

    reg [bits-1:0] mymem [0:words-1];
    reg [bits-1:0] DO;
    



buf (write_no_mask, !WEN_bmux);

// Memory r/w functionality
  always @ (posedge CK_rw) 
    if (WEN_bmux) DO = mymem[A];

  always @ (posedge CK_rw) 
    if (write_no_mask) mymem[A] = D[0];



buf (Q, DO);
endmodule
`undef readaddrx
//`undef readclkx
//`undef writeclkx
`nosuppress_faults


`celldefine




`endcelldefine



module ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim (SEL, A, B, Z);
input SEL, A, B;
output Z;

ST_SPHD_HIPERF_8192x32m16_Tlmr_TSDprim tsd_mux_path0 (!SEL,A,Z);
ST_SPHD_HIPERF_8192x32m16_Tlmr_TSDprim tsd_mux_path1 (SEL,B,Z);


endmodule



module ST_SPHD_HIPERF_8192x32m16_Tlmr_CGCprim (EN, CK, CK_gated);
input EN, CK;
output CK_gated;
wire EN_latch;

ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_cgc (1'b0, 1'b0, !CK, EN, EN_latch);
and (CK_gated, CK, EN_latch);

endmodule

`celldefine
module ST_SPHD_HIPERF_8192x32m16_Tlmr_SCFF (D,TI,TE,CP,Q);
input D,TI,TE,CP;
output Q;

ST_SPHD_HIPERF_8192x32m16_Tlmr_MUXprim mux_in_scff (TE, D, TI, temp);
ST_SPHD_HIPERF_8192x32m16_Tlmr_DFFprim dff_in_scff (1'b0, 1'b0, CP, temp, Q);

endmodule
`endcelldefine

`celldefine
module ST_SPHD_HIPERF_8192x32m16_Tlmr_lock_up_latch (CK, D, Q);
input CK,D;
output Q;

ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim dlat_lockup (1'b0, 1'b0, CK, D, Q);

endmodule
`endcelldefine

module ST_SPHD_HIPERF_8192x32m16_Tlmr_DFFprim (SET,CLR,CK,D,Q);
output Q;
input D,SET,CLR,CK;

_DFF dff (SET,CLR,CK,D,Q);

endmodule

module ST_SPHD_HIPERF_8192x32m16_Tlmr_DFFprim_blocking (SET,CLR,CK,D,Q);
output Q;
input D,SET,CLR,CK;

_DFF dff (SET,CLR,CK,D,Q);

endmodule

module ST_SPHD_HIPERF_8192x32m16_Tlmr_DLATprim (SET,CLR,CK,D,Q);
output Q;
input D,SET,CLR,CK;

_DLAT dlat (SET,CLR,CK,D,Q);

endmodule

module ST_SPHD_HIPERF_8192x32m16_Tlmr_SWprim (control,in,out);
output out;
input control,in;

_SW sw (control, in, out);

endmodule

module ST_SPHD_HIPERF_8192x32m16_Tlmr_TSDprim (control,in,out);
input control, in;
output out;

_TSD tsd (control, in, out);

endmodule






