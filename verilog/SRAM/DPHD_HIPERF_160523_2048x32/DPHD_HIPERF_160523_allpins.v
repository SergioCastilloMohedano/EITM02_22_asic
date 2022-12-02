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
//    WebGen configuration             : C28SOI_MEM_SRAM_DPHD_HIPERF:764,16:MemConfMAT10/distributed:2.3.a-00
//  
//    HDL C32_ST_DPHS Compiler version : 1.5@20141128.0 at Nov-28-2014 (PTBL date)                            
//    
//  
//  For more information about the cuts or the generation environment, please
//  refer to files uk.env and ugnGuiSetupDB in directory DESIGN_DATA.
//   
//  
//  




/****************************************************************************
--  Description		:  Verilog Allpins Model 
--  Last Modified in    : 1.4
--  Date 		: Sept , 2014
--  Last Modified By	: RSS
-- 
--  Modifications Done   : 
        v1.3   When WEN = X/TimViol, then only CCL and When TP = X/TimViol, then FSM corrupt
        v1.2   Verilog guidelines and SLM enhancement support
        v1.1   Full support of LS/HS pins with that of C32 DPHD. UPF support handling changed according to new guidelines
*/

/******************** START OF HEADER****************************
   This Header Gives Information about the parameters & options present in the Model
   memory_name = ST_DPHD_HIPERF_2048x32m4_Tlmr
   depth = 2048
   width  = 32
   mux   = 4

   //eswitch = No
   sync on posedge
   1 readport + 1 write port
   
   bit_mask = no         
   byte_write = no
   
   
   
   
   




	Signal Name     	Description			Port Mode	Active When
	A1 	 		Address Bus1			Input	
	A2 			Address Bus2			Input	
	ATP			Additional Test Pin. 		Input	High
	CK1			Clock1				Input	posedge
	CK2			Clock2				Input	posedge
	CSN1			Chip Select1			Input	Low
	CSN2			Chip Select2			Input	Low
	D1 			Data bus 1			Input	-
	D2 			Data bus 2			Input	-


	IG1			Input Gate			Input	High
	IG2			Input Gate			Input	High
	INITN			Initialization pin		Input	Low




	MTCK			Bist Clock			Input	Posedge
	Q1			Output Bus			Output	-
	Q2			Output Bus			Output	-




	SCTRLI1   		Scan ip1 Control bits		Input	-
	SCTRLI2			Scan ip1 Control bits		Input	-
	SCTRLO1			Scan op2 Control bits 		Output	-
	SCTRLO2			Scan op2 Control bits 		Output	-
	SDLI1			Scan ip1 data bits 		Input	-
	SDLI2			Scan ip2 data bits 		Input	-
	SDLO1			Scan op1 data bits left 	Output	-
	SDLO2			Scan op2 data bits left 	Output	-
	SDRI1			Scan ip1 data bits right	Input	-
	SDRI2			Scan ip2 data bits right	Input	-
	SDRO1			Scan op1 data bits right	Output	-
	SDRO2			Scan op2 data bits right	Output	-
	SE   		  	Scan enable pin	Input		High


	STDBY1			Standby p1 (leakage)		Input	HIGH
	STDBY2			Standby p2 (leakage)		Input	HIGH


	TA1 			Bist Address1 Bus		Input	-
	TA2 			Bist Address2 Bus		Input	-
	TBIST			Bist Enable pin			Input	-
	TBYPASS			Memory Bypass pin		Input	High
	TCSN1			Bist Chip Select1		Input	Low
	TCSN2			Bist Chip Select2		Input	Low
	TED1			Bist data pin even bits		Input	-
	TED2			Bist data pin even bits		Input	-


	TOD1			Bist data pin odd data		Input	-
	TOD2			Bist data pin odd data		Input	-


	TP			Special Bist Write test pin 	input	High


	TWEN1			Bist Write enable pin		Input	Low
	TWEN2			Bist Write enable pin		Input	Low
	WEN1			Write enable pin		Input	Low
	WEN2			Write enable pin		Input	Low





 


**********************END OF HEADER ******************************/

`celldefine
`ifdef ST_TIMESCALE
 `ST_TIMESCALE
`else
 `timescale 1ns/1ps
`endif

`ifdef ST_NODELAYMODE
`else
    `delay_mode_path
`endif

`ifdef ST_DELAY_SEQ
 `define access_time `ST_DELAY_SEQ
`else
 `define access_time 0.001
`endif

`ifdef ST_MEM_RETAIN_TIME
 `define retain_time `ST_MEM_RETAIN_TIME
`else
 `define retain_time 0.001
`endif

`ifdef ST_MSG_CONTROL_TIME
        `define st_msg_cntrl_time `ST_MSG_CONTROL_TIME
`else
        `define st_msg_cntrl_time 0
`endif

`ifdef ST_MEM_BLOCK_CTRL_TIME
        `define st_mem_block_ctrl_time `ST_MEM_BLOCK_CTRL_TIME
`else
        `define st_mem_block_ctrl_time 0
`endif


`ifdef ST_MEM_PSWSMALLMA_SETTLING_TIME
  `define pswsmallma_settling_time `ST_MEM_PSWSMALLMA_SETTLING_TIME
`else  
  `define pswsmallma_settling_time 1000
`endif

`ifdef ST_MEM_PSWLARGEMA_SETTLING_TIME
  `define pswlargema_settling_time `ST_MEM_PSWLARGEMA_SETTLING_TIME
`else  
  `define pswlargema_settling_time 1000
`endif

`ifdef ST_MEM_PSWSMALLMP_SETTLING_TIME
  `define pswsmallmp_settling_time `ST_MEM_PSWSMALLMP_SETTLING_TIME
`else  
  `define pswsmallmp_settling_time 1000
`endif

`ifdef ST_MEM_PSWLARGEMP_SETTLING_TIME
  `define pswlargemp_settling_time `ST_MEM_PSWLARGEMP_SETTLING_TIME
`else  
  `define pswlargemp_settling_time 1000
`endif



`define mono_rail 2'b00
`define mo_ma_tied 2'b01
`define mo_mp_tied 2'b10
`define dual_rail 2'b11


`define setup_time 0.0
`define hold_time 0.0
`define cycle_time 0.0
`define pulse_width_time 0.0
`define rec_rem_time 0.0
`define init_pulse_time 0.0



//*************************************************//
// Timing constraints between supply pins and SLEEP
//*************************************************//

`define tslvddmpl 2.0
`define tvddmphsl 10.0
`define tslvddmal 2.0
`define tvddmahsl 10.0
`define tslgndmh 2.0
 `define tgndmlsl 10.0 



module ST_DPHD_HIPERF_2048x32m4_Tlmr (A1, A2, ATP, CK1, CK2, CSN1, CSN2, D1, D2 , IG1, IG2, INITN   , MTCK   , Q1, Q2    ,SCTRLI1, SCTRLI2, SCTRLO1, SCTRLO2, SDLI1, SDLI2, SDLO1, SDLO2, SDRI1, SDRI2, SDRO1, SDRO2, SE    , STDBY1, STDBY2  , TA1, TA2, TBIST, TBYPASS, TCSN1, TCSN2, TED1, TED2  , TOD1, TOD2  , TP  , TWEN1, TWEN2, WEN1, WEN2 , gndm, vddm);


parameter
    `ifdef ST_NO_MSG_MODE
      p_debug_level = 2'b00,
    `elsif ST_ALL_MSG_MODE
      p_debug_level = 2'b11,
    `elsif ST_ERROR_ONLY_MODE
      p_debug_level = 2'b01,
    `else
      p_debug_level = 2'b10,
    `endif

    power_pins_config = `mono_rail,
    Fault_file_name = "ST_DPHD_HIPERF_2048x32m4_Tlmr_faults.txt",
    `ifdef ST_MEM_CONFIGFAULT
      ConfigFault = 1,
    `else
      ConfigFault = 0,
    `endif
    max_faults = 20,
    MEM_INITIALIZE  = 1'b0,
    BinaryInit = 1'b0,
    File_load_time=0,
    Initn_reset_value={32{1'b0}},
    InitFileName = "ST_DPHD_HIPERF_2048x32m4_Tlmr.cde",
    InstancePath = "ST_DPHD_HIPERF_2048x32m4_Tlmr",
   
    p_pswsmallma_settling_time = `pswsmallma_settling_time,
    p_pswlargema_settling_time = `pswlargema_settling_time,
    p_pswsmallmp_settling_time = `pswsmallmp_settling_time,
    p_pswlargemp_settling_time = `pswlargemp_settling_time, 
    message_control_time = `st_msg_cntrl_time,
    mem_block_ctrl_time = `st_mem_block_ctrl_time;
    
localparam
    Words = 2048,
    Bits  = 32,
    Addr  = 11;

localparam   
    mux = 4,
    bank = 1,
    mux_bits=2,
    bank_bits= 0,  
//log1 = 0. so for single bank bank bit =0
    Rows = Words/mux;

localparam
    read_margin_size = 3,
    write_margin_size = 4;

localparam
     repair_address_bus_width =   9 ,
     no_of_red_rows_in_a_bank = 2,
     RedWords = (bank * no_of_red_rows_in_a_bank * mux) ;


localparam
    wordx = 32'bx, 
    WordX = 32'bx, 
    word0 = 32'b0,
    Word0 = 32'b0, 
    addrx = 11'bx,
    X = 1'bx;
localparam
    Number_of_Banks = 1; 


localparam
   scanlen_ctrl_port1 = 14, 
   scanlen_ctrl_port2 = 14,
   scanlen_d1l = 16,
   scanlen_d1r = 16,
   scanlen_d2l = 16,
   scanlen_d2r = 16;

localparam
        p_ok = 1'b1,
        p_not_ok = 1'b0,
        unknown = 1'bx;



   // Output of ports
   
   output [Bits-1:0] Q1;
   output [Bits-1:0] Q2;

   output SCTRLO1;
   output SCTRLO2;

   output SDLO1 ; 
   output SDRO1 ;
   output SDLO2 ; 
   output SDRO2 ;



   



   // Inputs 1
   
   input  [Bits-1:0] D1;
   input  [Addr-1:0] A1;
   input  [Addr-1:0] TA1;
   input  IG1;
   input  CK1, CSN1, WEN1;
   input  TCSN1, TWEN1;
   input  SCTRLI1;
   input  TED1;
   input  TOD1;
   input  SDLI1;
   input  SDRI1;


  // Inputs 2
   
   input  [Bits-1:0] D2;
   input  [Addr-1:0] A2;
   input  [Addr-1:0] TA2;
   input  IG2;
   input  CK2, CSN2, WEN2;
   input  TCSN2, TWEN2;
   input  SCTRLI2;
   input  TED2;
   input  TOD2;
   input  SDLI2;
   input  SDRI2;


      
   //Other Input Pins

   input MTCK;
   input TBYPASS;
   input INITN;
   

   input STDBY1;
   input STDBY2;




   input TBIST;
   input ATP;
   input SE;
   input TP;


 
 

        
  
//----------------------------------------------------
//              Eswitch Related Pins
//----------------------------------------------------




//----------------------------------------------------
//              Power Supply Pins
//----------------------------------------------------
        inout gndm;
        assign gndm = 1'bz;
        
        
        
        
        inout vddm;
        assign vddm = 1'bz;
        
        
        
        
        
//--------------------------------------
//       Reg Declarations
//--------------------------------------
   reg  [Bits-1:0] D1_buf_r;
   reg  [Addr-1:0] A1_buf_r;
   reg  [Addr-1:0] TA1_buf_r;
   reg  IG1_buf_r;
   reg  CSN1_buf_r, WEN1_buf_r;
   reg  TCSN1_buf_r, TWEN1_buf_r;
   reg  SCTRLI1_buf_r;
   reg  TED1_buf_r;
   reg  TOD1_buf_r;
   reg  SDLI1_buf_r;
   reg  SDRI1_buf_r;


   reg  [Bits-1:0] D2_buf_r;
   reg  [Addr-1:0] A2_buf_r;
   reg  [Addr-1:0] TA2_buf_r;
   reg  IG2_buf_r;
   reg  CSN2_buf_r, WEN2_buf_r;
   reg  TCSN2_buf_r, TWEN2_buf_r;
   reg  SCTRLI2_buf_r;
   reg  TED2_buf_r;
   reg  TOD2_buf_r;
   reg  SDLI2_buf_r;
   reg  SDRI2_buf_r;


      
   reg TBYPASS_buf_r;
   reg INITN_buf_r;
   

   reg STDBY1_buf_r;
   reg STDBY2_buf_r;




   reg TBIST_buf_r;
   reg ATP_buf_r;
   reg SE_buf_r;
   reg TP_buf_r;


 
 


//----------------------------------------------------
//              Eswitch Related Pins
//----------------------------------------------------


//--------------------------------------
//       Wire Declarations
//--------------------------------------
   wire  [Bits-1:0] D1_buf;
   wire  [Addr-1:0] A1_buf;
   wire  [Addr-1:0] TA1_buf;
   wire  IG1_buf;
   wire  CSN1_buf, WEN1_buf;
   wire  TCSN1_buf, TWEN1_buf;
   wire  SCTRLI1_buf;
   wire  TED1_buf;
   wire  TOD1_buf;
   wire  SDLI1_buf;
   wire  SDRI1_buf;


   wire  [Bits-1:0] D2_buf;
   wire  [Addr-1:0] A2_buf;
   wire  [Addr-1:0] TA2_buf;
   wire  IG2_buf;
   wire  CSN2_buf, WEN2_buf;
   wire  TCSN2_buf, TWEN2_buf;
   wire  SCTRLI2_buf;
   wire  TED2_buf;
   wire  TOD2_buf;
   wire  SDLI2_buf;
   wire  SDRI2_buf;


   wire TBYPASS_buf;
   wire INITN_buf;
   

   wire STDBY1_buf;
   wire STDBY2_buf;




   wire TBIST_buf;
   wire ATP_buf;
   wire SE_buf;
   wire TP_buf;


 
 

        
reg [1:0] debug_level;
   reg initn_pulse_done;
   reg r_supply_trigger;  
   reg [Bits-1 : 0] delOutReg1_data;
   reg [Bits-1 : 0] delOutReg2_data;
//----------------------------------------------------
//              Eswitch Related Pins
//----------------------------------------------------


//----------------------------------------------------
//              Input Non-Blocking Buffers Starts
//----------------------------------------------------
always @(D1 or r_supply_trigger) begin
         D1_buf_r <= D1;
        end
buf buf_d [Bits-1:0] (D1_buf, D1_buf_r);

always @(A1 or r_supply_trigger) begin
          A1_buf_r <= A1;
        end
buf buf_A1 [Addr-1:0] (A1_buf,A1_buf_r );
always @(TA1 or r_supply_trigger) begin
          TA1_buf_r <= TA1;
        end
buf buf_TA1 [Addr-1:0] (TA1_buf,TA1_buf_r);

always @(IG1 or r_supply_trigger) begin
         IG1_buf_r <= IG1;
        end
buf (IG1_buf,IG1_buf_r);

always @(CSN1 or r_supply_trigger) begin
          CSN1_buf_r <= CSN1;
        end
buf (CSN1_buf,CSN1_buf_r);

always @(WEN1 or r_supply_trigger) begin
          WEN1_buf_r <= WEN1;
        end
buf (WEN1_buf,WEN1_buf_r);

always @(TCSN1 or r_supply_trigger) begin
          TCSN1_buf_r <= TCSN1;
        end
buf (TCSN1_buf,TCSN1_buf_r);

always @(TWEN1 or r_supply_trigger) begin
          TWEN1_buf_r <= TWEN1;
        end
buf (TWEN1_buf,TWEN1_buf_r);

always @(SCTRLI1 or r_supply_trigger) begin
          SCTRLI1_buf_r <= SCTRLI1;
        end
buf (SCTRLI1_buf,SCTRLI1_buf_r);

always @(TED1 or r_supply_trigger) begin
         TED1_buf_r <= TED1;
        end
buf (TED1_buf,TED1_buf_r);

always @(TOD1 or r_supply_trigger) begin
          TOD1_buf_r <= TOD1;
        end
buf (TOD1_buf,TOD1_buf_r);

always @(SDLI1 or r_supply_trigger) begin
          SDLI1_buf_r <= SDLI1;
        end
buf (SDLI1_buf,SDLI1_buf_r);

always @(SDRI1 or r_supply_trigger) begin
          SDRI1_buf_r <= SDRI1;
        end
buf (SDRI1_buf,SDRI1_buf_r);


always @(D2 or r_supply_trigger) begin
          D2_buf_r <= D2;
        end
buf buf_D2  [Bits-1:0] (D2_buf,D2_buf_r);

always @(A2 or r_supply_trigger) begin
          A2_buf_r <= A2;
        end
buf buf_A2 [Addr-1:0] (A2_buf,A2_buf_r);

always @(TA2 or r_supply_trigger) begin
          TA2_buf_r <= TA2;
        end
buf buf_TA2 [Addr-1:0] (TA2_buf,TA2_buf_r);

always @(IG2 or r_supply_trigger) begin
          IG2_buf_r <= IG2;
        end
buf (IG2_buf,IG2_buf_r);

always @(CSN2 or r_supply_trigger) begin
         CSN2_buf_r <= CSN2;
        end
buf (CSN2_buf,CSN2_buf_r);

always @(WEN2 or r_supply_trigger) begin
          WEN2_buf_r <= WEN2;
        end
buf (WEN2_buf,WEN2_buf_r);

always @(TCSN2 or r_supply_trigger) begin
          TCSN2_buf_r <= TCSN2;
        end
buf (TCSN2_buf,TCSN2_buf_r);

always @(TWEN2 or r_supply_trigger) begin
          TWEN2_buf_r <= TWEN2;
        end
buf (TWEN2_buf,TWEN2_buf_r);

always @(SCTRLI2 or r_supply_trigger) begin
          SCTRLI2_buf_r <= SCTRLI2;
        end
buf (SCTRLI2_buf,SCTRLI2_buf_r);

always @(TED2 or r_supply_trigger) begin
          TED2_buf_r <= TED2;
        end
buf (TED2_buf,TED2_buf_r);

always @(TOD2 or r_supply_trigger) begin
          TOD2_buf_r <= TOD2;
        end
buf (TOD2_buf,TOD2_buf_r);

always @(SDLI2 or r_supply_trigger) begin
          SDLI2_buf_r <= SDLI2;
        end
buf (SDLI2_buf,SDLI2_buf_r);

always @(SDRI2 or r_supply_trigger) begin
          SDRI2_buf_r <= SDRI2;
        end
buf (SDRI2_buf,SDRI2_buf_r);


always @(TBYPASS or r_supply_trigger) begin
          TBYPASS_buf_r <= TBYPASS;
        end
buf (TBYPASS_buf,TBYPASS_buf_r);

always @(INITN or r_supply_trigger) begin
          INITN_buf_r <= INITN;
        end
buf (INITN_buf,INITN_buf_r);


always @(STDBY1 or r_supply_trigger) begin
          STDBY1_buf_r <= STDBY1;
        end
buf (STDBY1_buf,STDBY1_buf_r);

always @(STDBY2 or r_supply_trigger) begin
          STDBY2_buf_r <= STDBY2;
        end
buf (STDBY2_buf,STDBY2_buf_r);

always @(TBIST or r_supply_trigger) begin
          TBIST_buf_r <= TBIST;
        end
buf (TBIST_buf,TBIST_buf_r);

always @(ATP or r_supply_trigger) begin
          ATP_buf_r <= ATP;
        end
buf (ATP_buf,ATP_buf_r);

always @(SE or r_supply_trigger) begin
          SE_buf_r <= SE;
        end
buf (SE_buf,SE_buf_r);

always @(TP or r_supply_trigger) begin
          TP_buf_r <= TP;
        end
buf (TP_buf,TP_buf_r);





//-----------------------------------------------------


  assign SLEEP_buf = 1'b0;
wire supply_ok;
reg mem_blocked = 1'b0;

`ifdef ST_MEM_POWER_SEQUENCING_OFF
  
  assign supply_ok = 1'b1;

`else
//--------------------------------------------------------------------
//                 POWER PINS FUNCTIONALITY STARTS
//--------------------------------------------------------------------
reg Proper_shutdown;

wire vddmp_int, vddsmp_int, vddma_int, vddmo_int, gndm_int, gndsm_int;
reg [63 : 0]  sleep_toggle_time, vddmp_toggle_time, vddsmp_toggle_time, vddma_toggle_time, vddmo_toggle_time; 
reg [63 : 0] t_ma_mo=0, t_mp_mo=0, t_mo_ma=0, t_mo_smp=0, t_mo_mp=0, t_sl_ma=0, t_sl_mp=0, t_smp_mp=0, t_mp_smp=0, t_sl_mo=0;
wire PSWSMALLMA_int,PSWSMALLMP_int,PSWLARGEMA_int,PSWLARGEMP_int;
wire vddmpi_int, vddmai_int;



//-----------------------------------------------------------------
//   Calculating the valid states for all power supplies starts
//   Example : 
//        -> For flip-well vddsm valid range is -1 to 0
//        -> For noflip-well vddsm valid range is 0 to 1
//-----------------------------------------------------------------


assign vddmp_int = vddm;
assign vddma_int = vddm;
assign vddmo_int = vddm; 
assign gndm_int  = (gndm == 1'b0) ? p_ok : p_not_ok;




assign PSWSMALLMA_int = 1'b0;
assign PSWSMALLMP_int = 1'b0; 
assign PSWLARGEMA_int = 1'b0;
assign PSWLARGEMP_int = 1'b0;

ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim SLEEP_MUX (vddmo_int,1'b0,SLEEP_buf,SLEEP_gated);

and (pswsmallma_int,SLEEP_gated,PSWSMALLMA_int);
and (pswlargema_int,SLEEP_gated,PSWLARGEMA_int);
not (pswsmallma_close, pswsmallma_int);
not (pswlargema_close, pswlargema_int);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim switch_pswsmallma (pswsmallma_close,vddma_int,vddmai_small);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim switch_pswlargema (pswlargema_close,vddma_int,vddmai_large);
ST_DPHD_HIPERF_2048x32m4_Tlmr_WANDprim wand_vddmai (vddmai_int,vddmai_small,vddmai_large);

and (pswsmallmp_int,SLEEP_gated,PSWSMALLMP_int);
and (pswlargemp_int,SLEEP_gated,PSWLARGEMP_int);
not (pswsmallmp_close, pswsmallmp_int);
not (pswlargemp_close, pswlargemp_int);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim switch_pswsmallmp (pswsmallmp_close,vddmp_int,vddmpi_small);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim switch_pswlargemp (pswlargemp_close,vddmp_int,vddmpi_large);
ST_DPHD_HIPERF_2048x32m4_Tlmr_WANDprim wand_vddmpi (vddmpi_int,vddmpi_small,vddmpi_large);


//-----------------------------------------------------------------
//   Calculating the valid states for all power supplies ends
//-----------------------------------------------------------------
reg pswsmallmp_stable=1'b1,pswlargema_stable=1'b1,pswlargemp_stable=1'b1,pswsmallma_stable=1'b1;
reg pswsmallmp_toggle=1'b0,pswlargema_toggle=1'b0,pswlargemp_toggle=1'b0,pswsmallma_toggle=1'b0;

assign supply_ok = (vddmo_int === p_ok && vddmpi_int === p_ok && vddmai_int === p_ok && gndm_int === p_ok)? 1'b1 : 1'b0;

//-----------------------------------------------------------------
//        Actions taken on Power supplies toggling starts
//-----------------------------------------------------------------

always @(SLEEP_gated ) begin
   if ($realtime > 0) begin	
	sleep_toggle_time = $realtobits($realtime);
	if (SLEEP_gated !== 1'b1 && vddmo_int === 1'b1)begin	
          if (pswsmallma_stable !== 1'b1 || pswsmallmp_stable !== 1'b1 || pswlargema_stable !== 1'b1 || pswlargemp_stable !== 1'b1 || PSWLARGEMA_int !== 1'b0 || PSWSMALLMA_int !== 1'b0 || PSWLARGEMP_int !== 1'b0 || PSWSMALLMP_int !== 1'b0)begin
            Block_Memory("SLEEP");
          end    
          if (power_pins_config !== `mono_rail)begin
            #`access_time;  
            Proper_Shutdown_Checker;
              if (Proper_shutdown !== 1'b1 && supply_ok === 1'b0)Block_Memory("SLEEP");
          end
        end  
   end
end    

always @(vddmpi_int ) begin
   if ($realtime > 0) begin	
	vddmp_toggle_time = $realtobits($realtime);
        #`access_time;
        Proper_Shutdown_Checker;
        if (Proper_shutdown !== 1'b1)begin
          if (power_pins_config === `dual_rail || power_pins_config === `mo_ma_tied)begin
            if (SLEEP_gated === 1'b1) begin
		if (vddmpi_int !== 1'b1) begin
		Corrupt_Periphery("vddm");
		Supply_timings_checker ("vddm",vddmpi_int, vddmp_toggle_time, sleep_toggle_time, vddmo_toggle_time, t_sl_mp, t_mo_mp);
	        end
	    end
            else Block_Memory("vddm");
          end
          else if (power_pins_config === `mo_mp_tied)begin
	    if (SLEEP_gated === 1'b1 || (vddmo_int === 1'bx && (vddmai_int === 1'b0 || vddmai_int === 1'bz))) begin
		if (vddmpi_int !== 1'b1) begin
		Corrupt_Periphery("vddm");
		Supply_timings_checker ("vddm",vddmpi_int, vddmp_toggle_time, sleep_toggle_time, vddmo_toggle_time, t_sl_mp, t_mo_mp);
	        end
   	    end
            else Block_Memory("vddm");
          end 
          else begin    //mono_rail
            if (supply_ok !== 1'b1)begin
              Corrupt_Periphery("vddm");
            end
          end
        end  
   end 
end




always @(vddmai_int ) begin
   if ($realtime > 0) begin	
	vddma_toggle_time = $realtobits($realtime);
        #`access_time;
        Proper_Shutdown_Checker;
	if (Proper_shutdown !== 1'b1)begin
          if (power_pins_config === `dual_rail || power_pins_config === `mo_mp_tied)begin
            if (SLEEP_gated === 1'b1) begin
		if (vddmai_int !== 1'b1) begin
		Corrupt_Array("vddm");
		Supply_timings_checker ("vddm",vddmai_int, vddma_toggle_time, sleep_toggle_time, vddmo_toggle_time, t_sl_ma, t_mo_ma);
                end      
            end      
            else Block_Memory("vddm");
          end
          else if (power_pins_config === `mo_ma_tied)begin
	    if (SLEEP_gated === 1'b1 || (vddmo_int === 1'bx && (vddmpi_int === 1'b0 || vddmpi_int === 1'bz))) begin
		if (vddmai_int !== 1'b1) begin
		Corrupt_Array("vddm");
		Supply_timings_checker ("vddm",vddmai_int, vddma_toggle_time, sleep_toggle_time, vddmo_toggle_time, t_sl_ma, t_mo_ma);
	        end
	    end
            else Block_Memory("vddm");
          end 
          else begin
            if (supply_ok !== 1'b1)begin
              Corrupt_Array("vddm");
            end
          end  
	end
   end
end




always @(gndm_int ) begin
   if ($realtime > 0) begin
        if (gndm_int !== p_ok) Block_Memory("gndm");	
   end     
end



always @ (Proper_shutdown)begin
  if (Proper_shutdown !== 1'b0)begin
    Corrupt_Peri_Array("vddm");
    
  end   
end  

//------------- eswitch functionality starts ------------------//

always @(PSWSMALLMA_int or PSWLARGEMA_int or PSWSMALLMP_int or PSWLARGEMP_int)begin
  if ($realtime > 0) begin
    if (SLEEP_gated === 1'bx && vddmo_int !== 1'bx)begin
      Block_Memory("SLEEP");
    end
  end
end  

always @(pswsmallma_int)begin
  pswsmallma_toggle = 1'b1;
  pswsmallma_toggle <= 1'b0;
end  

always @(pswsmallma_toggle)begin
  if ($realtime > 0)begin
      if(pswsmallma_int !== 1'b0)pswsmallma_stable = 1'b0;
      if (pswsmallma_int !== 1'b1)fork: block_pswsmallma
        begin
          #(p_pswsmallma_settling_time);
          pswsmallma_stable = 1'b1;
          disable block_pswsmallma;
        end  
        @(pswsmallma_int)begin
          pswsmallma_stable = 1'b0;
          disable block_pswsmallma;
        end
      join
  end
end  

always @(pswlargema_int)begin
  pswlargema_toggle = 1'b1;
  pswlargema_toggle <= 1'b0;
end  

always @ (pswlargema_toggle)begin
  if ($realtime > 0)begin
      if(pswlargema_int !== 1'b0)pswlargema_stable = 1'b0;
      if (pswlargema_int !== 1'b1)begin
        if (pswsmallma_int !== 1'b1 && pswsmallma_stable === 1'b1)fork: block_pswlargema
        begin
          #(p_pswlargema_settling_time);
          pswlargema_stable = 1'b1;
          disable block_pswlargema;
        end  
        @(pswsmallma_int or pswlargema_int or pswsmallma_stable)begin
          pswlargema_stable = 1'b0;
          disable block_pswlargema;
        end  
        join
        else begin
            Block_Memory("PSWLARGEM");
        end      
      end  
  end
end  

always @(pswsmallmp_int)begin
  pswsmallmp_toggle = 1'b1;
  pswsmallmp_toggle <= 1'b0;
end  

always @(pswsmallmp_toggle)begin
  if ($realtime > 0)begin
      if(pswsmallmp_int !== 1'b0)pswsmallmp_stable = 1'b0;
      if (pswsmallmp_int !== 1'b1)fork: block_pswsmallmp
        begin
          #(p_pswsmallmp_settling_time);
          pswsmallmp_stable = 1'b1;
          disable block_pswsmallmp;
        end  
        @(pswsmallmp_int)begin
          pswsmallmp_stable = 1'b0;
          disable block_pswsmallmp;
        end
      join
  end
end  

always @(pswlargemp_int)begin
  pswlargemp_toggle = 1'b1;
  pswlargemp_toggle <= 1'b0;
end  

always @ (pswlargemp_toggle)begin
  if ($realtime > 0)begin
      if(pswlargemp_int !== 1'b0)pswlargemp_stable = 1'b0;
      if (pswlargemp_int !== 1'b1)begin
        if (pswsmallmp_int !== 1'b1 && pswsmallmp_stable === 1'b1)fork: block_pswlargemp
        begin
          #(p_pswlargemp_settling_time);
          pswlargemp_stable = 1'b1;
          disable block_pswlargemp;
        end  
        @(pswsmallmp_int or pswlargemp_int or pswsmallmp_stable)begin
          pswlargemp_stable = 1'b0;
          disable block_pswlargemp;
        end  
        join
        else begin
            Block_Memory("PSWLARGEM");
        end      
      end  
  end
end  

//---------------------- eswitch functionality ends -----------------------//


//-----------------------------------------------------------------
//          Actions taken on Power supplies toggling ends
//-----------------------------------------------------------------

task Proper_Shutdown_Checker;
begin
  if (vddmo_int === 1'b0 && (vddmai_int === 1'b0 || vddmai_int === 1'bz) && (vddmpi_int === 1'b0 || vddmpi_int === 1'bz))begin
    Proper_shutdown = 1'b1;
  end
  else if (vddmo_int === 1'bx && vddma_int === 1'bx && vddmp_int === 1'bx) begin
    Proper_shutdown = 1'bx;
  end
  else begin
    Proper_shutdown = 1'b0;
  end
end
endtask

task Supply_timings_checker;
input [1023 : 0] input_string;
input input1;
input [63 : 0] real_time;
input [63 : 0] shut_time, rampup_time;
input [63 : 0] t_off, t_on;
begin
        if (input1 === 1'b0) begin
		if ((real_time - $bitstoreal(shut_time)) <= $bitstoreal(t_off)) Block_Memory(input_string);
	end
	else if (input1 === 1'b1) begin
		if ((real_time - $bitstoreal(rampup_time)) <= $bitstoreal(t_on)) Block_Memory(input_string);
	end
end
endtask

task Corrupt_Periphery;
input [1023:0] input_string;
begin
        WriteOut1X;
	WriteOut2X;
        DFT_port1_ScanChainX;
        DFT_port1_ScanOutX;
        DFT_port2_ScanChainX;
        DFT_port2_ScanOutX;
        if ( (debug_level > 1) && ($realtime > message_control_time) ) $display ("%m - %t ST_WARNING : Invalid Value/Sequence on %0s. Output Q and Scan flops corrupted", $realtime, input_string);
end
endtask

task Corrupt_Array;
input [1023:0] input_string;
begin
        MemX;
        if ( (debug_level > 1) && ($realtime > message_control_time) ) $display ("%m - %t ST_WARNING : Invalid Value/Sequence on %0s. Memory corrupted", $realtime, input_string);
end
endtask

task Corrupt_Peri_Array;
input [1023:0] input_string;
begin
        Corrupt_Periphery(input_string);
        Corrupt_Array(input_string);
end
endtask

task Block_Memory;
input [1023:0] input_string;
begin
`ifdef ST_MEM_NO_BLOCK_MEM
       MemX;
       WriteOut1X;
       WriteOut2X;
       delOutReg1_data =WordX;
       delOutReg2_data =WordX;
       DFT_port1_ScanChainX;
       DFT_port1_ScanOutX;
       DFT_port2_ScanChainX;
       DFT_port2_ScanOutX;
        if ( (debug_level > 0) && ($realtime > message_control_time) ) $display ("%m - %t ST_ERROR : Invalid Value/Sequence on %0s. Memory Contents, Output Q and Scan flops corrupted", $realtime, input_string);
`else  
     if ($realtime > mem_block_ctrl_time) begin
        Corrupt_Peri_Array(input_string);
        mem_blocked = 1'b1;
          if ( (debug_level > 0) && ($realtime > message_control_time) ) $display ("%m - %t ST_ERROR : Invalid Value/Sequence on %0s. Memory Contents, Output Q and Scan flops corrupted. All further operations on the Memory are Blocked", $realtime, input_string);
     end
     else begin
       MemX;
       WriteOut1X;
       WriteOut2X;
       delOutReg1_data =WordX;
       delOutReg2_data =WordX;
       DFT_port1_ScanChainX;
       DFT_port1_ScanOutX;
       DFT_port2_ScanChainX;
       DFT_port2_ScanOutX;
     if ( (debug_level > 0) && ($realtime > message_control_time) ) $display ("%m - %t ST_ERROR : Invalid Value/Sequence on %0s. Memory Contents, Output Q and Scan flops corrupted", $realtime, input_string);
     end
`endif
end
endtask

task UnBlock_Memory;
begin
  mem_blocked = 1'b0;
  pswsmallma_stable = 1'b1;       
  pswlargema_stable = 1'b1;
  pswsmallmp_stable = 1'b1;
  pswlargemp_stable = 1'b1;

end
endtask

//--------------------------------------------------------------------
//                 POWER PINS FUNCTIONALITY ENDS
//--------------------------------------------------------------------
`endif

//----------------------------------------------------------------------
  
  // WIRE DECLARATION RELATED TO POWER PINS
  // ======================================

   wire  [Bits-1:0] D1int;
   wire  [Bits-1:0] D2int;

   wire  [Bits-1:0] M1int; 
   wire  [Bits-1:0] M2int; 
   wire  [Bits-1:0] M1int_inv; 
   wire  [Bits-1:0] M2int_inv; 

   wire  [Addr-1:0] A1int;
   wire  [Addr-1:0] A2int;


   wire  CSN1int,WEN1int,CSN1_SEint, CSN2_SEint;

   wire  [scanlen_ctrl_port1 -1 -3 : 0] A1_int ;
   wire  [scanlen_ctrl_port2 -1 -2 : 0] A2_int ;

   wire  CSN2int,WEN2int ;
   wire CK1int_dft , CK2int_dft;
   wire  LStempint,LSint;
   wire  HStempint,HSint;
   wire  INITNtempint;
   wire  SLEEPtempint;
   wire  TBYPASStempint;
   wire  IG1tempint,IG1int;
   wire  IG2tempint,IG2int;
   wire  ATPint;
   wire CK1tempint , CK2tempint , MTCKtempint, CK1fint , CK2fint ;
   wire MEMEN_1, MEMEN_2, MEMEN_DFT1, MEMEN_DFT2 ;
   wire [read_margin_size - 1 : 0 ] RMint;
   wire [write_margin_size - 1 : 0 ] WMint;
   wire [repair_address_bus_width -1 : 0] RRAint;
   wire RRAEint;
   wire TRRAE1int;  
   wire TRRAE2int;
   wire TRRAEint;    
   wire red_en1;
   wire red_en2;
   wire [repair_address_bus_width -1 : 0] repair_add, next_repair_add;
   wire SEint;
   wire SElatch;
   reg LastSEint;
   wire STDBY1int, STDBY2int;
 wire LP_CK_gate1;
 wire LP_CK_gate2;

 reg MTCKint,CK2int,CK1int;
reg CK1reg_dft;
reg CK2reg_dft;


reg TimingViol_A1_CK1,TimingViol_TA1_CK1,TimingViol_TA1_MTCK,TimingViol_A2_CK2,TimingViol_TA2_CK2,TimingViol_TA2_MTCK,TimingViol_WEN1_CK1,TimingViol_TWEN1_CK1,TimingViol_TWEN1_MTCK, TimingViol_WEN2_CK2,TimingViol_TWEN2_CK2,TimingViol_TWEN2_MTCK,  TimingViol_CSN1_CK1,TimingViol_TCSN1_CK1,TimingViol_TCSN1_MTCK,TimingViol_CSN2_CK2,TimingViol_TCSN2_CK2,TimingViol_TCSN2_MTCK,TimingViol_IG1_CK1,TimingViol_IG1_MTCK,TimingViol_IG2_CK2,TimingViol_IG2_MTCK,TimingViol_SE_CK1,TimingViol_SE_MTCK,TimingViol_SE_CK2,TimingViol_INITNl,TimingViol_INITN_CK1,TimingViol_INITN_MTCK,TimingViol_INITN_CK2,TimingViol_TBYPASS_CK1, TimingViol_TBYPASS_MTCK,TimingViol_TBYPASS_CK2,TimingViol_SCTRLI1_CK1,TimingViol_SDLI1_CK1,TimingViol_SDRI1_CK1,TimingViol_SMLI1_CK1,TimingViol_SMRI1_CK1, TimingViol_SCTRLI2_CK2,TimingViol_SDLI2_CK2,TimingViol_SDRI2_CK2,TimingViol_SMLI2_CK2,TimingViol_SMRI2_CK2,  TimingViol_TBIST_CK1,TimingViol_TBIST_MTCK,TimingViol_TBIST_CK2,TimingViol_ATP_CK1,TimingViol_ATP_MTCK,TimingViol_ATP_CK2,TimingViol_CYCLE_1,TimingViol_CKH_1,TimingViol_CKL_1,TimingViol_CYCLE_SE_1,TimingViol_CKH_SE_1,TimingViol_CKL_SE_1,TimingViol_CYCLE_2,TimingViol_CKH_2,TimingViol_CKL_2,TimingViol_CYCLE_SE_2,TimingViol_CKH_SE_2,TimingViol_MTCKCYCLE,TimingViol_MTCKH,TimingViol_MTCKL,TimingViol_CKL_SE_2,TimingViol_CK2_CK1,TimingViol_CK1_CK2,TimingViol_STDBY2_CK2,TimingViol_STDBY1_MTCK,TimingViol_STDBY2_MTCK,TimingViol_STDBY1_CK1,TimingViol_dummy;


reg TimingViol_TED1_CK1,TimingViol_TED2_CK2,TimingViol_TOD1_CK1,TimingViol_TOD2_CK2, TimingViol_TED1_MTCK, TimingViol_TOD1_MTCK, TimingViol_TED2_MTCK, TimingViol_TOD2_MTCK, TimingViol_TEM1_CK1, TimingViol_TOM1_CK1, TimingViol_TEM2_CK2, TimingViol_TOM2_CK2, TimingViol_TEM1_MTCK, TimingViol_TOM1_MTCK, TimingViol_TEM2_MTCK, TimingViol_TOM2_MTCK, TimingViol_CSN1_TBIST, TimingViol_CSN1_ATP, TimingViol_CSN1_TBYPASS, TimingViol_CSN2_TBIST, TimingViol_CSN2_ATP, TimingViol_CSN2_TBYPASS, TimingViol_TCSN1_TBIST, TimingViol_TCSN1_ATP, TimingViol_TCSN1_TBYPASS, TimingViol_TCSN2_TBIST, TimingViol_TCSN2_ATP, TimingViol_TCSN2_TBYPASS, TimingViol_TCYCLE_TP_1, TimingViol_TCYCLE_TP_2, TimingViol_TP_CK1, TimingViol_TP_CK2, TimingViol_TP_MTCK, TimingViol_TRRAE1_CK1,TimingViol_TRRAE2_CK2 ;

reg TimingViol_RM_CK1, TimingViol_RM_CK2,TimingViol_WM_CK1,TimingViol_WM_CK2,TimingViol_RM_MTCK,TimingViol_WM_MTCK;
reg TimingViol_RRA_CK1, TimingViol_RRA_CK2, TimingViol_RRA_MTCK, TimingViol_RRAE_CK1, TimingViol_RRAE_CK2, TimingViol_RRAE_MTCK, TimingViol_TRRAE1_MTCK, TimingViol_TRRAE2_MTCK; 





reg TimingViol_D1_CK1_0;
reg TimingViol_D2_CK2_0;


reg TimingViol_D1_CK1_1;
reg TimingViol_D2_CK2_1;


reg TimingViol_D1_CK1_2;
reg TimingViol_D2_CK2_2;


reg TimingViol_D1_CK1_3;
reg TimingViol_D2_CK2_3;


reg TimingViol_D1_CK1_4;
reg TimingViol_D2_CK2_4;


reg TimingViol_D1_CK1_5;
reg TimingViol_D2_CK2_5;


reg TimingViol_D1_CK1_6;
reg TimingViol_D2_CK2_6;


reg TimingViol_D1_CK1_7;
reg TimingViol_D2_CK2_7;


reg TimingViol_D1_CK1_8;
reg TimingViol_D2_CK2_8;


reg TimingViol_D1_CK1_9;
reg TimingViol_D2_CK2_9;


reg TimingViol_D1_CK1_10;
reg TimingViol_D2_CK2_10;


reg TimingViol_D1_CK1_11;
reg TimingViol_D2_CK2_11;


reg TimingViol_D1_CK1_12;
reg TimingViol_D2_CK2_12;


reg TimingViol_D1_CK1_13;
reg TimingViol_D2_CK2_13;


reg TimingViol_D1_CK1_14;
reg TimingViol_D2_CK2_14;


reg TimingViol_D1_CK1_15;
reg TimingViol_D2_CK2_15;


reg TimingViol_D1_CK1_16;
reg TimingViol_D2_CK2_16;


reg TimingViol_D1_CK1_17;
reg TimingViol_D2_CK2_17;


reg TimingViol_D1_CK1_18;
reg TimingViol_D2_CK2_18;


reg TimingViol_D1_CK1_19;
reg TimingViol_D2_CK2_19;


reg TimingViol_D1_CK1_20;
reg TimingViol_D2_CK2_20;


reg TimingViol_D1_CK1_21;
reg TimingViol_D2_CK2_21;


reg TimingViol_D1_CK1_22;
reg TimingViol_D2_CK2_22;


reg TimingViol_D1_CK1_23;
reg TimingViol_D2_CK2_23;


reg TimingViol_D1_CK1_24;
reg TimingViol_D2_CK2_24;


reg TimingViol_D1_CK1_25;
reg TimingViol_D2_CK2_25;


reg TimingViol_D1_CK1_26;
reg TimingViol_D2_CK2_26;


reg TimingViol_D1_CK1_27;
reg TimingViol_D2_CK2_27;


reg TimingViol_D1_CK1_28;
reg TimingViol_D2_CK2_28;


reg TimingViol_D1_CK1_29;
reg TimingViol_D2_CK2_29;


reg TimingViol_D1_CK1_30;
reg TimingViol_D2_CK2_30;


reg TimingViol_D1_CK1_31;
reg TimingViol_D2_CK2_31;


reg TimingViol_stdby;
reg [Bits - 1: 0] TimingViol_D1,TimingViol_D1_MTCK,TimingViol_M1,TimingViol_M1_MTCK;
reg [Bits - 1: 0] TimingViol_D1_last,TimingViol_D1_MTCK_last,TimingViol_M1_last,TimingViol_M1_MTCK_last;
reg [Bits - 1: 0] TimingViol_D2,TimingViol_D2_MTCK,TimingViol_M2,TimingViol_M2_MTCK;
reg [Bits - 1: 0] TimingViol_D2_last,TimingViol_D2_MTCK_last,TimingViol_M2_last,TimingViol_M2_MTCK_last;


reg [Addr-mux_bits-1:0]A1row;
reg [Addr-mux_bits-1:0]A2row;
  
   
wire [scanlen_ctrl_port2 - 1 : 0] scanreg_ctrl_port2_wire;
wire [scanlen_ctrl_port1 - 1 : 0] scanreg_ctrl_port1_wire;

assign LP_CK_gate1 = scanreg_ctrl_port1_wire[13]; 
assign LP_CK_gate2 = scanreg_ctrl_port2_wire[13]; 


        

   assign D1int[0] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[0] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[0] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[0] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[1] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[1] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[1] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[1] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[2] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[2] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[2] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[2] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[3] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[3] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[3] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[3] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[4] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[4] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[4] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[4] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[5] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[5] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[5] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[5] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[6] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[6] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[6] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[6] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[7] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[7] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[7] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[7] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[8] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[8] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[8] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[8] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[9] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[9] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[9] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[9] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[10] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[10] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[10] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[10] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[11] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[11] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[11] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[11] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[12] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[12] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[12] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[12] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[13] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[13] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[13] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[13] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[14] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[14] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[14] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[14] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[15] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[15] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[15] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[15] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[16] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[16] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[16] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[16] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[17] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[17] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[17] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[17] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[18] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[18] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[18] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[18] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[19] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[19] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[19] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[19] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[20] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[20] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[20] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[20] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[21] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[21] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[21] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[21] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[22] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[22] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[22] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[22] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[23] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[23] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[23] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[23] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[24] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[24] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[24] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[24] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[25] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[25] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[25] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[25] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[26] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[26] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[26] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[26] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[27] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[27] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[27] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[27] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[28] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[28] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[28] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[28] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[29] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[29] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[29] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[29] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 


        

   assign D1int[30] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[30] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED1_buf : 1'bx;
   assign D2int[30] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[30] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1) ? TED2_buf : 1'bx;

  




   assign D1int[31] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D1_buf[31] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD1_buf : 1'bx;
   assign D2int[31] = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? D2_buf[31] : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TOD2_buf : 1'bx; 

 



   assign M1int = 32'b0;     
   assign M2int = 32'b0;    


assign M1int_inv = ~ M1int;
assign M2int_inv = ~ M2int;

assign A1int = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? A1_buf : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TA1_buf : addrx ;
  assign A2int = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? A2_buf : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TA2_buf : addrx ;

assign A1_int = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? A1_buf : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TA1_buf : addrx ;
assign A2_int = (ATP_buf === 1'b0 || TBIST_buf === 1'b0) ? A2_buf : (ATP_buf === 1'b1 && TBIST_buf === 1'b1 ) ? TA2_buf : addrx ;


assign WEN1_int = WEN1int;
assign WEN2_int = WEN2int;
assign CSN1_int = CSN1int;
assign CSN2_int = CSN2int;  


assign WEN1int = (ATP_buf === 1'b1) ? (SE_buf === 1'b0) ? (TBIST_buf === 1'b0 ) ? WEN1_buf : (TBIST_buf === 1'b1 ) ? TWEN1_buf : 1'bx : (SE_buf === 1'b1) ? 1'b1 : 1'bx : (ATP_buf === 1'b0) ? WEN1_buf : 1'bx;

assign WEN2int = (ATP_buf === 1'b1) ? (SE_buf === 1'b0) ? (TBIST_buf === 1'b0 ) ? WEN2_buf : (TBIST_buf === 1'b1 ) ? TWEN2_buf : 1'bx : (SE_buf === 1'b1) ? 1'b1 : 1'bx : (ATP_buf === 1'b0) ? WEN2_buf : 1'bx;

   assign WEN1sys = WEN1_buf;
   assign TWEN1sys = TWEN1_buf;
   assign WEN2sys = WEN2_buf;
   assign TWEN2sys = TWEN2_buf;

   
assign CSN1int = (ATP_buf === 1'b1) ? (SE_buf === 1'b0) ? (TBIST_buf === 1'b0 ) ? CSN1_buf : (TBIST_buf === 1'b1 ) ? TCSN1_buf : 1'bx : (SE_buf === 1'b1) ? 1'b1 : 1'bx : (ATP_buf === 1'b0) ? CSN1_buf : 1'bx;

 assign CSN2int = (ATP_buf === 1'b1) ? (SE_buf === 1'b0) ? (TBIST_buf === 1'b0 ) ? CSN2_buf : (TBIST_buf === 1'b1 ) ? TCSN2_buf : 1'bx : (SE_buf === 1'b1) ? 1'b1 : 1'bx : (ATP_buf === 1'b0) ? CSN2_buf : 1'bx;

//added only for ATP toggling. where SE is not guaranteed. hence if SE=1, CSNint cannot stop FSM corruption.

assign CSN1_SEint = (ATP_buf === 1'b1) ?  (TBIST_buf === 1'b0 ) ? CSN1_buf : (TBIST_buf === 1'b1 ) ? TCSN1_buf : 1'bx : (ATP_buf === 1'b0) ? CSN1_buf : 1'bx;
 assign CSN2_SEint = (ATP_buf === 1'b1) ?  (TBIST_buf === 1'b0 ) ? CSN2_buf : (TBIST_buf === 1'b1 ) ? TCSN2_buf : 1'bx : (ATP_buf === 1'b0) ? CSN2_buf : 1'bx;

   assign CSN2sys = CSN2_buf;
   assign TCSN2sys = TCSN2_buf;
   assign CSN1sys = CSN1_buf;
   assign TCSN1sys = TCSN1_buf;


    
   //Clock Mux


   buf (CK1tempint , CK1);
   buf (CK2tempint , CK2);
   buf (MTCKtempint , MTCK);
   
   assign CK1int_dft = CK1;
   assign CK1sys = CK1;
   assign CK2int_dft = CK2;
   assign CK2sys = CK2;
   assign MTCKsys = MTCK;
  
  

   assign INITNint = INITN_buf;
assign TBISTint = TBIST_buf;
assign TBYPASSint = TBYPASS_buf;

   
   assign LSint = 1'b0; 
   
   assign HSint = 1'b0; 

   assign STDBY1int = STDBY1_buf;   
   assign STDBY2int = STDBY2_buf; 


   
   assign SLEEPint = 1'b0; 
   assign SEint  = SE_buf;
 
assign IG1int = (ATP_buf === 1'b1) ? (SE_buf === 1'b0 ) ? IG1_buf : (SE_buf === 1'b1 ) ? 1'b1 : 1'bx : (ATP_buf === 1'b0) ? IG1_buf : 1'bx;
 assign IG1sys = IG1_buf;

 assign IG2int = (ATP_buf === 1'b1) ? (SE_buf === 1'b0 ) ? IG2_buf : (SE_buf === 1'b1 ) ? 1'b1 : 1'bx : (ATP_buf === 1'b0) ? IG2_buf : 1'bx;
 assign IG2sys = IG2_buf;


assign ATPint = ATP_buf;
   assign SCTRLI1int = SCTRLI1_buf;
   assign SDLI1int = SDLI1_buf;
   assign SDRI1int = SDRI1_buf;
   assign SCTRLI2int = SCTRLI2_buf;
   assign SDLI2int = SDLI2_buf;
   assign SDRI2int = SDRI2_buf;

 


   assign RMint = {read_margin_size{1'b0}};
   assign WMint = {write_margin_size{1'b0}};



   
     assign RRAint = 0;
     assign RRAEint = 1'b0;
     assign TRRAEint = 1'b0;
     assign TRRAE1int = 1'b0;
     assign TRRAE2int = 1'b0;

     assign repair_add = 0;
     assign next_repair_add = 0;
     assign red_en1 = 1'b0;
     assign red_en2 = 1'b0; 
   

   // parameter registers
   reg [2047:0] reg_Fault_file_name;
   reg reg_ConfigFault;
   reg reg_MEM_INITIALIZE;
   reg reg_BinaryInit;
   reg [2047:0] reg_InitFileName;
   reg [Bits -1 :0] reg_Initn_reset_value;
   time reg_File_load_time;
     
 //Power Supply Registers        

reg CK1_sc;
reg CK2_sc; 
reg Latch_open_1 = 0; 
reg Latch_open_2 = 0; 


   // RAM array
   `ifdef ST_MEM_SLM
   `else
   reg [Bits-1 : 0] Mem [Words-1 : 0];                      // Memory RAM array
   reg [Bits-1 : 0] RedMem [RedWords-1 : 0];        // Redundant RAM array
   `endif

   reg [Bits-1:0] Q1int;
   reg [Bits-1:0] Q2int;
   reg [Bits-1 : 0] OutReg1_data;
   reg [Bits-1 : 0] OutReg1_data_tim;
   reg [Bits-1 : 0] OutReg2_data;
   reg [Bits-1 : 0] OutReg2_data_tim;

   reg RRMATCH1reg, RRMATCH2reg,RRMATCH1reg_glitch,RRMATCH2reg_glitch;
   reg [repair_address_bus_width -1 : 0] port1_address_cmp, port2_address_cmp, repair_add_last_port1, repair_add_last_port2;
   reg RRAEint_last_port1, RRAEint_last_port2;
   reg RADswapflag;
   reg RADEreg;
   reg STDBY1reg;
   reg STDBY2reg;

   reg SLEEPreg_radck;
   reg [Bits-1 : 0] tbydata;
   reg [Bits-1 : 0] prevContents, newContents;
   wire WEN1internal;
   wire WEN2internal;



   reg flag_invalid_next_port1_cycle;      // if == 1 then it implies that memory port1 state machine has been corrupted and hence next port1 cycle is blocked.
   reg flag_invalid_present_port1_cycle; // if == 1 then it implies that memory port1 state machine was corrupted and hence this port1 cycle is blocked.
   reg flag_invalid_next_port2_cycle;    // if == 1 then it implies that memory port2 state machine has been corrupted and hence next port2 cycle is blocked.
   reg flag_invalid_present_port2_cycle; // if == 1 then it implies that memory port2 state machine was corrupted and hence this port2 cycle is blocked.
   reg lastSLEEP;
   reg file_loaded;
   reg lastCK1;
   reg lastCK2;
   reg lastMTCK;
   reg lastCK1tempint,lastCK2tempint,lastMTCKtempint;
   reg MEMEN_1_CK1_reg_pre,MEMEN_1_CK1_reg;
   reg MEMEN_2_CK2_reg_pre,MEMEN_2_CK2_reg;
   reg MEMEN_1_MTCK_reg_pre,MEMEN_1_MTCK_reg;
   reg MEMEN_2_MTCK_reg_pre,MEMEN_2_MTCK_reg;
   reg MEMEN_DFT_CK1_reg_pre,MEMEN_DFT_CK1_reg;
   reg MEMEN_DFT_CK2_reg_pre,MEMEN_DFT_CK2_reg;
reg scanreg_ctrl_port2;
reg scanreg_ctrl_port1;


reg scanreg_d1l;
reg scanreg_d1r;

   wire [scanlen_d1l - 1 :0] scanreg_d1l_wire;
   wire [scanlen_d1r -1 :0] scanreg_d1r_wire;

reg scanreg_d2l;
reg scanreg_d2r;

   wire [scanlen_d2l - 1 :0] scanreg_d2l_wire;
   wire [scanlen_d2r -1 :0] scanreg_d2r_wire;
        
   
   reg ATPreg_CK1,ATPreg_CK2,SLEEPreg_CK1,SLEEPreg_CK2,INITNreg_CK1,INITNreg_CK2,SEreg_CK2,SEreg_CK1,STDBY1reg_CK1,STDBY2reg_CK2, TBYPASSreg_CK2, TBYPASSreg_CK1;
   reg lastCK2_dft, lastCK1_dft;
   reg flag_invalid_next_port1_dft_cycle,flag_invalid_next_port2_dft_cycle;
   reg flag_invalid_present_port1_dft_cycle,flag_invalid_present_port2_dft_cycle;
   reg SCTRLO1_data,SCTRLO2_data,SDLO1_data,SDRO1_data,SMLO1_data,SMRO1_data,SDLO2_data,SDRO2_data,SMLO2_data,SMRO2_data;
   reg SCTRLO1_data_tim,SCTRLO2_data_tim,SDLO1_data_tim,SDRO1_data_tim,SMLO1_data_tim,SMRO1_data_tim,SDLO2_data_tim,SDRO2_data_tim,SMLO2_data_tim,SMRO2_data_tim;
   reg delSCTRLO1_data,delSCTRLO2_data,delSDLO1_data,delSDRO1_data,delSMLO1_data,delSMRO1_data,delSDLO2_data,delSDRO2_data,delSMLO2_data,delSMRO2_data;
   reg CSN1sys_reg_CK1_pre,CSN1sys_reg_CK1,WEN2sys_reg_CK2, WEN1sys_reg_CK1,IG1sys_reg_CK1,INITNsys_reg_CK1,ATPsys_reg_CK1,SEsys_reg_CK1,SEsys_reg_CK1_pre, TBISTsys_reg_CK1,TBYPASSsys_reg_CK1,STDBY1sys_reg_CK1, STDBY2sys_reg_CK2, RRAEsys_reg_CK1,RRAEsys_reg_CK2,RRAEsys_reg_MTCK,red_en1sys_regCK1, red_en2sys_regCK2;
   reg CSN2sys_reg_CK2_pre,CSN2sys_reg_CK2,IG2sys_reg_CK2,INITNsys_reg_CK2,SLEEPsys_reg_CK2,SLEEPsys_reg_CK1, ATPsys_reg_CK2,SEsys_reg_CK2,SEsys_reg_CK2_pre, TBISTsys_reg_CK2,TBYPASSsys_reg_CK2;
   reg [Addr - 1: 0] A1sys_reg_CK1,TA1sys_reg_MTCK,A2sys_reg_CK2,TA2sys_reg_MTCK;
   reg [Bits -1 : 0] M1sys_reg_CK1,M1sys_reg_MTCK, M2sys_reg_CK2,M2sys_reg_MTCK;
   reg [Bits -1 : 0] D1sys_reg_CK1,D1sys_reg_MTCK, D2sys_reg_CK2,D2sys_reg_MTCK;
   reg TCSN2sys_reg_MTCK_pre,TCSN2sys_reg_MTCK,IG2sys_reg_MTCK,TCSN1sys_reg_MTCK_pre,TWEN1sys_reg_MTCK,TWEN2sys_reg_MTCK,IG1sys_reg_MTCK,INITNsys_reg_MTCK,SLEEPsys_reg_MTCK,ATPsys_reg_MTCK,SEsys_reg_MTCK,TBISTsys_reg_MTCK,TCSN1sys_reg_MTCK,TBYPASSsys_reg_MTCK,STDBY1sys_reg_MTCK, STDBY2sys_reg_MTCK;
   reg SCTRLI1int_temp,SCTRLI2int_temp,SDLI1int_temp,SDRI1int_temp,SDLI2int_temp,SDRI2int_temp;
   reg SMLI1int_temp,SMRI1int_temp,  SMLI2int_temp,SMRI2int_temp;
   reg LSsys_reg_CK1, LSsys_reg_CK2, LSsys_reg_MTCK;
   reg HSsys_reg_CK1, HSsys_reg_CK2, HSsys_reg_MTCK;
   
   real CK1_rise_time;
   real CK2_rise_time;
   real TBIST_rise_time;
   real ATP_rise_time;
   real MEMEN_2_rise_time;
   real MEMEN_1_rise_time;
   real RADCK_rise_time;
   real TBYPASS_rise_time;
   real time_fall_sleep,time_fall_PSWLARGEMP,time_fall_PSWLARGEMP_0,time_fall_PSWLARGEMA,time_fall_PSWLARGEMA_0,time_fall_PSWSMALLMP,time_fall_PSWSMALLMA;
   integer e,f,q,k;
   reg corrupt_flag_periphery,corrupt_flag_array; // PCF
   reg lastPSWLARGEMP,lastPSWLARGEMA,lastPSWSMALLMP,lastPSWSMALLMA;
   reg power_up_done; //if == 1 then it implies that power up has been done
   
   `ifdef ST_MEM_SLM
   integer slm_handle;
   integer RedMemAddr;
   `endif


   //************************************************************
   //****** CONFIG FAULT IMPLEMENTATION VARIABLES*************** 
   //************************************************************ 

   integer file_ptr, ret_val,ptr;
   integer fault_word;
   integer fault_bit;
   integer fcnt, Fault_in_memory;
   integer n, cnt, t;  
   integer FailureLocn [max_faults -1 :0];
   integer Failurebit [max_faults -1 :0];
   

   reg [100 : 0] stuck_at;
   reg [100 : 0] fault_array;
   reg [200 : 0] tempStr;
   reg [7:0] fault_char;
   reg [7:0] fault_char1; // 8 Bit File Pointer
   reg [Addr -1 : 0] std_fault_word;
   reg [Addr -1 : mux_bits] fault_row_add [max_faults -1 :0];
   reg [Addr-mux_bits-bank_bits-1:0] fault_row_add_check [max_faults -1 :0];
   reg [max_faults -1 :0] fault_repair_flag;
   reg [max_faults -1 :0] repair_flag;
   reg [Bits - 1: 0] stuck_at_0fault [max_faults -1 : 0];
   reg [Bits - 1: 0] stuck_at_1fault [max_faults -1 : 0];
   reg [100 : 0] array_stuck_at[max_faults -1 : 0] ; 
   reg msgcnt;
   reg [100 : 0] mem_red_array_stuck_at[max_faults -1 : 0] ; 

   reg [Bits -1 : 0] stuck0;
   reg [Bits -1 : 0] stuck1;

   `ifdef ST_MEM_SLM
   reg [Bits -1 : 0] slm_temp_data;
   `endif

   integer flag_error, i;

   /* This register is used to force all messages
   off during run time. 
   This can be foced to 2'b01 for bist_warning_mode
   and to 2'b10 for no_warning_mode at run time
   */
   reg [8*10 : 0] operating_mode;
   reg [8*44 : 0] message_status;
  

//getting internal Write Enable Signal

 or (WEN1internal , CSN1int , WEN1int);
 or (WEN2internal , CSN2int , WEN2int);

 or (SE_or_TBYPASS , SEint , TBYPASSint);
 and (ATP_eff_mem , ATPint , SE_or_TBYPASS);

 nor (MEMEN_1 , !INITNint , SLEEPint , CSN1int , IG1int , ATP_eff_mem, STDBY1int);
 nor (MEMEN_2 , !INITNint , SLEEPint , CSN2int , IG2int , ATP_eff_mem, STDBY2int);

//bist_cap is blocked in ATP.TBIST.!TBYPASS.!SE mode

 nor (MEMEN_DFT1_t , !INITNint , SLEEPint , !ATPint, STDBY1int);
 nor (MEMEN_DFT2_t , !INITNint , SLEEPint , !ATPint, STDBY2int);

nand (nbist_cap, TBISTint, !TBYPASSint, !SEint);

and (MEMEN_DFT1, MEMEN_DFT1_t, nbist_cap );
and (MEMEN_DFT2, MEMEN_DFT2_t, nbist_cap );


reg flag_memory_non_functional = 1'b0;

  
// TASK DEFINITION DESCRIPTION
// ================================


task task_insert_faults_in_memory;
begin
   if (reg_ConfigFault)
   begin   
     for(i = 0;i< fcnt;i = i+ 1) begin
        if(mem_red_array_stuck_at[i] === "mem_array") begin
          if (array_stuck_at[i] === "sa0") begin
           `ifdef ST_MEM_SLM
            //Read first
            $slm_ReadMemoryS(slm_handle, FailureLocn[i], slm_temp_data);
            //operation
            slm_temp_data = slm_temp_data & stuck_at_0fault[i];
            //write back
            $slm_WriteMemoryS(slm_handle, FailureLocn[i], slm_temp_data);
          `else
            Mem[FailureLocn[i]] = Mem[FailureLocn[i]] & stuck_at_0fault[i];
          `endif
         end //if(array_stuck_at)
                                        
         if(array_stuck_at[i] === "sa1") begin
         `ifdef ST_MEM_SLM
            //Read first
            $slm_ReadMemoryS(slm_handle, FailureLocn[i], slm_temp_data);
            //operation
            slm_temp_data = slm_temp_data | stuck_at_1fault[i];
            //write back
            $slm_WriteMemoryS(slm_handle, FailureLocn[i], slm_temp_data);
         `else
            Mem[FailureLocn[i]] = Mem[FailureLocn[i]] | stuck_at_1fault[i]; 
         `endif
         end //if(array_stuck_at)
       end //if mem_red_array_stuck_at
    
    
     end    // end of for
   end  
end
endtask

      

task task_read_fault_file;
begin
/*  -----------Implementation for config fault starts------*/
   msgcnt = X;
   t = 0;
   fault_repair_flag = {max_faults{1'b1}};
   repair_flag = {max_faults{1'b1}};
   if(reg_ConfigFault) 
   begin
      file_ptr = $fopen(reg_Fault_file_name , "r");
      if(file_ptr == 0)
      begin     
          if((debug_level > 0) && ($realtime > message_control_time)) $display("%m - %t ST_ERROR: File cannot be opened ",$realtime);
      end        
      else                
      begin : read_fault_file
        t = 0;
        for (i = 0; i< max_faults; i= i + 1)
        begin
         
           stuck0 = {Bits{1'b1}};
           stuck1 = {Bits{1'b0}};
           fault_char1 = $fgetc (file_ptr);
           if (fault_char1 == 8'b11111111)
              disable read_fault_file;
           ret_val = $ungetc (fault_char1, file_ptr);
           ret_val = $fgets(tempStr, file_ptr);
           ret_val = $sscanf(tempStr, "%s %d %d %s",fault_array,fault_word, fault_bit, stuck_at) ;
           flag_error = 0; 
           if(ret_val !== 0)
           begin         
              if(ret_val == 3 || ret_val == 4)
              begin
                if(ret_val == 3)
                   stuck_at = "sa0";

                if(stuck_at !== "sa0" && stuck_at !== "sa1" && stuck_at !== "none")
                begin
                    if((debug_level > 0) && ($realtime > message_control_time)) $display("%m - %t ST_ERROR: Wrong value for stuck at in fault file ",$realtime);
                   flag_error = 1;
                end    
                      
                if(fault_word >= Words)
                begin
                   if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address out of range in fault file ",$realtime);
                   flag_error = 1;
                end    

                if(fault_bit >= Bits)
                begin  
                    if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Faulty bit out of range in fault file ",$realtime);
                   flag_error = 1;
                end    

                
                        
                if(fault_array !== "mem_array")
                begin
                  if( (debug_level > 1) && ($realtime > message_control_time) ) $display("%m - %t ST_WARNING: Fault array is not mem_array ",$realtime);
                  flag_error = 1;
                end

                if(fault_array === "red_array")
                begin
                  if( (debug_level > 1) && ($realtime > message_control_time) ) $display("%m - %t ST_WARNING: Fault array can't be on redundancy array in non redundancy cut.",$realtime);
                  flag_error = 1;
                end

                
                

                if(flag_error == 0)
                //Correct Inputs
                begin
                   if(stuck_at === "none")
                   begin
                       if((debug_level > 0) && ($realtime > message_control_time)) $display("%m - %t ST_ERROR: No fault injected, empty fault file ",$realtime);
                   end
                   else
                   //Adding the faults
                   begin
                      FailureLocn[t] = fault_word;
                      Failurebit[t]  = fault_bit ;
                      std_fault_word = fault_word;
                      fault_row_add[t] = std_fault_word[Addr-1:mux_bits];
                      fault_row_add_check[t] = {std_fault_word[Addr-mux_bits-1:3+bank_bits],std_fault_word[2:0]};
                      mem_red_array_stuck_at[t] = fault_array;
                      fault_repair_flag[t] = 1'b0;
                      if (stuck_at === "sa0" )
                      begin
                         stuck0[fault_bit] = 1'b0;         
                         stuck_at_0fault[t] = stuck0;
                      end     
                      if (stuck_at === "sa1" )
                      begin
                         stuck1[fault_bit] = 1'b1;
                         stuck_at_1fault[t] = stuck1; 
                      end

                      array_stuck_at[t] = stuck_at;
                      t = t + 1;
                   end //if(stuck_at === "none")  
                end //if(flag_error == 0)
              end //if(ret_val == 2 || ret_val == 3 
              else
              //wrong number of arguments
              begin
                if((debug_level > 0) && ($realtime > message_control_time)) $display("%m - %t ST_ERROR: WRONG VALUES ENTERED FOR FAULTY WORD OR FAULTY BIT OR STUCK_AT IN Fault_file_name ",$realtime); 
                flag_error = 1;
              end
           end //if(ret_val !== 0)
           else
           begin 
               if((debug_level > 0) && ($realtime > message_control_time)) $display("%m - %t ST_ERROR: No fault injected, empty fault file ",$realtime);
           end    
        end //for (i = 0; i< m
      end //begin: read_fault_file  
      $fclose (file_ptr);

      fcnt = t;
      
      //fault injection at time 0.
      task_insert_faults_in_memory;
  end // config_fault 
end
endtask







task WriteMem0;
integer i;
begin
`ifdef ST_MEM_SLM
   $slm_ResetMemory(slm_handle, Word0);
    
`else
    for (i = 0; i < Words; i = i + 1)
       Mem[i] = Word0;
    for (i = 0; i < RedWords; i = i + 1)
         RedMem[i] = Word0;       
`endif 
   task_insert_faults_in_memory;
end
endtask



task MemX;
integer i;
begin
 
 if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory Corrupted ",$realtime);
 if ($realtime != 0)
  `ifdef ST_MEM_SLM
  $slm_ResetMemory(slm_handle, wordx);
   
  `else     
     for (i=0; i< Words; i=i+1)
	Mem[i] = wordx;
     for (i = 0; i < RedWords; i = i + 1)
         RedMem[i] = wordx;   
  `endif      

   //insert faults at every memory corruption
  task_insert_faults_in_memory;
end
endtask


task WriteOut1X;
begin
     
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Output Corrupted ",$realtime);
     OutReg1_data = wordx;
     //OutReg1_data_tim = wordx;
     OutReg1_data_tim <= wordx;  
end               
endtask

task WriteOut2X;
begin
     
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Output Corrupted ",$realtime);
     OutReg2_data = wordx;
     //OutReg2_data_tim = wordx;
     OutReg2_data_tim <= wordx;  
end               
endtask

task Mem_port1_CCL;
reg [Addr-mux_bits-1:0]Row_Add;
reg [Addr-mux_bits-bank_bits-1:0] Row_Add_cmp;


reg [mux_bits-1:0]Col_Add;

integer po,n,Col_Add_integer,Bank_sel_integer,RedMem_address;
reg repair_flag;
begin
  repair_flag = 1'b0;
  Row_Add = A1int[Addr-1: mux_bits];
  Row_Add_cmp = {Row_Add[Addr-mux_bits-1:3+bank_bits],Row_Add[2:0]};

    
  Col_Add = A1int[mux_bits-1:0]; 

  if (red_en1 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add && next_repair_add !== 0)) ) begin
  
    repair_flag = 1'b1;

    Bank_sel_integer = 0 ; 

    if (Row_Add_cmp === repair_add) begin
            
      Col_Add_integer  = Col_Add; 
    end
    else if (Row_Add_cmp === next_repair_add) begin
            
      Col_Add_integer  = Col_Add + mux; 
    end  
    RedMem_address = ( (no_of_red_rows_in_a_bank*Bank_sel_integer*mux) + Col_Add_integer );
  end 
 
  if ((^A1int !== 1'bx && A1int < Words) || (A1int >= Words)) begin
    `ifdef ST_MEM_SLM
      $slm_WriteMemory(slm_handle, A1int, WordX);
    `else  
      if (repair_flag === 1'b0) begin
        $display("%m - %t ST_INFO: Memory CCL at port 1  ",$realtime);
        Mem[A1int] = WordX;
      end
      else if (repair_flag === 1'b1) begin
        $display("%m - %t ST_INFO: Red Memory CCL at port 1  ",$realtime);
        RedMem[RedMem_address] = WordX;
    end
    `endif  
    task_insert_faults_in_memory;
    
    WriteOut1X;
    
    if(CK1_rise_time == CK2_rise_time && STDBY2int===0 && CSN2int === 0 && WEN2int === 1 && IG2int === 0 && RMint === {read_margin_size{1'b0}} && A1int === A2int) begin
      if(!(red_en1 !== red_en2)) 
      WriteOut2X;
    end

  end
  else if (^A1int === 1'bx) begin
    Mem_port1_FSM_Corrupt; 
  end  
end
endtask

task Mem_port2_CCL;
reg [Addr-mux_bits-1:0]Row_Add;
reg [Addr-mux_bits-bank_bits-1:0] Row_Add_cmp;


reg [mux_bits-1:0]Col_Add;

integer po,n,Col_Add_integer,Bank_sel_integer,RedMem_address;
reg repair_flag;
begin
  repair_flag = 1'b0;
  Row_Add = A2int[Addr-1: mux_bits];
  Row_Add_cmp = {Row_Add[Addr-mux_bits-1:3+bank_bits],Row_Add[2:0]};

    
  Col_Add = A2int[mux_bits-1:0]; 

  if (red_en2 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add && next_repair_add !== 0)) ) begin
  
    repair_flag = 1'b1;

    Bank_sel_integer = 0 ; 

    if (Row_Add_cmp === repair_add) begin
            
      Col_Add_integer  = Col_Add; 
    end
    else if (Row_Add_cmp === next_repair_add) begin
            
      Col_Add_integer  = Col_Add + mux; 
    end  
    RedMem_address = ( (no_of_red_rows_in_a_bank*Bank_sel_integer*mux) + Col_Add_integer );
  end 
 
  if ((^A2int !== 1'bx && A2int < Words) || (A2int >= Words)) begin
    `ifdef ST_MEM_SLM
      $slm_WriteMemory(slm_handle, A2int, WordX);
    `else  
      if (repair_flag === 1'b0) begin
        $display("%m - %t ST_INFO: Memory CCL at port 2  ",$realtime);
        Mem[A2int] = WordX;
      end
      else if (repair_flag === 1'b1) begin
        $display("%m - %t ST_INFO: Red Memory CCL at port 2  ",$realtime);
        RedMem[RedMem_address] = WordX;
    end
    `endif
    task_insert_faults_in_memory;
    
    WriteOut2X;
    
    if(CK1_rise_time == CK2_rise_time && STDBY1int===0 && CSN1int === 0 && WEN1int === 1 && IG1int === 0 && RMint === {read_margin_size{1'b0}} && A1int === A2int) begin
      if(!(red_en1 !== red_en2)) 
      WriteOut1X;
    end

  end
  else if (^A2int === 1'bx) begin
    Mem_port2_FSM_Corrupt;
  end  
end
endtask

task Mem_port1_FSM_Corrupt;
begin
        MemX;
          WriteOut1X;        
        if(CK1_rise_time == CK2_rise_time && STDBY2int===0 && TBYPASSint === 1'b1 && ATPint === 1'b1 && SEint === 1'b0 && TBISTint === 1'b0 && IG2int === 0 && RMint === {read_margin_size{1'b0}})
          WriteOut2X;
        if(CK1_rise_time == CK2_rise_time && STDBY2int===0 && CSN2int === 0 && WEN2int === 1 && IG2int === 0 && RMint === {read_margin_size{1'b0}}) begin
          WriteOut2X;
          if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port1 and port2. ",$realtime);
        end   
     
        if (INITNint !== 0) begin  
   `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON  
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
        flag_invalid_next_port1_cycle = 1'b1;
       //  flag_invalid_next_port1_cycle <= 1'b1;
   `else
           flag_invalid_present_port1_cycle = 1'b1;    
   `endif 
     end 

end
endtask

always @(SEint)begin
  if(ATPint === 1  && STDBY1int === 0 && SLEEPint === 0 && INITNint === 1 && SEint !== X) begin 
        flag_invalid_present_port1_cycle = 1'b0;
        flag_invalid_next_port1_cycle = 1'b0;
        flag_invalid_next_port1_dft_cycle = 1'b0;
        flag_invalid_present_port1_dft_cycle = 1'b0;
  end 
  if(ATPint === 1  && STDBY2int === 0 && SLEEPint === 0 && INITNint === 1 && SEint !== X) begin 
        flag_invalid_present_port2_cycle = 1'b0;
        flag_invalid_next_port2_cycle = 1'b0;
        flag_invalid_next_port2_dft_cycle = 1'b0;
        flag_invalid_present_port2_dft_cycle = 1'b0;
  end 
end // added for fsm_corruption functionality 


task Mem_port2_FSM_Corrupt;
begin
        MemX;
          WriteOut2X;        
        if(CK1_rise_time == CK2_rise_time && STDBY1int===0 && TBYPASSint === 1'b1 && ATPint === 1'b1 && SEint === 1'b0 && TBISTint === 1'b0 && IG1int === 0 && RMint === {read_margin_size{1'b0}})
          WriteOut1X;
        if(CK1_rise_time == CK2_rise_time && STDBY1int===0 && CSN1int === 0 && WEN1int === 1 && IG1int === 0 && RMint === {read_margin_size{1'b0}}) begin
          WriteOut1X;
          if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port2 and port1. ",$realtime);
        end   
     
        if (INITNint !== 0) begin     
   `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON 
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
         flag_invalid_next_port2_cycle = 1'b1;
 	// flag_invalid_next_port2_cycle <= 1'b1;
    `else
 	flag_invalid_present_port2_cycle = 1'b1;

   `endif 
        end 

end
endtask

task Mem_port1_FSM_Corrupt_atp_tby_tbist;
begin
        MemX;
          WriteOut1X;        
        if(CK1_rise_time == CK2_rise_time && STDBY2int===0 && CSN2int === 0 && WEN2int === 1 && IG2int === 0 && RMint === {read_margin_size{1'b0}}) begin
          WriteOut2X;
          if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port1 and port2. ",$realtime);
        end   
        if (INITNint !== 0) begin        
         if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
         flag_invalid_next_port1_cycle = 1'b1;
       //  flag_invalid_next_port1_cycle <= 1'b1;

        end 

end
endtask



task Mem_port1_FSM_Corrupt_tim;
begin
        MemX;
          WriteOut1X;        
        if(CK1_rise_time == CK2_rise_time && STDBY2int===0 && CSN2int === 0 && WEN2int === 1 && IG2int === 0 && RMint === {read_margin_size{1'b0}}) begin
          WriteOut2X;
          if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port1 and port2. ",$realtime);
        end   
        if (INITN !== 0) begin        
         if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
         flag_invalid_next_port1_cycle = 1'b1;
       //  flag_invalid_next_port1_cycle <= 1'b1;

        end 

end
endtask

task Mem_port2_FSM_Corrupt_atp_tby_tbist;
begin
        MemX;
//	if(WEN2 === 1 ) begin 
          WriteOut2X;        
//        end  
        if(CK1_rise_time == CK2_rise_time && STDBY1int===0 && CSN1int === 0 && WEN1int === 1 && IG1int === 0 && RMint === {read_margin_size{1'b0}}) begin
          WriteOut1X;
          if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port2 and port1. ",$realtime);
        end   
        if (INITNint !== 0) begin        
         if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
         flag_invalid_next_port2_cycle = 1'b1;
 	// flag_invalid_next_port2_cycle <= 1'b1;
        end 

end
endtask


task Mem_port2_FSM_Corrupt_tim;
begin
        MemX;
//	if(WEN2 === 1 ) begin 
          WriteOut2X;        
//        end  
        if(CK1_rise_time == CK2_rise_time && STDBY1int===0 && CSN1int === 0 && WEN1int === 1 && IG1int === 0 && RMint === {read_margin_size{1'b0}}) begin
          WriteOut1X;
          if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port2 and port1. ",$realtime);
        end   
        if (INITN !== 0) begin        
         if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
         flag_invalid_next_port2_cycle = 1'b1;
 	// flag_invalid_next_port2_cycle <= 1'b1;
        end 

end
endtask


task main_write_port1;
begin
  if (reg_MEM_INITIALIZE === 1'b1 && $realtime >= reg_File_load_time && file_loaded ) begin   
   `ifdef ST_MEM_SLM
      if (reg_BinaryInit)
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_BIN");
      else
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_HEX");

   `else
      if (reg_BinaryInit)
         $readmemb(reg_InitFileName, Mem, 0, Words-1);
      else
         $readmemh(reg_InitFileName, Mem, 0, Words-1);
    `endif
    file_loaded = 0;
  end
WriteCycle1(A1int);
end
endtask


task main_write_port2;
begin
  if (reg_MEM_INITIALIZE === 1'b1 && $realtime >= reg_File_load_time && file_loaded ) begin   
   `ifdef ST_MEM_SLM
      if (reg_BinaryInit)
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_BIN");
      else
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_HEX");

   `else
      if (reg_BinaryInit)
         $readmemb(reg_InitFileName, Mem, 0, Words-1);
      else
         $readmemh(reg_InitFileName, Mem, 0, Words-1);
    `endif
    file_loaded = 0;
  end
WriteCycle2(A2int);
end
endtask


task main_read_port1;
begin
if (reg_MEM_INITIALIZE === 1'b1 && $realtime >= reg_File_load_time && file_loaded ) begin   
   `ifdef ST_MEM_SLM
      if (reg_BinaryInit)
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_BIN");
      else
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_HEX");

   `else
      if (reg_BinaryInit)
         $readmemb(reg_InitFileName, Mem, 0, Words-1);
      else
         $readmemh(reg_InitFileName, Mem, 0, Words-1);
    `endif
    file_loaded = 0;
end

ReadCycle1(A1int);
end
endtask


task main_read_port2;
begin
if (reg_MEM_INITIALIZE === 1'b1 && $realtime >= reg_File_load_time && file_loaded ) begin   
   `ifdef ST_MEM_SLM
      if (reg_BinaryInit)
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_BIN");
      else
         $slm_LoadMemory(slm_handle, reg_InitFileName, "VERILOG_HEX");

   `else
      if (reg_BinaryInit)
         $readmemb(reg_InitFileName, Mem, 0, Words-1);
      else
         $readmemh(reg_InitFileName, Mem, 0, Words-1);
    `endif
    file_loaded = 0;
end

ReadCycle2(A2int);
end
endtask



task WriteCycle1;
input [Addr -1 : 0 ] Address;
reg ValidAddress;
reg [Addr-mux_bits-1:0]Row_Add;
reg [Addr-mux_bits-bank_bits-1:0] Row_Add_cmp;


reg [mux_bits-1:0]Col_Add;
reg [Bits - 1 : 0 ] tempReg;
reg [Bits - 1 : 0 ] Contents_after_fault;
reg [Bits - 1 : 0 ] chk_fault;

integer po,n,Col_Add_integer,Bank_sel_integer,RedMem_address;
reg repair_flag;
begin
  repair_flag = 1'b0;
  Row_Add = Address[Addr-1: mux_bits];
  Row_Add_cmp = {Row_Add[Addr-mux_bits-1:3+bank_bits],Row_Add[2:0]};

    
  Col_Add = Address[mux_bits-1:0]; 

  if (^Address === 1'bX )
      ValidAddress = 1'bX;    
  else if ( Address < Words ) 
      ValidAddress = 1;
  else if ( Address >= Words )
      ValidAddress = 0;


  //if (red_en1 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add && next_repair_add !== 0)) ) begin
  if (red_en1 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add)) ) begin
  
    repair_flag = 1'b1;

    Bank_sel_integer = 0 ; 

    if (Row_Add_cmp === repair_add) begin
            
      Col_Add_integer  = Col_Add; 
    end
    else if (Row_Add_cmp === next_repair_add) begin
            
      Col_Add_integer  = Col_Add + mux; 
    end  
    RedMem_address = ( (no_of_red_rows_in_a_bank*Bank_sel_integer*mux) + Col_Add_integer );
  end 
 
  if (ValidAddress !== 1'bx && flag_invalid_present_port1_cycle ===0 && flag_invalid_next_port2_cycle ===0 && flag_invalid_present_port2_cycle === 0 ) begin
    if (repair_flag === 1'b0) begin
      if (ValidAddress === 1'b1) begin 
      `ifdef ST_MEM_SLM
//        $slm_ReadMemoryS(slm_handle, Address, tempReg);
      `else
         tempReg = Mem[Address];
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//         $slm_ReadMemoryS(RedMemAddr, Col_Add_integer, tempReg); 
      `else
         tempReg = RedMem[RedMem_address];
      `endif
    end      
    `ifdef ST_MEM_SLM
    `else
    prevContents = tempReg;
                   
     for (po=0;po<Bits;po=po+1) begin
           if ( D1int [po] !== tempReg [po]) begin
               if (M1int[po] === 1'b0)
                   tempReg[po] = D1int[po];
               else if (M1int[po] === 1'bX)
                   tempReg[po] = 1'bx;
           end                
      end
    `endif
    if (repair_flag === 1'b0) begin       
    if (ValidAddress === 1'b1) begin  
      `ifdef ST_MEM_SLM
        $slm_WriteMemory(slm_handle, Address, D1int, M1int_inv);
      `else
        Mem[Address] = tempReg;
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_WriteMemory(RedMemAddr, Col_Add_integer, tempReg_slm);
      `else
        RedMem[RedMem_address] = tempReg;
      `endif
    end
      
      `ifdef ST_MEM_SLM
      `else
       newContents = tempReg;
      task_insert_faults_in_memory;
      `endif

// mem has been written with "tempreg" if read again we will get the faults
// This is for read -write contention case
    if (repair_flag === 1'b0) begin
        if (ValidAddress === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_ReadMemory(slm_handle, Address, MemData);
      `else
        chk_fault = Mem[Address];
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_ReadMemory(RedMemAddr, Col_Add_integer, MemData);
      `else
        chk_fault = RedMem[RedMem_address];
      `endif
    end

    Contents_after_fault =  chk_fault;

   //Contention read -write

      n = 0;
     if(^A2int !== 1'bX &&  ((repair_flag === 0 && A2int < Words  ) || repair_flag === 1) && CK1_rise_time == CK2_rise_time && STDBY2int ===0 && WEN2int === 1 && CSN2int === 0 && IG2int === 0 && RMint === {read_margin_size{1'b0}} ) begin
       if( A1int === A2int && red_en1 === red_en2 ) begin
         `ifdef ST_MEM_SLM
          if(n==0) begin
           n = 1;
          end        
          OutReg2_data = {Bits{1'bX}};
          OutReg2_data_tim = {Bits{1'bX}};
          OutReg2_data_tim <= {Bits{1'bX}};
         `else
          for (po=0;po<Bits;po=po+1) begin
 	      if(M1int[po] !== 1) begin
             if((prevContents[po] !== tempReg[po]) && (prevContents[po] !== Contents_after_fault[po])) begin
               if(n==0) begin
                n = 1;
               end        
                     OutReg2_data[po] = 1'bX;
                     OutReg2_data_tim[po] = 1'bX;
                     OutReg2_data_tim[po] <= 1'bX;

		end	
             end        
          end        
          `endif
       end        
     end



    //Contention ends 

// && A2int < Words
      //Contention Write -write
      if(^A2int !== 1'bX  && ((repair_flag === 0 && A2int < Words  ) || repair_flag === 1) && CK1_rise_time == CK2_rise_time && STDBY2int ===0 && CSN2int === 0 && WEN2int !== 1'b1  && IG2int === 0 && WMint === {write_margin_size{1'b0}} ) begin
         if(A1int === A2int && red_en1 === red_en2) begin


//Contention write -write
             `ifdef ST_MEM_SLM
              tempReg = {Bits{1'bx}};
             `else
                if (WEN2int === 1'bx) tempReg = {Bits{1'bx}};
                else begin
                  for (po=0;po<Bits;po=po+1) begin
                     if ( D1int[po] === D2int[po] && M1int[po] === 1'b0 && M2int[po] === 1'b0)
                         tempReg[po] = D1int[po];		  	
                     else if (M1int[po] === 1'b0 && M2int[po] === 1'b1 )
                         tempReg[po] = D1int[po];		  	
                     else if (M1int[po] === 1'b1 && M2int[po] === 1'b0 ) 
                         tempReg[po] = D2int[po];
                     else if (M1int[po] === 1'bx || M2int[po] === 1'bx )    begin	
                              if ( M1int[po] ===1'bx && D1int[po] !== tempReg[po])
                               tempReg[po] = 1'bx;
                       if ( M2int[po] ===1'bx && D2int[po] !== tempReg[po])
                               tempReg[po] = 1'bx;
                         end	
                     else if ( D1int[po] !== D2int[po] && M1int[po] === 1'b0 && M2int[po] === 1'b0 )	
                          tempReg[po] = 1'bx;

                  end
                end
              `endif

	
		 if (repair_flag === 1'b0) begin       //mem write
                      if (ValidAddress === 1'b1) begin 
		      `ifdef ST_MEM_SLM
		        $slm_WriteMemory(slm_handle, Address, tempReg);
		      `else
		        Mem[Address] = tempReg;
		      `endif
		    end
		    end	
		    else if (repair_flag === 1'b1) begin
		      `ifdef ST_MEM_SLM
//		        $slm_WriteMemory(RedMemAddr, Col_Add_integer, tempReg_slm);
		      `else
		        RedMem[RedMem_address] = tempReg;
		      `endif
		    end  //mem write end
                    `ifdef ST_MEM_SLM
                    `else
                          newContents = tempReg;   
     			  task_insert_faults_in_memory;  
                    `endif

         end   // if(A1=A2      
      end        //contention end



end //if validaddr end
else if (ValidAddress === 1'bX) begin
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port1 write  Illegal Value on Address Bus. Memory Corrupted ",$realtime);
        MemX;
        `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON  
                WriteOut1X;        
        `endif    
        if(CK1_rise_time == CK2_rise_time && STDBY2int===0 && CSN2int === 0 && WEN2int === 1 && IG2int === 0 && RMint === {read_margin_size{1'b0}}) 
        begin
                WriteOut2X;
                if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port1 and port2. ",$realtime);
        end   
        
        if (INITNint !== 0) begin  
                `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON  
                if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
                flag_invalid_next_port1_cycle = 1'b1;
                //  flag_invalid_next_port1_cycle <= 1'b1;
                `else
                        flag_invalid_present_port1_cycle = 1'b1;    
                `endif 
        end 
end
if (ValidAddress === 0) begin
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port1 write  Address Out Of Range. ",$realtime);
        task_insert_faults_in_memory;
end

end //begin
endtask






task WriteCycle2;
input [Addr -1 : 0 ] Address;
reg ValidAddress;
reg [Addr-mux_bits-1:0]Row_Add;
reg [Addr-mux_bits-bank_bits-1:0] Row_Add_cmp;


reg [mux_bits-1:0]Col_Add;
reg [Bits - 1 : 0 ] tempReg;
reg [Bits - 1 : 0 ] Contents_after_fault;
reg [Bits - 1 : 0 ] chk_fault;

integer po,n,Col_Add_integer,Bank_sel_integer,RedMem_address;
reg repair_flag;
begin
  repair_flag = 1'b0;
  Row_Add = Address[Addr-1: mux_bits];
  Row_Add_cmp = {Row_Add[Addr-mux_bits-1:3+bank_bits],Row_Add[2:0]};

    
  Col_Add = Address[mux_bits-1:0]; 

  if (^Address === 1'bX )
      ValidAddress = 1'bX;    
  else if ( Address < Words ) 
      ValidAddress = 1;
  else if ( Address >= Words )
      ValidAddress = 0;


  //if (red_en2 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add && next_repair_add !== 0)) ) begin
  if (red_en2 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add)) ) begin
    repair_flag = 1'b1;

    Bank_sel_integer = 0 ; 

    if (Row_Add_cmp === repair_add) begin
            
      Col_Add_integer  = Col_Add; 
    end
    else if (Row_Add_cmp === next_repair_add) begin
            
      Col_Add_integer  = Col_Add + mux; 
    end  
    RedMem_address = ( (no_of_red_rows_in_a_bank*Bank_sel_integer*mux) + Col_Add_integer );
  end 

 
  if (ValidAddress !== 1'bx &&   flag_invalid_present_port2_cycle === 0  &&   flag_invalid_next_port1_cycle === 0  &&  flag_invalid_present_port1_cycle === 0 ) begin
    if (repair_flag === 1'b0) begin
      if (ValidAddress === 1'b1) begin 
      `ifdef ST_MEM_SLM
//        $slm_ReadMemoryS(slm_handle, Address, tempReg);
      `else
         tempReg = Mem[Address];
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//         $slm_ReadMemoryS(RedMemAddr, Col_Add_integer, tempReg); 
      `else
         tempReg = RedMem[RedMem_address];
      `endif
    end      

    `ifdef ST_MEM_SLM
    `else
    prevContents = tempReg;
                   
     for (po=0;po<Bits;po=po+1) begin
           if ( D2int [po] !== tempReg [po]) begin
               if (M2int[po] === 1'b0)
                   tempReg[po] = D2int[po];
               else if (M2int[po] === 1'bX)
                   tempReg[po] = 1'bx;
           end                
      end
      `endif
//#writing to mem here            
    if (repair_flag === 1'b0) begin   
       if (ValidAddress === 1'b1) begin      
      `ifdef ST_MEM_SLM
        $slm_WriteMemory(slm_handle, Address, D2int, M2int_inv);
      `else
        Mem[Address] = tempReg;
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_WriteMemory(RedMemAddr, Col_Add_integer, tempReg_slm);
      `else
        RedMem[RedMem_address] = tempReg;
      `endif
    end
      
     `ifdef ST_MEM_SLM
      `else
       newContents = tempReg;
      task_insert_faults_in_memory;
     `endif

// mem has been written with "tempreg" if we read it again we will get the stuck@ diff
// Reading same location. This is for read -write contention case
    if (repair_flag === 1'b0) begin
        if (ValidAddress === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_ReadMemory(slm_handle, Address, MemData);
      `else
        chk_fault = Mem[Address];
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_ReadMemory(RedMemAddr, Col_Add_integer, MemData);
      `else
        chk_fault = RedMem[RedMem_address];
      `endif
    end

    Contents_after_fault =  chk_fault;

  //Contention read -write

//&& A1int < Words

      n = 0;
     if(^A1int !== 1'bX && ((repair_flag === 0 && A1int < Words  ) || repair_flag === 1) && CK2_rise_time == CK1_rise_time && STDBY1int ===0  && WEN1int === 1 && CSN1int === 0 && IG1int === 0 && RMint === {read_margin_size{1'b0}} ) begin
       if( A2int === A1int && red_en1 === red_en2) begin
         `ifdef ST_MEM_SLM
          if(n==0) begin
           n = 1;
          end        
          OutReg1_data = {Bits{1'bX}};
          OutReg1_data_tim = {Bits{1'bX}};
          OutReg1_data_tim <= {Bits{1'bX}};
         `else
          for (po=0;po<Bits;po=po+1) begin
 	      if(M2int[po] !== 1) begin
             if((prevContents[po] !== tempReg[po])&& (prevContents[po] !== Contents_after_fault[po]))   begin
               if(n==0) begin
                n = 1;
               end        
                     OutReg1_data[po] = 1'bX;
                     OutReg1_data_tim[po] = 1'bX;
                     OutReg1_data_tim[po] <= 1'bX;

		end	
             end        
          end
          `endif
       end        
     end





      //Contention write -write
      if(^A1int !== 1'bX &&  ((repair_flag === 0 && A1int < Words  ) || repair_flag === 1) && CK1_rise_time == CK2_rise_time && STDBY1int ===0   && CSN1int === 0 && WEN1int !== 1'b1  && IG1int === 0 && WMint === {write_margin_size{1'b0}} ) begin
         if(A1int === A2int && red_en1 === red_en2) begin


                  `ifdef ST_MEM_SLM
                   tempReg = {Bits{1'bX}};
                  `else
		  if (WEN1int === 1'bx) tempReg = {Bits{1'bX}};
                  else begin
                    for (po=0;po<Bits;po=po+1) begin
                      if ( D1int[po] === D2int[po] && M1int[po] === 1'b0 && M2int[po] === 1'b0)
                          tempReg[po] = D1int[po];		  	
                      else if (M1int[po] === 1'b0 && M2int[po] === 1'b1 )
                          tempReg[po] = D1int[po];		  	
                      else if (M1int[po] === 1'b1 && M2int[po] === 1'b0 ) 
                          tempReg[po] = D2int[po];
                      else if (M1int[po] === 1'bx || M2int[po] === 1'bx )   begin	
                               if ( M1int[po] ===1'bx && D1int[po] !== tempReg[po])
                               tempReg[po] = 1'bx;
                              if ( M2int[po] ===1'bx && D2int[po] !== tempReg[po])
                               tempReg[po] = 1'bx;
                          end	
                      else if ( D1int[po] !== D2int[po] && M1int[po] === 1'b0 && M2int[po] === 1'b0 )	
                          tempReg[po] = 1'bx;

                    end
                  end
                 `endif





		 if (repair_flag === 1'b0) begin       //mem write
                      if (ValidAddress === 1'b1) begin 
		      `ifdef ST_MEM_SLM
		        $slm_WriteMemory(slm_handle, Address, tempReg);
		      `else
		        Mem[Address] = tempReg;
		      `endif
		    end
                    end
		    else if (repair_flag === 1'b1) begin
		      `ifdef ST_MEM_SLM
//		        $slm_WriteMemory(RedMemAddr, Col_Add_integer, tempReg_slm);
		      `else
		        RedMem[RedMem_address] = tempReg;
		      `endif
		    end  //mem write end
                        `ifdef ST_MEM_SLM
                        `else
			   newContents = tempReg;   
     			  task_insert_faults_in_memory;  
                        `endif

                   
         end   // if(A1=A2      
      end        //contention end
    end //if valid address end
   else if (ValidAddress === 1'bX) begin
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port2 write  Illegal Value on Address Bus. Memory Corrupted ",$realtime);
        MemX;
        `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON 
                WriteOut2X;        
        `endif     
        if(CK1_rise_time == CK2_rise_time && STDBY1int===0 && CSN1int === 0 && WEN1int === 1 && IG1int === 0 && RMint === {read_margin_size{1'b0}})
        begin
                WriteOut1X;
                if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port2 and port1. ",$realtime);
        end   

        if (INITNint !== 0) begin     
        `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON 
                if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Memory corrupted. Next clock cycle will be non-functional. ",$realtime);
                flag_invalid_next_port2_cycle = 1'b1;
        	// flag_invalid_next_port2_cycle <= 1'b1;
        `else
        	flag_invalid_present_port2_cycle = 1'b1;
        `endif 
    end
end
if (ValidAddress === 0) begin
if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port2 write  Address Out Of Range. ",$realtime);
task_insert_faults_in_memory;
end



end //begin
endtask

task ReadCycle1;
input [Addr -1 : 0 ] Address;
reg [Addr-mux_bits-1:0]Row_Add;
reg [Addr-mux_bits-bank_bits-1:0] Row_Add_cmp;


reg [mux_bits-1:0]Col_Add; 
reg ValidAddress;
reg [Bits - 1 : 0 ] MemData;
integer po,n,Col_Add_integer,Bank_sel_integer,RedMem_address;
reg repair_flag;
begin
  repair_flag = 1'b0;
  Row_Add = Address[Addr-1: mux_bits];
  Row_Add_cmp = {Row_Add[Addr-mux_bits-1:3+bank_bits],Row_Add[2:0]};

  
  Col_Add = Address[mux_bits-1:0]; 

  if (^Address === 1'bX )
      ValidAddress = 1'bX;    
  else if ( Address < Words ) 
      ValidAddress = 1;
  else if ( Address >= Words )
      ValidAddress = 0;

      
  //if (red_en1 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add && next_repair_add !== 0 )) ) begin
  if (red_en1 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add)) ) begin
    repair_flag = 1'b1;
    
    Bank_sel_integer = 0; 
    if (Row_Add_cmp === repair_add) begin
           
      Col_Add_integer  = Col_Add; 
    end
    else if (Row_Add_cmp === next_repair_add) begin
           
      Col_Add_integer  = Col_Add + mux; 
    end  
    RedMem_address = ( (no_of_red_rows_in_a_bank*Bank_sel_integer*mux) + Col_Add_integer );
  end  


if (ValidAddress === 1 && ( flag_invalid_present_port1_cycle === 1 || flag_invalid_next_port2_cycle === 1 ||  flag_invalid_present_port2_cycle === 1 )) begin
      MemData = WordX;
      OutReg1_data = MemData;
      OutReg1_data_tim <= MemData;
end



  if (ValidAddress !== 1'bx && flag_invalid_present_port1_cycle === 0 &&  flag_invalid_next_port2_cycle === 0  &&  flag_invalid_present_port2_cycle === 0 ) begin
    if (repair_flag === 1'b0) begin
     if (ValidAddress === 1'b1) begin  
      `ifdef ST_MEM_SLM
        $slm_ReadMemory(slm_handle, Address, MemData);
      `else
        MemData = Mem[Address];
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_ReadMemory(RedMemAddr, Col_Add_integer, MemData);
      `else
        MemData = RedMem[RedMem_address];
      `endif
    end
      
    //Contention
      n = 0;
     if(^A2int !== 1'bX &&  ((repair_flag === 0 && A2int < Words  ) || repair_flag === 1) && CK1_rise_time == CK2_rise_time && STDBY2int ===0 && WEN2int === 0 && CSN2int === 0 && IG2int === 0 && WMint === {write_margin_size{1'b0}} ) begin
       if( A1int === A2int && red_en1 === red_en2) begin
         `ifdef ST_MEM_SLM
           if(n==0) begin
            if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port2 Write and port1 Read. Output Corrupted ",$realtime);
            n = 1;
           end        
           MemData = {Bits{1'bX}};
         `else
          for (po=0;po<Bits;po=po+1) begin 
             if(prevContents[po] !== MemData[po]) begin
               if(n==0) begin
                if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port2 Write and port1 Read. Output Corrupted ",$realtime);
                n = 1;
               end        
               MemData[po] = 1'bX;
             end        
          end
          `endif
       end        
     end



    //Contention ends 
     OutReg1_data = MemData;                          
     for (po=0;po<Bits;po=po+1)begin
        if(OutReg1_data[po] !== OutReg1_data_tim[po]) begin
          OutReg1_data_tim[po] = 1'bx;
        end        
     end        
     OutReg1_data_tim <= OutReg1_data;
  end 
  else if (ValidAddress === 1'bX) begin
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port1 Illegal Value on Address Bus. Output Corrupted ",$realtime);
     Mem_port1_FSM_Corrupt;
  end        
  if (ValidAddress === 0) begin
     if (repair_flag === 1'b0 ) begin
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port1 Address Out Of Range. Output Corrupted ",$realtime);
      MemData = WordX;
      OutReg1_data = MemData;
      OutReg1_data_tim <= MemData;
     end
  end 

 
end
endtask



task ReadCycle2;
input [Addr -1 : 0 ] Address;
reg [Addr-mux_bits-1:0]Row_Add;
reg [Addr-mux_bits-bank_bits-1:0] Row_Add_cmp;


reg [mux_bits-1:0]Col_Add; 
reg ValidAddress;
reg [Bits - 1 : 0 ] MemData;
integer po,n,Col_Add_integer,Bank_sel_integer,RedMem_address;
reg repair_flag;
begin
  repair_flag = 1'b0;
  Row_Add = Address[Addr-1: mux_bits];
  Row_Add_cmp = {Row_Add[Addr-mux_bits-1:3+bank_bits],Row_Add[2:0]};

  
  Col_Add = Address[mux_bits-1:0]; 

  if (^Address === 1'bX )
      ValidAddress = 1'bX;    
  else if ( Address < Words ) 
      ValidAddress = 1;
  else if ( Address >= Words )
      ValidAddress = 0;

      
  //if (red_en2 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add  && next_repair_add !== 0)) ) begin
  if (red_en2 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add)) ) begin
    repair_flag = 1'b1;
    
    Bank_sel_integer = 0; 
    if (Row_Add_cmp === repair_add) begin
           
      Col_Add_integer  = Col_Add; 
    end
    else if (Row_Add_cmp === next_repair_add) begin
           
      Col_Add_integer  = Col_Add + mux; 
    end  
    RedMem_address = ( (no_of_red_rows_in_a_bank*Bank_sel_integer*mux) + Col_Add_integer );
  end  


if (ValidAddress === 1 && (  flag_invalid_present_port2_cycle === 1 ||  flag_invalid_next_port1_cycle === 1 ||  flag_invalid_present_port1_cycle === 1 )) begin
      MemData = WordX;
      OutReg2_data = MemData;
      OutReg2_data_tim <= MemData;
end



  if (ValidAddress !== 1'bx &&  flag_invalid_present_port2_cycle === 0 &&  flag_invalid_next_port1_cycle === 0 && flag_invalid_present_port1_cycle === 0 ) begin
    if (repair_flag === 1'b0) begin
      if (ValidAddress === 1'b1) begin 
      `ifdef ST_MEM_SLM
        $slm_ReadMemory(slm_handle, Address, MemData);
      `else
        MemData = Mem[Address];
      `endif
    end
    end
    else if (repair_flag === 1'b1) begin
      `ifdef ST_MEM_SLM
//        $slm_ReadMemory(RedMemAddr, Col_Add_integer, MemData);
      `else
        MemData = RedMem[RedMem_address];
      `endif
    end
      
    //Contention
      n = 0;
     if(^A1int !== 1'bX &&   ((repair_flag === 0 && A1int < Words  ) || repair_flag === 1) && CK1_rise_time == CK2_rise_time && STDBY1int ===0 && WEN1int === 0 && CSN1int === 0 && IG1int === 0 && WMint === {write_margin_size{1'b0}} ) begin
       if( A1int === A2int && red_en1 === red_en2) begin
         `ifdef ST_MEM_SLM
           if(n==0) begin
            if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port2 Write and port1 Read. Output Corrupted ",$realtime);
            n = 1;
           end        
           MemData = {Bits{1'bX}};
         `else
          for (po=0;po<Bits;po=po+1) begin 
             if(prevContents[po] !== MemData[po]) begin
               if(n==0) begin
                if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports port1 Write and port2 Read. Output Corrupted ",$realtime);
                n = 1;
               end        
               MemData[po] = 1'bX;
             end        
          end 
          `endif
       end        
     end


    //Contention ends 
     OutReg2_data = MemData;                          
     for (po=0;po<Bits;po=po+1)begin
        if(OutReg2_data[po] !== OutReg2_data_tim[po]) begin
          OutReg2_data_tim[po] = 1'bx;
        end        
     end        
     OutReg2_data_tim <= OutReg2_data;
  end 
  else if (ValidAddress === 1'bX) begin
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port2 Illegal Value on Address Bus. Output Corrupted ",$realtime);
     Mem_port2_FSM_Corrupt;
  end  
  if (ValidAddress === 0 ) begin
     if (repair_flag === 1'b0 ) begin
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port : port2 Address Out Of Range. Output Corrupted ",$realtime);
      MemData = WordX;
      OutReg2_data = MemData;
      OutReg2_data_tim <= MemData;
     end
  end 
       
end
endtask

//# DFT START

task DFT_port2_FSM_Corrupt_tim;
begin
    DFT_port2_ScanChainX;
    DFT_port2_ScanOutX;
    if(TBYPASSint !== 1'b0 && SEint !== 1'b1 ) begin
        WriteOut2X;
    end
    if(INITN !== 0) begin
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Port2 Scan Chains and Scan Outs Corrupted . Next clock cycle will be non-functional. ",$realtime);
      flag_invalid_next_port2_dft_cycle = 1'b1;
    end
end
endtask

task DFT_port1_FSM_Corrupt_tim;
begin
    DFT_port1_ScanChainX;
    DFT_port1_ScanOutX;
    if(TBYPASSint !== 1'b0 && SEint !== 1'b1 ) begin
        WriteOut1X;
     end

    if(INITN !== 0) begin 
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Port1 Scan Chains and Scan Outs Corrupted . Next clock cycle will be non-functional. ",$realtime);
     flag_invalid_next_port1_dft_cycle = 1'b1;
    end 
end
endtask



task DFT_port2_FSM_Corrupt;
begin
    DFT_port2_ScanChainX;
    DFT_port2_ScanOutX;
    if(TBYPASSint !== 1'b0 && SEint !== 1'b1 ) begin
        WriteOut2X;
    end
    if(INITNint !== 0) begin

   `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON  

      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Port2 Scan Chains and Scan Outs Corrupted . Next clock cycle will be non-functional. ",$realtime);
      flag_invalid_next_port2_dft_cycle = 1'b1;
   `else
      flag_invalid_present_port2_dft_cycle = 1'b1;
   `endif 


    end
end
endtask

task DFT_port1_FSM_Corrupt;
begin
    DFT_port1_ScanChainX;
    DFT_port1_ScanOutX;
    if(TBYPASSint !== 1'b0 && SEint !== 1'b1 ) begin
        WriteOut1X;
     end

    if(INITNint !== 0) begin 
 `ifdef ST_MEM_FUNCTION_NEXT_CYCLE_CORRUPTION_ON  

      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Memory state machine is corrupted Port1 Scan Chains and Scan Outs Corrupted . Next clock cycle will be non-functional. ",$realtime);
     flag_invalid_next_port1_dft_cycle = 1'b1;
   `else
      flag_invalid_present_port1_dft_cycle = 1'b1;
   `endif

    end 
end
endtask




task DFT_port1_ScanChainX;
begin
  if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Scan Chains Corrupted . ",$realtime); 

 scanreg_ctrl_port1 = 1'bx;
 scanreg_d1l = 1'bx;
 scanreg_d1r = 1'bx;

          
end
endtask


task DFT_port2_ScanChainX;
begin
  if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Scan Chains Corrupted . ",$realtime); 

scanreg_ctrl_port2 = 1'bx;
scanreg_d2l = 1'bx;
scanreg_d2r = 1'bx;

          
end
endtask



task DFT_port1_ScanOutX;
begin
   if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Scan Outs Corrupted . ",$realtime);
   SCTRLO1_data = 1'bx;
   SDLO1_data  = 1'bx;
   SDRO1_data  = 1'bx;
   
   
   SCTRLO1_data_tim <= 1'bx;
   SDLO1_data_tim  <= 1'bx;
   SDRO1_data_tim  <= 1'bx;
   
   


end
endtask



task DFT_port2_ScanOutX;
begin
   if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Scan Outs Corrupted . ",$realtime);
   SCTRLO2_data = 1'bx;
   SDLO2_data  = 1'bx;
   SDRO2_data  = 1'bx;
   
   
   SCTRLO2_data_tim <= 1'bx;
   SDLO2_data_tim  <= 1'bx;
   SDRO2_data_tim  <= 1'bx;
   
   


end
endtask

//Control scan chain for Port 1 ::

ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_0 (.D(WEN1_int), .TI(SCTRLI1_buf), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[0]), .OUTX(scanreg_ctrl_port1));

      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_1 (.D(CSN1_int), .TI(scanreg_ctrl_port1_wire[0]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[1]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_2 (.D(A1_int[0]), .TI(scanreg_ctrl_port1_wire[1]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[2]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_3 (.D(A1_int[1]), .TI(scanreg_ctrl_port1_wire[2]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[3]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_4 (.D(A1_int[6]), .TI(scanreg_ctrl_port1_wire[3]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[4]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_5 (.D(A1_int[7]), .TI(scanreg_ctrl_port1_wire[4]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[5]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_6 (.D(A1_int[4]), .TI(scanreg_ctrl_port1_wire[5]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[6]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_7 (.D(A1_int[5]), .TI(scanreg_ctrl_port1_wire[6]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[7]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_8 (.D(A1_int[8]), .TI(scanreg_ctrl_port1_wire[7]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[8]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_9 (.D(A1_int[9]), .TI(scanreg_ctrl_port1_wire[8]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[9]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_10 (.D(A1_int[10]), .TI(scanreg_ctrl_port1_wire[9]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[10]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_11 (.D(A1_int[2]), .TI(scanreg_ctrl_port1_wire[10]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[11]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_12 (.D(A1_int[3]), .TI(scanreg_ctrl_port1_wire[11]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[12]), .OUTX(scanreg_ctrl_port1));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_13 (.D(scanreg_ctrl_port1_wire[13]), .TI(scanreg_ctrl_port1_wire[12]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_ctrl_port1_wire[13]), .OUTX(scanreg_ctrl_port1));  

// Lock Up Latch

wire SCTRLO1_temp;
ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK1_SCTRLO1_latch (Latch_open_1, scanreg_ctrl_port1_wire[13], SCTRLO1_temp);   

always @(SCTRLO1_temp) begin
    SCTRLO1_data = SCTRLO1_temp;
`ifdef functional
 `else
 if (SCTRLO1_data !== SCTRLO1_data_tim) begin 
  if (SCTRLO1_data !==X)
   SCTRLO1_data_tim =1'bx;
   SCTRLO1_data_tim <= SCTRLO1_data;
 end 
 `endif
end 

// LEFT DATA SCAN CHAIN 

ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_0 (.D(D1int[15]), .TI(SDLI1_buf), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[0]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_1 (.D(D1int[14]), .TI(scanreg_d1l_wire[0]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[1]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_2 (.D(D1int[13]), .TI(scanreg_d1l_wire[1]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[2]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_3 (.D(D1int[12]), .TI(scanreg_d1l_wire[2]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[3]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_4 (.D(D1int[11]), .TI(scanreg_d1l_wire[3]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[4]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_5 (.D(D1int[10]), .TI(scanreg_d1l_wire[4]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[5]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_6 (.D(D1int[9]), .TI(scanreg_d1l_wire[5]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[6]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_7 (.D(D1int[8]), .TI(scanreg_d1l_wire[6]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[7]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_8 (.D(D1int[7]), .TI(scanreg_d1l_wire[7]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[8]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_9 (.D(D1int[6]), .TI(scanreg_d1l_wire[8]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[9]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_10 (.D(D1int[5]), .TI(scanreg_d1l_wire[9]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[10]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_11 (.D(D1int[4]), .TI(scanreg_d1l_wire[10]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[11]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_12 (.D(D1int[3]), .TI(scanreg_d1l_wire[11]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[12]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_13 (.D(D1int[2]), .TI(scanreg_d1l_wire[12]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[13]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_14 (.D(D1int[1]), .TI(scanreg_d1l_wire[13]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[14]), .OUTX(scanreg_d1l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_15 (.D(D1int[0]), .TI(scanreg_d1l_wire[14]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1l_wire[15]), .OUTX(scanreg_d1l));

// Lock Up Latch

wire SDLO1_temp;
ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK1_SDLO1_latch (Latch_open_1, scanreg_d1l_wire[15], SDLO1_temp);

always @(SDLO1_temp) begin
     SDLO1_data = SDLO1_temp;
 `ifdef functional
 `else

if(SDLO1_data !== SDLO1_data_tim) begin
  if (SDLO1_data !==X)
       SDLO1_data_tim = 1'bx;
       SDLO1_data_tim <= SDLO1_data;
   end
 `endif 
end

// RIGHT DATA SCAN CHAIN

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_0 (.D(D1int[31]), .TI(SDRI1_buf), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[0]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_1 (.D(D1int[30]), .TI(scanreg_d1r_wire[0]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[1]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_2 (.D(D1int[29]), .TI(scanreg_d1r_wire[1]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[2]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_3 (.D(D1int[28]), .TI(scanreg_d1r_wire[2]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[3]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_4 (.D(D1int[27]), .TI(scanreg_d1r_wire[3]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[4]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_5 (.D(D1int[26]), .TI(scanreg_d1r_wire[4]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[5]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_6 (.D(D1int[25]), .TI(scanreg_d1r_wire[5]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[6]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_7 (.D(D1int[24]), .TI(scanreg_d1r_wire[6]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[7]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_8 (.D(D1int[23]), .TI(scanreg_d1r_wire[7]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[8]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_9 (.D(D1int[22]), .TI(scanreg_d1r_wire[8]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[9]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_10 (.D(D1int[21]), .TI(scanreg_d1r_wire[9]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[10]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_11 (.D(D1int[20]), .TI(scanreg_d1r_wire[10]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[11]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_12 (.D(D1int[19]), .TI(scanreg_d1r_wire[11]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[12]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_13 (.D(D1int[18]), .TI(scanreg_d1r_wire[12]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[13]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_14 (.D(D1int[17]), .TI(scanreg_d1r_wire[13]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[14]), .OUTX(scanreg_d1r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_15 (.D(D1int[16]), .TI(scanreg_d1r_wire[14]), .TE(SE_buf), .CP(CK1_sc), .Q(scanreg_d1r_wire[15]), .OUTX(scanreg_d1r));

// Lock Up Latch
wire SDRO1_temp;
 ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch  CK1_SDRO1_latch (Latch_open_1, scanreg_d1r_wire[15], SDRO1_temp);

always @(SDRO1_temp) begin
     SDRO1_data = SDRO1_temp; 
 `ifdef functional
 `else
if(SDRO1_data !== SDRO1_data_tim) begin
  if (SDRO1_data !==X)  
       SDRO1_data_tim = 1'bx;
       SDRO1_data_tim <= SDRO1_data;
   end
 `endif 
end






task DFT_port1_Scan_Acquire;
  integer po; 
begin
 if (supply_ok === 1) begin 
    if ( SEint ===0 && (TBYPASSint === 1'b0 || LP_CK_gate1 === 1'b0 )) begin
         scanreg_ctrl_port1=1'b0;
         scanreg_d1l=1'b0;
         scanreg_d1r=1'b0;
                  
         Latch_open_1=1;
    end 
 end

   //TBYPASS Functionality
   
   if(TBYPASSint === 1'b1) begin
      OutReg1_data = D1int;
      for (po=0;po<Bits;po=po+1)begin
        if(OutReg1_data[po] !== OutReg1_data_tim[po]) begin
          OutReg1_data_tim[po] = 1'bx;
        end        
      end        
      OutReg1_data_tim <= OutReg1_data;
   end
   else if (TBYPASSint === 1'bx) begin
      WriteOut1X;
   end 

end
endtask

task DFT_port1_Scan_Shift;
begin
   if (supply_ok === 1) begin
    if (STDBY1int === 0 && SLEEPint === 0) begin
      if (CK1int_dft === X && INITNint !== 0 && SLEEPint !== 1 && STDBY1int !== 1 && ATPint !== 0) begin
         DFT_port1_ScanChainX;
         DFT_port1_ScanOutX;
      end
       else if(CK1int_dft === 1'b1 && lastCK1_dft === 1'b0) begin
          if(INITNint === 1'b1 && SLEEPint === 1'b0 && ATPint === 1'b1 && STDBY1int === 1'b0) begin
  	      ///SHIFT   
               if(SEint === 1'b1) begin
                  scanreg_ctrl_port1=1'b0;
         	  scanreg_d1l=1'b0;
         	  scanreg_d1r=1'b0;
                   
               //// SHIFT Ends
        end //
       else if (SEint === X) begin
            DFT_port1_ScanChainX;
            DFT_port1_ScanOutX;
        end
       end    
      end          
     end
   end 
end
endtask

//Control Scan Chain for Port 2 ::

ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_0 (.D(WEN2_int), .TI(SCTRLI2_buf), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[0]), .OUTX(scanreg_ctrl_port2));

      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_1 (.D(CSN2_int), .TI(scanreg_ctrl_port2_wire[0]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[1]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_2 (.D(A2_int[0]), .TI(scanreg_ctrl_port2_wire[1]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[2]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_3 (.D(A2_int[1]), .TI(scanreg_ctrl_port2_wire[2]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[3]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_4 (.D(A2_int[6]), .TI(scanreg_ctrl_port2_wire[3]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[4]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_5 (.D(A2_int[7]), .TI(scanreg_ctrl_port2_wire[4]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[5]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_6 (.D(A2_int[4]), .TI(scanreg_ctrl_port2_wire[5]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[6]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_7 (.D(A2_int[5]), .TI(scanreg_ctrl_port2_wire[6]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[7]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_8 (.D(A2_int[8]), .TI(scanreg_ctrl_port2_wire[7]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[8]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_9 (.D(A2_int[9]), .TI(scanreg_ctrl_port2_wire[8]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[9]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_10 (.D(A2_int[10]), .TI(scanreg_ctrl_port2_wire[9]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[10]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_11 (.D(A2_int[2]), .TI(scanreg_ctrl_port2_wire[10]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[11]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_12 (.D(A2_int[3]), .TI(scanreg_ctrl_port2_wire[11]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[12]), .OUTX(scanreg_ctrl_port2));  
      
 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_13 (.D(scanreg_ctrl_port2_wire[13]), .TI(scanreg_ctrl_port2_wire[12]), .TE(SE), .CP(CK2_sc), .Q(scanreg_ctrl_port2_wire[13]), .OUTX(scanreg_ctrl_port2));  


// Lock Up Latch

wire SCTRLO2_temp;
ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK2_SCTRLO2_latch (Latch_open_2, scanreg_ctrl_port2_wire[13], SCTRLO2_temp);   

always @(SCTRLO2_temp) begin
    SCTRLO2_data = SCTRLO2_temp;
`ifdef functional
 `else
 if (SCTRLO2_data !== SCTRLO2_data_tim) begin 
  if (SCTRLO2_data !==X)
   SCTRLO2_data_tim =1'bx;
   SCTRLO2_data_tim <= SCTRLO2_data;
 end 
 `endif
end


// LEFT DATA SCAN CHAIN 

ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_0 (.D(D2int[15]), .TI(SDLI2_buf), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[0]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_1 (.D(D2int[14]), .TI(scanreg_d2l_wire[0]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[1]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_2 (.D(D2int[13]), .TI(scanreg_d2l_wire[1]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[2]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_3 (.D(D2int[12]), .TI(scanreg_d2l_wire[2]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[3]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_4 (.D(D2int[11]), .TI(scanreg_d2l_wire[3]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[4]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_5 (.D(D2int[10]), .TI(scanreg_d2l_wire[4]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[5]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_6 (.D(D2int[9]), .TI(scanreg_d2l_wire[5]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[6]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_7 (.D(D2int[8]), .TI(scanreg_d2l_wire[6]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[7]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_8 (.D(D2int[7]), .TI(scanreg_d2l_wire[7]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[8]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_9 (.D(D2int[6]), .TI(scanreg_d2l_wire[8]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[9]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_10 (.D(D2int[5]), .TI(scanreg_d2l_wire[9]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[10]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_11 (.D(D2int[4]), .TI(scanreg_d2l_wire[10]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[11]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_12 (.D(D2int[3]), .TI(scanreg_d2l_wire[11]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[12]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_13 (.D(D2int[2]), .TI(scanreg_d2l_wire[12]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[13]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_14 (.D(D2int[1]), .TI(scanreg_d2l_wire[13]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[14]), .OUTX(scanreg_d2l));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_15 (.D(D2int[0]), .TI(scanreg_d2l_wire[14]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2l_wire[15]), .OUTX(scanreg_d2l));

// Lock Up Latch

wire SDLO2_temp;
ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK2_SDLO2_latch (Latch_open_2, scanreg_d2l_wire[15], SDLO2_temp);

always @(SDLO2_temp) begin
     SDLO2_data = SDLO2_temp;
 `ifdef functional
 `else

if(SDLO2_data !== SDLO2_data_tim) begin
  if (SDLO2_data !==X)
       SDLO2_data_tim = 1'bx;
       SDLO2_data_tim <= SDLO2_data;
   end
 `endif 
end

// RIGHT DATA SCAN CHAIN

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_0 (.D(D2int[31]), .TI(SDRI2_buf), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[0]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_1 (.D(D2int[30]), .TI(scanreg_d2r_wire[0]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[1]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_2 (.D(D2int[29]), .TI(scanreg_d2r_wire[1]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[2]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_3 (.D(D2int[28]), .TI(scanreg_d2r_wire[2]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[3]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_4 (.D(D2int[27]), .TI(scanreg_d2r_wire[3]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[4]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_5 (.D(D2int[26]), .TI(scanreg_d2r_wire[4]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[5]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_6 (.D(D2int[25]), .TI(scanreg_d2r_wire[5]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[6]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_7 (.D(D2int[24]), .TI(scanreg_d2r_wire[6]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[7]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_8 (.D(D2int[23]), .TI(scanreg_d2r_wire[7]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[8]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_9 (.D(D2int[22]), .TI(scanreg_d2r_wire[8]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[9]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_10 (.D(D2int[21]), .TI(scanreg_d2r_wire[9]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[10]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_11 (.D(D2int[20]), .TI(scanreg_d2r_wire[10]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[11]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_12 (.D(D2int[19]), .TI(scanreg_d2r_wire[11]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[12]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_13 (.D(D2int[18]), .TI(scanreg_d2r_wire[12]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[13]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_14 (.D(D2int[17]), .TI(scanreg_d2r_wire[13]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[14]), .OUTX(scanreg_d2r));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_15 (.D(D2int[16]), .TI(scanreg_d2r_wire[14]), .TE(SE_buf), .CP(CK2_sc), .Q(scanreg_d2r_wire[15]), .OUTX(scanreg_d2r));

// Lock Up Latch
wire SDRO_temp;
 ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch  CK2_SDRO2_latch (Latch_open_2, scanreg_d2r_wire[15], SDRO2_temp);

always @(SDRO2_temp) begin
     SDRO2_data = SDRO2_temp; 
 `ifdef functional
 `else
if(SDRO2_data !== SDRO2_data_tim) begin
  if (SDRO2_data !==X)  
       SDRO2_data_tim = 1'bx;
       SDRO2_data_tim <= SDRO2_data;
   end
 `endif 
end


task DFT_port2_Scan_Acquire;
integer po;
begin
 if (supply_ok === 1) begin 
  if ( SEint ===0 && (TBYPASSint === 1'b0 || LP_CK_gate2 === 1'b0 )) begin
         scanreg_ctrl_port2=1'b0;
         scanreg_d2l=1'b0;
         scanreg_d2r=1'b0;
                     
         Latch_open_2=1;
      end 
   end

   //TBYPASS Functionality
   
   if(TBYPASSint === 1'b1) begin
      OutReg2_data = D2int;
      for (po=0;po<Bits;po=po+1)begin
        if(OutReg2_data[po] !== OutReg2_data_tim[po]) begin
          OutReg2_data_tim[po] = 1'bx;
        end        
      end        
      OutReg2_data_tim <= OutReg2_data;
   end
   else if (TBYPASSint === 1'bx) begin
      WriteOut1X;
   end 

end
endtask

task DFT_port2_Scan_Shift;
begin
if (supply_ok === 1) begin
    if (STDBY2int === 0 && SLEEPint === 0) begin
      if (CK2int_dft === X && INITNint !== 0 && SLEEPint !== 1 && STDBY2int !== 1 && ATPint !== 0) begin
         DFT_port2_ScanChainX;
         DFT_port2_ScanOutX;
      end
       else if(CK2int_dft === 1'b1 && lastCK2_dft === 1'b0) begin
          if(INITNint === 1'b1 && SLEEPint === 1'b0 && ATPint === 1'b1 && STDBY2int === 1'b0) begin
  	      ///SHIFT   
               if(SEint === 1'b1) begin
                  scanreg_ctrl_port2=1'b0;
         	  scanreg_d2l=1'b0;
         	  scanreg_d2r=1'b0;
                    
          //// SHIFT Ends
        end 
       else if (SEint === X) begin
            DFT_port2_ScanChainX;
            DFT_port2_ScanOutX;
        end
       end    
      end          
     end
    end 
end
endtask


// DFT tasks end

task corrupt_all;
begin
                MemX;
                WriteOut1X;
		WriteOut2X;
                delOutReg1_data =WordX;
                delOutReg2_data =WordX;
                DFT_port1_ScanChainX;
                DFT_port1_ScanOutX;
                DFT_port2_ScanChainX;
                DFT_port2_ScanOutX;
                RRMATCH1reg = 1'bx;
                RRMATCH2reg = 1'bx;
end
endtask

//#BEGIN BLOCK

initial
begin
  // Define format for timing value
  $timeformat (-9, 6, " ns --", 10);
  CK1_rise_time = 0;
  CK2_rise_time = 0;
  TBIST_rise_time = 0;
  ATP_rise_time = 0;
  TBYPASS_rise_time = 0;
  // parameter assignment
   reg_Fault_file_name = Fault_file_name; 
   reg_ConfigFault     = ConfigFault;
   reg_MEM_INITIALIZE  = MEM_INITIALIZE;
   reg_BinaryInit      = BinaryInit;
   reg_InitFileName    = InitFileName;
   reg_Initn_reset_value = Initn_reset_value;
   reg_File_load_time    = File_load_time;
//  
  TimingViol_D1 = 0;
  TimingViol_D1_last = 0;
  TimingViol_D1_MTCK = 0;
  TimingViol_D1_MTCK_last = 0;
  TimingViol_M1 = 0;
  TimingViol_M1_last = 0;
  TimingViol_M1_MTCK = 0;
  TimingViol_M1_MTCK_last = 0;
  TimingViol_D2 = 0;
  TimingViol_D2_last = 0;
  TimingViol_D2_MTCK = 0;
  TimingViol_D2_MTCK_last = 0;
  TimingViol_M2 = 0;
  TimingViol_M2_last = 0;
  TimingViol_M2_MTCK = 0;
  TimingViol_M2_MTCK_last = 0;



  lastCK1 = CK1int;
  lastCK2 = CK2int;
  lastCK1_dft = CK1int_dft;
  lastCK2_dft = CK2int_dft;
  lastMTCK = MTCKint;


  repair_add_last_port1 = repair_add;
  repair_add_last_port2 = repair_add;

  RRAEint_last_port1 = RRAEint;
  RRAEint_last_port2 = RRAEint;
  
  corrupt_flag_periphery=1'b0;
  corrupt_flag_array=1'b0;
  

  power_up_done = 0;

  `ifdef ST_MEM_SLM
  $slm_RegisterMemory(slm_handle, Words, Bits); 
  `endif

  file_loaded = 1;
  debug_level= p_debug_level;
     
  `ifdef ST_MEM_SLM
   `ifdef functional
     operating_mode = "SLM + FUNCTIONAL";
   `else
     operating_mode = "SLM + TIMING";
   `endif
  `elsif functional
     operating_mode = "FUNCTIONAL";
  `else 
     operating_mode = "TIMING";
  `endif
  
   flag_invalid_next_port1_cycle = 1'b0;        // Initializing the flag to zero. 
   flag_invalid_present_port1_cycle = 1'b0;     // Initializing the flag to zero.

   flag_invalid_next_port2_cycle = 1'b0;        // Initializing the flag to zero. 
   flag_invalid_present_port2_cycle = 1'b0;     // Initializing the flag to zero.
  
   flag_invalid_next_port2_dft_cycle = 1'b0;
   flag_invalid_present_port2_dft_cycle = 1'b0;

   flag_invalid_next_port1_dft_cycle = 1'b0;
   flag_invalid_present_port1_dft_cycle = 1'b0;
   
    
  `ifndef ST_MEM_POWER_SEQUENCING_OFF
    Proper_shutdown = 1'b0;
  `endif  
  
 
   
   r_supply_trigger <= 1'b1;
  initn_pulse_done = 1;
  if (INITN_buf === 1'b0 && supply_ok === 1) begin 
      initn_pulse_done = 1;  
      power_up_done = 1;
  

      `ifdef ST_MEM_INITN_OUTPUT_RESET
       OutReg1_data = reg_Initn_reset_value;
       OutReg2_data = reg_Initn_reset_value;
     `endif
     // Reset memory contents     
     `ifdef ST_MEM_INITN_MEM_RESET
      WriteMem0;
     `endif
      
    end
 
 task_read_fault_file;  
   
`ifdef ST_MEM_CONTENTS_SLEEP
   ptr=$fopen("MEMORY_CONTENTS_SLEEP_ASSERT.dat","w");
   $fclose(ptr);
   ptr=$fopen("MEMORY_CONTENTS_SLEEP_DEASSERT.dat","w");
   $fclose(ptr);
   ptr=$fopen("MEMORY_CONTENTS_SLEEP_INVALID.dat","w");
   $fclose(ptr);
 `endif 
  
   #(message_control_time + `access_time);
   if (debug_level === 2'b00) begin
    message_status = "All Messages are Switched OFF";
   end
   else if (debug_level === 2'b11) begin
    message_status = "All Info/Warning/Error Messages are Switched ON";
   end
   else if (debug_level === 2'b01) begin
    message_status = "Error messages are switched ON. Warning/Info Messages are Switched OFF";
   end
   else begin
    message_status = "Error/Warning messages are switched ON. Info Messages are Switched OFF";
   end
   if(debug_level > 2) begin
     $display ("%m - %t ST_INFO: **************************************",$realtime);
     $display ("%m - %t ST_INFO: The Model is Operating in %s MODE",$realtime, operating_mode);
     $display ("%m - %t ST_INFO: %s",$realtime, message_status);
     if(reg_ConfigFault)
       $display ("%m - %t ST_INFO: Configurable Fault Functionality is ON",$realtime);   
     else
       $display ("%m - %t ST_INFO: Configurable Fault Functionality is OFF",$realtime);   

    $display("%m - %t ST_INFO: Fault File used by the model Fault_File_Name=%s",$realtime ,reg_Fault_file_name);
    $display("%m - %t ST_INFO: Values of Config_fault used in model=%d",$realtime  ,reg_ConfigFault);
    $display("%m - %t ST_INFO: Values of Mem_INITALIZE used in model=%d",$realtime ,reg_MEM_INITIALIZE);
    $display("%m - %t ST_INFO: Values of BinaryInit used in model=%d",$realtime ,reg_BinaryInit);
    $display("%m - %t ST_INFO: Values of InitFileName used in model=%s",$realtime ,reg_InitFileName);
    $display("%m - %t ST_INFO: Values of Initn_reset_value used in model=%d",$realtime ,reg_Initn_reset_value);
    $display("%m - %t ST_INFO: Values of File_load_time used in model=%t",$realtime ,reg_File_load_time);
     $display ("%m - %t ST_INFO: ***************************************",$realtime);
   end
end  // initial

//model is more pessimistic. in reality Q will remain unchanged until next posedge. This is just to align with other compilers  



always @(TBYPASSint or ATPint or STDBY1int)
begin
 if(supply_ok === 1) begin
    
    if(initn_pulse_done === 0) begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
    end 
 else begin
       if(ATPint !== 0 && TBYPASSint !== 0 && SEint !== 1 && INITNint !== 0 ) begin
          if(STDBY1int !== 1) begin
            WriteOut1X;
            delOutReg1_data = wordx;
          end    
        end        
    end  
    
 end  //if(supply_ok === 1 

end



always @(TBYPASSint or ATPint or STDBY2int)
begin
 if(supply_ok === 1) begin
    
    if(initn_pulse_done === 0) begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
    end 
 else begin
       if(ATPint !== 0 && TBYPASSint !== 0 && SEint !== 1 && INITNint !== 0 ) begin
   
          if(STDBY2int !== 1) begin
	    WriteOut2X;
	    delOutReg2_data = wordx;
          end    
       end        
    end  
    
 end  //if(supply_ok === 1 

end


// Clock Mux signal toggling ATP, TBIST, TBYPASS.
//modified to more pessimistic. Now only CSN can save from corruption. (stf arcs avoided)
// spurious glitch on CK_int
always @(ATPint)
begin
if ($realtime != 0 )
  begin   

      if (SElatch === 1'bx && ATPint !== 1'b0 && INITNint === 1'b1 && SLEEPint !== 1'b1) 
       begin
         if(TBYPASSint !==1'b0) WriteOut1X;
         if(TBYPASSint !==1'b0) WriteOut2X;
       end

     ATP_rise_time = $realtime;
     if ( !(CSN1sys === 1 && TCSN1sys === 1) && !(CK1tempint === 1'b0 && MTCKtempint === 1'b0))
     begin    
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Port :  Transition on Select Clock Pin. Memory Corrupted ",$realtime);
        Mem_port1_FSM_Corrupt_atp_tby_tbist;
     end   

     else if(ATPint !== X  && STDBY1int === 0 && SLEEPint === 0 && INITNint === 1 && SEint=== 1 ) begin 
        flag_invalid_present_port1_cycle = 1'b0;
        flag_invalid_next_port1_cycle = 1'b0;
        flag_invalid_next_port1_dft_cycle = 1'b0;
        flag_invalid_present_port1_dft_cycle = 1'b0;
     end // added for fsm_corruption functionality

     if (  !(CSN2sys === 1 && TCSN2sys === 1) && !(CK2tempint === 1'b0 && MTCKtempint === 1'b0))
     begin
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Port :  Transition on Select Clock Pin. Memory Corrupted ",$realtime); 
        Mem_port2_FSM_Corrupt_atp_tby_tbist;
     end   

     else if (ATPint !== X  && STDBY2int === 0 && SLEEPint === 0 && INITNint === 1 && SEint=== 1 ) begin 
        flag_invalid_present_port2_cycle = 1'b0;
        flag_invalid_next_port2_cycle = 1'b0;
        flag_invalid_next_port2_dft_cycle = 1'b0;
        flag_invalid_present_port2_dft_cycle = 1'b0;
     end // added for fsm_corruption functionality

  end  
end  



always @(TBISTint)
begin
  if ($realtime != 0)
  begin   
     TBIST_rise_time = $realtime;
     if ( !(CSN1sys === 1 && TCSN1sys === 1)  &&   !(CK1tempint === 1'b0 && MTCKtempint === 1'b0)  )
     begin    
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port1 port :  Transition on Select Clock Pin. Memory Corrupted ",$realtime);
        Mem_port1_FSM_Corrupt_atp_tby_tbist;
     end   
     if ( !(CSN2sys === 1 && TCSN2sys === 1)  &&   !(CK2tempint === 1'b0 && MTCKtempint === 1'b0))
     begin
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Port2 port :  Transition on Select Clock Pin. Memory Corrupted ",$realtime); 
        Mem_port2_FSM_Corrupt_atp_tby_tbist;
     end   
  end   
end  





always @(TBYPASSint)
begin
if(TBYPASSint !== 1'b1 && SEint !== 1'b1 && TBISTint !== 1'b1 && ATPint !== 1'b0 && SLEEPint !== 1'b1)
  begin
 	if (CK1int === 1'bx)begin
	 DFT_port1_ScanChainX;
	 DFT_port1_ScanOutX;
	end
	if (CK2int === 1'bx)begin
	 DFT_port2_ScanChainX;
	 DFT_port2_ScanOutX;
	end
  end

if(SElatch === 1'bx && TBYPASSint !== 1'b0 && ATPint !== 1'b0 && INITNint === 1'b1 && SLEEPint !== 1'b1)
begin
	WriteOut1X;
	WriteOut2X;
end

if ($realtime != 0 )
  begin   
     TBYPASS_rise_time = $realtime;
     if ( CSN1_SEint !== 1 && !(CK1tempint === 1'b0 && MTCKtempint === 1'b0))
     begin    
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Port :  Transition on Select Clock Pin. Memory Corrupted ",$realtime);
        Mem_port1_FSM_Corrupt_atp_tby_tbist;
     end   
     if ( CSN2_SEint !== 1  && !(CK2tempint === 1'b0 && MTCKtempint === 1'b0))
     begin
        if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Port :  Transition on Select Clock Pin. Memory Corrupted ",$realtime); 
        Mem_port2_FSM_Corrupt_atp_tby_tbist;
     end   
  end  
end



//DFT Operation

always @(CK1int_dft) 
begin
lastCK1_dft = CK1reg_dft;
CK1reg_dft = CK1int_dft;
Latch_open_1 = 0;

 if(supply_ok === 1) begin
    if(initn_pulse_done === 0) begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
    end 
    else begin
       if(CK1int_dft === 1'b1 && lastCK1_dft === 1'b0) begin
          if ((flag_invalid_next_port1_dft_cycle  ) === 1'b1) begin
             flag_invalid_next_port1_dft_cycle = 1'b0;
             flag_invalid_present_port1_dft_cycle = 1'b1;
          end
          else if (flag_invalid_next_port1_dft_cycle === 1'b0) begin
             flag_invalid_present_port1_dft_cycle = 1'b0;
          end   
       end // if(CK1int_dft === 1'b1

       if(CK1int_dft === 1'b0 && lastCK1_dft === 1'b1 && INITNint === 1'b1 && SLEEPint === 1'b0 && ATPreg_CK1 === 1'b1 && STDBY1int === 1'b0) begin
         if (SEreg_CK1 === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b1  ) begin
          
          for (f = 0; f< scanlen_d1l ; f=f+1) begin
            OutReg1_data[f] = scanreg_d1l_wire[scanlen_d1l -f -1 ];
          end       
          for (f = 0; f< scanlen_d1r ; f=f+1) begin
             OutReg1_data[f + scanlen_d1l ] = scanreg_d1r_wire[scanlen_d1r -f -1 ];
          end    
          
          
           for (f=0;f<Bits;f=f+1)begin
              if(OutReg1_data[f] !== OutReg1_data_tim[f]) begin
                  OutReg1_data_tim[f] = 1'bx;
              end        
           end        
           OutReg1_data_tim <= OutReg1_data;
         end  
       end  // if (CK1int_dft === 1'b0

     
if (CK1int_dft === 1'b1 && lastCK1_dft === 1'b0 && TBISTint === 1'b0 && TBYPASSint === 1'bx && INITNint === 1'b1 && SLEEPint === 1'b0 && ATPint === 1'b1 && STDBY1int === 1'b0 && SEint === 1'b0 ) begin
 DFT_port1_FSM_Corrupt ;
end 
         
       if(flag_invalid_next_port1_dft_cycle === 1'b0 && flag_invalid_present_port1_dft_cycle === 1'b0 ) begin
          
          if(CK1int_dft === 1'b1 && lastCK1_dft === 1'b0) begin
             SEreg_CK1 = SEint;
             ATPreg_CK1 = ATPint;
             INITNreg_CK1 = INITNint;
             SLEEPreg_CK1 = SLEEPint;
             STDBY1reg_CK1 = STDBY1int;
             TBYPASSreg_CK1 = TBYPASSint;
             

            if(INITNint === 1'b1 && SLEEPint === 1'b0 && ATPint === 1'b1 && STDBY1int === 1'b0) begin
               if(SEint === 1'b1) begin
                  DFT_port1_Scan_Shift;
               end        
               else if (SEint === 1'b0) begin
                 if (TBISTint === 1'b1 && TBYPASSint === 1'b0) begin
                   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Port1 Scan capture blocked when TBIST = 1 and TBYPASS = 0",$realtime);
                 end
                 else if (TBISTint === 1'bx && TBYPASSint !== 1'b1) begin
                  DFT_port1_ScanChainX;
                  DFT_port1_ScanOutX;
                  if (TBYPASSint === 1'bx) begin
                    WriteOut1X;
                  end  
                 end
                 else if (TBISTint !== 1'b0 && TBYPASSint === 1'bx) begin
                  DFT_port1_ScanChainX;
                  DFT_port1_ScanOutX;
                  WriteOut1X;
                 end  
                 else if ( TBYPASSint === 1'b0 || LP_CK_gate1 === 1'b0 ) begin
                   DFT_port1_Scan_Acquire; 
                 end 
                 else if ( TBYPASSint === 1'b1 && LP_CK_gate1 === X ) begin
                  DFT_port1_ScanChainX;
                  DFT_port1_ScanOutX;
                  WriteOut1X;
                 end 

               end 
               else if (SEint === 1'bx) begin
                  DFT_port1_ScanChainX;
                  DFT_port1_ScanOutX;
                    if(TBYPASSint !== 1'b0 ) begin
                      WriteOut1X;
                    end 
               end        
             end   
          end  //IF (CK1int_dft ===

          if(CK1int_dft === 1'b0 && lastCK1_dft === 1'b1) begin
            if(SEreg_CK1 === 1'b1 && INITNint === 1'b1 && SLEEPint === 1'b0 && ATPreg_CK1 === 1'b1 && STDBY1int === 1'b0) begin
              Latch_open_1 = 1'b1 ;   
           end        
          end // IF (CK1int_dft === 1'b0    
          
       end // IF (flag_invalid_next_port1_dft_cycle       
       
           if(CK1int_dft === 1'bX && MEMEN_DFT1 !== 1'b0) begin
if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && (ATPint !==1'b0 && ((SEint !==1'b0 || (TBYPASSint ===1'b1 && LP_CK_gate1 !==1'b1))|| (TBYPASSint !== 1'b1 && SEint !== 1'b1 ))))       
   begin    
               DFT_port1_FSM_Corrupt;     
            end  
          end //IF (CK1int_dft === 1'bX

          if(CK1int_dft === 1'b1 && lastCK1_dft === 1'b0) begin
             if((INITNint === 1'bx && SLEEPint !== 1'b1 && ATPint !== 1'b0 && STDBY1int !== 1'b1) || (INITNint !== 1'b0 && SLEEPint === 1'bx && ATPint !== 1'b0 && STDBY1int !== 1'b1) || (INITNint !== 1'b0 && SLEEPint !== 1'b1 && ATPint !== 1'b0 && STDBY1int === 1'bx) ) begin
               DFT_port1_FSM_Corrupt;
             end 
             if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && (ATPint === 1'bx && (TBIST_buf !==1'b1 || TBYPASSint !==1'b0|| SEint !==1'b0)) && STDBY1int !== 1'b1) begin
               DFT_port1_FSM_Corrupt;
 	     end
          end
 
if ((!(TBYPASSint!==0 && SEint!==1 && LP_CK_gate1!==0 ) && ( flag_invalid_next_port1_dft_cycle === 0 && flag_invalid_present_port1_dft_cycle === 0) ) || CK1int_dft !==1) begin
if(!((CK1int_dft === 1'bx && (ATPint === 1'b0 || (ATPint ===1'b1 && TBYPASSint ===1'b1 && SEint === 1'b0 && LP_CK_gate1 === 1'b1))) || (CK1int_dft === 1'b1 && lastCK1_dft === 1'bx && ATPint !==1'b0 )))begin
 CK1_sc=INITNreg_CK1 & !STDBY1reg_CK1 & !SLEEPreg_CK1 & ATPreg_CK1 & !(TBISTint & !TBYPASSreg_CK1 & !SEreg_CK1 ) & CK1reg_dft ; 
end
     end 
   end // ELSE  begin
 end //Supply_ok
end




always @(CK2int_dft) 
begin

//For clock CK2_sc 
lastCK2_dft = CK2reg_dft;
CK2reg_dft = CK2int_dft;
Latch_open_2 = 0;

 if(supply_ok === 1) begin
    if(initn_pulse_done === 0) begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
    end 
    else begin
       if(CK2int_dft === 1'b1 && lastCK2_dft === 1'b0) begin
          if ((flag_invalid_next_port2_dft_cycle  ) === 1'b1) begin
             flag_invalid_next_port2_dft_cycle = 1'b0;
             flag_invalid_present_port2_dft_cycle = 1'b1;
          end
          else if (flag_invalid_next_port2_dft_cycle === 1'b0) begin
             flag_invalid_present_port2_dft_cycle = 1'b0;
          end   
       end // if(CK2int_dft === 1'b1

       if(CK2int_dft === 1'b0 && lastCK2_dft === 1'b1 && INITNint === 1'b1 && SLEEPint === 1'b0 && ATPreg_CK2 === 1'b1 && STDBY2int === 1'b0) begin
         if (SEreg_CK2 === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b1 ) begin
          
          for (f = 0; f< scanlen_d2l ; f=f+1) begin
            OutReg2_data[f] = scanreg_d2l_wire[scanlen_d2l -f -1 ];
          end       
          for (f = 0; f< scanlen_d2r ; f=f+1) begin
             OutReg2_data[f + scanlen_d2l ] = scanreg_d2r_wire[scanlen_d2r -f -1 ];
          end    
          
          
           for (f=0;f<Bits;f=f+1)begin
              if(OutReg2_data[f] !== OutReg2_data_tim[f]) begin
                  OutReg2_data_tim[f] = 1'bx;
              end        
           end        
           OutReg2_data_tim <= OutReg2_data;
         end  
       end  // if (CK2int_dft === 1'b0


if (CK2int_dft === 1'b1 && lastCK2_dft === 1'b0 && TBISTint === 1'b0 && TBYPASSint === 1'bx && INITNint === 1'b1 && SLEEPint === 1'b0 && ATPint === 1'b1 && STDBY2int === 1'b0 && SEint === 1'b0 ) begin
 DFT_port2_FSM_Corrupt ;
end  

         
       if(flag_invalid_next_port2_dft_cycle === 1'b0 && flag_invalid_present_port2_dft_cycle === 1'b0 ) begin
          
          if(CK2int_dft === 1'b1 && lastCK2_dft === 1'b0) begin
             SEreg_CK2 = SEint;
             ATPreg_CK2 = ATPint;
             INITNreg_CK2 = INITNint;
             SLEEPreg_CK2 = SLEEPint;
             STDBY2reg_CK2 = STDBY2int;
             TBYPASSreg_CK2 = TBYPASSint;
            
             if(INITNint === 1'b1 && SLEEPint === 1'b0 && ATPint === 1'b1 && STDBY2int === 1'b0) begin
               if(SEint === 1'b1) begin
                  DFT_port2_Scan_Shift;
               end        
               else if (SEint === 1'b0) begin
                 if (TBISTint === 1'b1 && TBYPASSint === 1'b0) begin
                   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Write Scan capture blocked when TBIST = 1 and TBYPASS = 0",$realtime);
                 end
                 else if (TBISTint === 1'bx && TBYPASSint !== 1'b1) begin
                  DFT_port2_ScanChainX;
                  DFT_port2_ScanOutX;
                  if (TBYPASSint === 1'bx) begin
                    WriteOut2X;
                  end  
                 end
                 else if (TBISTint !== 1'b0 && TBYPASSint === 1'bx) begin
                  DFT_port2_ScanChainX;
                  DFT_port2_ScanOutX;
                  WriteOut2X;
                 end  
                 else if ( TBYPASSint === 1'b0 || LP_CK_gate2 === 1'b0 ) begin
                   DFT_port2_Scan_Acquire; 
                 end 
                 else if ( TBYPASSint === 1'b1 && LP_CK_gate2 === X ) begin
                  DFT_port2_ScanChainX;
                  DFT_port2_ScanOutX;
                  WriteOut2X;
                 end 

               end 
               else if (SEint === 1'bx) begin
                  DFT_port2_ScanChainX;
                  DFT_port2_ScanOutX;
                    if(TBYPASSint !== 1'b0 ) begin
                      WriteOut2X;
                    end 
               end        
             end   
          end  // IF (CK2int_dft ===
//scan out ports are updated on negedge of CK
          if(CK2int_dft === 1'b0 && lastCK2_dft === 1'b1) begin
            if(SEreg_CK2 === 1'b1 && INITNint === 1'b1 && SLEEPint === 1'b0 && ATPreg_CK2 === 1'b1 && STDBY2int === 1'b0) begin
              Latch_open_2 = 1'b1 ;    
            end        
          end // IF (CK2int_dft === 1'b0    
          
       end //if(flag_invalid_next_port2_dft_cycle       
       
if(CK2int_dft === 1'bX && MEMEN_DFT2 !== 1'b0) begin         
   if(INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && (ATPint !==1'b0 && ((SEint !==1'b0 || (TBYPASSint ===1'b1 && LP_CK_gate2 !==1'b1))|| (TBYPASSint !== 1'b1 && SEint !== 1'b1 )))) begin
               DFT_port2_FSM_Corrupt;     
            end  
          end //if(CK2int_dft === 1'bX

          if(CK2int_dft === 1'b1 && lastCK2_dft === 1'b0) begin
             if((INITNint === 1'bx && SLEEPint !== 1'b1 && ATPint !== 1'b0 && STDBY2int !== 1'b1) || (INITNint !== 1'b0 && SLEEPint === 1'bx && ATPint !== 1'b0 && STDBY2int !== 1'b1) || (INITNint !== 1'b0 && SLEEPint !== 1'b1 && ATPint !== 1'b0 && STDBY2int === 1'bx) ) begin
               DFT_port2_FSM_Corrupt;
             end 
             if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && (ATPint === 1'bx && (TBIST_buf !==1'b1 || TBYPASSint !==1'b0|| SEint !==1'b0)) && STDBY2int !== 1'b1) begin
               DFT_port2_FSM_Corrupt;
 	     end
          end

if ((!(TBYPASSint!==0 && SEint!==1 && LP_CK_gate2!==0 ) && ( flag_invalid_next_port2_dft_cycle === 0 && flag_invalid_present_port2_dft_cycle === 0) ) || CK2int_dft !==1) begin
 if(!((CK2int_dft === 1'bx && (ATPint === 1'b0 || (ATPint ===1'b1 && TBYPASSint ===1'b1 && SEint === 1'b0 && LP_CK_gate2 === 1'b1))) || (CK2int_dft === 1'b1 && lastCK2_dft === 1'bx && ATPint !==1'b0 ))) begin    
   CK2_sc=INITNreg_CK2 & !STDBY2reg_CK2 & !SLEEPreg_CK2 & ATPreg_CK2 & !(TBISTint & !TBYPASSreg_CK2 & !SEreg_CK2 ) & CK2reg_dft ;
  end 
end
    end // ELSE begin
 end //Supply_ok
end

always @(SEint or SElatch) 
begin
if(supply_ok === 1) begin
   if (initn_pulse_done === 0) begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
   end
   else begin
           
if(ATPint !== 1'b0 && INITNint !== 1'b0 && SLEEPint !== 1'b1) begin
    if(SEint !== 1'b0) begin
	if  (CK1int_dft === 1'bx) begin
	   DFT_port1_ScanChainX;
    	   DFT_port1_ScanOutX; end
	
        if  (CK2int_dft === 1'bx) begin
	   DFT_port2_ScanChainX;
    	   DFT_port2_ScanOutX; end
      end

    if((SEint !== 1'b1 || SElatch === 1'bx) && TBYPASSint !== 1'b0) 
     begin
	WriteOut1X;
	WriteOut2X;
     end
end

    if(ATPint === 1'b1 && INITNint === 1'b1 && SLEEPint === 1'b0) begin
	
     if(SEint === 1'b1) begin
	flag_invalid_present_port1_cycle = 1'b0;
	flag_invalid_present_port2_cycle = 1'b0;
     end

     if(SEint === 1'b0) begin
        
        if(TBYPASSint === 1'b1 && CK1int_dft === 1'b0 && LastSEint ===1'b1) begin
          
          for (f = 0; f< scanlen_d1l ; f=f+1) begin
            OutReg1_data[f] = scanreg_d1l_wire[scanlen_d1l -f -1 ];
          end       
          for (f = 0; f< scanlen_d1r ; f=f+1) begin
             OutReg1_data[f + scanlen_d1l ] = scanreg_d1r_wire[scanlen_d1r -f -1 ];
          end    
          
          
           for (f=0;f<Bits;f=f+1)begin
              if(OutReg1_data[f] !== OutReg1_data_tim[f]) begin
                  OutReg1_data_tim[f] = 1'bx;
              end        
           end        
           OutReg1_data_tim <= OutReg1_data;
        end //if(TBYPASSint 
            
         else if(TBYPASSint === 1'bx) begin
            WriteOut1X;
         end        

      if(TBYPASSint === 1'b1 && CK2int_dft === 1'b0 && LastSEint ===1'b1 ) begin
          
          for (f = 0; f< scanlen_d2l ; f=f+1) begin
            OutReg2_data[f] = scanreg_d2l_wire[scanlen_d2l -f -1 ];
          end       
          for (f = 0; f< scanlen_d2r ; f=f+1) begin
             OutReg2_data[f + scanlen_d2l ] = scanreg_d2r_wire[scanlen_d2r -f -1 ];
          end    
          
          
           for (f=0;f<Bits;f=f+1)begin
              if(OutReg2_data[f] !== OutReg2_data_tim[f]) begin
                  OutReg2_data_tim[f] = 1'bx;
              end        
           end        
           OutReg2_data_tim <= OutReg2_data;
        end //if(TBYPASSint 
            
         else if(TBYPASSint === 1'bx) begin
            WriteOut2X;
         end    


     end //if(SEint === 1'b0 
    end //if(ATPint === 1'b1)
   end //else begin        
end // if(supply_ok
LastSEint <= SElatch;
end


//to handle Flags CK1tempint blocks will be executed before CK1int always blocks.

always @(CK1tempint)
begin

    if(CK1tempint === 1'b1 && lastCK1tempint === 1'b0 && ((ATPint === 1'b0) || (TBISTint === 1'b0)) ) begin
      if (flag_invalid_next_port1_cycle ) begin
          flag_invalid_next_port1_cycle = 1'b0;
          flag_invalid_present_port1_cycle = 1'b1;
       end
       else if (flag_invalid_next_port1_cycle === 1'b0) begin
         flag_invalid_present_port1_cycle = 1'b0;
       end   
    end
CK1int = CK1tempint;    
    lastCK1tempint = CK1tempint;

end


always @(CK2tempint)
begin
   
  if(CK2tempint === 1'b1 && lastCK2tempint === 1'b0 && ((ATPint === 1'b0) || (TBISTint === 1'b0)) ) begin
      if (flag_invalid_next_port2_cycle ) begin
          flag_invalid_next_port2_cycle = 1'b0;
          flag_invalid_present_port2_cycle = 1'b1;
       end
       else if (flag_invalid_next_port2_cycle === 1'b0) begin
         flag_invalid_present_port2_cycle = 1'b0;
       end   
    end
 CK2int = CK2tempint;  
       lastCK2tempint = CK2tempint;
end

ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_se_port1 (1'b0, 1'b0, !CK1, SEint, SElatch);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_se_port2 (1'b0, 1'b0, !CK2, SEint, SElatch);

always @(MTCKtempint)
begin


   if(MTCKtempint === 1'b1 && lastMTCKtempint === 1'b0 && ATPint === 1'b1 && TBISTint === 1'b1) begin
      if (flag_invalid_next_port1_cycle ) begin
          flag_invalid_next_port1_cycle = 1'b0;
          flag_invalid_present_port1_cycle = 1'b1;
       end
       else if (flag_invalid_next_port1_cycle === 1'b0) begin
         flag_invalid_present_port1_cycle = 1'b0;
       end   
    end

   if(MTCKtempint === 1'b1 && lastMTCKtempint === 1'b0 && ATPint === 1'b1 && TBISTint === 1'b1) begin
       if (flag_invalid_next_port2_cycle ) begin
           flag_invalid_next_port2_cycle = 1'b0;
           flag_invalid_present_port2_cycle = 1'b1;
        end
        else if (flag_invalid_next_port2_cycle === 1'b0) begin
          flag_invalid_present_port2_cycle = 1'b0;
      end   
   end
  MTCKint = MTCKtempint; 
 lastMTCKtempint = MTCKtempint;
end







// port1
 
always @(CK1int)
begin
if(supply_ok === 1) begin

 if (initn_pulse_done === 0) begin
  if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
 end
 else begin
    if(CK1int === 1'b1 && lastCK1 === 1'b0 && ((ATPint === 1'b0) || (TBISTint === 1'b0)) ) begin
      
      CK1_rise_time = $realtime;
   

//write
       if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY1int === 1'b0 && IG1int === 1'b0 && CSN1int === 1'b0 && WEN1int === 1'b0 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&  flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en1 === 1'b0 || (red_en1 === 1'b1 && ^repair_add !== 1'bx)) && TP_buf !== 1'bx) begin 
       // A = X condition and contention condition. If A=x, it should cause next cycle to corrupt even if you are already in a corrupt cycle. So checking of present_cycle flag should be after chking A and then setting things accordingly
         main_write_port1;
       end   
//read
else  if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY1int === 1'b0 && IG1int === 1'b0 && CSN1int === 1'b0 && WEN1int === 1'b1 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&   flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en1 === 1'b0 || (red_en1 === 1'b1 && ^repair_add !== 1'bx))  && TP_buf !== 1'bx) begin
         main_read_port1;
       end   

//tbypass mode also sees FSM_corruption     
       else if (INITNint === 1'bX && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end        
       else if (INITNint !== 1'b0 && SLEEPint === 1'bX && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int === 1'bX  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end  

       else if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY1int === 1'b0 && IG1int === 1'b0 && CSN1int === 1'b0 && WEN1int === 1'bX && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0) )) begin
         Mem_port1_CCL;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int === 1'bX && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1  && (ATPint === 1'bX && (SEint !== 0 || TBYPASSint !== 0)) ) begin
         Mem_port1_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && LSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && LSint !== 1'bX && HSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end       

	else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1  && CSN1int !== 1'b1 && WEN1int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (RMint !== {read_margin_size{1'b0}} || WMint !== {write_margin_size{1'b0}} )  ) begin
         Mem_port1_FSM_Corrupt;  
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && WEN1int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && TP_buf === 1'bX  ) begin
         Mem_port1_FSM_Corrupt;
       end

       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int === 1'bx && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 ) )) begin
         Mem_port1_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && red_en1 === 1'bx) begin
         Mem_port1_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (red_en1 === 1'b1 && ^repair_add === 1'bx) ) begin
         Mem_port1_FSM_Corrupt;
       end

//A-> x in Bypass mode-> FSM corruption.
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b0 && (^A1int===1'bx || (red_en1 === 1'b1 && ^repair_add === 1'bx)) ) begin
         CK1_rise_time = $realtime;
         CK2_rise_time = $realtime;
         Mem_port1_FSM_Corrupt;
       end
//
//bypass->x with respect to CK1 can cause rw to get affected.

 else if ( INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 &&  (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==1 )) begin
         Mem_port1_FSM_Corrupt;
       end


   end   

// covers conds (atp=1,tbist=x; atp=x,tbist=1/x)
   else if (CK1int === 1'b1 && lastCK1 === 1'b0 && !((ATPint === 1'b1) && (TBISTint === 1'b1))) begin
       CK1_rise_time = $realtime;
        
          if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
          Mem_port1_FSM_Corrupt;  
          end  

//bypass->x with respect to CK1 can cause rw to get affected.

        else if ( INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 &&  (ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==1 )) begin
         Mem_port1_FSM_Corrupt;
       end


    end  

// Tbypass=1 added here.
    if(CK1int === 1'bX ) begin
      CK1_rise_time = $realtime;
      if ( (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1 &&  TBISTint !== 1'b1)))) begin
        Mem_port1_FSM_Corrupt;      
 end        
     if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && ATPint !== 1'b0 && TBYPASSint !== 1'b0 ) begin
	WriteOut1X;
	end
    end        
 end    
end 
lastCK1 = CK1int;
end //end of always CK1int




always @(CK2int)
begin
if(supply_ok === 1) begin

 if (initn_pulse_done === 0) begin
  if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
 end
 else begin
    if(CK2int === 1'b1 && lastCK2 === 1'b0 && ((ATPint === 1'b0) || (TBISTint === 1'b0)) ) begin
      
      CK2_rise_time = $realtime;

//#write
       if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY2int === 1'b0 && IG2int === 1'b0 && CSN2int === 1'b0 && WEN2int === 1'b0 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&   flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en2 === 1'b0 || (red_en2 === 1'b1 && ^repair_add !== 1'bx)) && TP_buf !== 1'bx) begin 
       // A = X condition and contention condition
         main_write_port2;
       end   
//#read
else  if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY2int === 1'b0 && IG2int === 1'b0 && CSN2int === 1'b0 && WEN2int === 1'b1 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&   flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en2 === 1'b0 || (red_en2 === 1'b1 && ^repair_add !== 1'bx)) && TP_buf !== 1'bx) begin
         main_read_port2;
       end   

     
       else if (INITNint === 1'bX && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 ) ) ) begin
         Mem_port2_FSM_Corrupt;
       end        
       else if (INITNint !== 1'b0 && SLEEPint === 1'bX && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int === 1'bX  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end  

       else if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY2int === 1'b0 && IG2int === 0 && CSN2int === 1'b0 && WEN2int === 1'bX && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0) ) ) begin
         Mem_port2_CCL;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int === 1'bX && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1  && (ATPint === 1'bX && (SEint !== 0 || TBYPASSint !== 0)) ) begin
         Mem_port2_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && LSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && LSint !== 1'bX && HSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && WEN2int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (WMint !== {write_margin_size{1'b0}} || RMint !== {read_margin_size{1'b0}})  ) begin
         Mem_port2_FSM_Corrupt;
       end

       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && WEN2int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && TP_buf === 1'bX  ) begin
         Mem_port2_FSM_Corrupt;
       end

       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int === 1'bx && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 ) )) begin
         Mem_port2_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && red_en2 === 1'bx) begin
         Mem_port2_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (red_en2 === 1'b1 && ^repair_add === 1'bx) ) begin
         Mem_port2_FSM_Corrupt;
       end
          //A-> x in Bypass mode-> FSM corruption.
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b0 && (^A2int===1'bx || (red_en2 === 1'b1 && ^repair_add === 1'bx)) ) begin
         CK1_rise_time = $realtime;
         CK2_rise_time = $realtime;

         Mem_port2_FSM_Corrupt;
       end

   //bypass->x with respect to CK2 can cause rw to get affected.

       else if ( INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 &&  (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==1 )) begin
         Mem_port2_FSM_Corrupt;
       end




   end   

  else if (CK2int === 1'b1 && lastCK2 === 1'b0 && !((ATPint === 1'b1) && (TBISTint === 1'b1))) begin
       CK2_rise_time = $realtime;

        if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
          Mem_port2_FSM_Corrupt;      
      end  

 //bypass->x with respect to CK1 can cause rw to get affected.

        else if ( INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 &&  (ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==1 )) begin
         Mem_port2_FSM_Corrupt;
       end


    end  
// Tbypass=1 added here.
    if(CK2int === 1'bX ) begin
      CK2_rise_time = $realtime;
      if ((INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1 && TBISTint !== 1'b1)))) begin
        Mem_port2_FSM_Corrupt;      
      end        
    if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && ATPint !== 1'b0 && TBYPASSint !== 1'b0) begin
	WriteOut2X;
end
end        
  
 end    
end 
lastCK2 = CK2int;
end //end of always CK2int






//Latching signals for Timing Model

always @(posedge CK1sys)
begin
if(supply_ok === 1) begin
  if (initn_pulse_done === 0) begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
  end
  else begin
     MEMEN_1_CK1_reg_pre = MEMEN_1_CK1_reg;
     MEMEN_1_CK1_reg = MEMEN_1;
     MEMEN_DFT_CK1_reg_pre = MEMEN_DFT_CK1_reg;
     MEMEN_DFT_CK1_reg = MEMEN_DFT1;

     CSN1sys_reg_CK1_pre = CSN1sys_reg_CK1;     
     CSN1sys_reg_CK1 = CSN1int;
     WEN1sys_reg_CK1 = WEN1int;
     IG1sys_reg_CK1 = IG1int;
     INITNsys_reg_CK1 = INITNint;
     SLEEPsys_reg_CK1 = SLEEPint;
     STDBY1sys_reg_CK1 = STDBY1int;
     ATPsys_reg_CK1 = ATPint;
     SEsys_reg_CK1_pre  = SEsys_reg_CK1;
     SEsys_reg_CK1 = SEint;
     TBISTsys_reg_CK1 = TBISTint;
     TBYPASSsys_reg_CK1 = TBYPASSint;
     A1sys_reg_CK1 = A1int;
     M1sys_reg_CK1 = M1int;
     D1sys_reg_CK1 = D1int;
     LSsys_reg_CK1 = LSint;     
     HSsys_reg_CK1 = HSint;   
     RRAEsys_reg_CK1 = RRAEint;	 
     red_en1sys_regCK1 = red_en1;  
  end        
end  
end


//Latching signals for Timing Model

always @(posedge CK2sys)
begin
if(supply_ok === 1) begin
  if (initn_pulse_done === 0) begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
  end
  else begin
     MEMEN_2_CK2_reg_pre = MEMEN_2_CK2_reg;
     MEMEN_2_CK2_reg = MEMEN_2;
     MEMEN_DFT_CK2_reg_pre = MEMEN_DFT_CK2_reg;
     MEMEN_DFT_CK2_reg = MEMEN_DFT2;
     CSN2sys_reg_CK2_pre = CSN2sys_reg_CK2;     
     CSN2sys_reg_CK2 = CSN2int;
     WEN2sys_reg_CK2 = WEN2int;
     IG2sys_reg_CK2 = IG2int;
     INITNsys_reg_CK2 = INITNint;
     SLEEPsys_reg_CK2 = SLEEPint;
     STDBY2sys_reg_CK2 = STDBY2int;
     ATPsys_reg_CK2 = ATPint;
     SEsys_reg_CK2_pre  = SEsys_reg_CK2;
     SEsys_reg_CK2 = SEint;
     TBISTsys_reg_CK2 = TBISTint;
     TBYPASSsys_reg_CK2 = TBYPASSint;
     A2sys_reg_CK2 = A2int;
     M2sys_reg_CK2 = M2int;
     D2sys_reg_CK2 = D2int;
     LSsys_reg_CK2 = LSint;     
     HSsys_reg_CK2 = HSint;   
     RRAEsys_reg_CK2 = RRAEint;
     red_en2sys_regCK2 = red_en2;  
  end        
end  
end




always @(MEMEN_1) 
begin
if(supply_ok === 1) begin 
 if (initn_pulse_done === 0) begin
  if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
 end
 else if (MEMEN_1 !== 0 && CK1int === 1'bX && (ATPint !== 1 || TBISTint !== 1'b1)) begin
   MEMEN_1_rise_time = $realtime;
   Mem_port1_FSM_Corrupt;
 end
 else if (MEMEN_1 !== 0 && MTCKint === 1'bx && ATPint !== 0 && TBISTint !== 1'b0) begin
   Mem_port1_FSM_Corrupt;
 end   
 
end
end



always @(MEMEN_2) 
begin
if(supply_ok === 1) begin 
 if (initn_pulse_done === 0) begin
  if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
 end
 else if (MEMEN_2 !== 0 && CK2int === 1'bX && (ATPint !== 1 || TBISTint !== 1'b1)) begin
   MEMEN_2_rise_time = $realtime;
   Mem_port2_FSM_Corrupt;
 end
 else if (MEMEN_2 !== 0 && MTCKint === 1'bx && ATPint !== 0 && TBISTint !== 1'b0) begin
   Mem_port2_FSM_Corrupt;
 end   
 
end
end


//DFT Operation

always @(MEMEN_DFT1)
begin
 if(supply_ok === 1) begin
 
   if (initn_pulse_done === 0) begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
   end
   else begin
       if(MEMEN_DFT1 !== 0 && CK1int_dft === 1'bx) begin
        if (!(TBYPASSint === 1'b1 && LP_CK_gate1 === 1'b1 && SEint === 1'b0)) begin
          DFT_port1_FSM_Corrupt;
        end
       end

      
       if(MEMEN_DFT1 !== 0 && TBYPASSint !== 0 && SEint !== 1) begin
        WriteOut1X;
       end        
   end
 
 end  
end


always @(MEMEN_DFT2)
begin
 if(supply_ok === 1) begin
 
   if (initn_pulse_done === 0) begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
   end
   else begin
      
       if(MEMEN_DFT2 !== 0 && CK2int_dft === 1'bx) begin
        if (!(TBYPASSint === 1'b1 && LP_CK_gate2 === 1'b1 && SEint === 1'b0)) begin
         DFT_port2_FSM_Corrupt;
        end 
       end 

       if(MEMEN_DFT2 !== 0 && TBYPASSint !== 0 && SEint !== 1) begin
        WriteOut2X;
       end        
   end
 
 end  
end


always @(MTCKint)
begin 
if(supply_ok === 1) begin
          
  if (initn_pulse_done === 0) begin
   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
  end
 else begin
    
  /*****************************************port1*************************************************/  
    if(MTCKint === 1'b1 && lastMTCK === 1'b0 && ATPint === 1'b1 && TBISTint === 1'b1) begin
//contn between CK1 and CK2 is checked.
      CK1_rise_time = $realtime; 
      CK2_rise_time = $realtime; 
 

 //#write2 : resolving race
       if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY2int === 1'b0 && IG2int === 1'b0 && CSN2int === 1'b0 && WEN2int === 1'b0 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&   flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en2 === 1'b0 || (red_en2 === 1'b1 && ^repair_add !== 1'bx))  && TP_buf !== 1'bx) begin 
       // A = X condition and contention condition
         main_write_port2;
       end       

   
//#write1
       if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY1int === 1'b0 && IG1int === 1'b0 && CSN1int === 1'b0 && WEN1int === 1'b0 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&   flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en1 === 1'b0 || (red_en1 === 1'b1 && ^repair_add !== 1'bx))  && TP_buf !== 1'bx) begin 
       // A = X condition and contention condition. If A=x, it should cause next cycle to corrupt even if you are already in a corrupt cycle. So checking of present_cycle flag should be after chking A and then setting things accordingly
         main_write_port1;
       end  


//#read2
  if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY2int === 1'b0 && IG2int === 1'b0 && CSN2int === 1'b0 && WEN2int === 1'b1 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&   flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en2 === 1'b0 || (red_en2 === 1'b1 && ^repair_add !== 1'bx)) && TP_buf !== 1'bx) begin
         main_read_port2;

  end  
 
//#read
if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY1int === 1'b0 && IG1int === 1'b0 && CSN1int === 1'b0 && WEN1int === 1'b1 && (LSint === 1'b1 || (LSint === 1'b0 && HSint !== 1'bX)) && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0 )) && (WMint === {write_margin_size{1'b0}} && RMint === {read_margin_size{1'b0}}) &&   flag_invalid_next_port1_cycle === 0 && flag_invalid_next_port2_cycle === 0 && mem_blocked === 1'b0 && (red_en1 === 1'b0 || (red_en1 === 1'b1 && ^repair_add !== 1'bx))  && TP_buf !== 1'bx) begin
         main_read_port1;
       end   

     
       else if (INITNint === 1'bX && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end        
       else if (INITNint !== 1'b0 && SLEEPint === 1'bX && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int === 1'bX  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end  

       else if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY1int === 1'b0 && IG1int === 0 && CSN1int === 1'b0 && WEN1int === 1'bX && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0) ) ) begin
         Mem_port1_CCL;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int === 1'bX && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1  && (ATPint === 1'bX && (SEint !== 0 || TBYPASSint !== 0)) ) begin
         Mem_port1_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && LSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && LSint !== 1'bX && HSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port1_FSM_Corrupt;
       end       

	else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1  && CSN1int !== 1'b1 && WEN1int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (RMint !== {read_margin_size{1'b0}} || WMint !== {write_margin_size{1'b0}})  ) begin
         Mem_port1_FSM_Corrupt;  
       end
       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && WEN1int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && TP_buf === 1'bX  ) begin
         Mem_port1_FSM_Corrupt;
       end
       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int === 1'bx && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) )) begin
         Mem_port1_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && red_en1 === 1'bx) begin
         Mem_port1_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (red_en1 === 1'b1 && ^repair_add === 1'bx) ) begin
         Mem_port1_FSM_Corrupt;
       end
//bypass->x with respect to MTCK can cause rw to get affected.
    else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==0 ) begin
    Mem_port1_FSM_Corrupt;
    end
    
end       
    else if (MTCKint === 1'b1 && lastMTCK === 1'b0 && !(ATPint === 1'b0 || TBISTint === 1'b0)) begin
      CK1_rise_time = $realtime; 
     CK2_rise_time = $realtime; 

        if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
        Mem_port1_FSM_Corrupt;      
      end 
       //bypass->x with respect to MTCK can cause rw to get affected.
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==0 ) begin
    Mem_port1_FSM_Corrupt;
       end

 
    end   
//Tbypass=1 added here.

    if(MTCKint === 1'bX && ATPint !== 0 && TBISTint !== 1'b0) begin
      CK1_rise_time = $realtime;
     CK2_rise_time = $realtime; 
 
       if ((INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && IG1int !== 1 && CSN1int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1))) || (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY1int !== 1'b1 && ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint !== 1'b0))  begin
        Mem_port1_FSM_Corrupt;      
     
      end        
    end    
    
    
/***************************Port2*************************************************/    
    
    if(MTCKint === 1'b1 && lastMTCK === 1'b0 && ((ATPint === 1'b1) && (TBISTint === 1'b1))) begin
      CK2_rise_time = $realtime; 
      CK1_rise_time = $realtime; 

//#write
  
//#read

     
        if (INITNint === 1'bX && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end        
       else if (INITNint !== 1'b0 && SLEEPint === 1'bX && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int === 1'bX  && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end  

       else if (INITNint === 1'b1 && SLEEPint === 1'b0 && STDBY2int === 1'b0 && IG2int === 0 && CSN2int === 1'b0 && WEN2int === 1'bX && (ATPint === 1'b0 || (ATPint === 1'b1 && SEint === 1'b0 && TBYPASSint === 1'b0) ) ) begin
         Mem_port2_CCL;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int === 1'bX && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end 

       else if (INITNint !== 1'b0 && SLEEPint !== 1'b1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1  && (ATPint === 1'bX && (SEint !== 0 || TBYPASSint !== 0)) ) begin
         Mem_port2_FSM_Corrupt;
       end  
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && LSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && LSint !== 1'bX && HSint === 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
         Mem_port2_FSM_Corrupt;
       end       
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && WEN2int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (WMint !== {write_margin_size{1'b0}} || RMint !== {read_margin_size{1'b0}})  ) begin
         Mem_port2_FSM_Corrupt;
       end

       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && WEN2int !== 1'bX && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && TP_buf === 1'bX  ) begin
         Mem_port2_FSM_Corrupt;
       end

       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int === 1'bx && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) )) begin
         Mem_port2_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && red_en2 === 1'bx) begin
         Mem_port2_FSM_Corrupt;
       end
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 &&  (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) && (red_en2 === 1'b1 && ^repair_add === 1'bx) ) begin
         Mem_port2_FSM_Corrupt;
       end
       //bypass->x with respect to MTCK can cause rw to get affected.
       else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==0 ) begin
        Mem_port2_FSM_Corrupt;
        end


 
    end      // if(MTCK end)


    else if (MTCKint === 1'b1 && lastMTCK === 1'b0 && !(ATPint === 1'b0 || TBISTint === 1'b0)) begin

      	  CK2_rise_time = $realtime; 
	  CK1_rise_time = $realtime; 

         if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1) ) ) begin
          Mem_port2_FSM_Corrupt;    
          end   
          //bypass->x with respect to MTCK can cause rw to get affected.
          else if (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint === 1'bx && TBISTint !==0 ) begin
          Mem_port2_FSM_Corrupt;
          end

    end   
//Tbypass=1 added here.

    if(MTCKint === 1'bX && ATPint !== 0 && TBISTint !== 1'b0) begin
        CK1_rise_time = $realtime; 
	CK2_rise_time = $realtime;
       if ((INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && IG2int !== 1 && CSN2int !== 1'b1 && (ATPint !== 1'b1 || (ATPint === 1'b1 && SEint !== 1'b1 && TBYPASSint !== 1'b1))) || (INITNint !== 1'b0 && SLEEPint !== 1 && STDBY2int !== 1'b1 && ATPint !== 1'b0 && SEint !== 1'b1 && TBYPASSint !== 1'b0))  begin
        Mem_port2_FSM_Corrupt; 
      end        
    end        
  
 end
end  //if supply_ok
lastMTCK = MTCKint;
end //end of always MTCKint

//Latching signals for Timing Model

always @(posedge MTCKsys)
begin
if(supply_ok === 1) begin
  if (initn_pulse_done === 0) begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
  end
  else begin
     MEMEN_1_MTCK_reg_pre = MEMEN_1_MTCK_reg;
     MEMEN_1_MTCK_reg = MEMEN_1;
     MEMEN_2_MTCK_reg_pre = MEMEN_2_MTCK_reg;
     MEMEN_2_MTCK_reg = MEMEN_2;
     
     TCSN1sys_reg_MTCK_pre = TCSN1sys_reg_MTCK;     
     TCSN1sys_reg_MTCK = CSN1int;
     IG1sys_reg_MTCK = IG1int;
     TCSN2sys_reg_MTCK_pre = TCSN2sys_reg_MTCK;
     TCSN2sys_reg_MTCK = CSN2int;
     TWEN2sys_reg_MTCK = WEN2int;
     TWEN1sys_reg_MTCK = WEN1int;
     IG2sys_reg_MTCK = IG2int;
     INITNsys_reg_MTCK = INITNint;
     SLEEPsys_reg_MTCK = SLEEPint;
     STDBY1sys_reg_MTCK = STDBY1int;
     STDBY2sys_reg_MTCK = STDBY2int;
     ATPsys_reg_MTCK = ATPint;
     SEsys_reg_MTCK = SEint;
     TBISTsys_reg_MTCK = TBISTint;
     TBYPASSsys_reg_MTCK = TBYPASSint;
     TA1sys_reg_MTCK = A1int;
     TA2sys_reg_MTCK = A2int;
     M1sys_reg_MTCK = M1int;
     D1sys_reg_MTCK = D1int;
     M2sys_reg_MTCK = M2int;
     D2sys_reg_MTCK = D2int;
     LSsys_reg_MTCK = LSint;     
     HSsys_reg_MTCK = HSint;  
     RRAEsys_reg_MTCK = RRAEint;   
  end        
end  
end
always @(INITNint or posedge supply_ok )  //INITN block starts
begin

if (CK1int_dft === 1'b1 &&  SEreg_CK1 !== 0 &&  ATPreg_CK1 !== 0 && INITNreg_CK1 === 1'b1 &&  STDBY1reg_CK1 === 1'b0  && INITNint !== 1)
   begin
    DFT_port1_ScanChainX;
    DFT_port1_ScanOutX;

   end
if (CK2int_dft === 1'b1 &&  SEreg_CK2 !== 0 &&  ATPreg_CK2 !== 0 && INITNreg_CK2 === 1'b1 &&  STDBY2reg_CK2 === 1'b0 && INITNint !== 1)
   begin
 DFT_port2_ScanChainX;
 DFT_port2_ScanOutX;
   end   

// during tbypass mode if INITN goes 0/X, FSM corruption will happen as the clk is internally mixed with INITN.

if (ATPreg_CK1 !== 1'b0 && SEreg_CK1 !== 1'b1 && TBYPASSreg_CK1 !== 1'b0 && STDBY1reg_CK1 !== 1'b1 && INITNreg_CK1 !== 0  && INITNint !== 1 ) begin
 Mem_port1_FSM_Corrupt;   
end

if (ATPreg_CK2 !== 1'b0 && SEreg_CK2 !== 1'b1 && TBYPASSreg_CK2 !== 1'b0 && STDBY2reg_CK2 !== 1'b1 &&  INITNreg_CK2 !== 0 && INITNint !== 1 ) begin
 Mem_port2_FSM_Corrupt;   
end



if (INITNint === 1'b0) begin
   if(supply_ok) begin
     flag_invalid_next_port1_cycle = 0;
     flag_invalid_present_port1_cycle = 0;
     flag_invalid_next_port2_cycle = 0;
     flag_invalid_present_port2_cycle = 0;
     flag_invalid_next_port1_dft_cycle = 1'b0;
     flag_invalid_present_port1_dft_cycle = 1'b0;
     flag_invalid_next_port2_dft_cycle = 1'b0;
     flag_invalid_present_port2_dft_cycle = 1'b0;

     initn_pulse_done = 1;
     power_up_done = 1;     
     lastCK1 = CK1int;
     lastCK2 = CK2int;
     lastCK1_dft = CK1int_dft;
     lastCK2_dft = CK2int_dft;
     lastMTCK = MTCKint;

     `ifdef ST_MEM_INITN_OUTPUT_RESET
       OutReg1_data = reg_Initn_reset_value;
       OutReg2_data = reg_Initn_reset_value;
     `endif
     // Reset memory contents     
     `ifdef ST_MEM_INITN_MEM_RESET
      WriteMem0;
     `endif
      
  end 
  else begin
    if (SLEEPint !== 1) begin
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Illegal Value on power pin(s). Memory Initialization corrupted.No initialization would happen when supplies are down in normal functional mode ",$realtime); 
     
    end        
  end        
 end
 
if (initn_pulse_done === 0 && INITNint === 1) begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
 end
 else if(initn_pulse_done === 1 && INITNint === 1) begin
         if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Initialization Action has been taken at init pin negedge. ",$realtime);
 end
 
end//always @(INITNint)


                

//assign output data
always @(OutReg1_data)
   #`access_time delOutReg1_data = OutReg1_data;

always @(OutReg2_data)
   #`access_time delOutReg2_data = OutReg2_data;


always @(delOutReg1_data )
begin
    Q1int <= delOutReg1_data;
end

always @(delOutReg2_data )
begin
    Q2int <= delOutReg2_data;
end


always @(SCTRLO1_data)
begin
  #`access_time delSCTRLO1_data = SCTRLO1_data;
end

always @(SCTRLO2_data)
begin
  #`access_time delSCTRLO2_data = SCTRLO2_data;
end

always @(SDLO1_data)
begin
  #`access_time delSDLO1_data = SDLO1_data;
end

always @(SDLO2_data)
begin
  #`access_time delSDLO2_data = SDLO2_data;
end

always @(SDRO1_data)
begin
  #`access_time delSDRO1_data = SDRO1_data;
end

always @(SDRO2_data)
begin
  #`access_time delSDRO2_data = SDRO2_data;
end



  

`ifdef functional
buf bufq1 [Bits -1 : 0] (Q1,delOutReg1_data);
buf bufq2 [Bits -1 : 0] (Q2,delOutReg2_data);

buf (SCTRLO1,delSCTRLO1_data);
buf (SCTRLO2,delSCTRLO2_data);
buf (SDLO1,delSDLO1_data);
buf (SDRO1,delSDRO1_data);

buf (SDLO2,delSDLO2_data);
buf (SDRO2,delSDRO2_data);

       

`else
buf bufq1 [Bits -1 : 0] (Q1,OutReg1_data_tim);
buf bufq2 [Bits -1 : 0] (Q2,OutReg2_data_tim);

buf (SCTRLO1,SCTRLO1_data_tim);
buf (SCTRLO2,SCTRLO2_data_tim);

buf (SDLO1,SDLO1_data_tim);
buf (SDRO1,SDRO1_data_tim);
buf (SDLO2,SDLO2_data_tim);
buf (SDRO2,SDRO2_data_tim);
       
       


`endif

assign RRMATCH1 = RRMATCH1reg;
assign RRMATCH2 = RRMATCH2reg;


always @(SLEEPint)
begin 
 
if (supply_ok === 1'b1) begin
   if (initn_pulse_done === 0)
     begin
       if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
     end
   else if (CK1int_dft === 1'b1 && SEreg_CK1 !== 0 && ATPreg_CK1 !== 0 && INITNreg_CK1 === 1'b1 && STDBY1reg_CK1 === 1'b0 && SLEEPreg_CK1 === 1'b0 && SLEEPint !== 0)
    begin
      DFT_port1_ScanOutX;
      DFT_port1_ScanChainX;
    end
  end
end 

always @(SLEEPint)
begin 
 
if (supply_ok === 1'b1) begin
   if (initn_pulse_done === 0)
     begin
       if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Init pulse not applied yet,No operation allowed before initialisation pulse ",$realtime);
     end
   else if (CK2int_dft === 1'b1 && SEreg_CK2 !== 0 && ATPreg_CK2 !== 0 && INITNreg_CK2 === 1'b1 && STDBY2reg_CK2 === 1'b0 && SLEEPreg_CK2 === 1'b0 && SLEEPint !== 0)
    begin
      DFT_port2_ScanOutX;
      DFT_port2_ScanChainX;
    end
  end
end

always @(STDBY2int)
begin

if (CK2int_dft === 1'b1 &&  SEreg_CK2 !== 0 &&  ATPreg_CK2 !== 0 && INITNreg_CK2 === 1'b1 &&  STDBY2reg_CK2 === 1'b0  && STDBY2int !== 0 && SLEEPint !== 1'b1)
   begin
    DFT_port2_ScanChainX;
    DFT_port2_ScanOutX;
   end
// during tbypass mode if STDBY goes 1/X, FSM corruption will happen.
if (ATPreg_CK2 !== 1'b0 && SEreg_CK2 !== 1'b1 && TBYPASSreg_CK2 !== 1'b0 && STDBY2reg_CK2 !== 1'b1 &&  INITNreg_CK2 !== 0 && STDBY2int !== 0  && SLEEPint !== 1'b1) begin
 Mem_port2_FSM_Corrupt;   
end
end  

always @(STDBY1int)
begin
if (CK1int_dft === 1'b1 &&  SEreg_CK1 !== 0 &&  ATPreg_CK1 !== 0 && INITNreg_CK1 === 1'b1 &&  STDBY1reg_CK1 === 1'b0  && STDBY1int !== 0 && SLEEPint !== 1'b1)
   begin
    DFT_port1_ScanChainX;
    DFT_port1_ScanOutX;
   end
if (ATPreg_CK1 !== 1'b0 && SEreg_CK1 !== 1'b1 && TBYPASSreg_CK1 !== 1'b0 && STDBY1reg_CK1 !== 1'b1 && INITNreg_CK1 !== 0  && STDBY1int !== 0 && SLEEPint !== 1'b1 ) begin
 Mem_port1_FSM_Corrupt;   
end
end  

/**********************************Parallel Loading ends*************************************************/
/*Timing model -assign sdf_cond -To be added in next REL*/
`ifdef functional
`else

//REG DECLARATIONS
reg TimingViol_A1;

/* CONDS */


assign Cond_gac1_mtck = ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK)!== 0) ? 1 : 0;
assign Cond_gac2_mtck = ((INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK)!== 0) ? 1 : 0;
////To change
assign Cond_func_rw1 = ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))!== 0) ? 1 : 0;
assign Cond_func_rw2 = ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))!== 0) ? 1 : 0;
assign Cond_func_cap = (((ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1))!== 0) ? 1 : 0;
assign Cond_gac1 = ((INITNsys_reg_CK1 & !STDBY1sys_reg_CK1)!== 0) ? 1 : 0;
assign Cond_gac2 = ((INITNsys_reg_CK2 & !STDBY2sys_reg_CK2)!== 0) ? 1 : 0;
assign Cond_csn_func_rw1 = ((!IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))!== 0) ? 1 : 0;
assign Cond_csn_func_rw2 = ((!IG1 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))!== 0) ? 1 : 0;

assign Cond_ig_func_rw1  = ((!CSN1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))!== 0) ? 1 : 0;
assign Cond_ig_func_rw2  = ((!CSN2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))!== 0) ? 1 : 0;
assign Cond_cap1  = ((ATPsys_reg_CK1 & !SEsys_reg_CK1)!== 0) ? 1 : 0;
assign Cond_cap2  = ((ATPsys_reg_CK2 & !SEsys_reg_CK2)!== 0) ? 1 : 0;
assign Cond_bist_rw1  = ((!TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK)!== 0) ? 1 : 0;
assign Cond_bist_rw2  = ((!TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK)!== 0) ? 1 : 0;
assign Cond_stdby_gac1  = ((INITNsys_reg_CK1)!== 0) ? 1 : 0;
assign Cond_stdby_gac2  = ((INITNsys_reg_CK2)!== 0) ? 1 : 0;





assign Cond_gac1_m  = ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK)!== 0) ? 1 : 0;
assign Cond_gac2_m  = ((INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK)!== 0) ? 1 : 0;
assign Cond_tbist_rw_en1   = ((ATPsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK & !IG1sys_reg_MTCK)!== 0) ? 1 : 0;
assign Cond_tbist_rw_en2   = ((ATPsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK & !IG2sys_reg_MTCK)!== 0) ? 1 : 0;

assign Cond_tbypass1  = ((ATPsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1)!== 0) ? 1 : 0;
assign Cond_tbypass2  = ((ATPsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2)!== 0) ? 1 : 0;
assign Cond_tbypass_m  = ((ATPsys_reg_MTCK & !SEsys_reg_MTCK & TBYPASSsys_reg_MTCK)!== 0) ? 1 : 0;


//direct assigns

assign Cond_sdf_ta_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|((ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1)))) !== 0) ? 1 : 0;
assign Cond_sdf_ta_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|((ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2)))) !== 0) ? 1 : 0;
assign Cond_sdf_taa_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && !CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)) && !TP) !== 0) ? 1 : 0;
assign Cond_sdf_taa_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && !CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)) && !TP) !== 0) ? 1 : 0;

assign Cond_sdf_taa_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && !TP) !== 0) ? 1 : 0;
assign Cond_sdf_taa_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && !TP) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sctrlo_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sctrlo_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sctrlo_se_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sctrlo_se_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdlo_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdlo_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdlo_se_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdlo_se_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdro_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdro_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdro_se_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_sdro_se_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smlo_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smlo_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smlo_se_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smlo_se_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smro_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smro_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smro_se_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_smro_se_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;

assign Cond_tst_sys_rw1  = (( !CSN1 & !IG1 & ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_tst_sys_rw2  = (( !CSN2 & !IG2 & ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2) !== 0) ? 1 : 0;

assign Cond_sys_rw1  = (( !CSN1 & !IG1 & ATPsys_reg_CK1 & !SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sys_rw2  = (( !CSN2 & !IG2 & ATPsys_reg_CK2 & !SEsys_reg_CK2) !== 0) ? 1 : 0;





assign Cond_sdf_taa_tckq_tm_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_taa_tckq_tm_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_taa_tm_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1 && !TP) !== 0) ? 1 : 0;
assign Cond_sdf_taa_tm_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2 && !TP) !== 0) ? 1 : 0;

assign Cond_sdf_taa_tm_tp_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1 && TP) !== 0) ? 1 : 0;


assign Cond_sdf_taa_tm_tp_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2 && TP) !== 0) ? 1 : 0;


assign Cond_sdf_taa_tp_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && !CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)) && TP) !== 0) ? 1 : 0;


assign Cond_sdf_taa_tp_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && !CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)) && TP) !== 0) ? 1 : 0;


assign Cond_sdf_taa_tp_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && TP) !== 0) ? 1 : 0;


assign Cond_sdf_taa_tp_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && TP) !== 0) ? 1 : 0;



assign Cond_sdf_taa_tseq_tm_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBYPASSint) !== 0) ? 1 : 0;
assign Cond_sdf_taa_tseq_tm_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBYPASSint) !== 0) ? 1 : 0;
assign Cond_sdf_tatp_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tatp_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tatp_m	 = (( (INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK|INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK )) !== 0) ? 1 : 0;
assign Cond_sdf_tba_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBISTsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tba_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBISTsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tba_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tba_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tck_m	 = (( ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK)|(INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK)) && ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tbde_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBISTsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tbde_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBISTsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tbdo_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBISTsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tbdo_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBISTsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tbist_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & !SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tbist_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & !SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tbme_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBISTsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tbme_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBISTsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tbmo_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBISTsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tbmo_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBISTsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBISTsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBISTsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;

//---instant values only

assign Cond_sdf_tbp_atp_1	 = (((CK1|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_atp_2	 = (((CK2|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_tbist_1	 = (((CK1|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_tbist_2	 = (((CK2|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_tbypas_1	 = (((CK1|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_tbypas_2	 = (((CK2|MTCK)) !== 0) ? 1 : 0;



assign Cond_sdf_tbw_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & TBISTsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tbw_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & TBISTsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tck_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ( (ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1)|!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1))|ATPsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1 )) !== 0) ? 1 : 0;
assign Cond_sdf_tck_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2)|!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2))|ATPsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2)) !== 0) ? 1 : 0;
assign Cond_sdf_tck_se_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tck_se_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tcycle_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1)|!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1))|ATPsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1) && !TP) !== 0) ? 1 : 0;


assign Cond_sdf_tcycle_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2)|!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2))|ATPsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) && !TP) !== 0) ? 1 : 0;


assign Cond_sdf_tcycle_se_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tcycle_se_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tcycle_tp_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1)|!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1))|ATPsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1)  && TP) !== 0) ? 1 : 0;


assign Cond_sdf_tcycle_tp_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2)|!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2))|ATPsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2) && TP) !== 0) ? 1 : 0;


assign Cond_sdf_td_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|((ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1)))) !== 0) ? 1 : 0;
assign Cond_sdf_td_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|((ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2)))) !== 0) ? 1 : 0;
assign Cond_sdf_tig_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((!CSN1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|(ATPsys_reg_CK1 & !SEsys_reg_CK1))) !== 0) ? 1 : 0;
assign Cond_sdf_tig_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((!CSN2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|(ATPsys_reg_CK2 & !SEsys_reg_CK2))) !== 0) ? 1 : 0;
assign Cond_sdf_tinitn_1	 = (( !STDBY1sys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|ATPsys_reg_CK1)) !== 0) ? 1 : 0;
assign Cond_sdf_tinitn_2	 = (( !STDBY2sys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|ATPsys_reg_CK2)) !== 0) ? 1 : 0;
assign Cond_sdf_tm_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|((ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1)))) !== 0) ? 1 : 0;
assign Cond_sdf_tm_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|((ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2)))) !== 0) ? 1 : 0;
assign Cond_sdf_tp_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && (!IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)) | (ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1))) !== 0) ? 1 : 0;
assign Cond_sdf_tp_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && (!IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2))|(ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2))) !== 0) ? 1 : 0;

//--instant values only

assign Cond_sdf_tp_atp_1	 = (((CK1|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tp_atp_2	 = (((CK2|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tp_tbist_1	 = (((CK1|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tp_tbist_2	 = (((CK2|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tp_tbypas_1	 = (((CK1|MTCK)) !== 0) ? 1 : 0;
assign Cond_sdf_tp_tbypas_2	 = (((CK2|MTCK)) !== 0) ? 1 : 0;



assign Cond_sdf_trec_ck1_ck2	 = ( ((INITNsys_reg_CK1 & !STDBY1sys_reg_CK1&!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))&(INITNsys_reg_CK2 & !STDBY2sys_reg_CK2&!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))&((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)) & !WEN1sys_reg_CK1)|(!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)) & !WEN2sys_reg_CK2)) & (A1sys_reg_CK1 === A2sys_reg_CK2 & red_en1sys_regCK1 == red_en2sys_regCK2) ) !== 0) ? 1 : 0;

assign Cond_sdf_trec_ck2_ck1	 = ( ((INITNsys_reg_CK1 & !STDBY1sys_reg_CK1&!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))&(INITNsys_reg_CK2 & !STDBY2sys_reg_CK2&!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))&((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)) & !WEN1sys_reg_CK1)|(!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)) & !WEN2sys_reg_CK2)) & (A1sys_reg_CK1 === A2sys_reg_CK2 & red_en1sys_regCK1 == red_en2sys_regCK2)) !== 0) ? 1 : 0;



assign Cond_sdf_trm_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|(ATPsys_reg_CK1))) !== 0) ? 1 : 0;
assign Cond_sdf_trm_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|(ATPsys_reg_CK2))) !== 0) ? 1 : 0;

assign Cond_sdf_tsctrli_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tsctrli_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tsdli_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tsdli_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tsdri_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tsdri_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tse_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tse_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tsmli_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tsmli_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tsmri_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ATPsys_reg_CK1 & SEsys_reg_CK1) !== 0) ? 1 : 0;
assign Cond_sdf_tsmri_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ATPsys_reg_CK2 & SEsys_reg_CK2) !== 0) ? 1 : 0;
assign Cond_sdf_tstdby_1	 = (( INITNsys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|ATPsys_reg_CK1)) !== 0) ? 1 : 0;
assign Cond_sdf_tstdby_2	 = (( INITNsys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|ATPsys_reg_CK2)) !== 0) ? 1 : 0;





assign Cond_sdf_ttm_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && (!CSN1 & !IG1 & ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1|ATPsys_reg_CK1 & !SEsys_reg_CK1)) !== 0) ? 1 : 0;
assign Cond_sdf_ttm_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && (!CSN2 & !IG2 & ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2|ATPsys_reg_CK2 & !SEsys_reg_CK2)) !== 0) ? 1 : 0;
assign Cond_sdf_ttp_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && (!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1))|ATPsys_reg_CK1 & !SEsys_reg_CK1 & TBYPASSsys_reg_CK1)) !== 0) ? 1 : 0;
assign Cond_sdf_ttp_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && (!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2))|ATPsys_reg_CK2 & !SEsys_reg_CK2 & TBYPASSsys_reg_CK2)) !== 0) ? 1 : 0;

assign Cond_sdf_tw_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|((ATPsys_reg_CK1 & !SEsys_reg_CK1 & !TBISTsys_reg_CK1)))) !== 0) ? 1 : 0;
assign Cond_sdf_tw_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|((ATPsys_reg_CK2 & !SEsys_reg_CK2 & !TBISTsys_reg_CK2)))) !== 0) ? 1 : 0;
assign Cond_sdf_twm_1	 = (( INITNsys_reg_CK1 & !STDBY1sys_reg_CK1 && ((!CSN1 & !IG1 & (!ATPsys_reg_CK1|(!SEsys_reg_CK1 & !TBISTsys_reg_CK1 & !TBYPASSsys_reg_CK1)))|(ATPsys_reg_CK1))) !== 0) ? 1 : 0;
assign Cond_sdf_twm_2	 = (( INITNsys_reg_CK2 & !STDBY2sys_reg_CK2 && ((!CSN2 & !IG2 & (!ATPsys_reg_CK2|(!SEsys_reg_CK2 & !TBISTsys_reg_CK2 & !TBYPASSsys_reg_CK2)))|(ATPsys_reg_CK2))) !== 0) ? 1 : 0;

//2



//MTCK

assign Cond_sdf_tbde_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tbde_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;

assign Cond_sdf_tbist_m	 = (( ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && ATPsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK & !IG1sys_reg_MTCK) |(INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && ATPsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK & !IG2sys_reg_MTCK))) !== 0) ? 1 : 0;

assign Cond_sdf_tbdo_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tbdo_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;


assign Cond_sdf_tbme_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tbme_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;

assign Cond_sdf_tbmo_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tbmo_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;


assign Cond_sdf_tbp_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tbp_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;


assign Cond_sdf_tbw_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tbw_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;

assign Cond_sdf_tcycle_m	 = (( ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK)|(INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK)) && ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && !TP) !== 0) ? 1 : 0;






assign Cond_sdf_twm_m	 = (( ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK)|(INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK))) !== 0) ? 1 : 0;
assign Cond_sdf_ttp_m	 = (( ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && (!TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK))|(INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && (!TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK)))) !== 0) ? 1 : 0;
assign Cond_sdf_ttm_m	 = (( ((!TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK)|(!TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK))) !== 0) ? 1 : 0;
assign Cond_sdf_tstdby_m_1	 = (( INITNsys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tstdby_m_2	 = (( INITNsys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tse_m	 = (( (INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK|INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK) && ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_trm_m	 = (( ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK)|(INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK))) !== 0) ? 1 : 0;
assign Cond_sdf_tinitn_m	 = (( (!STDBY1sys_reg_MTCK && !TCSN1 & !IG1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK)|(!STDBY2sys_reg_MTCK && !TCSN2 & !IG2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK)) !== 0) ? 1 : 0;

assign Cond_sdf_tig_m_1	 = (( INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK && !TCSN1 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tig_m_2	 = (( INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK && !TCSN2 & ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK) !== 0) ? 1 : 0;
assign Cond_sdf_tcycle_tp_m	 = (( ((INITNsys_reg_MTCK & !STDBY1sys_reg_MTCK)|(INITNsys_reg_MTCK & !STDBY2sys_reg_MTCK)) && ATPsys_reg_MTCK & TBISTsys_reg_MTCK & !SEsys_reg_MTCK & !TBYPASSsys_reg_MTCK && TP) !== 0) ? 1 : 0;





/* CONDS */

specify
    specparam


   PATHPULSE$CK1$Q1 = 0,
   PATHPULSE$CK2$Q2 = 0,
   PATHPULSE$MTCK$Q1 = 0,
   PATHPULSE$MTCK$Q2 = 0,

   PATHPULSE$CK1$SCTRLO1 = 0,
   PATHPULSE$CK2$SCTRLO2 = 0,
   PATHPULSE$CK1$SDLO1 = 0,
   PATHPULSE$CK1$SDRO1 = 0,
   PATHPULSE$CK2$SDLO2 = 0,
   PATHPULSE$CK2$SDRO2 = 0,
   
   
   
   PATHPULSE$SE$Q1 = 0,
   PATHPULSE$SE$Q2 = 0,

//timing labels {---

tas_1 = `setup_time,
tah_1 = `hold_time,
tas_2 = `setup_time,
tah_2 = `hold_time,
tatps_1 = `setup_time,
tatph_1 = `hold_time,
tatps_2 = `setup_time,
tatph_2 = `hold_time,
tatps_m = `setup_time,
tatph_m = `hold_time,
trec_ck1_ck2 = `rec_rem_time,
trec_ck2_ck1 = `rec_rem_time,
trem_ck2_ck1 = `rec_rem_time,
trem_ck1_ck2 = `rec_rem_time,
tps_1 = `setup_time,
tph_1 = `hold_time,
tps_tbist_r_1 = `setup_time,
tph_tbist_r_1 = `hold_time,
tps_tbist_f_1 = `setup_time,
tph_tbist_f_1 = `hold_time,
tps_atp_r_1 = `setup_time,
tph_atp_r_1 = `hold_time,
tps_tbypas_r_1 = `setup_time,
tph_tbypas_r_1 = `hold_time,
tps_atp_f_1 = `setup_time,
tph_atp_f_1 = `hold_time,
tps_tbypas_f_1 = `setup_time,
tph_tbypas_f_1 = `hold_time,
tps_2 = `setup_time,
tph_2 = `hold_time,
tps_tbist_r_2 = `setup_time,
tph_tbist_r_2 = `hold_time,
tps_tbist_f_2 = `setup_time,
tph_tbist_f_2 = `hold_time,
tps_atp_r_2 = `setup_time,
tph_atp_r_2 = `hold_time,
tps_tbypas_r_2 = `setup_time,
tph_tbypas_r_2 = `hold_time,
tps_atp_f_2 = `setup_time,
tph_atp_f_2 = `hold_time,
tps_tbypas_f_2 = `setup_time,
tph_tbypas_f_2 = `hold_time,
tds_1 = `setup_time,
tdh_1 = `hold_time,
tds_2 = `setup_time,
tdh_2 = `hold_time,
tigs_1 = `setup_time,
tigh_1 = `hold_time,
tigs_m_1 = `setup_time,
tigh_m_1 = `hold_time,
tigs_2 = `setup_time,
tigh_2 = `hold_time,
tigs_m_2 = `setup_time,
tigh_m_2 = `hold_time,
tinitnrs_1 = `setup_time,
tinitnrh_1 = `hold_time,
tinitnrs_2 = `setup_time,
tinitnrh_2 = `hold_time,
tinitnfs_1 = `setup_time,
tinitnfh_1 = `hold_time,
tinitnfs_2 = `setup_time,
tinitnfh_2 = `hold_time,
tinitnrs_m = `setup_time,
tinitnrh_m = `hold_time,
tinitnfs_m = `setup_time,
tinitnfh_m = `hold_time,
tlss_1 = `setup_time,
tlsh_1 = `hold_time,
tlss_2 = `setup_time,
tlsh_2 = `hold_time,
tlss_m = `setup_time,
tlsh_m = `hold_time,
thss_1 = `setup_time,
thsh_1 = `hold_time,
thss_2 = `setup_time,
thsh_2 = `hold_time,
thss_m = `setup_time,
thsh_m = `hold_time,
tblss = `setup_time,
tblsh = `hold_time,
tms_1 = `setup_time,
tmh_1 = `hold_time,
tms_2 = `setup_time,
tmh_2 = `hold_time,
trms_1 = `setup_time,
trmh_1 = `hold_time,
trms_2 = `setup_time,
trmh_2 = `hold_time,
trms_m = `setup_time,
trmh_m = `hold_time,
trras_1 = `setup_time,
trrah_1 = `hold_time,
trras_2 = `setup_time,
trrah_2 = `hold_time,
trras_m = `setup_time,
trrah_m = `hold_time,
trraes_1 = `setup_time,
trraeh_1 = `hold_time,
trraes_2 = `setup_time,
trraeh_2 = `hold_time,
trraes_m = `setup_time,
trraeh_m = `hold_time,
tsctrlis_1 = `setup_time,
tsctrlih_1 = `hold_time,
tsctrlis_2 = `setup_time,
tsctrlih_2 = `hold_time,
tsdlis_1 = `setup_time,
tsdlih_1 = `hold_time,
tsdlis_2 = `setup_time,
tsdlih_2 = `hold_time,
tsdris_1 = `setup_time,
tsdrih_1 = `hold_time,
tsdris_2 = `setup_time,
tsdrih_2 = `hold_time,
tses_1 = `setup_time,
tseh_1 = `hold_time,
tses_2 = `setup_time,
tseh_2 = `hold_time,
tses_m = `setup_time,
tseh_m = `hold_time,
tsmlis_1 = `setup_time,
tsmlih_1 = `hold_time,
tsmlis_2 = `setup_time,
tsmlih_2 = `hold_time,
tsmris_1 = `setup_time,
tsmrih_1 = `hold_time,
tsmris_2 = `setup_time,
tsmrih_2 = `hold_time,
tstdbys_1 = `setup_time,
tstdbyh_1 = `hold_time,
tstdbys_m_1 = `setup_time,
tstdbyh_m_1 = `hold_time,
tstdbys_2 = `setup_time,
tstdbyh_2 = `hold_time,
tstdbys_m_2 = `setup_time,
tstdbyh_m_2 = `hold_time,


tsls_1 = `setup_time,
tsls_2  = `hold_time,
tslh_1 = `setup_time,
tslh_2 = `hold_time,

tsls_m = `setup_time,
tslh_m = `hold_time,

tbas_1 = `setup_time,
tbah_1 = `hold_time,
tbas_m_1 = `setup_time,
tbah_m_1 = `hold_time,
tbas_2 = `setup_time,
tbah_2 = `hold_time,
tbas_m_2 = `setup_time,
tbah_m_2 = `hold_time,
tbists_1 = `setup_time,
tbisth_1 = `hold_time,
tbists_2 = `setup_time,
tbisth_2 = `hold_time,
tbists_m = `setup_time,
tbisth_m = `hold_time,
ttms_1 = `setup_time,
ttmh_1 = `hold_time,
ttms_2 = `setup_time,
ttmh_2 = `hold_time,
ttms_m = `setup_time,
ttmh_m = `hold_time,
tbps_1 = `setup_time,
tbph_1 = `hold_time,
tbps_m_1 = `setup_time,
tbph_m_1 = `hold_time,
tbps_tbist_r_1 = `setup_time,
tbph_tbist_r_1 = `hold_time,
tbps_tbist_f_1 = `setup_time,
tbph_tbist_f_1 = `hold_time,
tbps_atp_r_1 = `setup_time,
tbph_atp_r_1 = `hold_time,
tbps_atp_f_1 = `setup_time,
tbph_atp_f_1 = `hold_time,
tbps_tbypas_r_1 = `setup_time,
tbph_tbypas_r_1 = `hold_time,
tbps_tbypas_f_1 = `setup_time,
tbph_tbypas_f_1 = `hold_time,
tbps_2 = `setup_time,
tbph_2 = `hold_time,
tbps_m_2 = `setup_time,
tbph_m_2 = `hold_time,
tbps_tbist_r_2 = `setup_time,
tbph_tbist_r_2 = `hold_time,
tbps_tbist_f_2 = `setup_time,
tbph_tbist_f_2 = `hold_time,
tbps_atp_r_2 = `setup_time,
tbph_atp_r_2 = `hold_time,
tbps_atp_f_2 = `setup_time,
tbph_atp_f_2 = `hold_time,
tbps_tbypas_r_2 = `setup_time,
tbph_tbypas_r_2 = `hold_time,
tbps_tbypas_f_2 = `setup_time,
tbph_tbypas_f_2 = `hold_time,
tbdes_1 = `setup_time,
tbdeh_1 = `hold_time,
tbdes_m_1 = `setup_time,
tbdeh_m_1 = `hold_time,
tbdes_2 = `setup_time,
tbdeh_2 = `hold_time,
tbdes_m_2 = `setup_time,
tbdeh_m_2 = `hold_time,
tbmes_1 = `setup_time,
tbmeh_1 = `hold_time,
tbmes_m_1 = `setup_time,
tbmeh_m_1 = `hold_time,
tbmes_2 = `setup_time,
tbmeh_2 = `hold_time,
tbmes_m_2 = `setup_time,
tbmeh_m_2 = `hold_time,
tbdos_1 = `setup_time,
tbdoh_1 = `hold_time,
tbdos_m_1 = `setup_time,
tbdoh_m_1 = `hold_time,
tbdos_2 = `setup_time,
tbdoh_2 = `hold_time,
tbdos_m_2 = `setup_time,
tbdoh_m_2 = `hold_time,
tbmos_1 = `setup_time,
tbmoh_1 = `hold_time,
tbmos_m_1 = `setup_time,
tbmoh_m_1 = `hold_time,
tbmos_2 = `setup_time,
tbmoh_2 = `hold_time,
tbmos_m_2 = `setup_time,
tbmoh_m_2 = `hold_time,
ttps_1 = `setup_time,
ttph_1 = `hold_time,
ttps_2 = `setup_time,
ttph_2 = `hold_time,
ttps_m = `setup_time,
ttph_m = `hold_time,
ttrraes_m_1 = `setup_time,
ttrraeh_m_1 = `hold_time,
ttrraes_1 = `setup_time,
ttrraeh_1 = `hold_time,
ttrraes_m_2 = `setup_time,
ttrraeh_m_2 = `hold_time,
ttrraes_2 = `setup_time,
ttrraeh_2 = `hold_time,
tbws_1 = `setup_time,
tbwh_1 = `hold_time,
tbws_m_1 = `setup_time,
tbwh_m_1 = `hold_time,
tbws_2 = `setup_time,
tbwh_2 = `hold_time,
tbws_m_2 = `setup_time,
tbwh_m_2 = `hold_time,
tws_1 = `setup_time,
twh_1 = `hold_time,
tws_2 = `setup_time,
twh_2 = `hold_time,
twms_1 = `setup_time,
twmh_1 = `hold_time,
twms_2 = `setup_time,
twmh_2 = `hold_time,
twms_m = `setup_time,
twmh_m = `hold_time,
//---------
tcycle_m = `cycle_time,
tcycle_tp_m = `cycle_time,
tcycle_1 = `cycle_time,
tcycle_tp_1 = `cycle_time,
tcycle_tp_ls1_1 = `cycle_time,
tcycle_tp_hs1_1 = `cycle_time,
tcycle_se_1 = `cycle_time,
tcycle_2 = `cycle_time,
tcycle_tp_2 = `cycle_time,
tcycle_tp_ls1_2 = `cycle_time,
tcycle_tp_hs1_2 = `cycle_time,
tcycle_se_2 = `cycle_time,
tcycle_tp_ls1_m = `cycle_time,
tcycle_tp_hs1_m = `cycle_time,

tcycle_ls1_1 = `cycle_time,
tcycle_ls1_2 = `cycle_time,
tcycle_hs1_1 = `cycle_time,
tcycle_hs1_2 = `cycle_time,
tcycle_m_ls1 = `cycle_time,
tcycle_m_hs1 = `cycle_time,


tckh_1 = `pulse_width_time,
tckl_1 = `pulse_width_time,
tckh_se_1 = `pulse_width_time,
tckl_se_1 = `pulse_width_time,
tckh_m = `pulse_width_time,
tckl_m = `pulse_width_time,
tckh_2 = `pulse_width_time,
tckl_2 = `pulse_width_time,
tckh_se_2 = `pulse_width_time,
tckl_se_2 = `pulse_width_time,
//-------------------1.0, 0.9
taa_1 = `access_time,
taa_ls1_1 = `access_time,
taa_m_ls1_1 = `access_time,
taa_tm_ls1_1 = `access_time,
taa_ls1_2 = `access_time,
taa_m_ls1_2 = `access_time,
taa_tm_ls1_2 = `access_time,
taa_hs1_1 = `access_time,
taa_m_hs1_1 = `access_time,
taa_tm_hs1_1 = `access_time,
taa_hs1_2 = `access_time,
taa_m_hs1_2 = `access_time,
taa_tm_hs1_2 = `access_time,
taa_tp_1 = `access_time,
taa_tp_ls1_1 = `access_time,
taa_tp_hs1_1 = `access_time,
taa_tm_tp_ls1_1 = `access_time,
taa_tm_tp_hs1_1 = `access_time,
taa_tm_1 = `access_time,
taa_tm_tp_1 = `access_time,
taa_m_1 = `access_time,
taa_tp_m_1 = `access_time,
taa_tp_m_ls1_1 = `access_time,
taa_tp_m_hs1_1 = `access_time,
taa_tseq_tm_1 = `access_time,
taa_tckq_tm_1 = `access_time,
taa_2 = `access_time,
taa_tp_2 = `access_time,
taa_tp_ls1_2 = `access_time,
taa_tp_hs1_2 = `access_time,
taa_tm_tp_ls1_2 = `access_time,
taa_tm_tp_hs1_2 = `access_time,
taa_tm_2 = `access_time,
taa_tm_tp_2 = `access_time,
taa_m_2 = `access_time,
taa_tp_m_2 = `access_time,
taa_tp_m_ls1_2 = `access_time,
taa_tp_m_hs1_2 = `access_time,
taa_tseq_tm_2 = `access_time,
taa_tckq_tm_2 = `access_time,
taa_tamatch_1 = `access_time,
taa_ttamatch_1 = `access_time,
taa_trramatch_1 = `access_time,
taa_trraematch_1 = `access_time,
taa_ttrraematch_1 = `access_time,
taa_ttbistmatch_1 = `access_time,
taa_tatpmatch_1 = `access_time,
taa_tsematch_1 = `access_time,
taa_tamatch_2 = `access_time,
taa_ttamatch_2 = `access_time,
taa_trramatch_2 = `access_time,
taa_trraematch_2 = `access_time,
taa_ttrraematch_2 = `access_time,
taa_ttbistmatch_2 = `access_time,
taa_tatpmatch_2 = `access_time,
taa_tsematch_2 = `access_time,
taa_sctrlo_1 = `access_time,
taa_sctrlo_se_1 = `access_time,
taa_sctrlo_2 = `access_time,
taa_sctrlo_se_2 = `access_time,
taa_sdlo_1 = `access_time,
taa_sdlo_se_1 = `access_time,
taa_sdlo_2 = `access_time,
taa_sdlo_se_2 = `access_time,
taa_sdro_1 = `access_time,
taa_sdro_se_1 = `access_time,
taa_sdro_2 = `access_time,
taa_sdro_se_2 = `access_time,
taa_smlo_1 = `access_time,
taa_smlo_se_1 = `access_time,
taa_smlo_2 = `access_time,
taa_smlo_se_2 = `access_time,
taa_smro_1 = `access_time,
taa_smro_se_1 = `access_time,
taa_smro_2 = `access_time,
taa_smro_se_2 = `access_time,


th_1 = `retain_time,

th_ls1_1 = `retain_time,
th_m_ls1_1 = `retain_time,
th_tp_ls1_1 = `retain_time,
th_tm_tp_ls1_1 = `retain_time,
th_tp_m_ls1_1 = `retain_time,
th_tm_ls1_1 = `retain_time,
th_ls1_2 = `retain_time,
th_m_ls1_2 = `retain_time,
th_tm_ls1_2 = `retain_time,
th_tp_ls1_2 = `retain_time,
th_tm_tp_ls1_2 = `retain_time,
th_tp_m_ls1_2 = `retain_time,
th_hs1_1 = `retain_time,
th_m_hs1_1 = `retain_time,
th_tm_hs1_1 = `retain_time,
th_hs1_2 = `retain_time,
th_m_hs1_2 = `retain_time,
th_tm_hs1_2 = `retain_time,
th_tp_hs1_1 = `retain_time,
th_tm_tp_hs1_1 = `retain_time,
th_tp_m_hs1_1 = `retain_time,
th_tp_hs1_2 = `retain_time,
th_tm_tp_hs1_2 = `retain_time,
th_tp_m_hs1_2 = `retain_time,
th_tp_1 = `retain_time,
th_tm_1 = `retain_time,
th_tm_tp_1 = `retain_time,
th_m_1 = `retain_time,
th_tp_m_1 = `retain_time,
th_tseq_tm_1 = `retain_time,
th_tckq_tm_1 = `retain_time,
th_2 = `retain_time,
th_tp_2 = `retain_time,
th_tm_2 = `retain_time,
th_tm_tp_2 = `retain_time,
th_m_2 = `retain_time,
th_tp_m_2 = `retain_time,
th_tseq_tm_2 = `retain_time,
th_tckq_tm_2 = `retain_time,
th_tamatch_1 = `retain_time,
th_ttamatch_1 = `retain_time,
th_trramatch_1 = `retain_time,
th_trraematch_1 = `retain_time,
th_ttrraematch_1 = `retain_time,
th_ttbistmatch_1 = `retain_time,
th_tatpmatch_1 = `retain_time,
th_tsematch_1 = `retain_time,
th_tamatch_2 = `retain_time,
th_ttamatch_2 = `retain_time,
th_trramatch_2 = `retain_time,
th_trraematch_2 = `retain_time,
th_ttrraematch_2 = `retain_time,
th_ttbistmatch_2 = `retain_time,
th_tatpmatch_2 = `retain_time,
th_tsematch_2 = `retain_time,
th_sctrlo_1 = `retain_time,
th_sctrlo_se_1 = `retain_time,
th_sctrlo_2 = `retain_time,
th_sctrlo_se_2 = `retain_time,
th_sdlo_1 = `retain_time,
th_sdlo_se_1 = `retain_time,
th_sdlo_2 = `retain_time,
th_sdlo_se_2 = `retain_time,
th_sdro_1 = `retain_time,
th_sdro_se_1 = `retain_time,
th_sdro_2 = `retain_time,
th_sdro_se_2 = `retain_time,
th_smlo_1 = `retain_time,
th_smlo_se_1 = `retain_time,
th_smlo_2 = `retain_time,
th_smlo_se_2 = `retain_time,
th_smro_1 = `retain_time,
th_smro_se_1 = `retain_time,
th_smro_2 = `retain_time,
th_smro_se_2 = `retain_time;

///timing label end }---

   
//---------------------- Timing Checks ---------------------//
//-----

	
  $setup(posedge A1[0], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[0], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[0], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[0], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[0], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[0], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[0], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[0], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[1], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[1], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[1], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[1], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[1], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[1], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[1], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[1], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[2], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[2], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[2], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[2], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[2], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[2], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[2], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[2], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[3], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[3], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[3], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[3], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[3], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[3], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[3], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[3], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[4], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[4], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[4], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[4], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[4], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[4], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[4], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[4], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[5], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[5], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[5], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[5], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[5], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[5], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[5], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[5], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[6], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[6], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[6], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[6], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[6], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[6], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[6], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[6], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[7], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[7], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[7], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[7], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[7], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[7], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[7], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[7], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[8], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[8], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[8], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[8], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[8], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[8], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[8], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[8], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[9], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[9], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[9], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[9], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[9], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[9], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[9], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[9], tah_2, TimingViol_A2_CK2); 

	
  $setup(posedge A1[10], posedge CK1 &&& (Cond_sdf_ta_1) , tas_1, TimingViol_A1_CK1);
  $setup(negedge A1[10], posedge CK1 &&& (Cond_sdf_ta_1), tas_1, TimingViol_A1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), posedge A1[10], tah_1, TimingViol_A1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_ta_1), negedge A1[10], tah_1, TimingViol_A1_CK1); 
  $setup(posedge A2[10], posedge CK2 &&& (Cond_sdf_ta_2) , tas_2, TimingViol_A2_CK2);
  $setup(negedge A2[10], posedge CK2 &&& (Cond_sdf_ta_2), tas_2, TimingViol_A2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), posedge A2[10], tah_2, TimingViol_A2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_ta_2), negedge A2[10], tah_2, TimingViol_A2_CK2); 


	
  $setup(posedge TA1[0], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[0], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[0], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[0], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[0], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[0], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[0], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[0], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[1], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[1], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[1], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[1], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[1], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[1], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[1], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[1], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[2], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[2], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[2], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[2], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[2], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[2], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[2], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[2], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[3], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[3], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[3], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[3], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[3], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[3], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[3], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[3], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[4], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[4], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[4], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[4], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[4], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[4], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[4], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[4], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[5], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[5], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[5], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[5], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[5], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[5], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[5], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[5], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[6], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[6], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[6], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[6], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[6], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[6], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[6], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[6], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[7], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[7], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[7], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[7], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[7], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[7], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[7], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[7], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[8], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[8], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[8], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[8], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[8], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[8], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[8], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[8], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[9], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[9], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[9], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[9], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[9], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[9], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[9], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[9], tbah_2, TimingViol_TA2_CK2); 

	
  $setup(posedge TA1[10], posedge CK1 &&& (Cond_sdf_tba_1)  , tbas_1, TimingViol_TA1_CK1);
  $setup(negedge TA1[10], posedge CK1 &&& (Cond_sdf_tba_1) , tbas_1, TimingViol_TA1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tba_1), posedge TA1[10], tbah_1, TimingViol_TA1_CK1); 
  $hold(posedge CK1 &&& (Cond_sdf_tba_1) , negedge TA1[10], tbah_1, TimingViol_TA1_CK1); 
  $setup(posedge TA2[10], posedge CK2 &&& (Cond_sdf_tba_2)  , tbas_2, TimingViol_TA2_CK2);
  $setup(negedge TA2[10], posedge CK2 &&& (Cond_sdf_tba_2) , tbas_2, TimingViol_TA2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tba_2), posedge TA2[10], tbah_2, TimingViol_TA2_CK2); 
  $hold(posedge CK2 &&& (Cond_sdf_tba_2) , negedge TA2[10], tbah_2, TimingViol_TA2_CK2); 

 
	
  $setup(posedge TA1[0], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[0], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[0], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[0], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[0], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[0], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[0], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[0], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[1], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[1], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[1], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[1], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[1], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[1], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[1], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[1], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[2], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[2], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[2], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[2], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[2], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[2], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[2], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[2], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[3], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[3], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[3], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[3], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[3], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[3], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[3], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[3], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[4], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[4], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[4], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[4], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[4], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[4], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[4], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[4], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[5], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[5], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[5], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[5], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[5], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[5], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[5], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[5], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[6], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[6], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[6], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[6], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[6], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[6], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[6], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[6], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[7], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[7], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[7], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[7], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[7], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[7], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[7], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[7], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[8], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[8], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[8], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[8], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[8], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[8], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[8], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[8], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[9], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[9], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[9], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[9], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[9], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[9], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[9], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[9], tbah_m_2, TimingViol_TA2_MTCK); 

	
  $setup(posedge TA1[10], posedge MTCK &&& (Cond_sdf_tba_m_1)  , tbas_m_1, TimingViol_TA1_MTCK);
  $setup(negedge TA1[10], posedge MTCK &&& (Cond_sdf_tba_m_1) , tbas_m_1, TimingViol_TA1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , posedge TA1[10], tbah_m_1, TimingViol_TA1_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_1) , negedge TA1[10], tbah_m_1, TimingViol_TA1_MTCK); 
  $setup(posedge TA2[10], posedge MTCK &&& (Cond_sdf_tba_m_2)  , tbas_m_2, TimingViol_TA2_MTCK);
  $setup(negedge TA2[10], posedge MTCK &&& (Cond_sdf_tba_m_2) , tbas_m_2, TimingViol_TA2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , posedge TA2[10], tbah_m_2, TimingViol_TA2_MTCK); 
  $hold(posedge MTCK &&& (Cond_sdf_tba_m_2) , negedge TA2[10], tbah_m_2, TimingViol_TA2_MTCK); 



	
  $setup(posedge D1[0], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_0);
  $setup(negedge D1[0], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_0);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[0], tdh_1, TimingViol_D1_CK1_0);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[0], tdh_1, TimingViol_D1_CK1_0);

  $setup(posedge D2[0], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_0);
  $setup(negedge D2[0], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_0);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[0], tdh_2, TimingViol_D2_CK2_0);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[0], tdh_2, TimingViol_D2_CK2_0);

	
  $setup(posedge D1[1], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_1);
  $setup(negedge D1[1], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_1);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[1], tdh_1, TimingViol_D1_CK1_1);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[1], tdh_1, TimingViol_D1_CK1_1);

  $setup(posedge D2[1], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_1);
  $setup(negedge D2[1], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_1);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[1], tdh_2, TimingViol_D2_CK2_1);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[1], tdh_2, TimingViol_D2_CK2_1);

	
  $setup(posedge D1[2], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_2);
  $setup(negedge D1[2], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_2);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[2], tdh_1, TimingViol_D1_CK1_2);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[2], tdh_1, TimingViol_D1_CK1_2);

  $setup(posedge D2[2], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_2);
  $setup(negedge D2[2], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_2);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[2], tdh_2, TimingViol_D2_CK2_2);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[2], tdh_2, TimingViol_D2_CK2_2);

	
  $setup(posedge D1[3], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_3);
  $setup(negedge D1[3], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_3);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[3], tdh_1, TimingViol_D1_CK1_3);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[3], tdh_1, TimingViol_D1_CK1_3);

  $setup(posedge D2[3], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_3);
  $setup(negedge D2[3], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_3);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[3], tdh_2, TimingViol_D2_CK2_3);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[3], tdh_2, TimingViol_D2_CK2_3);

	
  $setup(posedge D1[4], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_4);
  $setup(negedge D1[4], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_4);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[4], tdh_1, TimingViol_D1_CK1_4);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[4], tdh_1, TimingViol_D1_CK1_4);

  $setup(posedge D2[4], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_4);
  $setup(negedge D2[4], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_4);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[4], tdh_2, TimingViol_D2_CK2_4);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[4], tdh_2, TimingViol_D2_CK2_4);

	
  $setup(posedge D1[5], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_5);
  $setup(negedge D1[5], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_5);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[5], tdh_1, TimingViol_D1_CK1_5);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[5], tdh_1, TimingViol_D1_CK1_5);

  $setup(posedge D2[5], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_5);
  $setup(negedge D2[5], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_5);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[5], tdh_2, TimingViol_D2_CK2_5);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[5], tdh_2, TimingViol_D2_CK2_5);

	
  $setup(posedge D1[6], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_6);
  $setup(negedge D1[6], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_6);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[6], tdh_1, TimingViol_D1_CK1_6);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[6], tdh_1, TimingViol_D1_CK1_6);

  $setup(posedge D2[6], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_6);
  $setup(negedge D2[6], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_6);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[6], tdh_2, TimingViol_D2_CK2_6);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[6], tdh_2, TimingViol_D2_CK2_6);

	
  $setup(posedge D1[7], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_7);
  $setup(negedge D1[7], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_7);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[7], tdh_1, TimingViol_D1_CK1_7);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[7], tdh_1, TimingViol_D1_CK1_7);

  $setup(posedge D2[7], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_7);
  $setup(negedge D2[7], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_7);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[7], tdh_2, TimingViol_D2_CK2_7);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[7], tdh_2, TimingViol_D2_CK2_7);

	
  $setup(posedge D1[8], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_8);
  $setup(negedge D1[8], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_8);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[8], tdh_1, TimingViol_D1_CK1_8);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[8], tdh_1, TimingViol_D1_CK1_8);

  $setup(posedge D2[8], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_8);
  $setup(negedge D2[8], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_8);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[8], tdh_2, TimingViol_D2_CK2_8);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[8], tdh_2, TimingViol_D2_CK2_8);

	
  $setup(posedge D1[9], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_9);
  $setup(negedge D1[9], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_9);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[9], tdh_1, TimingViol_D1_CK1_9);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[9], tdh_1, TimingViol_D1_CK1_9);

  $setup(posedge D2[9], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_9);
  $setup(negedge D2[9], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_9);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[9], tdh_2, TimingViol_D2_CK2_9);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[9], tdh_2, TimingViol_D2_CK2_9);

	
  $setup(posedge D1[10], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_10);
  $setup(negedge D1[10], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_10);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[10], tdh_1, TimingViol_D1_CK1_10);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[10], tdh_1, TimingViol_D1_CK1_10);

  $setup(posedge D2[10], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_10);
  $setup(negedge D2[10], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_10);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[10], tdh_2, TimingViol_D2_CK2_10);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[10], tdh_2, TimingViol_D2_CK2_10);

	
  $setup(posedge D1[11], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_11);
  $setup(negedge D1[11], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_11);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[11], tdh_1, TimingViol_D1_CK1_11);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[11], tdh_1, TimingViol_D1_CK1_11);

  $setup(posedge D2[11], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_11);
  $setup(negedge D2[11], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_11);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[11], tdh_2, TimingViol_D2_CK2_11);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[11], tdh_2, TimingViol_D2_CK2_11);

	
  $setup(posedge D1[12], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_12);
  $setup(negedge D1[12], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_12);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[12], tdh_1, TimingViol_D1_CK1_12);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[12], tdh_1, TimingViol_D1_CK1_12);

  $setup(posedge D2[12], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_12);
  $setup(negedge D2[12], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_12);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[12], tdh_2, TimingViol_D2_CK2_12);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[12], tdh_2, TimingViol_D2_CK2_12);

	
  $setup(posedge D1[13], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_13);
  $setup(negedge D1[13], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_13);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[13], tdh_1, TimingViol_D1_CK1_13);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[13], tdh_1, TimingViol_D1_CK1_13);

  $setup(posedge D2[13], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_13);
  $setup(negedge D2[13], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_13);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[13], tdh_2, TimingViol_D2_CK2_13);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[13], tdh_2, TimingViol_D2_CK2_13);

	
  $setup(posedge D1[14], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_14);
  $setup(negedge D1[14], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_14);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[14], tdh_1, TimingViol_D1_CK1_14);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[14], tdh_1, TimingViol_D1_CK1_14);

  $setup(posedge D2[14], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_14);
  $setup(negedge D2[14], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_14);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[14], tdh_2, TimingViol_D2_CK2_14);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[14], tdh_2, TimingViol_D2_CK2_14);

	
  $setup(posedge D1[15], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_15);
  $setup(negedge D1[15], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_15);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[15], tdh_1, TimingViol_D1_CK1_15);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[15], tdh_1, TimingViol_D1_CK1_15);

  $setup(posedge D2[15], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_15);
  $setup(negedge D2[15], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_15);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[15], tdh_2, TimingViol_D2_CK2_15);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[15], tdh_2, TimingViol_D2_CK2_15);

	
  $setup(posedge D1[16], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_16);
  $setup(negedge D1[16], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_16);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[16], tdh_1, TimingViol_D1_CK1_16);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[16], tdh_1, TimingViol_D1_CK1_16);

  $setup(posedge D2[16], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_16);
  $setup(negedge D2[16], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_16);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[16], tdh_2, TimingViol_D2_CK2_16);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[16], tdh_2, TimingViol_D2_CK2_16);

	
  $setup(posedge D1[17], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_17);
  $setup(negedge D1[17], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_17);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[17], tdh_1, TimingViol_D1_CK1_17);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[17], tdh_1, TimingViol_D1_CK1_17);

  $setup(posedge D2[17], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_17);
  $setup(negedge D2[17], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_17);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[17], tdh_2, TimingViol_D2_CK2_17);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[17], tdh_2, TimingViol_D2_CK2_17);

	
  $setup(posedge D1[18], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_18);
  $setup(negedge D1[18], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_18);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[18], tdh_1, TimingViol_D1_CK1_18);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[18], tdh_1, TimingViol_D1_CK1_18);

  $setup(posedge D2[18], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_18);
  $setup(negedge D2[18], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_18);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[18], tdh_2, TimingViol_D2_CK2_18);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[18], tdh_2, TimingViol_D2_CK2_18);

	
  $setup(posedge D1[19], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_19);
  $setup(negedge D1[19], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_19);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[19], tdh_1, TimingViol_D1_CK1_19);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[19], tdh_1, TimingViol_D1_CK1_19);

  $setup(posedge D2[19], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_19);
  $setup(negedge D2[19], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_19);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[19], tdh_2, TimingViol_D2_CK2_19);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[19], tdh_2, TimingViol_D2_CK2_19);

	
  $setup(posedge D1[20], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_20);
  $setup(negedge D1[20], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_20);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[20], tdh_1, TimingViol_D1_CK1_20);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[20], tdh_1, TimingViol_D1_CK1_20);

  $setup(posedge D2[20], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_20);
  $setup(negedge D2[20], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_20);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[20], tdh_2, TimingViol_D2_CK2_20);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[20], tdh_2, TimingViol_D2_CK2_20);

	
  $setup(posedge D1[21], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_21);
  $setup(negedge D1[21], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_21);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[21], tdh_1, TimingViol_D1_CK1_21);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[21], tdh_1, TimingViol_D1_CK1_21);

  $setup(posedge D2[21], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_21);
  $setup(negedge D2[21], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_21);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[21], tdh_2, TimingViol_D2_CK2_21);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[21], tdh_2, TimingViol_D2_CK2_21);

	
  $setup(posedge D1[22], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_22);
  $setup(negedge D1[22], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_22);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[22], tdh_1, TimingViol_D1_CK1_22);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[22], tdh_1, TimingViol_D1_CK1_22);

  $setup(posedge D2[22], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_22);
  $setup(negedge D2[22], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_22);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[22], tdh_2, TimingViol_D2_CK2_22);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[22], tdh_2, TimingViol_D2_CK2_22);

	
  $setup(posedge D1[23], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_23);
  $setup(negedge D1[23], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_23);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[23], tdh_1, TimingViol_D1_CK1_23);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[23], tdh_1, TimingViol_D1_CK1_23);

  $setup(posedge D2[23], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_23);
  $setup(negedge D2[23], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_23);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[23], tdh_2, TimingViol_D2_CK2_23);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[23], tdh_2, TimingViol_D2_CK2_23);

	
  $setup(posedge D1[24], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_24);
  $setup(negedge D1[24], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_24);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[24], tdh_1, TimingViol_D1_CK1_24);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[24], tdh_1, TimingViol_D1_CK1_24);

  $setup(posedge D2[24], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_24);
  $setup(negedge D2[24], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_24);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[24], tdh_2, TimingViol_D2_CK2_24);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[24], tdh_2, TimingViol_D2_CK2_24);

	
  $setup(posedge D1[25], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_25);
  $setup(negedge D1[25], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_25);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[25], tdh_1, TimingViol_D1_CK1_25);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[25], tdh_1, TimingViol_D1_CK1_25);

  $setup(posedge D2[25], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_25);
  $setup(negedge D2[25], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_25);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[25], tdh_2, TimingViol_D2_CK2_25);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[25], tdh_2, TimingViol_D2_CK2_25);

	
  $setup(posedge D1[26], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_26);
  $setup(negedge D1[26], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_26);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[26], tdh_1, TimingViol_D1_CK1_26);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[26], tdh_1, TimingViol_D1_CK1_26);

  $setup(posedge D2[26], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_26);
  $setup(negedge D2[26], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_26);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[26], tdh_2, TimingViol_D2_CK2_26);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[26], tdh_2, TimingViol_D2_CK2_26);

	
  $setup(posedge D1[27], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_27);
  $setup(negedge D1[27], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_27);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[27], tdh_1, TimingViol_D1_CK1_27);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[27], tdh_1, TimingViol_D1_CK1_27);

  $setup(posedge D2[27], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_27);
  $setup(negedge D2[27], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_27);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[27], tdh_2, TimingViol_D2_CK2_27);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[27], tdh_2, TimingViol_D2_CK2_27);

	
  $setup(posedge D1[28], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_28);
  $setup(negedge D1[28], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_28);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[28], tdh_1, TimingViol_D1_CK1_28);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[28], tdh_1, TimingViol_D1_CK1_28);

  $setup(posedge D2[28], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_28);
  $setup(negedge D2[28], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_28);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[28], tdh_2, TimingViol_D2_CK2_28);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[28], tdh_2, TimingViol_D2_CK2_28);

	
  $setup(posedge D1[29], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_29);
  $setup(negedge D1[29], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_29);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[29], tdh_1, TimingViol_D1_CK1_29);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[29], tdh_1, TimingViol_D1_CK1_29);

  $setup(posedge D2[29], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_29);
  $setup(negedge D2[29], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_29);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[29], tdh_2, TimingViol_D2_CK2_29);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[29], tdh_2, TimingViol_D2_CK2_29);

	
  $setup(posedge D1[30], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_30);
  $setup(negedge D1[30], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_30);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[30], tdh_1, TimingViol_D1_CK1_30);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[30], tdh_1, TimingViol_D1_CK1_30);

  $setup(posedge D2[30], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_30);
  $setup(negedge D2[30], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_30);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[30], tdh_2, TimingViol_D2_CK2_30);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[30], tdh_2, TimingViol_D2_CK2_30);

	
  $setup(posedge D1[31], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_31);
  $setup(negedge D1[31], posedge CK1 &&& (Cond_sdf_td_1) , tds_1, TimingViol_D1_CK1_31);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , posedge D1[31], tdh_1, TimingViol_D1_CK1_31);
  $hold(posedge CK1 &&& (Cond_sdf_td_1) , negedge D1[31], tdh_1, TimingViol_D1_CK1_31);

  $setup(posedge D2[31], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_31);
  $setup(negedge D2[31], posedge CK2 &&& (Cond_sdf_td_2) , tds_2, TimingViol_D2_CK2_31);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , posedge D2[31], tdh_2, TimingViol_D2_CK2_31);
  $hold(posedge CK2 &&& (Cond_sdf_td_2) , negedge D2[31], tdh_2, TimingViol_D2_CK2_31);


  $setup(posedge TED1, posedge CK1 &&& (Cond_sdf_tbde_1)  , tbdes_1, TimingViol_TED1_CK1);
  $setup(negedge TED1, posedge CK1 &&& (Cond_sdf_tbde_1) , tbdes_1, TimingViol_TED1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbde_1) , posedge TED1, tbdeh_1, TimingViol_TED1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbde_1) , negedge TED1, tbdeh_1, TimingViol_TED1_CK1);

  $setup(posedge TED2, posedge CK2 &&& (Cond_sdf_tbde_2)  , tbdes_2, TimingViol_TED2_CK2);
  $setup(negedge TED2, posedge CK2 &&& (Cond_sdf_tbde_2) , tbdes_2, TimingViol_TED2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbde_2) , posedge TED2, tbdeh_2, TimingViol_TED2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbde_2) , negedge TED2, tbdeh_2, TimingViol_TED2_CK2);




  $setup(posedge TOD1, posedge CK1 &&& (Cond_sdf_tbdo_1)  , tbdos_1, TimingViol_TOD1_CK1);
  $setup(negedge TOD1, posedge CK1 &&& (Cond_sdf_tbdo_1) , tbdos_1, TimingViol_TOD1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbdo_1) , posedge TOD1, tbdoh_1, TimingViol_TOD1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbdo_1) , negedge TOD1, tbdoh_1, TimingViol_TOD1_CK1);


  $setup(posedge TOD2, posedge CK2 &&& (Cond_sdf_tbdo_2)  , tbdos_2, TimingViol_TOD2_CK2);
  $setup(negedge TOD2, posedge CK2 &&& (Cond_sdf_tbdo_2) , tbdos_2, TimingViol_TOD2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbdo_2) , posedge TOD2, tbdoh_2, TimingViol_TOD2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbdo_2) , negedge TOD2, tbdoh_2, TimingViol_TOD2_CK2);


  $setup(posedge TED1, posedge MTCK &&& (Cond_sdf_tbde_m_1)   , tbdes_m_1, TimingViol_TED1_MTCK);
  $setup(negedge TED1, posedge MTCK &&& (Cond_sdf_tbde_m_1)  , tbdes_m_1, TimingViol_TED1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbde_m_1)  , posedge TED1  , tbdeh_m_1, TimingViol_TED1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbde_m_1) , negedge TED1  , tbdeh_m_1, TimingViol_TED1_MTCK);

  $setup(posedge TOD1, posedge MTCK &&& (Cond_sdf_tbdo_m_1)   , tbdos_m_1, TimingViol_TOD1_MTCK);
  $setup(negedge TOD1, posedge MTCK &&& (Cond_sdf_tbdo_m_1)  , tbdos_m_1, TimingViol_TOD1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbdo_m_1)  , posedge TOD1  , tbdoh_m_1, TimingViol_TOD1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbdo_m_1) , negedge TOD1  , tbdoh_m_1, TimingViol_TOD1_MTCK);

  $setup(posedge TED2, posedge MTCK &&& (Cond_sdf_tbde_m_2)   , tbdes_m_2, TimingViol_TED2_MTCK);
  $setup(negedge TED2, posedge MTCK &&& (Cond_sdf_tbde_m_2)  , tbdes_m_2, TimingViol_TED2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbde_m_2)  , posedge TED2  , tbdeh_m_2, TimingViol_TED2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbde_m_2) , negedge TED2  , tbdeh_m_2, TimingViol_TED2_MTCK);

  $setup(posedge TOD2, posedge MTCK &&& (Cond_sdf_tbdo_m_2)   , tbdos_m_2, TimingViol_TOD2_MTCK);
  $setup(negedge TOD2, posedge MTCK &&& (Cond_sdf_tbdo_m_2)  , tbdos_m_2, TimingViol_TOD2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbdo_m_2)  , posedge TOD2  , tbdoh_m_2, TimingViol_TOD2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbdo_m_2) , negedge TOD2  , tbdoh_m_2, TimingViol_TOD2_MTCK);



        


 $setup(posedge WEN1, posedge CK1 &&& (Cond_sdf_tw_1)  , tws_1, TimingViol_WEN1_CK1);
 $setup(negedge WEN1, posedge CK1 &&& (Cond_sdf_tw_1) , tws_1, TimingViol_WEN1_CK1);
 $hold(posedge CK1  &&& (Cond_sdf_tw_1) , posedge WEN1, twh_1, TimingViol_WEN1_CK1);
 $hold(posedge CK1 &&& (Cond_sdf_tw_1) , negedge WEN1, twh_1, TimingViol_WEN1_CK1);

 $setup(posedge WEN2, posedge CK2 &&& (Cond_sdf_tw_2)  , tws_2, TimingViol_WEN2_CK2);
 $setup(negedge WEN2, posedge CK2 &&& (Cond_sdf_tw_2) , tws_2, TimingViol_WEN2_CK2);
 $hold(posedge CK2  &&& (Cond_sdf_tw_2) , posedge WEN2, twh_2, TimingViol_WEN2_CK2);
 $hold(posedge CK2 &&& (Cond_sdf_tw_2) , negedge WEN2, twh_2, TimingViol_WEN2_CK2);


 $setup(posedge TWEN1, posedge CK1 &&& (Cond_sdf_tbw_1)  , tbws_1, TimingViol_TWEN1_CK1);
 $setup(negedge TWEN1, posedge CK1 &&& (Cond_sdf_tbw_1) , tbws_1, TimingViol_TWEN1_CK1);
 $hold(posedge CK1 &&& (Cond_sdf_tbw_1) , posedge TWEN1, tbwh_1, TimingViol_TWEN1_CK1);
 $hold(posedge CK1 &&& (Cond_sdf_tbw_1)  , negedge TWEN1, tbwh_1, TimingViol_TWEN1_CK1);

 $setup(posedge TWEN2, posedge CK2 &&& (Cond_sdf_tbw_2)  , tbws_2, TimingViol_TWEN2_CK2);
 $setup(negedge TWEN2, posedge CK2 &&& (Cond_sdf_tbw_2) , tbws_2, TimingViol_TWEN2_CK2);
 $hold(posedge CK2 &&& (Cond_sdf_tbw_2) , posedge TWEN2, tbwh_2, TimingViol_TWEN2_CK2);
 $hold(posedge CK2 &&& (Cond_sdf_tbw_2)  , negedge TWEN2, tbwh_2, TimingViol_TWEN2_CK2);

 $setup(posedge TWEN1, posedge MTCK &&& (Cond_sdf_tbw_m_1) , tbws_m_1, TimingViol_TWEN1_MTCK);
 $setup(negedge TWEN1, posedge MTCK &&& (Cond_sdf_tbw_m_1) , tbws_m_1, TimingViol_TWEN1_MTCK);
 $hold(posedge MTCK &&& (Cond_sdf_tbw_m_1) , posedge TWEN1, tbwh_m_1, TimingViol_TWEN1_MTCK);
 $hold(posedge MTCK &&& (Cond_sdf_tbw_m_1) , negedge TWEN1, tbwh_m_1, TimingViol_TWEN1_MTCK);

 
 $setup(posedge TWEN2, posedge MTCK &&& (Cond_sdf_tbw_m_2) , tbws_m_2, TimingViol_TWEN2_MTCK);
 $setup(negedge TWEN2, posedge MTCK &&& (Cond_sdf_tbw_m_2) , tbws_m_2, TimingViol_TWEN2_MTCK);
 $hold(posedge MTCK &&& (Cond_sdf_tbw_m_2) , posedge TWEN2, tbwh_m_2, TimingViol_TWEN2_MTCK);
 $hold(posedge MTCK &&& (Cond_sdf_tbw_m_2) , negedge TWEN2, tbwh_m_2, TimingViol_TWEN2_MTCK);

  
  $setup(posedge CSN1, posedge CK1 &&& (Cond_sdf_tp_1), tps_1, TimingViol_CSN1_CK1);
  $setup(negedge CSN1, posedge CK1 &&& (Cond_sdf_tp_1) , tps_1, TimingViol_CSN1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tp_1) , posedge CSN1 , tph_1, TimingViol_CSN1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tp_1) , negedge CSN1 , tph_1, TimingViol_CSN1_CK1);

  $setup(posedge CSN2, posedge CK2 &&& (Cond_sdf_tp_2), tps_2, TimingViol_CSN2_CK2);
  $setup(negedge CSN2, posedge CK2 &&& (Cond_sdf_tp_2) , tps_2, TimingViol_CSN2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tp_2) , posedge CSN2 , tph_2, TimingViol_CSN2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tp_2) , negedge CSN2 , tph_2, TimingViol_CSN2_CK2);


  $setup(posedge TCSN1, posedge CK1 &&& (Cond_sdf_tbp_1)  , tbps_1, TimingViol_TCSN1_CK1);
  $setup(negedge TCSN1, posedge CK1 &&& (Cond_sdf_tbp_1)  , tbps_1, TimingViol_TCSN1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbp_1)  , posedge TCSN1 , tbph_1, TimingViol_TCSN1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbp_1) , negedge TCSN1 , tbph_1, TimingViol_TCSN1_CK1);

  $setup(posedge TCSN2, posedge CK2 &&& (Cond_sdf_tbp_2)  , tbps_2, TimingViol_TCSN2_CK2);
  $setup(negedge TCSN2, posedge CK2 &&& (Cond_sdf_tbp_2)  , tbps_2, TimingViol_TCSN2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbp_2)  , posedge TCSN2 , tbph_2, TimingViol_TCSN2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbp_2) , negedge TCSN2 , tbph_2, TimingViol_TCSN2_CK2);


  $setup(posedge TCSN1, posedge MTCK &&& (Cond_sdf_tbp_m_1) , tbps_m_1, TimingViol_TCSN1_MTCK);
  $setup(negedge TCSN1, posedge MTCK &&& (Cond_sdf_tbp_m_1) , tbps_m_1, TimingViol_TCSN1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbp_m_1) , posedge TCSN1 , tbph_m_1, TimingViol_TCSN1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbp_m_1) , negedge TCSN1 , tbph_m_1, TimingViol_TCSN1_MTCK);

  $setup(posedge TCSN2, posedge MTCK &&& (Cond_sdf_tbp_m_2) , tbps_m_2, TimingViol_TCSN2_MTCK);
  $setup(negedge TCSN2, posedge MTCK &&& (Cond_sdf_tbp_m_2) , tbps_m_2, TimingViol_TCSN2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbp_m_2) , posedge TCSN2 , tbph_m_2, TimingViol_TCSN2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbp_m_2) , negedge TCSN2 , tbph_m_2, TimingViol_TCSN2_MTCK);

//--- TP releated

  $setup(posedge TP, posedge CK1 &&& (Cond_sdf_ttp_1)  , ttps_1, TimingViol_TP_CK1);
  $setup(negedge TP, posedge CK1 &&& (Cond_sdf_ttp_1)  , ttps_1, TimingViol_TP_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ttp_1)  , posedge TP , ttph_1, TimingViol_TP_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ttp_1) , negedge TP , ttph_1, TimingViol_TP_CK1);

  $setup(posedge TP, posedge CK2 &&& (Cond_sdf_ttp_2)  , ttps_2, TimingViol_TP_CK2);
  $setup(negedge TP, posedge CK2 &&& (Cond_sdf_ttp_2)  , ttps_2, TimingViol_TP_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ttp_2)  , posedge TP , ttph_2, TimingViol_TP_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ttp_2) , negedge TP , ttph_2, TimingViol_TP_CK2);

  $setup(posedge TP, posedge MTCK &&& (Cond_sdf_ttp_m)  , ttps_m, TimingViol_TP_MTCK);
  $setup(negedge TP, posedge MTCK &&& (Cond_sdf_ttp_m)  , ttps_m, TimingViol_TP_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_ttp_m)  , posedge TP , ttph_m, TimingViol_TP_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_ttp_m) , negedge TP , ttph_m, TimingViol_TP_MTCK);



//--- clk mux toggling arcs
//CSN 

  $setup(posedge CSN1, posedge TBIST &&& (Cond_sdf_tp_tbist_1), tps_tbist_r_1, TimingViol_CSN1_TBIST);
  $setup(negedge CSN1, posedge TBIST &&& (Cond_sdf_tp_tbist_1) , tps_tbist_r_1, TimingViol_CSN1_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tp_tbist_1) , posedge CSN1 , tph_tbist_r_1, TimingViol_CSN1_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tp_tbist_1) , negedge CSN1 , tph_tbist_r_1, TimingViol_CSN1_TBIST);

  $setup(posedge CSN1, negedge TBIST &&& (Cond_sdf_tp_tbist_1), tps_tbist_f_1, TimingViol_CSN1_TBIST);
  $setup(negedge CSN1, negedge TBIST &&& (Cond_sdf_tp_tbist_1) , tps_tbist_f_1, TimingViol_CSN1_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tp_tbist_1) , posedge CSN1 , tph_tbist_f_1, TimingViol_CSN1_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tp_tbist_1) , negedge CSN1 , tph_tbist_f_1, TimingViol_CSN1_TBIST);

  $setup(posedge CSN1, posedge ATP &&& (Cond_sdf_tp_atp_1), tps_atp_r_1, TimingViol_CSN1_ATP);
  $setup(negedge CSN1, posedge ATP &&& (Cond_sdf_tp_atp_1) , tps_atp_r_1, TimingViol_CSN1_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tp_atp_1) , posedge CSN1 , tph_atp_r_1, TimingViol_CSN1_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tp_atp_1) , negedge CSN1 , tph_atp_r_1, TimingViol_CSN1_ATP);

  $setup(posedge CSN1, negedge ATP &&& (Cond_sdf_tp_atp_1), tps_atp_f_1, TimingViol_CSN1_ATP);
  $setup(negedge CSN1, negedge ATP &&& (Cond_sdf_tp_atp_1) , tps_atp_f_1, TimingViol_CSN1_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tp_atp_1) , posedge CSN1 , tph_atp_f_1, TimingViol_CSN1_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tp_atp_1) , negedge CSN1 , tph_atp_f_1, TimingViol_CSN1_ATP);

  $setup(posedge CSN1, posedge TBYPASS &&& (Cond_sdf_tp_tbypas_1), tps_tbypas_r_1, TimingViol_CSN1_TBYPASS);
  $setup(negedge CSN1, posedge TBYPASS &&& (Cond_sdf_tp_tbypas_1) , tps_tbypas_r_1, TimingViol_CSN1_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tp_tbypas_1) , posedge CSN1 , tph_tbypas_r_1, TimingViol_CSN1_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tp_tbypas_1) , negedge CSN1 , tph_tbypas_r_1, TimingViol_CSN1_TBYPASS);

  $setup(posedge CSN1, negedge TBYPASS &&& (Cond_sdf_tp_tbypas_1), tps_tbypas_f_1, TimingViol_CSN1_TBYPASS);
  $setup(negedge CSN1, negedge TBYPASS &&& (Cond_sdf_tp_tbypas_1) , tps_tbypas_f_1, TimingViol_CSN1_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tp_tbypas_1) , posedge CSN1 , tph_tbypas_f_1, TimingViol_CSN1_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tp_tbypas_1) , negedge CSN1 , tph_tbypas_f_1, TimingViol_CSN1_TBYPASS);

  $setup(posedge CSN2, posedge TBIST &&& (Cond_sdf_tp_tbist_2), tps_tbist_r_2, TimingViol_CSN2_TBIST);
  $setup(negedge CSN2, posedge TBIST &&& (Cond_sdf_tp_tbist_2) , tps_tbist_r_2, TimingViol_CSN2_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tp_tbist_2) , posedge CSN2 , tph_tbist_r_2, TimingViol_CSN2_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tp_tbist_2) , negedge CSN2 , tph_tbist_r_2, TimingViol_CSN2_TBIST);

  $setup(posedge CSN2, negedge TBIST &&& (Cond_sdf_tp_tbist_2), tps_tbist_f_2, TimingViol_CSN2_TBIST);
  $setup(negedge CSN2, negedge TBIST &&& (Cond_sdf_tp_tbist_2) , tps_tbist_f_2, TimingViol_CSN2_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tp_tbist_2) , posedge CSN2 , tph_tbist_f_2, TimingViol_CSN2_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tp_tbist_2) , negedge CSN2 , tph_tbist_f_2, TimingViol_CSN2_TBIST);

  $setup(posedge CSN2, posedge ATP &&& (Cond_sdf_tp_atp_2), tps_atp_r_2, TimingViol_CSN2_ATP);
  $setup(negedge CSN2, posedge ATP &&& (Cond_sdf_tp_atp_2) , tps_atp_r_2, TimingViol_CSN2_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tp_atp_2) , posedge CSN2 , tph_atp_r_2, TimingViol_CSN2_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tp_atp_2) , negedge CSN2 , tph_atp_r_2, TimingViol_CSN2_ATP);

  $setup(posedge CSN2, negedge ATP &&& (Cond_sdf_tp_atp_2), tps_atp_f_2, TimingViol_CSN2_ATP);
  $setup(negedge CSN2, negedge ATP &&& (Cond_sdf_tp_atp_2) , tps_atp_f_2, TimingViol_CSN2_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tp_atp_2) , posedge CSN2 , tph_atp_f_2, TimingViol_CSN2_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tp_atp_2) , negedge CSN2 , tph_atp_f_2, TimingViol_CSN2_ATP);

  $setup(posedge CSN2, posedge TBYPASS &&& (Cond_sdf_tp_tbypas_2), tps_tbypas_r_2, TimingViol_CSN2_TBYPASS);
  $setup(negedge CSN2, posedge TBYPASS &&& (Cond_sdf_tp_tbypas_2) , tps_tbypas_r_2, TimingViol_CSN2_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tp_tbypas_2) , posedge CSN2 , tph_tbypas_r_2, TimingViol_CSN2_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tp_tbypas_2) , negedge CSN2 , tph_tbypas_r_2, TimingViol_CSN2_TBYPASS);

  $setup(posedge CSN2, negedge TBYPASS &&& (Cond_sdf_tp_tbypas_2), tps_tbypas_f_2, TimingViol_CSN2_TBYPASS);
  $setup(negedge CSN2, negedge TBYPASS &&& (Cond_sdf_tp_tbypas_2) , tps_tbypas_f_2, TimingViol_CSN2_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tp_tbypas_2) , posedge CSN2 , tph_tbypas_f_2, TimingViol_CSN2_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tp_tbypas_2) , negedge CSN2 , tph_tbypas_f_2, TimingViol_CSN2_TBYPASS);


//TCSN
  $setup(posedge TCSN1, posedge TBIST &&& (Cond_sdf_tbp_tbist_1), tbps_tbist_r_1, TimingViol_TCSN1_TBIST);
  $setup(negedge TCSN1, posedge TBIST &&& (Cond_sdf_tbp_tbist_1) , tbps_tbist_r_1, TimingViol_TCSN1_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tbp_tbist_1) , posedge TCSN1 , tbph_tbist_r_1, TimingViol_TCSN1_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tbp_tbist_1) , negedge TCSN1 , tbph_tbist_r_1, TimingViol_TCSN1_TBIST);

  $setup(posedge TCSN1, negedge TBIST &&& (Cond_sdf_tbp_tbist_1), tbps_tbist_f_1, TimingViol_TCSN1_TBIST);
  $setup(negedge TCSN1, negedge TBIST &&& (Cond_sdf_tbp_tbist_1) , tbps_tbist_f_1, TimingViol_TCSN1_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tbp_tbist_1) , posedge TCSN1 , tbph_tbist_f_1, TimingViol_TCSN1_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tbp_tbist_1) , negedge TCSN1 , tbph_tbist_f_1, TimingViol_TCSN1_TBIST);

  $setup(posedge TCSN1, posedge ATP &&& (Cond_sdf_tbp_atp_1), tbps_atp_r_1, TimingViol_TCSN1_ATP);
  $setup(negedge TCSN1, posedge ATP &&& (Cond_sdf_tbp_atp_1) , tbps_atp_r_1, TimingViol_TCSN1_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tbp_atp_1) , posedge TCSN1 , tbph_atp_r_1, TimingViol_TCSN1_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tbp_atp_1) , negedge TCSN1 , tbph_atp_r_1, TimingViol_TCSN1_ATP);

  $setup(posedge TCSN1, negedge ATP &&& (Cond_sdf_tbp_atp_1), tbps_atp_f_1, TimingViol_TCSN1_ATP);
  $setup(negedge TCSN1, negedge ATP &&& (Cond_sdf_tbp_atp_1) , tbps_atp_f_1, TimingViol_TCSN1_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tbp_atp_1) , posedge TCSN1 , tbph_atp_f_1, TimingViol_TCSN1_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tbp_atp_1) , negedge TCSN1 , tbph_atp_f_1, TimingViol_TCSN1_ATP);

  $setup(posedge TCSN1, posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1), tbps_tbypas_r_1, TimingViol_TCSN1_TBYPASS);
  $setup(negedge TCSN1, posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1) , tbps_tbypas_r_1, TimingViol_TCSN1_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1) , posedge TCSN1 , tbph_tbypas_r_1, TimingViol_TCSN1_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1) , negedge TCSN1 , tbph_tbypas_r_1, TimingViol_TCSN1_TBYPASS);

  $setup(posedge TCSN1, negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1), tbps_tbypas_f_1, TimingViol_TCSN1_TBYPASS);
  $setup(negedge TCSN1, negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1) , tbps_tbypas_f_1, TimingViol_TCSN1_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1) , posedge TCSN1 , tbph_tbypas_f_1, TimingViol_TCSN1_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_1) , negedge TCSN1 , tbph_tbypas_f_1, TimingViol_TCSN1_TBYPASS);

  $setup(posedge TCSN2, posedge TBIST &&& (Cond_sdf_tbp_tbist_2), tbps_tbist_r_2, TimingViol_TCSN2_TBIST);
  $setup(negedge TCSN2, posedge TBIST &&& (Cond_sdf_tbp_tbist_2) , tbps_tbist_r_2, TimingViol_TCSN2_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tbp_tbist_2) , posedge TCSN2 , tbph_tbist_r_2, TimingViol_TCSN2_TBIST);
  $hold(posedge TBIST &&& (Cond_sdf_tbp_tbist_2) , negedge TCSN2 , tbph_tbist_r_2, TimingViol_TCSN2_TBIST);

  $setup(posedge TCSN2, negedge TBIST &&& (Cond_sdf_tbp_tbist_2), tbps_tbist_f_2, TimingViol_TCSN2_TBIST);
  $setup(negedge TCSN2, negedge TBIST &&& (Cond_sdf_tbp_tbist_2) , tbps_tbist_f_2, TimingViol_TCSN2_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tbp_tbist_2) , posedge TCSN2 , tbph_tbist_f_2, TimingViol_TCSN2_TBIST);
  $hold(negedge TBIST &&& (Cond_sdf_tbp_tbist_2) , negedge TCSN2 , tbph_tbist_f_2, TimingViol_TCSN2_TBIST);

  $setup(posedge TCSN2, posedge ATP &&& (Cond_sdf_tbp_atp_2), tbps_atp_r_2, TimingViol_TCSN2_ATP);
  $setup(negedge TCSN2, posedge ATP &&& (Cond_sdf_tbp_atp_2) , tbps_atp_r_2, TimingViol_TCSN2_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tbp_atp_2) , posedge TCSN2 , tbph_atp_r_2, TimingViol_TCSN2_ATP);
  $hold(posedge ATP &&& (Cond_sdf_tbp_atp_2) , negedge TCSN2 , tbph_atp_r_2, TimingViol_TCSN2_ATP);

  $setup(posedge TCSN2, negedge ATP &&& (Cond_sdf_tbp_atp_2), tbps_atp_f_2, TimingViol_TCSN2_ATP);
  $setup(negedge TCSN2, negedge ATP &&& (Cond_sdf_tbp_atp_2) , tbps_atp_f_2, TimingViol_TCSN2_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tbp_atp_2) , posedge TCSN2 , tbph_atp_f_2, TimingViol_TCSN2_ATP);
  $hold(negedge ATP &&& (Cond_sdf_tbp_atp_2) , negedge TCSN2 , tbph_atp_f_2, TimingViol_TCSN2_ATP);


  $setup(posedge TCSN2, posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2), tbps_tbypas_r_2, TimingViol_TCSN2_TBYPASS);
  $setup(negedge TCSN2, posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2) , tbps_tbypas_r_2, TimingViol_TCSN2_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2) , posedge TCSN2 , tbph_tbypas_r_2, TimingViol_TCSN2_TBYPASS);
  $hold(posedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2) , negedge TCSN2 , tbph_tbypas_r_2, TimingViol_TCSN2_TBYPASS);

  $setup(posedge TCSN2, negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2), tbps_tbypas_f_2, TimingViol_TCSN2_TBYPASS);
  $setup(negedge TCSN2, negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2) , tbps_tbypas_f_2, TimingViol_TCSN2_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2) , posedge TCSN2 , tbph_tbypas_f_2, TimingViol_TCSN2_TBYPASS);
  $hold(negedge TBYPASS &&& (Cond_sdf_tbp_tbypas_2) , negedge TCSN2 , tbph_tbypas_f_2, TimingViol_TCSN2_TBYPASS);
//----



  $setup(posedge IG1, posedge CK1 &&& (Cond_sdf_tig_1) , tigs_1, TimingViol_IG1_CK1);
  $setup(negedge IG1, posedge CK1 &&& (Cond_sdf_tig_1) , tigs_1, TimingViol_IG1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tig_1) , posedge IG1 , tigh_1, TimingViol_IG1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tig_1) , negedge IG1 , tigh_1, TimingViol_IG1_CK1);

  $setup(posedge IG1, posedge MTCK &&& (Cond_sdf_tig_m_1) , tigs_m_1, TimingViol_IG1_MTCK);
  $setup(negedge IG1, posedge MTCK &&& (Cond_sdf_tig_m_1) , tigs_m_1, TimingViol_IG1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tig_m_1) , posedge IG1 , tigh_m_1, TimingViol_IG1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tig_m_1) , negedge IG1 , tigh_m_1, TimingViol_IG1_MTCK);

  $setup(posedge IG2, posedge CK2 &&& (Cond_sdf_tig_2) , tigs_2, TimingViol_IG2_CK2);
  $setup(negedge IG2, posedge CK2 &&& (Cond_sdf_tig_2) , tigs_2, TimingViol_IG2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tig_2) , posedge IG2 , tigh_2, TimingViol_IG2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tig_2) , negedge IG2 , tigh_2, TimingViol_IG2_CK2);

  $setup(posedge IG2, posedge MTCK &&& (Cond_sdf_tig_m_2) , tigs_m_2, TimingViol_IG2_MTCK);
  $setup(negedge IG2, posedge MTCK &&& (Cond_sdf_tig_m_2) , tigs_m_2, TimingViol_IG2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tig_m_2) , posedge IG2 , tigh_m_2, TimingViol_IG2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tig_m_2) , negedge IG2 , tigh_m_2, TimingViol_IG2_MTCK);


  
  $setup(posedge SE, posedge CK1 &&& (Cond_sdf_tse_1) , tses_1, TimingViol_SE_CK1);
  $setup(negedge SE, posedge CK1 &&& (Cond_sdf_tse_1) , tses_1, TimingViol_SE_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tse_1) , posedge SE , tseh_1, TimingViol_SE_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tse_1) , negedge SE , tseh_1, TimingViol_SE_CK1);

  $setup(posedge SE, posedge CK2 &&& (Cond_sdf_tse_2) , tses_2, TimingViol_SE_CK2);
  $setup(negedge SE, posedge CK2 &&& (Cond_sdf_tse_2) , tses_2, TimingViol_SE_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tse_2) , posedge SE , tseh_2, TimingViol_SE_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tse_2) , negedge SE , tseh_2, TimingViol_SE_CK2);

  $setup(posedge SE, posedge MTCK &&& (Cond_sdf_tse_m) , tses_m, TimingViol_SE_MTCK);
  $setup(negedge SE, posedge MTCK &&& (Cond_sdf_tse_m) , tses_m, TimingViol_SE_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tse_m) , posedge SE , tseh_m, TimingViol_SE_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tse_m) , negedge SE , tseh_m, TimingViol_SE_MTCK);





  $setup(posedge INITN, posedge CK1 &&& (Cond_sdf_tinitn_1) , tinitnrs_1, TimingViol_INITN_CK1);
  $setup(negedge INITN, posedge CK1 &&& (Cond_sdf_tinitn_1) , tinitnfs_1, TimingViol_INITN_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tinitn_1) , posedge INITN , tinitnrh_1, TimingViol_INITN_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tinitn_1) , negedge INITN , tinitnfh_1, TimingViol_INITN_CK1);

  $setup(posedge INITN, posedge CK2 &&& (Cond_sdf_tinitn_2) , tinitnrs_2, TimingViol_INITN_CK2);
  $setup(negedge INITN, posedge CK2 &&& (Cond_sdf_tinitn_2) , tinitnfs_2, TimingViol_INITN_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tinitn_2) , posedge INITN , tinitnrh_2, TimingViol_INITN_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tinitn_2) , negedge INITN , tinitnfh_2, TimingViol_INITN_CK2);

  $setup(posedge INITN, posedge MTCK &&& (Cond_sdf_tinitn_m) , tinitnrs_m, TimingViol_INITN_MTCK);
  $setup(negedge INITN, posedge MTCK &&& (Cond_sdf_tinitn_m) , tinitnfs_m, TimingViol_INITN_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tinitn_m) , posedge INITN , tinitnrh_m, TimingViol_INITN_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tinitn_m) , negedge INITN , tinitnfh_m, TimingViol_INITN_MTCK);






  $setup(posedge STDBY1, posedge CK1 &&& (Cond_sdf_tstdby_1) , tstdbys_1, TimingViol_STDBY1_CK1);
  $setup(negedge STDBY1, posedge CK1 &&& (Cond_sdf_tstdby_1) , tstdbys_1, TimingViol_STDBY1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tstdby_1) , posedge STDBY1 , tstdbyh_1, TimingViol_STDBY1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tstdby_1) , negedge STDBY1 , tstdbyh_1, TimingViol_STDBY1_CK1);

  $setup(posedge STDBY1, posedge MTCK &&& (Cond_sdf_tstdby_m_1) , tstdbys_m_1, TimingViol_STDBY1_MTCK);
  $setup(negedge STDBY1, posedge MTCK &&& (Cond_sdf_tstdby_m_1) , tstdbys_m_1, TimingViol_STDBY1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tstdby_m_1) , posedge STDBY1 , tstdbyh_m_1, TimingViol_STDBY1_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tstdby_m_1) , negedge STDBY1 , tstdbyh_m_1, TimingViol_STDBY1_MTCK);

  $setup(posedge STDBY2, posedge CK2 &&& (Cond_sdf_tstdby_2) , tstdbys_2, TimingViol_STDBY2_CK2);
  $setup(negedge STDBY2, posedge CK2 &&& (Cond_sdf_tstdby_2) , tstdbys_2, TimingViol_STDBY2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tstdby_2) , posedge STDBY2 , tstdbyh_2, TimingViol_STDBY2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tstdby_2) , negedge STDBY2 , tstdbyh_2, TimingViol_STDBY2_CK2);

  $setup(posedge STDBY2, posedge MTCK &&& (Cond_sdf_tstdby_m_2) , tstdbys_m_2, TimingViol_STDBY2_MTCK);
  $setup(negedge STDBY2, posedge MTCK &&& (Cond_sdf_tstdby_m_2) , tstdbys_m_2, TimingViol_STDBY2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tstdby_m_2) , posedge STDBY2 , tstdbyh_m_2, TimingViol_STDBY2_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tstdby_m_2) , negedge STDBY2 , tstdbyh_m_2, TimingViol_STDBY2_MTCK);

  


  $setup(posedge TBYPASS, posedge CK1 &&& (Cond_sdf_ttm_1) , ttms_1, TimingViol_TBYPASS_CK1);
  $setup(negedge TBYPASS, posedge CK1 &&& (Cond_sdf_ttm_1) , ttms_1, TimingViol_TBYPASS_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ttm_1) , posedge TBYPASS , ttmh_1, TimingViol_TBYPASS_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_ttm_1) , negedge TBYPASS , ttmh_1, TimingViol_TBYPASS_CK1);

  $setup(posedge TBYPASS, posedge CK2 &&& (Cond_sdf_ttm_2) , ttms_2, TimingViol_TBYPASS_CK2);
  $setup(negedge TBYPASS, posedge CK2 &&& (Cond_sdf_ttm_2) , ttms_2, TimingViol_TBYPASS_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ttm_2) , posedge TBYPASS , ttmh_2, TimingViol_TBYPASS_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_ttm_2) , negedge TBYPASS , ttmh_2, TimingViol_TBYPASS_CK2);


  $setup(posedge TBYPASS, posedge MTCK &&& (Cond_sdf_ttm_m) , ttms_m, TimingViol_TBYPASS_MTCK);
  $setup(negedge TBYPASS, posedge MTCK &&& (Cond_sdf_ttm_m) , ttms_m, TimingViol_TBYPASS_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_ttm_m) , posedge TBYPASS , ttmh_m, TimingViol_TBYPASS_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_ttm_m) , negedge TBYPASS , ttmh_m, TimingViol_TBYPASS_MTCK);



  $setup(posedge SCTRLI1, posedge CK1 &&& (Cond_sdf_tsctrli_1) , tsctrlis_1, TimingViol_SCTRLI1_CK1);
  $setup(negedge SCTRLI1, posedge CK1 &&& (Cond_sdf_tsctrli_1) , tsctrlis_1, TimingViol_SCTRLI1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tsctrli_1), posedge SCTRLI1 , tsctrlih_1, TimingViol_SCTRLI1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tsctrli_1) , negedge SCTRLI1 , tsctrlih_1, TimingViol_SCTRLI1_CK1);

  $setup(posedge SDLI1, posedge CK1 &&& (Cond_sdf_tsdli_1) , tsdlis_1, TimingViol_SDLI1_CK1);
  $setup(negedge SDLI1, posedge CK1 &&& (Cond_sdf_tsdli_1) , tsdlis_1, TimingViol_SDLI1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tsdli_1), posedge SDLI1 , tsdlih_1, TimingViol_SDLI1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tsdli_1) , negedge SDLI1 , tsdlih_1, TimingViol_SDLI1_CK1);

  $setup(posedge SDRI1, posedge CK1 &&& (Cond_sdf_tsdri_1) , tsdris_1, TimingViol_SDRI1_CK1);
  $setup(negedge SDRI1, posedge CK1 &&& (Cond_sdf_tsdri_1) , tsdris_1, TimingViol_SDRI1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tsdri_1), posedge SDRI1 , tsdrih_1, TimingViol_SDRI1_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tsdri_1) , negedge SDRI1 , tsdrih_1, TimingViol_SDRI1_CK1);


  $setup(posedge SCTRLI2, posedge CK2 &&& (Cond_sdf_tsctrli_2) , tsctrlis_2, TimingViol_SCTRLI2_CK2);
  $setup(negedge SCTRLI2, posedge CK2 &&& (Cond_sdf_tsctrli_2) , tsctrlis_2, TimingViol_SCTRLI2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tsctrli_2), posedge SCTRLI2 , tsctrlih_2, TimingViol_SCTRLI2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tsctrli_2) , negedge SCTRLI2 , tsctrlih_2, TimingViol_SCTRLI2_CK2);

  $setup(posedge SDLI2, posedge CK2 &&& (Cond_sdf_tsdli_2) , tsdlis_2, TimingViol_SDLI2_CK2);
  $setup(negedge SDLI2, posedge CK2 &&& (Cond_sdf_tsdli_2) , tsdlis_2, TimingViol_SDLI2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tsdli_2), posedge SDLI2 , tsdlih_2, TimingViol_SDLI2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tsdli_2) , negedge SDLI2 , tsdlih_2, TimingViol_SDLI2_CK2);

  $setup(posedge SDRI2, posedge CK2 &&& (Cond_sdf_tsdri_2) , tsdris_2, TimingViol_SDRI2_CK2);
  $setup(negedge SDRI2, posedge CK2 &&& (Cond_sdf_tsdri_2) , tsdris_2, TimingViol_SDRI2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tsdri_2), posedge SDRI2 , tsdrih_2, TimingViol_SDRI2_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tsdri_2) , negedge SDRI2 , tsdrih_2, TimingViol_SDRI2_CK2);




        





 
  $setup(posedge TBIST, posedge CK1 &&& (Cond_sdf_tbist_1)  , tbists_1, TimingViol_TBIST_CK1);
  $setup(negedge TBIST, posedge CK1 &&& (Cond_sdf_tbist_1), tbists_1, TimingViol_TBIST_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbist_1), posedge TBIST  , tbisth_1, TimingViol_TBIST_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tbist_1), negedge TBIST  , tbisth_1, TimingViol_TBIST_CK1);

  $setup(posedge TBIST, posedge CK2 &&& (Cond_sdf_tbist_2)  , tbists_2, TimingViol_TBIST_CK2);
  $setup(negedge TBIST, posedge CK2 &&& (Cond_sdf_tbist_2), tbists_2, TimingViol_TBIST_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbist_2), posedge TBIST  , tbisth_2, TimingViol_TBIST_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tbist_2), negedge TBIST  , tbisth_2, TimingViol_TBIST_CK2);

  $setup(posedge TBIST, posedge MTCK &&& (Cond_sdf_tbist_m) , tbists_m, TimingViol_TBIST_MTCK);
  $setup(negedge TBIST, posedge MTCK &&& (Cond_sdf_tbist_m) , tbists_m, TimingViol_TBIST_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbist_m) , posedge TBIST , tbisth_m, TimingViol_TBIST_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tbist_m) , negedge TBIST , tbisth_m, TimingViol_TBIST_MTCK);

 

  $setup(posedge ATP, posedge CK1 &&& (Cond_sdf_tatp_1)   , tatps_1, TimingViol_ATP_CK1);
  $setup(negedge ATP, posedge CK1 &&& (Cond_sdf_tatp_1) , tatps_1, TimingViol_ATP_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tatp_1), posedge ATP  , tatph_1, TimingViol_ATP_CK1);
  $hold(posedge CK1 &&& (Cond_sdf_tatp_1), negedge ATP  , tatph_1, TimingViol_ATP_CK1);

  $setup(posedge ATP, posedge CK2 &&& (Cond_sdf_tatp_2)   , tatps_2, TimingViol_ATP_CK2);
  $setup(negedge ATP, posedge CK2 &&& (Cond_sdf_tatp_2) , tatps_2, TimingViol_ATP_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tatp_2), posedge ATP  , tatph_2, TimingViol_ATP_CK2);
  $hold(posedge CK2 &&& (Cond_sdf_tatp_2), negedge ATP  , tatph_2, TimingViol_ATP_CK2);

  $setup(posedge ATP, posedge MTCK &&& (Cond_sdf_tatp_m)  , tatps_m, TimingViol_ATP_MTCK);
  $setup(negedge ATP, posedge MTCK &&& (Cond_sdf_tatp_m) , tatps_m, TimingViol_ATP_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tatp_m) , posedge ATP , tatph_m, TimingViol_ATP_MTCK);
  $hold(posedge MTCK &&& (Cond_sdf_tatp_m) , negedge ATP , tatph_m, TimingViol_ATP_MTCK);




            



//--period and width
//CK1
   $period(posedge CK1 &&& (Cond_sdf_tcycle_1) , tcycle_1, TimingViol_CYCLE_1);





   $width(posedge CK1  &&& (Cond_sdf_tck_1), tckh_1, 0, TimingViol_CKH_1);
   $width(negedge CK1  &&& (Cond_sdf_tck_1), tckl_1, 0, TimingViol_CKL_1); 

   $period(posedge CK1 &&& (Cond_sdf_tcycle_se_1) , tcycle_se_1, TimingViol_CYCLE_SE_1);
   $width(posedge CK1  &&& (Cond_sdf_tck_se_1), tckh_se_1, 0, TimingViol_CKH_SE_1);
   $width(negedge CK1  &&& (Cond_sdf_tck_se_1), tckl_se_1, 0, TimingViol_CKL_SE_1);
 
   $period(posedge CK1 &&& (Cond_sdf_tcycle_tp_1) , tcycle_tp_1, TimingViol_TCYCLE_TP_1);

//CK2 
   $period(posedge CK2 &&& (Cond_sdf_tcycle_2) , tcycle_2, TimingViol_CYCLE_2);





   $width(posedge CK2  &&& (Cond_sdf_tck_2), tckh_2, 0, TimingViol_CKH_2);
   $width(negedge CK2  &&& (Cond_sdf_tck_2), tckl_2, 0, TimingViol_CKL_2); 

   $period(posedge CK2 &&& (Cond_sdf_tcycle_se_2) , tcycle_se_2, TimingViol_CYCLE_SE_2);
   $width(posedge CK2  &&& (Cond_sdf_tck_se_2), tckh_se_2, 0, TimingViol_CKH_SE_2);
   $width(negedge CK2  &&& (Cond_sdf_tck_se_2), tckl_se_2, 0, TimingViol_CKL_SE_2);
 
   $period(posedge CK2 &&& (Cond_sdf_tcycle_tp_2) , tcycle_tp_2, TimingViol_TCYCLE_TP_2);
 
//MTCK

   $period(posedge MTCK &&& (Cond_sdf_tcycle_m) , tcycle_m, TimingViol_MTCKCYCLE);




   $width(posedge MTCK  &&& (Cond_sdf_tck_m), tckh_m, 0, TimingViol_MTCKH);
   $width(negedge MTCK  &&& (Cond_sdf_tck_m), tckl_m, 0, TimingViol_MTCKL);

   $period(posedge MTCK &&& (Cond_sdf_tcycle_tp_m) , tcycle_tp_m, TimingViol_MTCKCYCLE);

//--recovery

   $recovery(posedge CK1, posedge CK2 &&& (Cond_sdf_trec_ck1_ck2) , trec_ck1_ck2, TimingViol_CK1_CK2);
   $recovery(posedge CK2, posedge CK1 &&& (Cond_sdf_trec_ck2_ck1) , trec_ck2_ck1, TimingViol_CK2_CK1);


//***************************************************************************************************//
// Dummy removal arc in .v to support sdf backannotation, In actual design there is no such timing arc
//***************************************************************************************************//   

 
   $removal(posedge CK1, posedge CK2 &&& (Cond_sdf_trec_ck1_ck2), trem_ck1_ck2, TimingViol_dummy);
   $removal(posedge CK2, posedge CK1 &&& (Cond_sdf_trec_ck2_ck1), trem_ck2_ck1, TimingViol_dummy);



//--delays
//Q1
	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[0] +: OutReg1_data_tim[0])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[1] +: OutReg1_data_tim[1])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[2] +: OutReg1_data_tim[2])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[3] +: OutReg1_data_tim[3])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[4] +: OutReg1_data_tim[4])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[5] +: OutReg1_data_tim[5])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[6] +: OutReg1_data_tim[6])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[7] +: OutReg1_data_tim[7])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[8] +: OutReg1_data_tim[8])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[9] +: OutReg1_data_tim[9])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[10] +: OutReg1_data_tim[10])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[11] +: OutReg1_data_tim[11])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[12] +: OutReg1_data_tim[12])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[13] +: OutReg1_data_tim[13])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[14] +: OutReg1_data_tim[14])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[15] +: OutReg1_data_tim[15])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[16] +: OutReg1_data_tim[16])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[17] +: OutReg1_data_tim[17])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[18] +: OutReg1_data_tim[18])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[19] +: OutReg1_data_tim[19])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[20] +: OutReg1_data_tim[20])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[21] +: OutReg1_data_tim[21])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[22] +: OutReg1_data_tim[22])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[23] +: OutReg1_data_tim[23])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[24] +: OutReg1_data_tim[24])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[25] +: OutReg1_data_tim[25])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[26] +: OutReg1_data_tim[26])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[27] +: OutReg1_data_tim[27])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[28] +: OutReg1_data_tim[28])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[29] +: OutReg1_data_tim[29])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[30] +: OutReg1_data_tim[30])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);

	
        if (Cond_sdf_taa_1) 
           (posedge CK1 => (Q1[31] +: OutReg1_data_tim[31])) = (taa_1, taa_1, th_1, taa_1, th_1, taa_1);


	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[0] +: OutReg1_data_tim[0])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[1] +: OutReg1_data_tim[1])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[2] +: OutReg1_data_tim[2])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[3] +: OutReg1_data_tim[3])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[4] +: OutReg1_data_tim[4])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[5] +: OutReg1_data_tim[5])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[6] +: OutReg1_data_tim[6])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[7] +: OutReg1_data_tim[7])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[8] +: OutReg1_data_tim[8])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[9] +: OutReg1_data_tim[9])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[10] +: OutReg1_data_tim[10])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[11] +: OutReg1_data_tim[11])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[12] +: OutReg1_data_tim[12])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[13] +: OutReg1_data_tim[13])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[14] +: OutReg1_data_tim[14])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[15] +: OutReg1_data_tim[15])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[16] +: OutReg1_data_tim[16])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[17] +: OutReg1_data_tim[17])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[18] +: OutReg1_data_tim[18])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[19] +: OutReg1_data_tim[19])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[20] +: OutReg1_data_tim[20])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[21] +: OutReg1_data_tim[21])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[22] +: OutReg1_data_tim[22])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[23] +: OutReg1_data_tim[23])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[24] +: OutReg1_data_tim[24])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[25] +: OutReg1_data_tim[25])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[26] +: OutReg1_data_tim[26])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[27] +: OutReg1_data_tim[27])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[28] +: OutReg1_data_tim[28])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[29] +: OutReg1_data_tim[29])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[30] +: OutReg1_data_tim[30])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);

	
        if (Cond_sdf_taa_m_1) 
           (posedge MTCK => (Q1[31] +: OutReg1_data_tim[31])) = (taa_m_1, taa_m_1, th_m_1, taa_m_1, th_m_1, taa_m_1);


	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[0] +: OutReg1_data_tim[0])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[1] +: OutReg1_data_tim[1])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[2] +: OutReg1_data_tim[2])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[3] +: OutReg1_data_tim[3])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[4] +: OutReg1_data_tim[4])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[5] +: OutReg1_data_tim[5])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[6] +: OutReg1_data_tim[6])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[7] +: OutReg1_data_tim[7])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[8] +: OutReg1_data_tim[8])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[9] +: OutReg1_data_tim[9])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[10] +: OutReg1_data_tim[10])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[11] +: OutReg1_data_tim[11])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[12] +: OutReg1_data_tim[12])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[13] +: OutReg1_data_tim[13])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[14] +: OutReg1_data_tim[14])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[15] +: OutReg1_data_tim[15])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[16] +: OutReg1_data_tim[16])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[17] +: OutReg1_data_tim[17])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[18] +: OutReg1_data_tim[18])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[19] +: OutReg1_data_tim[19])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[20] +: OutReg1_data_tim[20])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[21] +: OutReg1_data_tim[21])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[22] +: OutReg1_data_tim[22])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[23] +: OutReg1_data_tim[23])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[24] +: OutReg1_data_tim[24])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[25] +: OutReg1_data_tim[25])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[26] +: OutReg1_data_tim[26])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[27] +: OutReg1_data_tim[27])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[28] +: OutReg1_data_tim[28])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[29] +: OutReg1_data_tim[29])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[30] +: OutReg1_data_tim[30])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);

	
        if (Cond_sdf_taa_tm_1) 
           (posedge CK1 => (Q1[31] +: OutReg1_data_tim[31])) = (taa_tm_1, taa_tm_1, th_tm_1, taa_tm_1, th_tm_1, taa_tm_1);


	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[0] +: OutReg1_data_tim[0])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[1] +: OutReg1_data_tim[1])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[2] +: OutReg1_data_tim[2])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[3] +: OutReg1_data_tim[3])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[4] +: OutReg1_data_tim[4])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[5] +: OutReg1_data_tim[5])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[6] +: OutReg1_data_tim[6])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[7] +: OutReg1_data_tim[7])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[8] +: OutReg1_data_tim[8])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[9] +: OutReg1_data_tim[9])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[10] +: OutReg1_data_tim[10])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[11] +: OutReg1_data_tim[11])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[12] +: OutReg1_data_tim[12])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[13] +: OutReg1_data_tim[13])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[14] +: OutReg1_data_tim[14])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[15] +: OutReg1_data_tim[15])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[16] +: OutReg1_data_tim[16])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[17] +: OutReg1_data_tim[17])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[18] +: OutReg1_data_tim[18])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[19] +: OutReg1_data_tim[19])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[20] +: OutReg1_data_tim[20])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[21] +: OutReg1_data_tim[21])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[22] +: OutReg1_data_tim[22])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[23] +: OutReg1_data_tim[23])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[24] +: OutReg1_data_tim[24])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[25] +: OutReg1_data_tim[25])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[26] +: OutReg1_data_tim[26])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[27] +: OutReg1_data_tim[27])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[28] +: OutReg1_data_tim[28])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[29] +: OutReg1_data_tim[29])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[30] +: OutReg1_data_tim[30])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);

	
        if (Cond_sdf_taa_tm_tp_1) 
           (posedge CK1 => (Q1[31] +: OutReg1_data_tim[31])) = (taa_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1, th_tm_tp_1, taa_tm_tp_1);



	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[0] +: OutReg1_data_tim[0])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[1] +: OutReg1_data_tim[1])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[2] +: OutReg1_data_tim[2])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[3] +: OutReg1_data_tim[3])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[4] +: OutReg1_data_tim[4])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[5] +: OutReg1_data_tim[5])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[6] +: OutReg1_data_tim[6])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[7] +: OutReg1_data_tim[7])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[8] +: OutReg1_data_tim[8])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[9] +: OutReg1_data_tim[9])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[10] +: OutReg1_data_tim[10])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[11] +: OutReg1_data_tim[11])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[12] +: OutReg1_data_tim[12])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[13] +: OutReg1_data_tim[13])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[14] +: OutReg1_data_tim[14])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[15] +: OutReg1_data_tim[15])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[16] +: OutReg1_data_tim[16])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[17] +: OutReg1_data_tim[17])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[18] +: OutReg1_data_tim[18])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[19] +: OutReg1_data_tim[19])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[20] +: OutReg1_data_tim[20])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[21] +: OutReg1_data_tim[21])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[22] +: OutReg1_data_tim[22])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[23] +: OutReg1_data_tim[23])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[24] +: OutReg1_data_tim[24])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[25] +: OutReg1_data_tim[25])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[26] +: OutReg1_data_tim[26])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[27] +: OutReg1_data_tim[27])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[28] +: OutReg1_data_tim[28])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[29] +: OutReg1_data_tim[29])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[30] +: OutReg1_data_tim[30])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);

	
        if (Cond_sdf_taa_tp_m_1) 
           (posedge MTCK => (Q1[31] +: OutReg1_data_tim[31])) = (taa_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1, th_tp_m_1, taa_tp_m_1);


	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[0] +: OutReg1_data_tim[0])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[1] +: OutReg1_data_tim[1])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[2] +: OutReg1_data_tim[2])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[3] +: OutReg1_data_tim[3])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[4] +: OutReg1_data_tim[4])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[5] +: OutReg1_data_tim[5])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[6] +: OutReg1_data_tim[6])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[7] +: OutReg1_data_tim[7])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[8] +: OutReg1_data_tim[8])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[9] +: OutReg1_data_tim[9])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[10] +: OutReg1_data_tim[10])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[11] +: OutReg1_data_tim[11])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[12] +: OutReg1_data_tim[12])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[13] +: OutReg1_data_tim[13])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[14] +: OutReg1_data_tim[14])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[15] +: OutReg1_data_tim[15])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[16] +: OutReg1_data_tim[16])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[17] +: OutReg1_data_tim[17])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[18] +: OutReg1_data_tim[18])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[19] +: OutReg1_data_tim[19])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[20] +: OutReg1_data_tim[20])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[21] +: OutReg1_data_tim[21])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[22] +: OutReg1_data_tim[22])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[23] +: OutReg1_data_tim[23])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[24] +: OutReg1_data_tim[24])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[25] +: OutReg1_data_tim[25])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[26] +: OutReg1_data_tim[26])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[27] +: OutReg1_data_tim[27])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[28] +: OutReg1_data_tim[28])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[29] +: OutReg1_data_tim[29])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[30] +: OutReg1_data_tim[30])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);

	
        if (Cond_sdf_taa_tp_1) 
           (posedge CK1 => (Q1[31] +: OutReg1_data_tim[31])) = (taa_tp_1, taa_tp_1, th_tp_1, taa_tp_1, th_tp_1, taa_tp_1);




	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[0] +: OutReg1_data_tim[0])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[1] +: OutReg1_data_tim[1])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[2] +: OutReg1_data_tim[2])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[3] +: OutReg1_data_tim[3])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[4] +: OutReg1_data_tim[4])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[5] +: OutReg1_data_tim[5])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[6] +: OutReg1_data_tim[6])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[7] +: OutReg1_data_tim[7])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[8] +: OutReg1_data_tim[8])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[9] +: OutReg1_data_tim[9])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[10] +: OutReg1_data_tim[10])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[11] +: OutReg1_data_tim[11])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[12] +: OutReg1_data_tim[12])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[13] +: OutReg1_data_tim[13])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[14] +: OutReg1_data_tim[14])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[15] +: OutReg1_data_tim[15])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[16] +: OutReg1_data_tim[16])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[17] +: OutReg1_data_tim[17])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[18] +: OutReg1_data_tim[18])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[19] +: OutReg1_data_tim[19])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[20] +: OutReg1_data_tim[20])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[21] +: OutReg1_data_tim[21])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[22] +: OutReg1_data_tim[22])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[23] +: OutReg1_data_tim[23])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[24] +: OutReg1_data_tim[24])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[25] +: OutReg1_data_tim[25])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[26] +: OutReg1_data_tim[26])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[27] +: OutReg1_data_tim[27])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[28] +: OutReg1_data_tim[28])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[29] +: OutReg1_data_tim[29])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[30] +: OutReg1_data_tim[30])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);

	
        if (Cond_sdf_taa_tckq_tm_1) 
           (negedge CK1 => (Q1[31] +: OutReg1_data_tim[31])) = (taa_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1, th_tckq_tm_1, taa_tckq_tm_1);


	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[0] +: OutReg1_data_tim[0])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[1] +: OutReg1_data_tim[1])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[2] +: OutReg1_data_tim[2])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[3] +: OutReg1_data_tim[3])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[4] +: OutReg1_data_tim[4])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[5] +: OutReg1_data_tim[5])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[6] +: OutReg1_data_tim[6])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[7] +: OutReg1_data_tim[7])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[8] +: OutReg1_data_tim[8])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[9] +: OutReg1_data_tim[9])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[10] +: OutReg1_data_tim[10])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[11] +: OutReg1_data_tim[11])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[12] +: OutReg1_data_tim[12])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[13] +: OutReg1_data_tim[13])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[14] +: OutReg1_data_tim[14])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[15] +: OutReg1_data_tim[15])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[16] +: OutReg1_data_tim[16])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[17] +: OutReg1_data_tim[17])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[18] +: OutReg1_data_tim[18])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[19] +: OutReg1_data_tim[19])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[20] +: OutReg1_data_tim[20])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[21] +: OutReg1_data_tim[21])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[22] +: OutReg1_data_tim[22])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[23] +: OutReg1_data_tim[23])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[24] +: OutReg1_data_tim[24])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[25] +: OutReg1_data_tim[25])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[26] +: OutReg1_data_tim[26])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[27] +: OutReg1_data_tim[27])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[28] +: OutReg1_data_tim[28])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[29] +: OutReg1_data_tim[29])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[30] +: OutReg1_data_tim[30])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);

	
        if (Cond_sdf_taa_tseq_tm_1) 
           (negedge SE => (Q1[31] +: OutReg1_data_tim[31])) = (taa_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1, th_tseq_tm_1, taa_tseq_tm_1);


//Q2

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[0] +: OutReg2_data_tim[0])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[1] +: OutReg2_data_tim[1])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[2] +: OutReg2_data_tim[2])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[3] +: OutReg2_data_tim[3])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[4] +: OutReg2_data_tim[4])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[5] +: OutReg2_data_tim[5])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[6] +: OutReg2_data_tim[6])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[7] +: OutReg2_data_tim[7])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[8] +: OutReg2_data_tim[8])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[9] +: OutReg2_data_tim[9])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[10] +: OutReg2_data_tim[10])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[11] +: OutReg2_data_tim[11])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[12] +: OutReg2_data_tim[12])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[13] +: OutReg2_data_tim[13])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[14] +: OutReg2_data_tim[14])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[15] +: OutReg2_data_tim[15])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[16] +: OutReg2_data_tim[16])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[17] +: OutReg2_data_tim[17])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[18] +: OutReg2_data_tim[18])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[19] +: OutReg2_data_tim[19])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[20] +: OutReg2_data_tim[20])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[21] +: OutReg2_data_tim[21])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[22] +: OutReg2_data_tim[22])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[23] +: OutReg2_data_tim[23])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[24] +: OutReg2_data_tim[24])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[25] +: OutReg2_data_tim[25])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[26] +: OutReg2_data_tim[26])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[27] +: OutReg2_data_tim[27])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[28] +: OutReg2_data_tim[28])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[29] +: OutReg2_data_tim[29])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[30] +: OutReg2_data_tim[30])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);

	
        if (Cond_sdf_taa_2) 
           (posedge CK2 => (Q2[31] +: OutReg2_data_tim[31])) = (taa_2, taa_2, th_2, taa_2, th_2, taa_2);


	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[0] +: OutReg2_data_tim[0])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[1] +: OutReg2_data_tim[1])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[2] +: OutReg2_data_tim[2])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[3] +: OutReg2_data_tim[3])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[4] +: OutReg2_data_tim[4])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[5] +: OutReg2_data_tim[5])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[6] +: OutReg2_data_tim[6])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[7] +: OutReg2_data_tim[7])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[8] +: OutReg2_data_tim[8])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[9] +: OutReg2_data_tim[9])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[10] +: OutReg2_data_tim[10])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[11] +: OutReg2_data_tim[11])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[12] +: OutReg2_data_tim[12])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[13] +: OutReg2_data_tim[13])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[14] +: OutReg2_data_tim[14])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[15] +: OutReg2_data_tim[15])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[16] +: OutReg2_data_tim[16])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[17] +: OutReg2_data_tim[17])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[18] +: OutReg2_data_tim[18])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[19] +: OutReg2_data_tim[19])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[20] +: OutReg2_data_tim[20])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[21] +: OutReg2_data_tim[21])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[22] +: OutReg2_data_tim[22])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[23] +: OutReg2_data_tim[23])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[24] +: OutReg2_data_tim[24])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[25] +: OutReg2_data_tim[25])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[26] +: OutReg2_data_tim[26])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[27] +: OutReg2_data_tim[27])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[28] +: OutReg2_data_tim[28])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[29] +: OutReg2_data_tim[29])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[30] +: OutReg2_data_tim[30])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);

	
        if (Cond_sdf_taa_m_2) 
           (posedge MTCK => (Q2[31] +: OutReg2_data_tim[31])) = (taa_m_2, taa_m_2, th_m_2, taa_m_2, th_m_2, taa_m_2);


	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[0] +: OutReg2_data_tim[0])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[1] +: OutReg2_data_tim[1])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[2] +: OutReg2_data_tim[2])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[3] +: OutReg2_data_tim[3])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[4] +: OutReg2_data_tim[4])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[5] +: OutReg2_data_tim[5])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[6] +: OutReg2_data_tim[6])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[7] +: OutReg2_data_tim[7])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[8] +: OutReg2_data_tim[8])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[9] +: OutReg2_data_tim[9])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[10] +: OutReg2_data_tim[10])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[11] +: OutReg2_data_tim[11])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[12] +: OutReg2_data_tim[12])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[13] +: OutReg2_data_tim[13])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[14] +: OutReg2_data_tim[14])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[15] +: OutReg2_data_tim[15])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[16] +: OutReg2_data_tim[16])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[17] +: OutReg2_data_tim[17])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[18] +: OutReg2_data_tim[18])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[19] +: OutReg2_data_tim[19])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[20] +: OutReg2_data_tim[20])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[21] +: OutReg2_data_tim[21])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[22] +: OutReg2_data_tim[22])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[23] +: OutReg2_data_tim[23])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[24] +: OutReg2_data_tim[24])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[25] +: OutReg2_data_tim[25])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[26] +: OutReg2_data_tim[26])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[27] +: OutReg2_data_tim[27])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[28] +: OutReg2_data_tim[28])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[29] +: OutReg2_data_tim[29])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[30] +: OutReg2_data_tim[30])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);

	
        if (Cond_sdf_taa_tm_2) 
           (posedge CK2 => (Q2[31] +: OutReg2_data_tim[31])) = (taa_tm_2, taa_tm_2, th_tm_2, taa_tm_2, th_tm_2, taa_tm_2);


	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[0] +: OutReg2_data_tim[0])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[1] +: OutReg2_data_tim[1])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[2] +: OutReg2_data_tim[2])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[3] +: OutReg2_data_tim[3])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[4] +: OutReg2_data_tim[4])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[5] +: OutReg2_data_tim[5])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[6] +: OutReg2_data_tim[6])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[7] +: OutReg2_data_tim[7])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[8] +: OutReg2_data_tim[8])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[9] +: OutReg2_data_tim[9])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[10] +: OutReg2_data_tim[10])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[11] +: OutReg2_data_tim[11])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[12] +: OutReg2_data_tim[12])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[13] +: OutReg2_data_tim[13])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[14] +: OutReg2_data_tim[14])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[15] +: OutReg2_data_tim[15])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[16] +: OutReg2_data_tim[16])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[17] +: OutReg2_data_tim[17])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[18] +: OutReg2_data_tim[18])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[19] +: OutReg2_data_tim[19])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[20] +: OutReg2_data_tim[20])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[21] +: OutReg2_data_tim[21])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[22] +: OutReg2_data_tim[22])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[23] +: OutReg2_data_tim[23])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[24] +: OutReg2_data_tim[24])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[25] +: OutReg2_data_tim[25])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[26] +: OutReg2_data_tim[26])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[27] +: OutReg2_data_tim[27])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[28] +: OutReg2_data_tim[28])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[29] +: OutReg2_data_tim[29])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[30] +: OutReg2_data_tim[30])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);

	
        if (Cond_sdf_taa_tm_tp_2) 
           (posedge CK2 => (Q2[31] +: OutReg2_data_tim[31])) = (taa_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2, th_tm_tp_2, taa_tm_tp_2);




	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[0] +: OutReg2_data_tim[0])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[1] +: OutReg2_data_tim[1])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[2] +: OutReg2_data_tim[2])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[3] +: OutReg2_data_tim[3])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[4] +: OutReg2_data_tim[4])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[5] +: OutReg2_data_tim[5])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[6] +: OutReg2_data_tim[6])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[7] +: OutReg2_data_tim[7])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[8] +: OutReg2_data_tim[8])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[9] +: OutReg2_data_tim[9])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[10] +: OutReg2_data_tim[10])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[11] +: OutReg2_data_tim[11])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[12] +: OutReg2_data_tim[12])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[13] +: OutReg2_data_tim[13])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[14] +: OutReg2_data_tim[14])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[15] +: OutReg2_data_tim[15])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[16] +: OutReg2_data_tim[16])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[17] +: OutReg2_data_tim[17])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[18] +: OutReg2_data_tim[18])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[19] +: OutReg2_data_tim[19])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[20] +: OutReg2_data_tim[20])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[21] +: OutReg2_data_tim[21])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[22] +: OutReg2_data_tim[22])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[23] +: OutReg2_data_tim[23])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[24] +: OutReg2_data_tim[24])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[25] +: OutReg2_data_tim[25])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[26] +: OutReg2_data_tim[26])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[27] +: OutReg2_data_tim[27])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[28] +: OutReg2_data_tim[28])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[29] +: OutReg2_data_tim[29])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[30] +: OutReg2_data_tim[30])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);

	
        if (Cond_sdf_taa_tp_m_2) 
           (posedge MTCK => (Q2[31] +: OutReg2_data_tim[31])) = (taa_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2, th_tp_m_2, taa_tp_m_2);


	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[0] +: OutReg2_data_tim[0])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[1] +: OutReg2_data_tim[1])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[2] +: OutReg2_data_tim[2])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[3] +: OutReg2_data_tim[3])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[4] +: OutReg2_data_tim[4])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[5] +: OutReg2_data_tim[5])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[6] +: OutReg2_data_tim[6])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[7] +: OutReg2_data_tim[7])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[8] +: OutReg2_data_tim[8])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[9] +: OutReg2_data_tim[9])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[10] +: OutReg2_data_tim[10])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[11] +: OutReg2_data_tim[11])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[12] +: OutReg2_data_tim[12])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[13] +: OutReg2_data_tim[13])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[14] +: OutReg2_data_tim[14])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[15] +: OutReg2_data_tim[15])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[16] +: OutReg2_data_tim[16])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[17] +: OutReg2_data_tim[17])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[18] +: OutReg2_data_tim[18])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[19] +: OutReg2_data_tim[19])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[20] +: OutReg2_data_tim[20])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[21] +: OutReg2_data_tim[21])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[22] +: OutReg2_data_tim[22])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[23] +: OutReg2_data_tim[23])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[24] +: OutReg2_data_tim[24])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[25] +: OutReg2_data_tim[25])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[26] +: OutReg2_data_tim[26])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[27] +: OutReg2_data_tim[27])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[28] +: OutReg2_data_tim[28])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[29] +: OutReg2_data_tim[29])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[30] +: OutReg2_data_tim[30])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);

	
        if (Cond_sdf_taa_tp_2) 
           (posedge CK2 => (Q2[31] +: OutReg2_data_tim[31])) = (taa_tp_2, taa_tp_2, th_tp_2, taa_tp_2, th_tp_2, taa_tp_2);




	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[0] +: OutReg2_data_tim[0])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[1] +: OutReg2_data_tim[1])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[2] +: OutReg2_data_tim[2])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[3] +: OutReg2_data_tim[3])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[4] +: OutReg2_data_tim[4])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[5] +: OutReg2_data_tim[5])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[6] +: OutReg2_data_tim[6])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[7] +: OutReg2_data_tim[7])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[8] +: OutReg2_data_tim[8])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[9] +: OutReg2_data_tim[9])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[10] +: OutReg2_data_tim[10])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[11] +: OutReg2_data_tim[11])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[12] +: OutReg2_data_tim[12])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[13] +: OutReg2_data_tim[13])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[14] +: OutReg2_data_tim[14])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[15] +: OutReg2_data_tim[15])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[16] +: OutReg2_data_tim[16])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[17] +: OutReg2_data_tim[17])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[18] +: OutReg2_data_tim[18])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[19] +: OutReg2_data_tim[19])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[20] +: OutReg2_data_tim[20])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[21] +: OutReg2_data_tim[21])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[22] +: OutReg2_data_tim[22])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[23] +: OutReg2_data_tim[23])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[24] +: OutReg2_data_tim[24])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[25] +: OutReg2_data_tim[25])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[26] +: OutReg2_data_tim[26])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[27] +: OutReg2_data_tim[27])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[28] +: OutReg2_data_tim[28])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[29] +: OutReg2_data_tim[29])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[30] +: OutReg2_data_tim[30])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);

	
        if (Cond_sdf_taa_tckq_tm_2) 
           (negedge CK2 => (Q2[31] +: OutReg2_data_tim[31])) = (taa_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2, th_tckq_tm_2, taa_tckq_tm_2);


	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[0] +: OutReg2_data_tim[0])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[1] +: OutReg2_data_tim[1])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[2] +: OutReg2_data_tim[2])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[3] +: OutReg2_data_tim[3])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[4] +: OutReg2_data_tim[4])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[5] +: OutReg2_data_tim[5])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[6] +: OutReg2_data_tim[6])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[7] +: OutReg2_data_tim[7])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[8] +: OutReg2_data_tim[8])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[9] +: OutReg2_data_tim[9])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[10] +: OutReg2_data_tim[10])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[11] +: OutReg2_data_tim[11])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[12] +: OutReg2_data_tim[12])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[13] +: OutReg2_data_tim[13])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[14] +: OutReg2_data_tim[14])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[15] +: OutReg2_data_tim[15])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[16] +: OutReg2_data_tim[16])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[17] +: OutReg2_data_tim[17])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[18] +: OutReg2_data_tim[18])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[19] +: OutReg2_data_tim[19])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[20] +: OutReg2_data_tim[20])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[21] +: OutReg2_data_tim[21])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[22] +: OutReg2_data_tim[22])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[23] +: OutReg2_data_tim[23])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[24] +: OutReg2_data_tim[24])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[25] +: OutReg2_data_tim[25])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[26] +: OutReg2_data_tim[26])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[27] +: OutReg2_data_tim[27])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[28] +: OutReg2_data_tim[28])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[29] +: OutReg2_data_tim[29])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[30] +: OutReg2_data_tim[30])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (negedge SE => (Q2[31] +: OutReg2_data_tim[31])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);


	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[0] +: OutReg2_data_tim[0])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[1] +: OutReg2_data_tim[1])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[2] +: OutReg2_data_tim[2])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[3] +: OutReg2_data_tim[3])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[4] +: OutReg2_data_tim[4])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[5] +: OutReg2_data_tim[5])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[6] +: OutReg2_data_tim[6])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[7] +: OutReg2_data_tim[7])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[8] +: OutReg2_data_tim[8])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[9] +: OutReg2_data_tim[9])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[10] +: OutReg2_data_tim[10])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[11] +: OutReg2_data_tim[11])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[12] +: OutReg2_data_tim[12])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[13] +: OutReg2_data_tim[13])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[14] +: OutReg2_data_tim[14])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[15] +: OutReg2_data_tim[15])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[16] +: OutReg2_data_tim[16])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[17] +: OutReg2_data_tim[17])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[18] +: OutReg2_data_tim[18])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[19] +: OutReg2_data_tim[19])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[20] +: OutReg2_data_tim[20])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[21] +: OutReg2_data_tim[21])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[22] +: OutReg2_data_tim[22])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[23] +: OutReg2_data_tim[23])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[24] +: OutReg2_data_tim[24])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[25] +: OutReg2_data_tim[25])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[26] +: OutReg2_data_tim[26])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[27] +: OutReg2_data_tim[27])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[28] +: OutReg2_data_tim[28])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[29] +: OutReg2_data_tim[29])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[30] +: OutReg2_data_tim[30])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);

	
        if (Cond_sdf_taa_tseq_tm_2) 
           (posedge SE => (Q2[31] +: OutReg2_data_tim[31])) = (taa_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2, th_tseq_tm_2, taa_tseq_tm_2);








if (Cond_sdf_taa_sctrlo_1) 
    (posedge CK1 *> (SCTRLO1 :  SCTRLI1)) = (taa_sctrlo_1,taa_sctrlo_1,th_sctrlo_1,taa_sctrlo_1,th_sctrlo_1,taa_sctrlo_1); 

if (Cond_sdf_taa_sctrlo_se_1) 
     (negedge CK1 *> (SCTRLO1 : SCTRLI1)) = (taa_sctrlo_se_1,taa_sctrlo_se_1,th_sctrlo_se_1,taa_sctrlo_se_1,th_sctrlo_se_1,taa_sctrlo_se_1);



if (Cond_sdf_taa_sdlo_1) 
    (posedge CK1 *> (SDLO1 :  SDLI1)) = (taa_sdlo_1,taa_sdlo_1,th_sdlo_1,taa_sdlo_1,th_sdlo_1,taa_sdlo_1); 

if (Cond_sdf_taa_sdlo_se_1) 
     (negedge CK1 *> (SDLO1 : SDLI1)) = (taa_sdlo_se_1,taa_sdlo_se_1,th_sdlo_se_1,taa_sdlo_se_1,th_sdlo_se_1,taa_sdlo_se_1);   

if (Cond_sdf_taa_sdro_1) 
    (posedge CK1 *> (SDRO1 :  SDRI1)) = (taa_sdro_1,taa_sdro_1,th_sdro_1,taa_sdro_1,th_sdro_1,taa_sdro_1); 

if (Cond_sdf_taa_sdro_se_1) 
     (negedge CK1 *> (SDRO1 : SDRI1)) = (taa_sdro_se_1,taa_sdro_se_1,th_sdro_se_1,taa_sdro_se_1,th_sdro_se_1,taa_sdro_se_1);


        

//CK2

if (Cond_sdf_taa_sctrlo_2) 
    (posedge CK2 *> (SCTRLO2 :  SCTRLI2)) = (taa_sctrlo_2,taa_sctrlo_2,th_sctrlo_2,taa_sctrlo_2,th_sctrlo_2,taa_sctrlo_2); 

if (Cond_sdf_taa_sctrlo_se_2) 
     (negedge CK2 *> (SCTRLO2 : SCTRLI2)) = (taa_sctrlo_se_2,taa_sctrlo_se_2,th_sctrlo_se_2,taa_sctrlo_se_2,th_sctrlo_se_2,taa_sctrlo_se_2);

if (Cond_sdf_taa_sdlo_2) 
    (posedge CK2 *> (SDLO2 :  SDLI2)) = (taa_sdlo_2,taa_sdlo_2,th_sdlo_2,taa_sdlo_2,th_sdlo_2,taa_sdlo_2); 

if (Cond_sdf_taa_sdlo_se_2) 
     (negedge CK2 *> (SDLO2 : SDLI2)) = (taa_sdlo_se_2,taa_sdlo_se_2,th_sdlo_se_2,taa_sdlo_se_2,th_sdlo_se_2,taa_sdlo_se_2);   

if (Cond_sdf_taa_sdro_2) 
    (posedge CK2 *> (SDRO2 :  SDRI2)) = (taa_sdro_2,taa_sdro_2,th_sdro_2,taa_sdro_2,th_sdro_2,taa_sdro_2); 

if (Cond_sdf_taa_sdro_se_2) 
     (negedge CK2 *> (SDRO2 : SDRI2)) = (taa_sdro_se_2,taa_sdro_se_2,th_sdro_se_2,taa_sdro_se_2,th_sdro_se_2,taa_sdro_se_2);


        






//


endspecify //specify block ends

//--------------

task WriteLocMskX_bwise;
   input [Addr-1 : 0] Address;
   input [Bits-1 : 0] Mask;

reg [Bits -1 :0] tempReg1;
integer num1,j;
reg [Bits -1 :0] Mask_inv_int;


reg [Addr-mux_bits-1:0]Row_Add;
reg [Addr-mux_bits-bank_bits-1:0] Row_Add_cmp;


reg [mux_bits-1:0]Col_Add;
reg [Bits - 1 : 0 ] tempReg;
integer po,n,Col_Add_integer,Bank_sel_integer,RedMem_address;
reg repair_flag;


begin

//---
  Mask_inv_int = ~ Mask;
  repair_flag = 1'b0;
  Row_Add = Address[Addr-1: mux_bits];
  Row_Add_cmp = {Row_Add[Addr-mux_bits-1:3+bank_bits],Row_Add[2:0]};

  Col_Add = Address[mux_bits-1:0]; 

 if (red_en1 === 1 && ((Row_Add_cmp === repair_add) || (Row_Add_cmp === next_repair_add && next_repair_add !== 0)) ) begin
  
    repair_flag = 1'b1;


    Bank_sel_integer = 0 ; 

    if (Row_Add_cmp === repair_add) begin
            
      Col_Add_integer  = Col_Add; 
    end
    else if (Row_Add_cmp === next_repair_add) begin
            
      Col_Add_integer  = Col_Add + mux; 
    end  
    RedMem_address = ( (no_of_red_rows_in_a_bank*Bank_sel_integer*mux) + Col_Add_integer );
  end 
       
  if (^Address !== X ) begin

    if (repair_flag === 1'b0) begin
      `ifdef ST_MEM_SLM
        $slm_ReadMemory(slm_handle, Address, tempReg1);
      `else
         tempReg1 = Mem[Address];
      `endif
             
         for (j = 0;j< Bits; j=j+1) begin
         num1=j;
          if (Mask[j] === 1'bx)
            tempReg1[num1] = 1'bx;
          end
      `ifdef ST_MEM_SLM
          $slm_WriteMemory(slm_handle, Address, tempReg1, Mask_inv_int);
      `else
      Mem[Address] = tempReg1;
      `endif
      task_insert_faults_in_memory;
   end   
   else if (repair_flag === 1'b1) begin
     `ifdef ST_MEM_SLM
     `else
       tempReg1 = RedMem[RedMem_address];
             
         for (j = 0;j< Bits; j=j+1) begin
         num1=j;
          if (Mask[j] === 1'bx)
            tempReg1[num1] = 1'bx;
          end
      RedMem[RedMem_address] = tempReg1;
     `endif
      task_insert_faults_in_memory;
   end

 end //valid add        
end
endtask


//---------------Actions taken on timing violations---------//
//always @ timing_violation blocks


always @(TimingViol_D1_CK1_0)
begin
   TimingViol_D1[0] = ~TimingViol_D1[0];
end


always @(TimingViol_D1_CK1_1)
begin
   TimingViol_D1[1] = ~TimingViol_D1[1];
end


always @(TimingViol_D1_CK1_2)
begin
   TimingViol_D1[2] = ~TimingViol_D1[2];
end


always @(TimingViol_D1_CK1_3)
begin
   TimingViol_D1[3] = ~TimingViol_D1[3];
end


always @(TimingViol_D1_CK1_4)
begin
   TimingViol_D1[4] = ~TimingViol_D1[4];
end


always @(TimingViol_D1_CK1_5)
begin
   TimingViol_D1[5] = ~TimingViol_D1[5];
end


always @(TimingViol_D1_CK1_6)
begin
   TimingViol_D1[6] = ~TimingViol_D1[6];
end


always @(TimingViol_D1_CK1_7)
begin
   TimingViol_D1[7] = ~TimingViol_D1[7];
end


always @(TimingViol_D1_CK1_8)
begin
   TimingViol_D1[8] = ~TimingViol_D1[8];
end


always @(TimingViol_D1_CK1_9)
begin
   TimingViol_D1[9] = ~TimingViol_D1[9];
end


always @(TimingViol_D1_CK1_10)
begin
   TimingViol_D1[10] = ~TimingViol_D1[10];
end


always @(TimingViol_D1_CK1_11)
begin
   TimingViol_D1[11] = ~TimingViol_D1[11];
end


always @(TimingViol_D1_CK1_12)
begin
   TimingViol_D1[12] = ~TimingViol_D1[12];
end


always @(TimingViol_D1_CK1_13)
begin
   TimingViol_D1[13] = ~TimingViol_D1[13];
end


always @(TimingViol_D1_CK1_14)
begin
   TimingViol_D1[14] = ~TimingViol_D1[14];
end


always @(TimingViol_D1_CK1_15)
begin
   TimingViol_D1[15] = ~TimingViol_D1[15];
end


always @(TimingViol_D1_CK1_16)
begin
   TimingViol_D1[16] = ~TimingViol_D1[16];
end


always @(TimingViol_D1_CK1_17)
begin
   TimingViol_D1[17] = ~TimingViol_D1[17];
end


always @(TimingViol_D1_CK1_18)
begin
   TimingViol_D1[18] = ~TimingViol_D1[18];
end


always @(TimingViol_D1_CK1_19)
begin
   TimingViol_D1[19] = ~TimingViol_D1[19];
end


always @(TimingViol_D1_CK1_20)
begin
   TimingViol_D1[20] = ~TimingViol_D1[20];
end


always @(TimingViol_D1_CK1_21)
begin
   TimingViol_D1[21] = ~TimingViol_D1[21];
end


always @(TimingViol_D1_CK1_22)
begin
   TimingViol_D1[22] = ~TimingViol_D1[22];
end


always @(TimingViol_D1_CK1_23)
begin
   TimingViol_D1[23] = ~TimingViol_D1[23];
end


always @(TimingViol_D1_CK1_24)
begin
   TimingViol_D1[24] = ~TimingViol_D1[24];
end


always @(TimingViol_D1_CK1_25)
begin
   TimingViol_D1[25] = ~TimingViol_D1[25];
end


always @(TimingViol_D1_CK1_26)
begin
   TimingViol_D1[26] = ~TimingViol_D1[26];
end


always @(TimingViol_D1_CK1_27)
begin
   TimingViol_D1[27] = ~TimingViol_D1[27];
end


always @(TimingViol_D1_CK1_28)
begin
   TimingViol_D1[28] = ~TimingViol_D1[28];
end


always @(TimingViol_D1_CK1_29)
begin
   TimingViol_D1[29] = ~TimingViol_D1[29];
end


always @(TimingViol_D1_CK1_30)
begin
   TimingViol_D1[30] = ~TimingViol_D1[30];
end


always @(TimingViol_D1_CK1_31)
begin
   TimingViol_D1[31] = ~TimingViol_D1[31];
end



always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[0] = ~TimingViol_D1_MTCK[0];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[1] = ~TimingViol_D1_MTCK[1];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[2] = ~TimingViol_D1_MTCK[2];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[3] = ~TimingViol_D1_MTCK[3];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[4] = ~TimingViol_D1_MTCK[4];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[5] = ~TimingViol_D1_MTCK[5];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[6] = ~TimingViol_D1_MTCK[6];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[7] = ~TimingViol_D1_MTCK[7];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[8] = ~TimingViol_D1_MTCK[8];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[9] = ~TimingViol_D1_MTCK[9];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[10] = ~TimingViol_D1_MTCK[10];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[11] = ~TimingViol_D1_MTCK[11];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[12] = ~TimingViol_D1_MTCK[12];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[13] = ~TimingViol_D1_MTCK[13];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[14] = ~TimingViol_D1_MTCK[14];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[15] = ~TimingViol_D1_MTCK[15];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[16] = ~TimingViol_D1_MTCK[16];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[17] = ~TimingViol_D1_MTCK[17];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[18] = ~TimingViol_D1_MTCK[18];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[19] = ~TimingViol_D1_MTCK[19];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[20] = ~TimingViol_D1_MTCK[20];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[21] = ~TimingViol_D1_MTCK[21];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[22] = ~TimingViol_D1_MTCK[22];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[23] = ~TimingViol_D1_MTCK[23];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[24] = ~TimingViol_D1_MTCK[24];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[25] = ~TimingViol_D1_MTCK[25];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[26] = ~TimingViol_D1_MTCK[26];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[27] = ~TimingViol_D1_MTCK[27];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[28] = ~TimingViol_D1_MTCK[28];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[29] = ~TimingViol_D1_MTCK[29];
end


always @( TimingViol_TED1_MTCK  )
begin
   TimingViol_D1_MTCK[30] = ~TimingViol_D1_MTCK[30];
end


always @( TimingViol_TOD1_MTCK  )
begin
   TimingViol_D1_MTCK[31] = ~TimingViol_D1_MTCK[31];
end



always @(TimingViol_D2_CK2_0)
begin
   TimingViol_D2[0] = ~TimingViol_D2[0];
end


always @(TimingViol_D2_CK2_1)
begin
   TimingViol_D2[1] = ~TimingViol_D2[1];
end


always @(TimingViol_D2_CK2_2)
begin
   TimingViol_D2[2] = ~TimingViol_D2[2];
end


always @(TimingViol_D2_CK2_3)
begin
   TimingViol_D2[3] = ~TimingViol_D2[3];
end


always @(TimingViol_D2_CK2_4)
begin
   TimingViol_D2[4] = ~TimingViol_D2[4];
end


always @(TimingViol_D2_CK2_5)
begin
   TimingViol_D2[5] = ~TimingViol_D2[5];
end


always @(TimingViol_D2_CK2_6)
begin
   TimingViol_D2[6] = ~TimingViol_D2[6];
end


always @(TimingViol_D2_CK2_7)
begin
   TimingViol_D2[7] = ~TimingViol_D2[7];
end


always @(TimingViol_D2_CK2_8)
begin
   TimingViol_D2[8] = ~TimingViol_D2[8];
end


always @(TimingViol_D2_CK2_9)
begin
   TimingViol_D2[9] = ~TimingViol_D2[9];
end


always @(TimingViol_D2_CK2_10)
begin
   TimingViol_D2[10] = ~TimingViol_D2[10];
end


always @(TimingViol_D2_CK2_11)
begin
   TimingViol_D2[11] = ~TimingViol_D2[11];
end


always @(TimingViol_D2_CK2_12)
begin
   TimingViol_D2[12] = ~TimingViol_D2[12];
end


always @(TimingViol_D2_CK2_13)
begin
   TimingViol_D2[13] = ~TimingViol_D2[13];
end


always @(TimingViol_D2_CK2_14)
begin
   TimingViol_D2[14] = ~TimingViol_D2[14];
end


always @(TimingViol_D2_CK2_15)
begin
   TimingViol_D2[15] = ~TimingViol_D2[15];
end


always @(TimingViol_D2_CK2_16)
begin
   TimingViol_D2[16] = ~TimingViol_D2[16];
end


always @(TimingViol_D2_CK2_17)
begin
   TimingViol_D2[17] = ~TimingViol_D2[17];
end


always @(TimingViol_D2_CK2_18)
begin
   TimingViol_D2[18] = ~TimingViol_D2[18];
end


always @(TimingViol_D2_CK2_19)
begin
   TimingViol_D2[19] = ~TimingViol_D2[19];
end


always @(TimingViol_D2_CK2_20)
begin
   TimingViol_D2[20] = ~TimingViol_D2[20];
end


always @(TimingViol_D2_CK2_21)
begin
   TimingViol_D2[21] = ~TimingViol_D2[21];
end


always @(TimingViol_D2_CK2_22)
begin
   TimingViol_D2[22] = ~TimingViol_D2[22];
end


always @(TimingViol_D2_CK2_23)
begin
   TimingViol_D2[23] = ~TimingViol_D2[23];
end


always @(TimingViol_D2_CK2_24)
begin
   TimingViol_D2[24] = ~TimingViol_D2[24];
end


always @(TimingViol_D2_CK2_25)
begin
   TimingViol_D2[25] = ~TimingViol_D2[25];
end


always @(TimingViol_D2_CK2_26)
begin
   TimingViol_D2[26] = ~TimingViol_D2[26];
end


always @(TimingViol_D2_CK2_27)
begin
   TimingViol_D2[27] = ~TimingViol_D2[27];
end


always @(TimingViol_D2_CK2_28)
begin
   TimingViol_D2[28] = ~TimingViol_D2[28];
end


always @(TimingViol_D2_CK2_29)
begin
   TimingViol_D2[29] = ~TimingViol_D2[29];
end


always @(TimingViol_D2_CK2_30)
begin
   TimingViol_D2[30] = ~TimingViol_D2[30];
end


always @(TimingViol_D2_CK2_31)
begin
   TimingViol_D2[31] = ~TimingViol_D2[31];
end



always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[0] = ~TimingViol_D2_MTCK[0];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[1] = ~TimingViol_D2_MTCK[1];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[2] = ~TimingViol_D2_MTCK[2];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[3] = ~TimingViol_D2_MTCK[3];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[4] = ~TimingViol_D2_MTCK[4];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[5] = ~TimingViol_D2_MTCK[5];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[6] = ~TimingViol_D2_MTCK[6];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[7] = ~TimingViol_D2_MTCK[7];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[8] = ~TimingViol_D2_MTCK[8];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[9] = ~TimingViol_D2_MTCK[9];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[10] = ~TimingViol_D2_MTCK[10];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[11] = ~TimingViol_D2_MTCK[11];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[12] = ~TimingViol_D2_MTCK[12];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[13] = ~TimingViol_D2_MTCK[13];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[14] = ~TimingViol_D2_MTCK[14];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[15] = ~TimingViol_D2_MTCK[15];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[16] = ~TimingViol_D2_MTCK[16];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[17] = ~TimingViol_D2_MTCK[17];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[18] = ~TimingViol_D2_MTCK[18];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[19] = ~TimingViol_D2_MTCK[19];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[20] = ~TimingViol_D2_MTCK[20];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[21] = ~TimingViol_D2_MTCK[21];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[22] = ~TimingViol_D2_MTCK[22];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[23] = ~TimingViol_D2_MTCK[23];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[24] = ~TimingViol_D2_MTCK[24];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[25] = ~TimingViol_D2_MTCK[25];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[26] = ~TimingViol_D2_MTCK[26];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[27] = ~TimingViol_D2_MTCK[27];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[28] = ~TimingViol_D2_MTCK[28];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[29] = ~TimingViol_D2_MTCK[29];
end


always @( TimingViol_TED2_MTCK  )
begin
   TimingViol_D2_MTCK[30] = ~TimingViol_D2_MTCK[30];
end


always @( TimingViol_TOD2_MTCK  )
begin
   TimingViol_D2_MTCK[31] = ~TimingViol_D2_MTCK[31];
end







      






  
always @(TimingViol_D1)
begin
#0
    if((Cond_gac1 && Cond_func_rw1) !== 0) begin
      for (q=0;q<Bits;q=q+1) begin
         if(TimingViol_D1[q] !== TimingViol_D1_last[q]) begin
            D1sys_reg_CK1[q] = 1'bx;
            if(M1sys_reg_CK1[q] !== 1) begin
              M1sys_reg_CK1[q] = 1'bx;
            end        
         end        
      end
     if(WEN1sys_reg_CK1 !==1)
      WriteLocMskX_bwise(A1sys_reg_CK1,M1sys_reg_CK1);
    end        

    if((Cond_gac1 && Cond_func_cap) !== 0) begin
            
      scanreg_d1l = 1'bx;
      scanreg_d1r = 1'bx;

      SDLO1_data  = 1'bx;
      SDRO1_data  = 1'bx;
      
      SDLO1_data_tim  <= 1'bx;
      SDRO1_data_tim  <= 1'bx;
      
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Chains Corrupted . ",$realtime);
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Outs Corrupted . ",$realtime);

        if(TBYPASSsys_reg_CK1 !== 0) begin
        WriteOut1X;
        end 

    end
    else begin
       if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of D1 has no impact on Scan Chain ",$realtime);
    end        
   
   TimingViol_D1_last = TimingViol_D1; 
end




always @(TimingViol_TED1_CK1 or TimingViol_TOD1_CK1)
begin
#0



  if(TBYPASSsys_reg_CK1 !== 0 && SEsys_reg_CK1 !== 1'b1 ) begin
     WriteOut1X;
  end 



   if((Cond_sdf_tbde_1) !== 0) begin
      scanreg_d1l = 1'bx;
      scanreg_d1r = 1'bx;

      SDLO1_data  = 1'bx;
      SDRO1_data  = 1'bx;
      
      SDLO1_data_tim  <= 1'bx;
      SDRO1_data_tim  <= 1'bx;
      
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Chains Corrupted . ",$realtime);
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Outs Corrupted . ",$realtime);
   end
   else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TED1 and TOD1 has no impact on Scan Chain ",$realtime);
   end        

end

always @(TimingViol_D1_MTCK)
begin
#0
   if(( Cond_sdf_tbde_m_1 ) !== 0) begin
      for (q=0;q<Bits;q=q+1) begin
         if(TimingViol_D1_MTCK[q] !== TimingViol_D1_MTCK_last[q]) begin
             D1sys_reg_MTCK[q] = 1'bx;
             if(M1sys_reg_MTCK[q] !== 1) begin
               M1sys_reg_MTCK[q] = 1'bx;
             end        
         end        
      end
       if(TWEN1sys_reg_MTCK !==1)
      WriteLocMskX_bwise(TA1sys_reg_MTCK,M1sys_reg_MTCK);
    end           
   TimingViol_D1_MTCK_last = TimingViol_D1_MTCK; 

end


//D2, TED2

always @(TimingViol_D2)
begin
#0
    if((Cond_gac2 && Cond_func_rw2) !== 0) begin
      for (q=0;q<Bits;q=q+1) begin
         if(TimingViol_D2[q] !== TimingViol_D2_last[q]) begin
            D2sys_reg_CK2[q] = 1'bx;
            if(M2sys_reg_CK2[q] !== 1) begin
              M2sys_reg_CK2[q] = 1'bx;
            end        
         end        
      end
      if(WEN2sys_reg_CK2 !==1)
      WriteLocMskX_bwise(A2sys_reg_CK2,M2sys_reg_CK2);
    end        

    if((Cond_gac2 && Cond_func_cap) !== 0) begin
            
      scanreg_d2l = 1'bx;
      scanreg_d2r = 1'bx;

      SDLO2_data  = 1'bx;
      SDRO2_data  = 1'bx;
      
      SDLO2_data_tim  <= 1'bx;
      SDRO2_data_tim  <= 1'bx;
      
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Chains Corrupted . ",$realtime);
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Outs Corrupted . ",$realtime);

        if(TBYPASSsys_reg_CK2 !== 0) begin
        WriteOut2X;
        end 

    end
    else begin
       if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of D2 has no impact on Scan Chain ",$realtime);
    end        
   
   TimingViol_D2_last = TimingViol_D2; 
end




always @(TimingViol_TED2_CK2 or TimingViol_TOD2_CK2)
begin
#0


   if(TBYPASSsys_reg_CK2 !== 0 && SEsys_reg_CK2 !== 1'b1 ) begin
        WriteOut2X;
   end 

   if((Cond_sdf_tbde_2) !== 0) begin
      scanreg_d2l = 1'bx;
      scanreg_d2r = 1'bx;

      SDLO2_data  = 1'bx;
      SDRO2_data  = 1'bx;
      
      SDLO2_data_tim  <= 1'bx;
      SDRO2_data_tim  <= 1'bx;
      
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Chains Corrupted . ",$realtime);
      if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Data Scan Outs Corrupted . ",$realtime);
   end
   else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TED2 and TOD2 has no impact on Scan Chain ",$realtime);
   end        

end

always @(TimingViol_D2_MTCK)
begin
#0
   if(( Cond_sdf_tbde_m_2 ) !== 0) begin
      for (q=0;q<Bits;q=q+1) begin
         if(TimingViol_D2_MTCK[q] !== TimingViol_D2_MTCK_last[q]) begin
             D2sys_reg_MTCK[q] = 1'bx;
             if(M2sys_reg_MTCK[q] !== 1) begin
               M2sys_reg_MTCK[q] = 1'bx;
             end        
         end        
      end
      if(TWEN2sys_reg_MTCK !==1)
      WriteLocMskX_bwise(TA2sys_reg_MTCK,M2sys_reg_MTCK);
    end           
   TimingViol_D2_MTCK_last = TimingViol_D2_MTCK; 

end







        

//A1

always @(TimingViol_A1_CK1) 
begin
#0
  if ((Cond_gac1 && (Cond_func_rw1 | Cond_tbypass1)) !== 0 ) begin
    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of A1 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac1 && Cond_func_cap) !== 0 ) begin
     scanreg_ctrl_port1 = 1'bx;

     SCTRLO1_data = 1'bX;
     SCTRLO1_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Out Corrupted . ",$realtime);
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of A1 has no impact on Scan Chain ",$realtime);      
  end        
end

always @(TimingViol_TA1_CK1) 
begin
#0

// Cond_bist_bypass -> FSM_corrupt

  if((Cond_tbypass1)!== 0)
   Mem_port1_FSM_Corrupt_tim;

  if((Cond_sdf_tba_1) !== 0 ) begin
     scanreg_ctrl_port1 = 1'bx;

     SCTRLO1_data = 1'bX;
     SCTRLO1_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Out Corrupted . ",$realtime);

  end 
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TA1 has no impact on Scan Chain ",$realtime);      
  end    
end

always @(TimingViol_TA1_MTCK) 
begin
#0
  if((Cond_sdf_tba_m_1) !== 0 ) begin
    Mem_port1_FSM_Corrupt_tim;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TA1 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end

//A2
always @(TimingViol_A2_CK2) 
begin
#0
  if ((Cond_gac2 && (Cond_func_rw2 | Cond_tbypass2)) !== 0 ) begin
    Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of A2 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac2 && Cond_func_cap) !== 0 ) begin
     scanreg_ctrl_port2 = 1'bx;

     SCTRLO2_data = 1'bX;
     SCTRLO2_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Out Corrupted . ",$realtime);
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of A2 has no impact on Scan Chain ",$realtime);      
  end        
end

always @(TimingViol_TA2_CK2) 
begin
#0
// Cond_bist_bypass -> FSM_corrupt

   if((Cond_tbypass2)!== 0)
   Mem_port2_FSM_Corrupt_tim;

  if((Cond_sdf_tba_2) !== 0 ) begin
     scanreg_ctrl_port2 = 1'bx;

     SCTRLO2_data = 1'bX;
     SCTRLO2_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Out Corrupted . ",$realtime);

  end 
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TA2 has no impact on Scan Chain ",$realtime);      
  end    
end

always @(TimingViol_TA2_MTCK) 
begin
#0
  if((Cond_sdf_tba_m_2) !== 0 ) begin
    Mem_port2_FSM_Corrupt_tim;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TA2 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end




//WEN1


always @(TimingViol_WEN1_CK1)
begin
#0
  WEN1sys_reg_CK1 = 1'bx;
  
  if ((Cond_gac1 && Cond_func_rw1) !== 0 ) begin
     Mem_port1_CCL;
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of WEN1 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac1 && Cond_func_cap) !== 0 ) begin
     scanreg_ctrl_port1 = 1'bx;

     SCTRLO1_data = 1'bX;
     SCTRLO1_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Out Corrupted . ",$realtime);

  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of WEN1 has no impact on Scan Chain ",$realtime);      
  end      

end

always @(TimingViol_TWEN1_CK1) 
begin
#0
  if((Cond_sdf_tbw_1) !== 0 ) begin
     scanreg_ctrl_port1 = 1'bx;

     SCTRLO1_data = 1'bX;
     SCTRLO1_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Out Corrupted . ",$realtime);
  end 
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TWEN1 has no impact on Scan Chain ",$realtime);      
  end    
end

always @(TimingViol_TWEN1_MTCK) 
begin
#0
  
  TWEN1sys_reg_MTCK = 1'bx;
  
  if((Cond_sdf_tbw_m_1) !== 0 ) begin
    Mem_port1_CCL;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TWEN1 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end

//WEN2
always @(TimingViol_WEN2_CK2)
begin
#0
  WEN2sys_reg_CK2 = 1'bx;
  
  if ((Cond_gac2 && Cond_func_rw2) !== 0 ) begin
     Mem_port2_CCL;   
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of WEN2 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac2 && Cond_func_cap) !== 0 ) begin
     scanreg_ctrl_port2 = 1'bx;

     SCTRLO2_data = 1'bX;
     SCTRLO2_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Out Corrupted . ",$realtime);

  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of WEN2 has no impact on Scan Chain ",$realtime);      
  end      

end

always @(TimingViol_TWEN2_CK2) 
begin
#0
  if((Cond_sdf_tbw_2) !== 0 ) begin
     scanreg_ctrl_port2 = 1'bx;

     SCTRLO2_data = 1'bX;
     SCTRLO2_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Out Corrupted . ",$realtime);
  end 
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TWEN2 has no impact on Scan Chain ",$realtime);      
  end    
end

always @(TimingViol_TWEN2_MTCK) 
begin
#0
  
  TWEN2sys_reg_MTCK = 1'bx;
  
  if((Cond_sdf_tbw_m_2) !== 0 ) begin
    Mem_port2_CCL;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TWEN2 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end




//WCSN


always @(TimingViol_CSN1_CK1)
begin
#0
  CSN1sys_reg_CK1 = 1'bx;
  if ((Cond_gac1 && Cond_csn_func_rw1) !== 0 ) begin
     Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of CSN1 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac1 && Cond_func_cap) !== 0 ) begin
     scanreg_ctrl_port1 = 1'bx;

     SCTRLO1_data = 1'bX;
     SCTRLO1_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Out Corrupted . ",$realtime);

  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of CSN1 has no impact on Scan Chain ",$realtime);      
  end      

end

always @(TimingViol_TCSN1_CK1) 
begin
#0
  if((Cond_sdf_tbp_1) !== 0 ) begin
     scanreg_ctrl_port1 = 1'bx;

     SCTRLO1_data = 1'bX;
     SCTRLO1_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Out Corrupted . ",$realtime);
  end 
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TCSN1 has no impact on Scan Chain ",$realtime);      
  end    
end

always @(TimingViol_TCSN1_MTCK) 
begin
#0
   TCSN1sys_reg_MTCK = 1'bx;

  if((Cond_sdf_tbp_m_1) !== 0 ) begin
    Mem_port1_FSM_Corrupt_tim;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TCSN1 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end


//CSN2



always @(TimingViol_CSN2_CK2)
begin
#0
  CSN2sys_reg_CK2 = 1'bx;
  if ((Cond_gac2 && Cond_csn_func_rw2) !== 0 ) begin
     Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of CSN2 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac2 && Cond_func_cap) !== 0 ) begin
     scanreg_ctrl_port2 = 1'bx;

     SCTRLO2_data = 1'bX;
     SCTRLO2_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Out Corrupted . ",$realtime);

  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of CSN2 has no impact on Scan Chain ",$realtime);      
  end      

end

always @(TimingViol_TCSN2_CK2) 
begin
#0
  if((Cond_sdf_tbp_2) !== 0 ) begin
     scanreg_ctrl_port2 = 1'bx;

     SCTRLO2_data = 1'bX;
     SCTRLO2_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Out Corrupted . ",$realtime);
  end 
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TCSN2 has no impact on Scan Chain ",$realtime);      
  end    
end

always @(TimingViol_TCSN2_MTCK) 
begin
#0
   TCSN2sys_reg_MTCK = 1'bx;

  if((Cond_sdf_tbp_m_2) !== 0 ) begin
    Mem_port2_FSM_Corrupt_tim;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TCSN2 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end




//IG

always @(TimingViol_IG1_CK1)
begin
#0
 
  IG1sys_reg_CK1 = 1'bx;
  if (( Cond_gac1 && Cond_ig_func_rw1) !== 0 ) begin
     Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of IG1 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac1 && Cond_cap1 ) !== 0 ) begin
     scanreg_ctrl_port1 = 1'bx;

     SCTRLO1_data = 1'bX;
     SCTRLO1_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port1 Control Scan Out Corrupted . ",$realtime);

  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of IG1 has no impact on Scan Chain ",$realtime);      
  end      

end

always @(TimingViol_IG1_MTCK) 
begin
#0

  IG1sys_reg_MTCK = 1'bx;
  
  if((Cond_sdf_tig_m_1) !== 0 ) begin
    Mem_port1_FSM_Corrupt_tim;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of IG1 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end

//IG2
always @(TimingViol_IG2_CK2)
begin
#0
 
  IG2sys_reg_CK2 = 1'bx;
  if (( Cond_gac2 && Cond_ig_func_rw2) !== 0 ) begin
     Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of IG2 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac2 && Cond_cap2 ) !== 0 ) begin
     scanreg_ctrl_port2 = 1'bx; 

     SCTRLO2_data = 1'bX;
     SCTRLO2_data_tim <= 1'bX;
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Chain Corrupted . ",$realtime);
     if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: port2 Control Scan Out Corrupted . ",$realtime);

  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of IG2 has no impact on Scan Chain ",$realtime);      
  end      

end

always @(TimingViol_IG2_MTCK) 
begin
#0

  IG2sys_reg_MTCK = 1'bx;
  
  if((Cond_sdf_tig_m_2) !== 0 ) begin
    Mem_port2_FSM_Corrupt_tim;
  end      
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of IG2 has no impact on Write Clock FSM and Memory Array ",$realtime); 
  end        
end
//
//SE

always @(TimingViol_SE_CK1)
begin
#0
   SEsys_reg_CK1 = 1'bx;
//Cond_tbypass added.
  if( ( (Cond_gac1 && (TBISTsys_reg_CK1 !== 1) && ATPsys_reg_CK1) || ( Cond_gac1 && (TBYPASSsys_reg_CK1 !==0)  ) )  !== 0) begin
    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of SE has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac1 && ATPsys_reg_CK1) !== 0) begin
    DFT_port1_ScanChainX;
    DFT_port1_ScanOutX;
    if(TBYPASSsys_reg_CK1 !== 0) begin
      WriteOut1X;
    end   
    
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of SE has no impact on Scan Chain ",$realtime);      
  end     
end

always @(TimingViol_SE_MTCK) 
begin
#0
  SEsys_reg_MTCK = 1'bx;
 
   if((Cond_gac1 && Cond_sdf_tse_m ) !== 0 ) 
     Mem_port1_FSM_Corrupt_tim; 
   if((Cond_gac2 && Cond_sdf_tse_m ) !== 0 )   
     Mem_port2_FSM_Corrupt_tim;    
  
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of SE has no impact on Read Clock FSM and Memory Output ",$realtime);      
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of SE has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

end

always @(TimingViol_SE_CK2)
begin
#0
   SEsys_reg_CK2 = 1'bx;
  if ( ( (Cond_gac2 && (TBISTsys_reg_CK2 !== 1) && ATPsys_reg_CK2) || ( Cond_gac2 && (TBYPASSsys_reg_CK2 !==0)  ) )  !== 0) begin
    Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of SE has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac2 && ATPsys_reg_CK2) !== 0) begin
    DFT_port2_ScanChainX;
    DFT_port2_ScanOutX;
    if(TBYPASSsys_reg_CK2 !== 0) begin
      WriteOut2X;
    end   
    
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of SE has no impact on Scan Chain ",$realtime);      
  end     
end






always @( TimingViol_INITN_CK1) 
begin
#0
  INITNsys_reg_CK1 = 1'bx;

 
 if(((STDBY1sys_reg_CK1 !== 1) && ( Cond_func_rw1 || Cond_tbypass1 )) !== 0 ) begin   

    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of INITN has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

 

  if(((STDBY1sys_reg_CK1 !== 1) && ATPsys_reg_CK1) !== 0 ) begin  

     DFT_port1_FSM_Corrupt_tim;
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of INITN has no impact on Scan Chain ",$realtime);      
  end     

end

always @( TimingViol_INITN_CK2) 
begin
#0
  INITNsys_reg_CK2 = 1'bx;
 
 
 if(((STDBY2sys_reg_CK2 !== 1) && (Cond_func_rw2 || Cond_tbypass2 )) !== 0 ) begin   
 
    Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of INITN has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

 

  if(((STDBY2sys_reg_CK2 !== 1) && ATPsys_reg_CK2) !== 0 ) begin 
     DFT_port2_FSM_Corrupt_tim;
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of INITN has no impact on Scan Chain ",$realtime);      
  end     

end



always @( TimingViol_INITN_MTCK) 
begin
#0
   INITNsys_reg_MTCK = 1'bx;

  

  if(( (STDBY1sys_reg_MTCK !== 1) && Cond_bist_rw1) !== 0 ) begin  
    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of INITN has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 
 
 
  if(( (STDBY2sys_reg_MTCK !== 1) && Cond_bist_rw2) !== 0 ) begin  
    Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of INITN has no impact on Read Clock FSM and Memory Output ",$realtime);      
  end 
 
 if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of INITN has no impact on Scan Chain ",$realtime);
 
end


////STDBY1

always @( TimingViol_STDBY1_CK1) 
begin
#0
  STDBY1sys_reg_CK1 = 1'bx;
 
 
 
 if((INITNsys_reg_CK1 && (Cond_func_rw1 || Cond_tbypass1 )  ) !== 0 ) begin 

    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY1 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 


  if((INITNsys_reg_CK1  && ATPsys_reg_CK1) !== 0 ) begin 
     DFT_port1_FSM_Corrupt_tim;
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY1 has no impact on Scan Chain ",$realtime);      
  end     

end

always @( TimingViol_STDBY2_CK2) 
begin
#0
  STDBY2sys_reg_CK2 = 1'bx;

  

 if((INITNsys_reg_CK2 && (Cond_func_rw2 || Cond_tbypass2 ) ) !== 0 ) begin 
    Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY2 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 



  if((INITNsys_reg_CK2  && ATPsys_reg_CK2) !== 0 ) begin 
     DFT_port2_FSM_Corrupt_tim;
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY2 has no impact on Scan Chain ",$realtime);      
  end     

end


always @( TimingViol_STDBY1_MTCK) 
begin
#0
   STDBY1sys_reg_MTCK = 1'bx;
  


  if((INITNsys_reg_MTCK  && Cond_bist_rw1) !== 0 ) begin 
    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY1 has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 
 
  if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY1 has no impact on Scan Chain ",$realtime);
 
end

always @( TimingViol_STDBY2_MTCK) 
begin
#0
   STDBY2sys_reg_MTCK = 1'bx;



 if((INITNsys_reg_MTCK  && Cond_bist_rw2) !== 0 ) begin 
   Mem_port2_FSM_Corrupt_tim;    
 end
 else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY2 has no impact on Read Clock FSM and Memory Output ",$realtime);      
 end 
 
  if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of STDBY2 has no impact on Scan Chain ",$realtime);
 
end





always @(TimingViol_TBYPASS_CK1)
begin
#0
   TBYPASSsys_reg_CK1 = 1'bx;
   
   if((Cond_gac1 &&  Cond_sys_rw1) !== 0 ) begin
    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBYPASS has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac1 && (ATPsys_reg_CK1 !== 0) ) !== 0 ) begin
     WriteOut1X;
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBYPASS has no impact on Read Clock FSM and Memory Output ",$realtime);      
  end   
  if((Cond_gac1 && Cond_cap1  ) !== 0 ) begin
  DFT_port1_FSM_Corrupt_tim;
  end  

end


always @(TimingViol_TBYPASS_CK2)
begin
#0
   TBYPASSsys_reg_CK2 = 1'bx;
   
   if((Cond_gac2 && Cond_sys_rw2) !== 0 ) begin
    Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBYPASS has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 

  if((Cond_gac2 && (ATPsys_reg_CK2 !== 0) ) !== 0 ) begin
     WriteOut2X;
  end       
  else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBYPASS has no impact on Read Clock FSM and Memory Output ",$realtime);      
  end   


  if((Cond_gac2 && Cond_cap2  ) !== 0 ) begin
  DFT_port2_FSM_Corrupt_tim;
  end  

end



always @(TimingViol_TBYPASS_MTCK)
begin
#0
  TBYPASSsys_reg_MTCK = 1'bx;

  if((Cond_sdf_tstdby_m_1) !== 0 ) begin
    Mem_port1_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBYPASS has no impact on Write Clock FSM and Memory Array ",$realtime);      
  end 
  
 if((Cond_sdf_tstdby_m_2) !== 0 ) begin
    Mem_port2_FSM_Corrupt_tim;    
  end
  else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBYPASS has no impact on Read Clock FSM and Memory Output ",$realtime);      
  end 
  
  if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBYPASS has no impact on Scan Chain ",$realtime);
end

always @(TimingViol_TBIST_CK1)
begin
#0
   TBISTsys_reg_CK1 = 1'bx;
   if ((Cond_gac1 && ATPsys_reg_CK1 && (SEsys_reg_CK1 !== 1) && (TBYPASSsys_reg_CK1 !== 1) && (IG1sys_reg_CK1 !== 1)) !== 0) begin
       Mem_port1_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBIST has no impact on Write Clock FSM and Memory Array ",$realtime);      
   end        

   if((Cond_sdf_tbist_1) !== 0) begin
     DFT_port1_ScanChainX;
     DFT_port1_ScanOutX;
   end
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBIST has no impact on Scan Chain ",$realtime);
   end        
end

always @(TimingViol_TBIST_CK2)
begin
#0
   TBISTsys_reg_CK2 = 1'bx;
   if ((Cond_gac2 && ATPsys_reg_CK2 && (SEsys_reg_CK2 !== 1) && (TBYPASSsys_reg_CK2 !== 1) && (IG2sys_reg_CK2 !== 1)) !== 0) begin
       Mem_port2_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBIST has no impact on Write Clock FSM and Memory Array ",$realtime);      
   end        

   if((Cond_sdf_tbist_2) !== 0) begin
     DFT_port2_ScanChainX;
     DFT_port2_ScanOutX;
   end
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBIST has no impact on Scan Chain ",$realtime);
   end        
end


always @(TimingViol_TBIST_MTCK)
begin
#0

   TBISTsys_reg_MTCK = 1'bx;

   //if ((Cond1c && ATPsys_reg_MTCK && (SEsys_reg_MTCK !== 1) && (TBYPASSsys_reg_MTCK !== 1) && (WIGsys_reg_MTCK !== 1)) !== 0) begin
   if ((Cond_gac1_m && Cond_tbist_rw_en1)!== 0) begin
       Mem_port1_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBIST has no impact on Write Clock FSM and Memory Array ",$realtime);      
   end  

   if ((Cond_gac2_m && Cond_tbist_rw_en2) !== 0) begin
       Mem_port2_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBIST has no impact on Read Clock FSM and Memory Output ",$realtime);      
   end
   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of TBIST has no impact on Scan Chain ",$realtime);
end


////ATP

always @(TimingViol_ATP_CK1)
begin
#0
   
   ATPsys_reg_CK1 = 1'bx;
   if (Cond_sdf_tatp_1 !== 0) begin
     Mem_port1_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of ATP has no impact on Write Clock FSM and Memory Array ",$realtime);      
   end
   if (Cond_sdf_tatp_1 !== 0 ) begin
     DFT_port1_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of ATP has no impact on Scan Chain ",$realtime);
   end

end

always @(TimingViol_ATP_CK2)
begin
#0
   
   ATPsys_reg_CK2 = 1'bx;
   if (Cond_sdf_tatp_2 !== 0) begin
     Mem_port2_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of ATP has no impact on Write Clock FSM and Memory Array ",$realtime);      
   end
   if (Cond_sdf_tatp_2 !== 0 ) begin
     DFT_port2_FSM_Corrupt_tim;
   end        
   else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of ATP has no impact on Scan Chain ",$realtime);
   end

end



always @(TimingViol_ATP_MTCK)
begin
#0
   ATPsys_reg_MTCK = 1'bx;

   if (Cond_gac1_m !== 0 ) 
     Mem_port1_FSM_Corrupt_tim;
   else if (Cond_gac2_m !== 0 ) 
     Mem_port2_FSM_Corrupt_tim;
   else begin
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of ATP has no impact on Write Clock FSM and Memory Array ",$realtime);
    if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of ATP has no impact on Read Clock FSM and Memory Output ",$realtime);
   end        
   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of ATP has no impact on Scan Chain ",$realtime);
end




 always @(TimingViol_CYCLE_1) 
 begin
#0
  
    if( ( MEMEN_1_CK1_reg_pre !== 0 && MEMEN_1_CK1_reg !== 0)|| (Cond_tbypass1 !==0) ) begin
        Mem_port1_FSM_Corrupt_tim;
    end    

     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK1 has no impact on Write Clock FSM and Memory Array ",$realtime);
     end        

     if(MEMEN_DFT_CK1_reg_pre !== 0 && MEMEN_DFT_CK1_reg !== 0) begin
       DFT_port1_FSM_Corrupt_tim;
     end        
     else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK1 has no impact on Scan Chain ",$realtime); 
     end    
 end
 


 always @(TimingViol_CYCLE_2) 
 begin
#0
  
    if( (MEMEN_2_CK2_reg_pre !== 0 && MEMEN_2_CK2_reg !== 0) || (Cond_tbypass2 !==0)) begin
        Mem_port2_FSM_Corrupt_tim;
    end    

     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK2 has no impact on Write Clock FSM and Memory Array ",$realtime);
     end        

     if(MEMEN_DFT_CK2_reg_pre !== 0 && MEMEN_DFT_CK2_reg !== 0) begin
       DFT_port2_FSM_Corrupt_tim;
     end        
     else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK2 has no impact on Scan Chain ",$realtime); 
     end    
 end



 always @(TimingViol_CKL_1) 
 begin
#0
   
     if(MEMEN_1 !== 0 || (Cond_tbypass1 !==0)) begin
        Mem_port1_FSM_Corrupt_tim;
     end      
     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK1 has no impact on Write Clock FSM and Memory Array ",$realtime);
     end        

     if(MEMEN_DFT1 !== 0) begin
       DFT_port1_FSM_Corrupt_tim;
     end        
     else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK1 has no impact on Scan Chain ",$realtime); 
     end        
 end


 always @(TimingViol_CKH_1) 
 begin
#0

     if( MEMEN_1 !== 0|| (Cond_tbypass1 !==0)) begin
        Mem_port1_FSM_Corrupt_tim;
     end      
     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min High Pulse of CK1 has no impact on Write Clock FSM and Memory Array ",$realtime);
     end        

     if(MEMEN_DFT1 !== 0) begin
       DFT_port1_FSM_Corrupt_tim;
     end        
     else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min High Pulse of CK1 has no impact on Scan Chain ",$realtime); 
     end      
 
 end


 always @(TimingViol_CKL_2) 
 begin
#0
   
     if(MEMEN_2 !== 0 || (Cond_tbypass2 !==0)) begin
        Mem_port2_FSM_Corrupt_tim;
     end      
     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK2 has no impact on Write Clock FSM and Memory Array ",$realtime);
     end        

     if(MEMEN_DFT2 !== 0) begin
       DFT_port2_FSM_Corrupt_tim;
     end        
     else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK2 has no impact on Scan Chain ",$realtime); 
     end        
 end


 always @(TimingViol_CKH_2) 
 begin
#0

     if( MEMEN_2 !== 0|| (Cond_tbypass2 !==0)) begin
        Mem_port2_FSM_Corrupt_tim;
     end      
     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min High Pulse of CK2 has no impact on Write Clock FSM and Memory Array ",$realtime);
     end        

     if(MEMEN_DFT2 !== 0) begin
       DFT_port2_FSM_Corrupt_tim;
     end        
     else begin
      if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min High Pulse of CK2 has no impact on Scan Chain ",$realtime); 
     end      
 
 end






 always @(TimingViol_CYCLE_SE_1)
 begin
#0
    if( MEMEN_DFT_CK1_reg_pre !== 0 && MEMEN_DFT_CK1_reg !== 0 ) begin
      DFT_port1_FSM_Corrupt_tim;
    end 
    else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK1 has no impact on Scan Chain ",$realtime); 
    end        
 end

 always @(TimingViol_CKL_SE_1)
 begin
#0
    if(MEMEN_DFT1 !== 0 ) begin
      DFT_port1_FSM_Corrupt_tim;
    end 
    else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK1 has no impact on Scan Chain ",$realtime); 
    end        
 end


 always @(TimingViol_CKH_SE_1)
 begin
#0
    DFT_port1_FSM_Corrupt_tim;
 end





 always @(TimingViol_CYCLE_SE_2)
 begin
#0
    if( MEMEN_DFT_CK2_reg_pre !== 0 && MEMEN_DFT_CK2_reg !== 0 ) begin
      DFT_port2_FSM_Corrupt_tim;
    end 
    else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK2 has no impact on Scan Chain ",$realtime); 
    end        
 end

 always @(TimingViol_CKL_SE_2)
 begin
#0
    if(MEMEN_DFT2 !== 0 ) begin
      DFT_port2_FSM_Corrupt_tim;
    end 
    else begin
     if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of CK2 has no impact on Scan Chain ",$realtime); 
    end        
 end


 always @(TimingViol_CKH_SE_2)
 begin
#0
    DFT_port2_FSM_Corrupt_tim;
 end


always @(TimingViol_MTCKCYCLE)
begin
#0
   
   if((MEMEN_1_MTCK_reg_pre !== 0 && MEMEN_1_MTCK_reg !== 0) || (Cond_tbypass_m !== 0)) begin
        Mem_port1_FSM_Corrupt_tim;
     end      
     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of MTCK has no impact on Write Clock FSM and Memory Array ",$realtime);
     end    
  
   if((MEMEN_2_MTCK_reg_pre !== 0 && MEMEN_2_MTCK_reg !== 0) || (Cond_tbypass_m !== 0)) begin
        Mem_port2_FSM_Corrupt_tim;
     end      
   else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of MTCK has no impact on Read Clock FSM and Memory Output ",$realtime);
   end 

   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of MTCK has no impact on Scan Chain ",$realtime);

end
 
 
always @(TimingViol_MTCKL)
begin
#0

   if(MEMEN_1 !== 0) begin
        Mem_port1_FSM_Corrupt_tim;
     end      
     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of MTCK has no impact on Write Clock FSM and Memory Array ",$realtime);
     end    
  
   if(MEMEN_2 !== 0) begin
        Mem_port2_FSM_Corrupt_tim;
     end      
   else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of MTCK has no impact on Read Clock FSM and Memory Output ",$realtime);
   end 

   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min Clock Cycle or Min low Pulse of MTCK has no impact on Scan Chain ",$realtime);
  
 end


 always @(TimingViol_MTCKH)
 begin
#0

   if( (Cond_gac1_m && Cond_sdf_tck_m ) !== 0) begin
        Mem_port1_FSM_Corrupt_tim;
     end      
     else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min High Pulse of MTCK has no impact on Write Clock FSM and Memory Array ",$realtime);
     end    
  
   if( (Cond_gac2_m && Cond_sdf_tck_m) !== 0) begin
        Mem_port2_FSM_Corrupt_tim;
     end      
   else begin
        if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min High Pulse of MTCK has no impact on Read Clock FSM and Memory Output ",$realtime);
   end 

   if( (debug_level > 2 ) && ($realtime > message_control_time) ) $display("%m - %t ST_INFO: Timing Violation of Min High Pulse of MTCK has no impact on Scan Chain ",$realtime);
  
 end

always @(TimingViol_SCTRLI1_CK1)
begin
#0
 if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Timing Violation of Scan Input SCTRLI1 has corrupted Write Port Control Scan Chain ",$realtime); 
 DFT_port1_ScanChainX;
end



always @(TimingViol_SDLI1_CK1)
begin
#0
 if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Timing Violation of Scan Input SDLI1 has corrupted Left part of Data Scan Chain ",$realtime); 
   scanreg_d1l = 1'bx;
end


always @(TimingViol_SDRI1_CK1)
begin
#0
 if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Timing Violation of Scan Input SDRI1 has corrupted Right part of Data Scan Chain ",$realtime); 
   scanreg_d1r = 1'bx;
end


always @(TimingViol_SCTRLI2_CK2)
begin
#0
 if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Timing Violation of Scan Input SCTRLI2 has corrupted Write Port Control Scan Chain ",$realtime); 
 DFT_port2_ScanChainX;
end



always @(TimingViol_SDLI2_CK2)
begin
#0
 if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Timing Violation of Scan Input SDLI2 has corrupted Left part of Data Scan Chain ",$realtime); 
   scanreg_d2l = 1'bx;
end


always @(TimingViol_SDRI2_CK2)
begin
#0
 if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Timing Violation of Scan Input SDRI2 has corrupted Right part of Data Scan Chain ",$realtime); 
    scanreg_d2r = 1'bx;
end








always @(TimingViol_CK1_CK2)
begin
#0
  k = 0;

if (flag_invalid_next_port1_cycle || flag_invalid_next_port2_cycle || flag_invalid_present_port1_cycle || flag_invalid_present_port2_cycle ) begin

  if (WEN1sys_reg_CK1!==0)
  WriteOut1X ;  
  if (WEN2sys_reg_CK2!==0)
  WriteOut2X ;

end



 if(A1sys_reg_CK1 === A2sys_reg_CK2) begin

   if (WEN1sys_reg_CK1!==0) begin
   if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports Write and Read. Output Corrupted ",$realtime);
	for (e=0;e<Bits;e=e+1) begin
          if(M2sys_reg_CK2[e] !== 1) begin
     	        OutReg1_data[e] = 1'bX;
        	OutReg1_data_tim[e] <= 1'bX;
      	end
	end


   end
   if (WEN2sys_reg_CK2!==0) begin
   if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports Write and Read. Output Corrupted ",$realtime);
          for (e=0;e<Bits;e=e+1) begin
          if(M1sys_reg_CK1[e] !== 1) begin
     	        OutReg2_data[e] = 1'bX;
        	OutReg2_data_tim[e] <= 1'bX;
        	end
          end


   end
   
  if (WEN1sys_reg_CK1!==1 && WEN2sys_reg_CK2!==1) begin
    M1sys_reg_CK1 = wordx; 
    WriteLocMskX_bwise(A1sys_reg_CK1,M1sys_reg_CK1);
      
   end


end 
end

always @(TimingViol_CK2_CK1)
begin
#0
 k = 0;


if (flag_invalid_next_port1_cycle || flag_invalid_next_port2_cycle || flag_invalid_present_port1_cycle || flag_invalid_present_port2_cycle ) begin

  if (WEN1sys_reg_CK1!==0)
  WriteOut1X ;  
  if (WEN2sys_reg_CK2!==0)
  WriteOut2X ;

end



if(A1sys_reg_CK1 === A2sys_reg_CK2) begin

   if (WEN1sys_reg_CK1!==0) begin
   if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports Write and Read. Output Corrupted ",$realtime);
 	for (e=0;e<Bits;e=e+1) begin
          if(M2sys_reg_CK2[e] !== 1) begin
     	        OutReg1_data[e] = 1'bX;
        	OutReg1_data_tim[e] <= 1'bX;
      	end
	end

   end
   if (WEN2sys_reg_CK2!==0) begin
   if((debug_level > 1) && ($realtime > message_control_time)) $display("%m - %t ST_WARNING: Address Contention on Ports Write and Read. Output Corrupted ",$realtime);
	for (e=0;e<Bits;e=e+1) begin
          if(M1sys_reg_CK1[e] !== 1) begin
     	        OutReg2_data[e] = 1'bX;
        	OutReg2_data_tim[e] <= 1'bX;
      	end
        end


       end
   if (WEN1sys_reg_CK1!==1 && WEN2sys_reg_CK2!==1) begin
       M1sys_reg_CK1 = wordx; 
       WriteLocMskX_bwise(A1sys_reg_CK1,M1sys_reg_CK1);
                         
   
   end


end
end


always @(TimingViol_RM_CK1)
begin
#0

 if((Cond_gac1 && (Cond_func_rw1 || Cond_tbypass1 )) !==0)
    Mem_port1_FSM_Corrupt_tim;
 if((ATPsys_reg_CK1) !==0)
    DFT_port1_FSM_Corrupt_tim;

end

always @(TimingViol_WM_CK1)
begin
#0

 if((Cond_gac1 && Cond_func_rw1) !==0)
    Mem_port1_FSM_Corrupt_tim;
 if((ATPsys_reg_CK1) !==0)
    DFT_port1_FSM_Corrupt_tim;

end

always @(TimingViol_TP_CK1)
begin
#0
    Mem_port1_FSM_Corrupt_tim;
end

always @(TimingViol_TP_CK2)
begin
#0
    Mem_port2_FSM_Corrupt_tim;
end

always @(TimingViol_TP_MTCK)
begin
#0
    if(MEMEN_1 !== 0) begin
      Mem_port1_FSM_Corrupt_tim;
    end  
    if(MEMEN_2 !== 0) begin
      Mem_port2_FSM_Corrupt_tim;
    end  
end

always @(TimingViol_RM_CK2)
begin
#0

 if((Cond_gac2 && (Cond_func_rw2 || Cond_tbypass1)) !==0)
    Mem_port2_FSM_Corrupt_tim;
 if(ATPsys_reg_CK2 !==0)
    DFT_port2_FSM_Corrupt_tim;

end

always @(TimingViol_WM_CK2)
begin
#0

 if((Cond_gac2 && Cond_func_rw2) !==0)
    Mem_port2_FSM_Corrupt_tim;
 if(ATPsys_reg_CK2 !==0)
    DFT_port2_FSM_Corrupt_tim;

end



always @(TimingViol_RM_MTCK)
begin
#0
  if((Cond_gac1_m && Cond_bist_rw1) !== 0) 
    Mem_port1_FSM_Corrupt_tim;
  if((Cond_gac2_m && Cond_bist_rw2) !== 0) 
    Mem_port2_FSM_Corrupt_tim;
          
end

always @(TimingViol_WM_MTCK) begin
#0
 
  if((Cond_gac1_m && Cond_bist_rw1) !== 0) 
    Mem_port1_FSM_Corrupt_tim;
  if((Cond_gac2_m && Cond_bist_rw2) !== 0) 
    Mem_port2_FSM_Corrupt_tim;
          
end



// ck mux related:

always @(TimingViol_TCSN1_ATP) begin
#0
  if ((Cond_sdf_tbp_atp_1) !== 0) begin
  Mem_port1_FSM_Corrupt_tim;
  end

end

always @(TimingViol_TCSN1_TBIST) begin
#0
  if ((Cond_sdf_tbp_tbist_1) !== 0) begin
  Mem_port1_FSM_Corrupt_tim;
  end


end

always @(TimingViol_TCSN1_TBYPASS) begin
#0
  if ((Cond_sdf_tbp_tbypas_1) !== 0) begin
  Mem_port1_FSM_Corrupt_tim;
  end


end

always @(TimingViol_CSN1_ATP) begin
#0
  if ((Cond_sdf_tp_atp_1) !== 0) begin
  Mem_port1_FSM_Corrupt_tim;
  end

end

always @(TimingViol_CSN1_TBIST) begin
#0
  if ((Cond_sdf_tp_tbist_1) !== 0) begin
  Mem_port1_FSM_Corrupt_tim;
  end

end

always @(TimingViol_CSN1_TBYPASS) begin
#0
  if ((Cond_sdf_tp_tbypas_1) !== 0) begin
  Mem_port1_FSM_Corrupt_tim;
  end


end

always @(TimingViol_TCSN2_ATP) begin
#0
  if ((Cond_sdf_tbp_atp_2) !== 0) begin
  Mem_port2_FSM_Corrupt_tim;
  end

end

always @(TimingViol_TCSN2_TBIST) begin
#0
  if ((Cond_sdf_tbp_tbist_2) !== 0) begin
  Mem_port2_FSM_Corrupt_tim;
  end


end

always @(TimingViol_TCSN2_TBYPASS) begin
#0
  if ((Cond_sdf_tbp_tbypas_2) !== 0) begin
  Mem_port2_FSM_Corrupt_tim;
  end


end

always @(TimingViol_CSN2_ATP) begin
#0
  if ((Cond_sdf_tp_atp_2) !== 0) begin
  Mem_port2_FSM_Corrupt_tim;
  end

end

always @(TimingViol_CSN2_TBIST) begin
#0
  if ((Cond_sdf_tp_tbist_2) !== 0) begin
  Mem_port2_FSM_Corrupt_tim;
  end

end

always @(TimingViol_CSN2_TBYPASS) begin
#0
  if ((Cond_sdf_tp_tbypas_2) !== 0) begin
  Mem_port2_FSM_Corrupt_tim;
  end


end




//---------------Actions on timing violations end

`endif
//*******************************************/
endmodule

`undef setup_time
`undef hold_time
`undef access_time
`undef retain_time
`undef cycle_time
`undef pulse_width_time
`undef rec_rem_time
`undef init_pulse_time
`undef st_msg_cntrl_time
`undef st_mem_block_ctrl_time
`undef mono_rail
`undef mo_ma_tied
`undef mo_mp_tied
`undef dual_rail


`undef pswsmallma_settling_time
`undef pswlargema_settling_time
`undef pswsmallmp_settling_time
`undef pswlargemp_settling_time


//*************************************************//
// Timing constraints between supply pins and SLEEP
//*************************************************//

`undef tslvddmpl
`undef tvddmphsl
`undef tslvddmal
`undef tvddmahsl
`undef tslgndmh
`undef tgndmlsl 


// Added to support Parallel Loading in Tetramax

module ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim (SET,CLR,CK,D,Q);
output reg Q;
input D,SET,CLR,CK;
reg Qprev;

        always @ (SET or CLR or CK or D) begin
          
          if (SET === 1'b1 && CLR === 1'b0) Q = 1'b1;  // Output is SET
          else if (SET === 1'b1 && CLR !== 1'b0) Q = 1'bx; // Race bet SET and CLR. Q = X
          else if (SET === 1'b0 && CLR === 1'b1) Q = 1'b0; // Output is RESET
          else if (SET !== 1'b0 && CLR === 1'b1) Q = 1'bx; // Race bet SET and CLR. Q = X
          else if (CK === 1'b1) Q = D;  // Latch Transparant
          else if (CK === 1'bx) Q = 1'bx;
        
          Qprev = Q; // Storing the previous value of Q
        
        end

endmodule


module ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch (EN,D,Q);
input EN,D;
output reg Q;

  always @(EN or D) begin
    if (EN === 1) begin
       Q = D;
    end
    else if ((EN === 1'bz || EN === 1'bx  )&& D !== Q) begin
        Q=1'bx;
    end    
  end
endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF (D,TI,TE,CP,Q,OUTX);
input D,TI,TE,CP;
input OUTX;
output reg Q;
wire Dint;
assign Dint= (TE===1)?TI:(TE===0)?D:1'bx;

always @(posedge CP)
        begin
          if(Dint === 1'bZ || CP ===1'bx)
          begin
                  Q <= 1'bx;
          end
          else
          begin
                  Q <= Dint;
          end        
        end
always @(posedge OUTX)
Q <= 1'bx;
endmodule


module ST_DPHD_HIPERF_2048x32m4_Tlmr_WANDprim (out,in1,in2);
input in1,in2;
output out;

assign out = (in1 === 1'b0 || in2 === 1'b0) ? 1'b0 : (in1 === 1'b1 && in2 === 1'b1) ? 1'b1 : (in1 === 1'bz && in2 === 1'bz) ? 1'b0 : 1'bx;
endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim (SEL, A, B, Z);
input SEL, A, B;
output Z;
assign Z = (SEL === 1'b0) ? A : (SEL === 1'b1) ? B : 1'bx;

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim (control,in,out);
output out;
input control,in;

assign out = (control === 1'b1) ? in : 
             (control === 1'b0) ? 1'bz :
             1'bx;
endmodule

`endcelldefine



