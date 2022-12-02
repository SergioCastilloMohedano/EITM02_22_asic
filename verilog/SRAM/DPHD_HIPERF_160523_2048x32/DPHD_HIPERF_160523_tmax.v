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
--  Description         : Dual Port High Density Compiler
--  Last Modified in    : 1.3
--  Date                : Feb, 2013
--  Last Modified By    : PS
--  Release History
               1.0      : First release - derived from 32nm bulk models
               1.2      : Multiple Coding enhancements for better fault sites handling, clock generation & X handling
               1.3      : Input 'X' handling updates.
                          -> "`define readaddrx, read_write, write_write" compiler directives placed at the right place (Over the read/write module)
                          -> Address gated with MEM Enable
                          -> Write Enable gated with MEM Enable
                          -> Mask gated with MEM Enable & Write Enable
                        : Standardization of input signal names  
 
--*************************************************************************/


/******************** START OF HEADER****************************
   This Header Gives Information about the parameters & options present in the Model
   memory_name = ST_DPHD_HIPERF_2048x32m4_Tlmr
   depth = 2048
   width  = 32
   mux   = 4

   
   //eswitch = no
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





//********************************************//
// ST_DPHD_HIPERF_2048x32m4_Tlmr model for TetraMAX //
//********************************************//



module ST_DPHD_HIPERF_2048x32m4_Tlmr (A1, A2, ATP, CK1, CK2, CSN1, CSN2, D1, D2 , IG1, IG2, INITN   , MTCK   , Q1, Q2    ,SCTRLI1, SCTRLI2, SCTRLO1, SCTRLO2, SDLI1, SDLI2, SDLO1, SDLO2, SDRI1, SDRI2, SDRO1, SDRO2, SE   , STDBY1, STDBY2  , TA1, TA2, TBIST, TBYPASS, TCSN1, TCSN2, TED1, TED2  , TOD1, TOD2  , TP  , TWEN1, TWEN2, WEN1, WEN2    );


parameter
    Words = 2048,
    Bits  = 32,
    Addr  = 11;

parameter
    read_margin_size = 3,
    write_margin_size = 4; 
 parameter
    repair_address_bus_width =   9 ;

parameter max_address_bits = 11;

  parameter mux_bits = 2;
  parameter bank_bits = 0;


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


 
 

  



//################## New additions ######
//  wire TBIST_and_ATP_NTBYPASS , CK1int , CK2int;

  wire [Bits -1 : 0] D1_bmux,D2_bmux; //,Q1_mem,Q2_mem;
   
       
  wire [Bits -1 : 0] D1_scff_out, D2_scff_out, Q1_CORE, Q2_CORE;
  
          
//  wire [Addr - 1: 0] A1_bmux,A2_bmux;
 
  wire [max_address_bits - 1 :0] A1_int,A2_int;

  wire CSN1_int, WEN1_int, WEN2_int, CSN2_int;
//  wire [max_address_bits - 1 :0] A1_bmux_cap,A2_bmux_cap;
//  wire block_scan_capture, block_scan_capture_lat_CK1, block_scan_capture_lat_CK2;
//  wire clock_gate_en1,clock_gate_en2;
wire [13:0] scanreg_ctrl_port1_wire;
wire [13:0] scanreg_ctrl_port2_wire;

//  supply0 gnd; 


ST_DPHD_HIPERF_2048x32m4_Tlmr_INTERFACE I0 (
// CONTROL
//top level input/outputs
.ATP(ATP) , .INITN(INITN)       , .SE(SE), .TBYPASS(TBYPASS), .TBIST(TBIST), .MTCK(MTCK), .Q1(Q1) , .Q2(Q2)

// intermediate signals
, .Q1_CORE(Q1_CORE), .Q2_CORE(Q2_CORE), .scanreg_ctrl_wire_1(scanreg_ctrl_port1_wire[13]), .scanreg_ctrl_wire_2(scanreg_ctrl_port2_wire[13]),

// port 1

.CK1(CK1), .CSN1(CSN1), .IG1(IG1), .A1(A1), .TA1(TA1), .TCSN1(TCSN1), .WEN1(WEN1), .TWEN1(TWEN1), .D1(D1),  .TED1(TED1), .TOD1(TOD1),  .STDBY1(STDBY1),

  .D1_bmux(D1_bmux), .D1_scff_out(D1_scff_out),  .A1_int(A1_int), .CK1_scff(CK1_scff), .CK1_lock_up_latch(CK1_lock_up_latch), .CK1_rw(CK1_rw), .shift_en1_inst(shift_en1_inst), .WEN1_int(WEN1_int), .CSN1_int(CSN1_int),
// port 2

.CK2(CK2), .CSN2(CSN2), .IG2(IG2), .A2(A2), .TA2(TA2), .TCSN2(TCSN2), .WEN2(WEN2), .TWEN2(TWEN2), .D2(D2),  .TED2(TED2), .TOD2(TOD2),  .STDBY2(STDBY2),

   .D2_bmux(D2_bmux), .D2_scff_out(D2_scff_out), .A2_int(A2_int), .CK2_scff(CK2_scff), .CK2_lock_up_latch(CK2_lock_up_latch), .CK2_rw(CK2_rw),  .shift_en2_inst(shift_en2_inst), .WEN2_int(WEN2_int), .CSN2_int(CSN2_int) ,.MEM_EN1_inst(MEM_EN1_inst), .MEM_EN2_inst(MEM_EN2_inst)
);

// memory r/w functionality
ST_DPHD_HIPERF_2048x32m4_Tlmr_mem_inst rw (.MEM_EN1_inst(MEM_EN1_inst), .MEM_EN2_inst(MEM_EN2_inst), .CK1(CK1_rw), .A1(A1_int[Addr-1:0]), .CK2(CK2_rw), .A2(A2_int[Addr-1:0]), .D1(D1_bmux), .D2(D2_bmux) , .Q1_CORE(Q1_CORE), .Q2_CORE(Q2_CORE),  .WEN1(WEN1_int),.WEN2(WEN2_int));



// SCAN CHAIN IMPLEMENTATION
ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_0 (.D(WEN1_int), .TI(SCTRLI1), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[0]));

      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_1 (.D(CSN1_int), .TI(scanreg_ctrl_port1_wire[0]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[1]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_2 (.D(A1_int[0]), .TI(scanreg_ctrl_port1_wire[1]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[2]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_3 (.D(A1_int[1]), .TI(scanreg_ctrl_port1_wire[2]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[3]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_4 (.D(A1_int[6]), .TI(scanreg_ctrl_port1_wire[3]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[4]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_5 (.D(A1_int[7]), .TI(scanreg_ctrl_port1_wire[4]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[5]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_6 (.D(A1_int[4]), .TI(scanreg_ctrl_port1_wire[5]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[6]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_7 (.D(A1_int[5]), .TI(scanreg_ctrl_port1_wire[6]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[7]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_8 (.D(A1_int[8]), .TI(scanreg_ctrl_port1_wire[7]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[8]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_9 (.D(A1_int[9]), .TI(scanreg_ctrl_port1_wire[8]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[9]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_10 (.D(A1_int[10]), .TI(scanreg_ctrl_port1_wire[9]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[10]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_11 (.D(A1_int[2]), .TI(scanreg_ctrl_port1_wire[10]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[11]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_12 (.D(A1_int[3]), .TI(scanreg_ctrl_port1_wire[11]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[12]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p1a_13 (.D(scanreg_ctrl_port1_wire[13]), .TI(scanreg_ctrl_port1_wire[12]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(scanreg_ctrl_port1_wire[13]));  

ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK1_SCTRLO1_latch (!CK1_lock_up_latch ,scanreg_ctrl_port1_wire[13],SCTRLO1 );


// LEFT DATA SCAN CHAIN 

ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_0 (.D(D1_bmux[15]), .TI(SDLI1), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[15]));

     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_1 (.D(D1_bmux[14]), .TI(D1_scff_out[15]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[14]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_2 (.D(D1_bmux[13]), .TI(D1_scff_out[14]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[13]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_3 (.D(D1_bmux[12]), .TI(D1_scff_out[13]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[12]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_4 (.D(D1_bmux[11]), .TI(D1_scff_out[12]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[11]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_5 (.D(D1_bmux[10]), .TI(D1_scff_out[11]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[10]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_6 (.D(D1_bmux[9]), .TI(D1_scff_out[10]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[9]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_7 (.D(D1_bmux[8]), .TI(D1_scff_out[9]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[8]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_8 (.D(D1_bmux[7]), .TI(D1_scff_out[8]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[7]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_9 (.D(D1_bmux[6]), .TI(D1_scff_out[7]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[6]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_10 (.D(D1_bmux[5]), .TI(D1_scff_out[6]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[5]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_11 (.D(D1_bmux[4]), .TI(D1_scff_out[5]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[4]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_12 (.D(D1_bmux[3]), .TI(D1_scff_out[4]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[3]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_13 (.D(D1_bmux[2]), .TI(D1_scff_out[3]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[2]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_14 (.D(D1_bmux[1]), .TI(D1_scff_out[2]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[1]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1l_15 (.D(D1_bmux[0]), .TI(D1_scff_out[1]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[0]));


ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK1_SDLO1_latch (!CK1_lock_up_latch ,D1_scff_out[0],SDLO1 );

// RIGHT DATA SCAN CHAIN

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_0 (.D(D1_bmux[31]), .TI(SDRI1), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[31]));

     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_1 (.D(D1_bmux[30]), .TI(D1_scff_out[31]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[30]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_2 (.D(D1_bmux[29]), .TI(D1_scff_out[30]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[29]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_3 (.D(D1_bmux[28]), .TI(D1_scff_out[29]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[28]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_4 (.D(D1_bmux[27]), .TI(D1_scff_out[28]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[27]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_5 (.D(D1_bmux[26]), .TI(D1_scff_out[27]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[26]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_6 (.D(D1_bmux[25]), .TI(D1_scff_out[26]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[25]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_7 (.D(D1_bmux[24]), .TI(D1_scff_out[25]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[24]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_8 (.D(D1_bmux[23]), .TI(D1_scff_out[24]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[23]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_9 (.D(D1_bmux[22]), .TI(D1_scff_out[23]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[22]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_10 (.D(D1_bmux[21]), .TI(D1_scff_out[22]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[21]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_11 (.D(D1_bmux[20]), .TI(D1_scff_out[21]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[20]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_12 (.D(D1_bmux[19]), .TI(D1_scff_out[20]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[19]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_13 (.D(D1_bmux[18]), .TI(D1_scff_out[19]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[18]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_14 (.D(D1_bmux[17]), .TI(D1_scff_out[18]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[17]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d1r_15 (.D(D1_bmux[16]), .TI(D1_scff_out[17]), .TE(shift_en1_inst), .CP(CK1_scff), .Q(D1_scff_out[16]));

ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK1_SDRO1_latch (!CK1_lock_up_latch ,D1_scff_out[16],SDRO1 );


 


// Port2 control scan chain


ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_0 (.D(WEN2_int), .TI(SCTRLI2), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[0]));

      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_1 (.D(CSN2_int), .TI(scanreg_ctrl_port2_wire[0]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[1]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_2 (.D(A2_int[0]), .TI(scanreg_ctrl_port2_wire[1]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[2]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_3 (.D(A2_int[1]), .TI(scanreg_ctrl_port2_wire[2]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[3]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_4 (.D(A2_int[6]), .TI(scanreg_ctrl_port2_wire[3]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[4]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_5 (.D(A2_int[7]), .TI(scanreg_ctrl_port2_wire[4]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[5]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_6 (.D(A2_int[4]), .TI(scanreg_ctrl_port2_wire[5]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[6]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_7 (.D(A2_int[5]), .TI(scanreg_ctrl_port2_wire[6]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[7]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_8 (.D(A2_int[8]), .TI(scanreg_ctrl_port2_wire[7]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[8]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_9 (.D(A2_int[9]), .TI(scanreg_ctrl_port2_wire[8]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[9]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_10 (.D(A2_int[10]), .TI(scanreg_ctrl_port2_wire[9]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[10]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_11 (.D(A2_int[2]), .TI(scanreg_ctrl_port2_wire[10]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[11]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_12 (.D(A2_int[3]), .TI(scanreg_ctrl_port2_wire[11]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[12]));  
      

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF p2a_13 (.D(scanreg_ctrl_port2_wire[13]), .TI(scanreg_ctrl_port2_wire[12]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(scanreg_ctrl_port2_wire[13]));  

// Lock Up Latch

ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK2_SCTRLO2_latch (!CK2_lock_up_latch ,scanreg_ctrl_port2_wire[13],SCTRLO2 );


// LEFT DATA SCAN CHAIN 

ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_0 (.D(D2_bmux[15]), .TI(SDLI2), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[15]));

     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_1 (.D(D2_bmux[14]), .TI(D2_scff_out[15]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[14]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_2 (.D(D2_bmux[13]), .TI(D2_scff_out[14]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[13]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_3 (.D(D2_bmux[12]), .TI(D2_scff_out[13]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[12]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_4 (.D(D2_bmux[11]), .TI(D2_scff_out[12]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[11]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_5 (.D(D2_bmux[10]), .TI(D2_scff_out[11]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[10]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_6 (.D(D2_bmux[9]), .TI(D2_scff_out[10]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[9]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_7 (.D(D2_bmux[8]), .TI(D2_scff_out[9]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[8]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_8 (.D(D2_bmux[7]), .TI(D2_scff_out[8]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[7]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_9 (.D(D2_bmux[6]), .TI(D2_scff_out[7]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[6]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_10 (.D(D2_bmux[5]), .TI(D2_scff_out[6]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[5]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_11 (.D(D2_bmux[4]), .TI(D2_scff_out[5]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[4]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_12 (.D(D2_bmux[3]), .TI(D2_scff_out[4]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[3]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_13 (.D(D2_bmux[2]), .TI(D2_scff_out[3]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[2]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_14 (.D(D2_bmux[1]), .TI(D2_scff_out[2]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[1]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2l_15 (.D(D2_bmux[0]), .TI(D2_scff_out[1]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[0]));

// Lock Up Latch
ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK2_SDLO2_latch (!CK2_lock_up_latch ,D2_scff_out[0],SDLO2 );


// RIGHT DATA SCAN CHAIN

 ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_0 (.D(D2_bmux[31]), .TI(SDRI2), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[31]));

     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_1 (.D(D2_bmux[30]), .TI(D2_scff_out[31]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[30]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_2 (.D(D2_bmux[29]), .TI(D2_scff_out[30]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[29]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_3 (.D(D2_bmux[28]), .TI(D2_scff_out[29]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[28]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_4 (.D(D2_bmux[27]), .TI(D2_scff_out[28]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[27]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_5 (.D(D2_bmux[26]), .TI(D2_scff_out[27]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[26]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_6 (.D(D2_bmux[25]), .TI(D2_scff_out[26]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[25]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_7 (.D(D2_bmux[24]), .TI(D2_scff_out[25]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[24]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_8 (.D(D2_bmux[23]), .TI(D2_scff_out[24]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[23]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_9 (.D(D2_bmux[22]), .TI(D2_scff_out[23]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[22]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_10 (.D(D2_bmux[21]), .TI(D2_scff_out[22]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[21]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_11 (.D(D2_bmux[20]), .TI(D2_scff_out[21]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[20]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_12 (.D(D2_bmux[19]), .TI(D2_scff_out[20]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[19]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_13 (.D(D2_bmux[18]), .TI(D2_scff_out[19]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[18]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_14 (.D(D2_bmux[17]), .TI(D2_scff_out[18]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[17]));
     ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF d2r_15 (.D(D2_bmux[16]), .TI(D2_scff_out[17]), .TE(shift_en2_inst), .CP(CK2_scff), .Q(D2_scff_out[16]));

// Lock Up Latch

ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch CK2_SDRO2_latch (!CK2_lock_up_latch ,D2_scff_out[16],SDRO2 );







//redundancy end





endmodule


`celldefine
module ST_DPHD_HIPERF_2048x32m4_Tlmr_INTERFACE (
// CONTROL
//top level input/outputs
ATP , INITN       , SE, TBYPASS, TBIST, MTCK, Q1 , Q2

// intermediate signals
, Q1_CORE, Q2_CORE, scanreg_ctrl_wire_1, scanreg_ctrl_wire_2,

// port 1

CK1, CSN1, IG1, A1, TA1, TCSN1, WEN1, TWEN1, D1,  TED1, TOD1,  STDBY1,

  D1_bmux, D1_scff_out, A1_int, CK1_scff, CK1_lock_up_latch, CK1_rw,  shift_en1_inst, WEN1_int, CSN1_int,
// port 2

CK2, CSN2, IG2, A2, TA2, TCSN2, WEN2, TWEN2, D2,  TED2, TOD2,  STDBY2,

  D2_bmux, D2_scff_out, A2_int, CK2_scff, CK2_lock_up_latch, CK2_rw,  shift_en2_inst, WEN2_int, CSN2_int, MEM_EN1_inst, MEM_EN2_inst


);


parameter
    Words = 2048,
    Bits  = 32,
    databits = 32,
    Addr  = 11,
    addrbits  = 11;

parameter
    read_margin_size = 3,
    write_margin_size = 4; 
 parameter
    repair_address_bus_width =   9 ;

parameter max_address_bits = 11;

  parameter mux_bits = 2;
  parameter bank_bits = 0;


input ATP, INITN;

 
 
 
 

  
input SE, TBYPASS, STDBY1, STDBY2, TBIST, MTCK, scanreg_ctrl_wire_1, scanreg_ctrl_wire_2, CK1, CSN1, IG1, TCSN1, TCSN2, TWEN1, TWEN2, CK2, CSN2, WEN1, WEN2, IG2, TED1, TOD1,  TED2, TOD2 ;

input [addrbits-1:0] A1, TA1, A2, TA2;
output [max_address_bits-1:0] A1_int , A2_int;
input [databits-1:0] D1, Q1_CORE, D2, Q2_CORE , D1_scff_out,D2_scff_out;
output [databits-1:0] D1_bmux, Q1, D2_bmux, Q2;


output shift_en1_inst, shift_en2_inst, WEN1_int, WEN2_int, CSN1_int, CSN2_int;
output MEM_EN1_inst, MEM_EN2_inst;
// prakhar
output CK1_scff,CK1_rw,CK2_scff, CK2_rw, CK1_lock_up_latch, CK2_lock_up_latch;

supply0 gnd;

wire [max_address_bits-1:0] A1_bmux_cap , A2_bmux_cap;
wire [addrbits-1:0] A1_bmux, A2_bmux;
    //Clock Mux
  
   not (NTBYPASS, TBYPASS);
   and (TBIST_and_ATP_NTBYPASS , TBIST , ATP, NTBYPASS ); 
   
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim ms0 (TBIST_and_ATP_NTBYPASS , CK1, MTCK, CK1int);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim ms1 (TBIST_and_ATP_NTBYPASS , CK2, MTCK, CK2int);


  //Data Mux

   and (TBIST_and_ATP , TBIST , ATP); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_0 (TBIST_and_ATP , D1[0], TED1, D1_bmux[0]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_0 (TBIST_and_ATP , D2[0], TED2, D2_bmux[0]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_1 (TBIST_and_ATP , D1[1], TOD1, D1_bmux[1]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_1 (TBIST_and_ATP , D2[1], TOD2, D2_bmux[1]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_2 (TBIST_and_ATP , D1[2], TED1, D1_bmux[2]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_2 (TBIST_and_ATP , D2[2], TED2, D2_bmux[2]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_3 (TBIST_and_ATP , D1[3], TOD1, D1_bmux[3]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_3 (TBIST_and_ATP , D2[3], TOD2, D2_bmux[3]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_4 (TBIST_and_ATP , D1[4], TED1, D1_bmux[4]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_4 (TBIST_and_ATP , D2[4], TED2, D2_bmux[4]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_5 (TBIST_and_ATP , D1[5], TOD1, D1_bmux[5]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_5 (TBIST_and_ATP , D2[5], TOD2, D2_bmux[5]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_6 (TBIST_and_ATP , D1[6], TED1, D1_bmux[6]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_6 (TBIST_and_ATP , D2[6], TED2, D2_bmux[6]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_7 (TBIST_and_ATP , D1[7], TOD1, D1_bmux[7]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_7 (TBIST_and_ATP , D2[7], TOD2, D2_bmux[7]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_8 (TBIST_and_ATP , D1[8], TED1, D1_bmux[8]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_8 (TBIST_and_ATP , D2[8], TED2, D2_bmux[8]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_9 (TBIST_and_ATP , D1[9], TOD1, D1_bmux[9]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_9 (TBIST_and_ATP , D2[9], TOD2, D2_bmux[9]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_10 (TBIST_and_ATP , D1[10], TED1, D1_bmux[10]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_10 (TBIST_and_ATP , D2[10], TED2, D2_bmux[10]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_11 (TBIST_and_ATP , D1[11], TOD1, D1_bmux[11]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_11 (TBIST_and_ATP , D2[11], TOD2, D2_bmux[11]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_12 (TBIST_and_ATP , D1[12], TED1, D1_bmux[12]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_12 (TBIST_and_ATP , D2[12], TED2, D2_bmux[12]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_13 (TBIST_and_ATP , D1[13], TOD1, D1_bmux[13]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_13 (TBIST_and_ATP , D2[13], TOD2, D2_bmux[13]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_14 (TBIST_and_ATP , D1[14], TED1, D1_bmux[14]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_14 (TBIST_and_ATP , D2[14], TED2, D2_bmux[14]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_15 (TBIST_and_ATP , D1[15], TOD1, D1_bmux[15]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_15 (TBIST_and_ATP , D2[15], TOD2, D2_bmux[15]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_16 (TBIST_and_ATP , D1[16], TED1, D1_bmux[16]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_16 (TBIST_and_ATP , D2[16], TED2, D2_bmux[16]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_17 (TBIST_and_ATP , D1[17], TOD1, D1_bmux[17]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_17 (TBIST_and_ATP , D2[17], TOD2, D2_bmux[17]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_18 (TBIST_and_ATP , D1[18], TED1, D1_bmux[18]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_18 (TBIST_and_ATP , D2[18], TED2, D2_bmux[18]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_19 (TBIST_and_ATP , D1[19], TOD1, D1_bmux[19]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_19 (TBIST_and_ATP , D2[19], TOD2, D2_bmux[19]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_20 (TBIST_and_ATP , D1[20], TED1, D1_bmux[20]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_20 (TBIST_and_ATP , D2[20], TED2, D2_bmux[20]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_21 (TBIST_and_ATP , D1[21], TOD1, D1_bmux[21]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_21 (TBIST_and_ATP , D2[21], TOD2, D2_bmux[21]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_22 (TBIST_and_ATP , D1[22], TED1, D1_bmux[22]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_22 (TBIST_and_ATP , D2[22], TED2, D2_bmux[22]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_23 (TBIST_and_ATP , D1[23], TOD1, D1_bmux[23]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_23 (TBIST_and_ATP , D2[23], TOD2, D2_bmux[23]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_24 (TBIST_and_ATP , D1[24], TED1, D1_bmux[24]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_24 (TBIST_and_ATP , D2[24], TED2, D2_bmux[24]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_25 (TBIST_and_ATP , D1[25], TOD1, D1_bmux[25]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_25 (TBIST_and_ATP , D2[25], TOD2, D2_bmux[25]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_26 (TBIST_and_ATP , D1[26], TED1, D1_bmux[26]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_26 (TBIST_and_ATP , D2[26], TED2, D2_bmux[26]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_27 (TBIST_and_ATP , D1[27], TOD1, D1_bmux[27]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_27 (TBIST_and_ATP , D2[27], TOD2, D2_bmux[27]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_28 (TBIST_and_ATP , D1[28], TED1, D1_bmux[28]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_28 (TBIST_and_ATP , D2[28], TED2, D2_bmux[28]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_29 (TBIST_and_ATP , D1[29], TOD1, D1_bmux[29]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_29 (TBIST_and_ATP , D2[29], TOD2, D2_bmux[29]); 



  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_30 (TBIST_and_ATP , D1[30], TED1, D1_bmux[30]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_30 (TBIST_and_ATP , D2[30], TED2, D2_bmux[30]);




  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D1_after_bmux_31 (TBIST_and_ATP , D1[31], TOD1, D1_bmux[31]); 
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim D2_after_bmux_31 (TBIST_and_ATP , D2[31], TOD2, D2_bmux[31]); 



  //Mask Mux
  


  //Read addrbitsess Mux


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_0 (TBIST_and_ATP , A1[0], TA1[0], A1_bmux[0]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_0 (TBIST_and_ATP , A2[0], TA2[0], A2_bmux[0]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_1 (TBIST_and_ATP , A1[1], TA1[1], A1_bmux[1]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_1 (TBIST_and_ATP , A2[1], TA2[1], A2_bmux[1]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_2 (TBIST_and_ATP , A1[2], TA1[2], A1_bmux[2]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_2 (TBIST_and_ATP , A2[2], TA2[2], A2_bmux[2]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_3 (TBIST_and_ATP , A1[3], TA1[3], A1_bmux[3]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_3 (TBIST_and_ATP , A2[3], TA2[3], A2_bmux[3]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_4 (TBIST_and_ATP , A1[4], TA1[4], A1_bmux[4]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_4 (TBIST_and_ATP , A2[4], TA2[4], A2_bmux[4]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_5 (TBIST_and_ATP , A1[5], TA1[5], A1_bmux[5]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_5 (TBIST_and_ATP , A2[5], TA2[5], A2_bmux[5]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_6 (TBIST_and_ATP , A1[6], TA1[6], A1_bmux[6]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_6 (TBIST_and_ATP , A2[6], TA2[6], A2_bmux[6]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_7 (TBIST_and_ATP , A1[7], TA1[7], A1_bmux[7]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_7 (TBIST_and_ATP , A2[7], TA2[7], A2_bmux[7]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_8 (TBIST_and_ATP , A1[8], TA1[8], A1_bmux[8]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_8 (TBIST_and_ATP , A2[8], TA2[8], A2_bmux[8]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_9 (TBIST_and_ATP , A1[9], TA1[9], A1_bmux[9]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_9 (TBIST_and_ATP , A2[9], TA2[9], A2_bmux[9]);


  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A1_after_bmux_10 (TBIST_and_ATP , A1[10], TA1[10], A1_bmux[10]);
  ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim A2_after_bmux_10 (TBIST_and_ATP , A2[10], TA2[10], A2_bmux[10]);



 buf A1_after_bmux_cap_0 (A1_bmux_cap[0],A1_bmux[0]);
 buf A2_after_bmux_cap_0 (A2_bmux_cap[0],A2_bmux[0]);


 buf A1_after_bmux_cap_1 (A1_bmux_cap[1],A1_bmux[1]);
 buf A2_after_bmux_cap_1 (A2_bmux_cap[1],A2_bmux[1]);


 buf A1_after_bmux_cap_2 (A1_bmux_cap[2],A1_bmux[2]);
 buf A2_after_bmux_cap_2 (A2_bmux_cap[2],A2_bmux[2]);


 buf A1_after_bmux_cap_3 (A1_bmux_cap[3],A1_bmux[3]);
 buf A2_after_bmux_cap_3 (A2_bmux_cap[3],A2_bmux[3]);


 buf A1_after_bmux_cap_4 (A1_bmux_cap[4],A1_bmux[4]);
 buf A2_after_bmux_cap_4 (A2_bmux_cap[4],A2_bmux[4]);


 buf A1_after_bmux_cap_5 (A1_bmux_cap[5],A1_bmux[5]);
 buf A2_after_bmux_cap_5 (A2_bmux_cap[5],A2_bmux[5]);


 buf A1_after_bmux_cap_6 (A1_bmux_cap[6],A1_bmux[6]);
 buf A2_after_bmux_cap_6 (A2_bmux_cap[6],A2_bmux[6]);


 buf A1_after_bmux_cap_7 (A1_bmux_cap[7],A1_bmux[7]);
 buf A2_after_bmux_cap_7 (A2_bmux_cap[7],A2_bmux[7]);


 buf A1_after_bmux_cap_8 (A1_bmux_cap[8],A1_bmux[8]);
 buf A2_after_bmux_cap_8 (A2_bmux_cap[8],A2_bmux[8]);


 buf A1_after_bmux_cap_9 (A1_bmux_cap[9],A1_bmux[9]);
 buf A2_after_bmux_cap_9 (A2_bmux_cap[9],A2_bmux[9]);


 buf A1_after_bmux_cap_10 (A1_bmux_cap[10],A1_bmux[10]);
 buf A2_after_bmux_cap_10 (A2_bmux_cap[10],A2_bmux[10]);


//Gnd unused Address Bits
        


  //CSN , WEN , ist mux

ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim CSN1_after_bmux (TBIST_and_ATP, CSN1, TCSN1, CSN1_int);

ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim CSN2_after_bmux (TBIST_and_ATP, CSN2, TCSN2, CSN2_int);

 ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim WEN1_after_bmux (TBIST_and_ATP, WEN1, TWEN1, WEN1_int);
 ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim WEN2_after_bmux (TBIST_and_ATP, WEN2, TWEN2, WEN2_int);

and (GAC1, INITN, !STDBY1 ); 
and (GAC2, INITN, !STDBY2 ); 

buf (BYP_EN1int, scanreg_ctrl_wire_1);
buf (BYP_EN2int, scanreg_ctrl_wire_2);
//Scan Clock Generation for Port1, port2

and (port1_capture_bypass1, TBYPASS, !BYP_EN1int, !SE, ATP, GAC1);
and (port1_capture_bypass0, !TBYPASS, !TBIST, !SE, ATP, GAC1);
and (shift_en1_inst, SE, ATP, GAC1);
or  (port1_shift_or_capture_inst, shift_en1_inst, port1_capture_bypass0, port1_capture_bypass1);
// Clock Gating Logic
ST_DPHD_HIPERF_2048x32m4_Tlmr_CGCprim cgc_CK_dft1 (.EN(port1_shift_or_capture_inst), .CK(CK1), .CK_gated(CK1_scff));

and (port2_capture_bypass1, TBYPASS, !BYP_EN2int, !SE, ATP, GAC2);
and (port2_capture_bypass0, !TBYPASS, !TBIST, !SE, ATP, GAC2);
and (shift_en2_inst, SE, ATP, GAC2);
or  (port2_shift_or_capture_inst, shift_en2_inst, port2_capture_bypass0, port2_capture_bypass1);
// Clock Gating Logic
ST_DPHD_HIPERF_2048x32m4_Tlmr_CGCprim cgc_CK_dft2 (.EN(port2_shift_or_capture_inst), .CK(CK2), .CK_gated(CK2_scff));


// Clock for lock-up-latch at the end of scan chains... (scan shift mode)
ST_DPHD_HIPERF_2048x32m4_Tlmr_CGCprim cgc_CK1_lkp_latch (.EN(shift_en1_inst), .CK(CK1), .CK_gated(CK1_lock_up_latch));
ST_DPHD_HIPERF_2048x32m4_Tlmr_CGCprim cgc_CK2_lkp_latch (.EN(shift_en2_inst), .CK(CK2), .CK_gated(CK2_lock_up_latch));


buf (A1_int[0], A1_bmux_cap[0]);
buf (A1_int[1], A1_bmux_cap[1]);
buf (A1_int[2], A1_bmux_cap[2]);
buf (A1_int[3], A1_bmux_cap[3]);
buf (A1_int[4], A1_bmux_cap[4]);
buf (A1_int[5], A1_bmux_cap[5]);
buf (A1_int[6], A1_bmux_cap[6]);
buf (A1_int[7], A1_bmux_cap[7]);
buf (A1_int[8], A1_bmux_cap[8]);
buf (A1_int[9], A1_bmux_cap[9]);
buf (A1_int[10], A1_bmux_cap[10]);

buf (A2_int[0], A2_bmux_cap[0]);
buf (A2_int[1], A2_bmux_cap[1]);
buf (A2_int[2], A2_bmux_cap[2]);
buf (A2_int[3], A2_bmux_cap[3]);
buf (A2_int[4], A2_bmux_cap[4]);
buf (A2_int[5], A2_bmux_cap[5]);
buf (A2_int[6], A2_bmux_cap[6]);
buf (A2_int[7], A2_bmux_cap[7]);
buf (A2_int[8], A2_bmux_cap[8]);
buf (A2_int[9], A2_bmux_cap[9]);
buf (A2_int[10], A2_bmux_cap[10]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_se_ck1 (1'b0, 1'b0, !CK1, SE, SE_latch_CK1);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_se_ck2 (1'b0, 1'b0, !CK2, SE, SE_latch_CK2);

//########################

and (MEM_EN1_inst, GAC1, ATP, !SE, !TBYPASS, !IG1, !CSN1_int);
and (MEM_EN2_inst, GAC2, ATP, !SE, !TBYPASS, !IG2, !CSN2_int);
// ----- Clock generation for "rw" block
ST_DPHD_HIPERF_2048x32m4_Tlmr_CGCprim cgc_CK1_rw (.EN(MEM_EN1_inst), .CK(CK1int), .CK_gated(CK1_rw));
ST_DPHD_HIPERF_2048x32m4_Tlmr_CGCprim cgc_CK2_rw (.EN(MEM_EN2_inst), .CK(CK2int), .CK_gated(CK2_rw));

ST_DPHD_HIPERF_2048x32m4_Tlmr_DFFprim_blocking dff_mem_en1 (1'b0, bypass_en1, CK1_rw, MEM_EN1_inst, MEMEN1_reg_temp);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DFFprim_blocking dff_mem_en2 (1'b0, bypass_en2, CK2_rw, MEM_EN2_inst, MEMEN2_reg_temp);
and (MEMEN1_reg, MEMEN1_reg_temp, !bypass_en1); // To Avoid 'Z' violations
and (MEMEN2_reg, MEMEN2_reg_temp, !bypass_en2); // To Avoid 'Z' violations

and (bypass_en1, GAC1 ,ATP, !SE_latch_CK1, TBYPASS);
and (bypass_en2, GAC2 ,ATP, !SE_latch_CK2, TBYPASS);

ST_DPHD_HIPERF_2048x32m4_Tlmr_outputmux omux1 (.Q(Q1), .D_scff_out(D1_scff_out), .bypass_en(bypass_en1), .Q_CORE(Q1_CORE), .MEMEN_reg(MEMEN1_reg));
ST_DPHD_HIPERF_2048x32m4_Tlmr_outputmux omux2 (.Q(Q2), .D_scff_out(D2_scff_out), .bypass_en(bypass_en2), .Q_CORE(Q2_CORE), .MEMEN_reg(MEMEN2_reg));



endmodule
`endcelldefine

/*-------------------------------------------------------
        module definition for Output MUX block
--------------------------------------------------------*/

module ST_DPHD_HIPERF_2048x32m4_Tlmr_outputmux ( Q, D_scff_out, bypass_en, Q_CORE, MEMEN_reg);

parameter bits = 32;

input   MEMEN_reg;
input [bits-1:0] Q_CORE;
input bypass_en;
input [bits-1:0] D_scff_out;
output [bits-1:0] Q;
trireg (medium) [bits-1:0] Q;

ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_0 (MEMEN_reg, Q_CORE[0], Q[0]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_1 (MEMEN_reg, Q_CORE[1], Q[1]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_2 (MEMEN_reg, Q_CORE[2], Q[2]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_3 (MEMEN_reg, Q_CORE[3], Q[3]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_4 (MEMEN_reg, Q_CORE[4], Q[4]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_5 (MEMEN_reg, Q_CORE[5], Q[5]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_6 (MEMEN_reg, Q_CORE[6], Q[6]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_7 (MEMEN_reg, Q_CORE[7], Q[7]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_8 (MEMEN_reg, Q_CORE[8], Q[8]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_9 (MEMEN_reg, Q_CORE[9], Q[9]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_10 (MEMEN_reg, Q_CORE[10], Q[10]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_11 (MEMEN_reg, Q_CORE[11], Q[11]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_12 (MEMEN_reg, Q_CORE[12], Q[12]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_13 (MEMEN_reg, Q_CORE[13], Q[13]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_14 (MEMEN_reg, Q_CORE[14], Q[14]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_15 (MEMEN_reg, Q_CORE[15], Q[15]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_16 (MEMEN_reg, Q_CORE[16], Q[16]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_17 (MEMEN_reg, Q_CORE[17], Q[17]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_18 (MEMEN_reg, Q_CORE[18], Q[18]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_19 (MEMEN_reg, Q_CORE[19], Q[19]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_20 (MEMEN_reg, Q_CORE[20], Q[20]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_21 (MEMEN_reg, Q_CORE[21], Q[21]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_22 (MEMEN_reg, Q_CORE[22], Q[22]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_23 (MEMEN_reg, Q_CORE[23], Q[23]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_24 (MEMEN_reg, Q_CORE[24], Q[24]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_25 (MEMEN_reg, Q_CORE[25], Q[25]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_26 (MEMEN_reg, Q_CORE[26], Q[26]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_27 (MEMEN_reg, Q_CORE[27], Q[27]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_28 (MEMEN_reg, Q_CORE[28], Q[28]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_29 (MEMEN_reg, Q_CORE[29], Q[29]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_30 (MEMEN_reg, Q_CORE[30], Q[30]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim memory_path_31 (MEMEN_reg, Q_CORE[31], Q[31]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_0 (bypass_en, D_scff_out[0], Q[0]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_1 (bypass_en, D_scff_out[1], Q[1]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_2 (bypass_en, D_scff_out[2], Q[2]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_3 (bypass_en, D_scff_out[3], Q[3]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_4 (bypass_en, D_scff_out[4], Q[4]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_5 (bypass_en, D_scff_out[5], Q[5]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_6 (bypass_en, D_scff_out[6], Q[6]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_7 (bypass_en, D_scff_out[7], Q[7]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_8 (bypass_en, D_scff_out[8], Q[8]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_9 (bypass_en, D_scff_out[9], Q[9]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_10 (bypass_en, D_scff_out[10], Q[10]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_11 (bypass_en, D_scff_out[11], Q[11]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_12 (bypass_en, D_scff_out[12], Q[12]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_13 (bypass_en, D_scff_out[13], Q[13]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_14 (bypass_en, D_scff_out[14], Q[14]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_15 (bypass_en, D_scff_out[15], Q[15]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_16 (bypass_en, D_scff_out[16], Q[16]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_17 (bypass_en, D_scff_out[17], Q[17]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_18 (bypass_en, D_scff_out[18], Q[18]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_19 (bypass_en, D_scff_out[19], Q[19]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_20 (bypass_en, D_scff_out[20], Q[20]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_21 (bypass_en, D_scff_out[21], Q[21]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_22 (bypass_en, D_scff_out[22], Q[22]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_23 (bypass_en, D_scff_out[23], Q[23]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_24 (bypass_en, D_scff_out[24], Q[24]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_25 (bypass_en, D_scff_out[25], Q[25]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_26 (bypass_en, D_scff_out[26], Q[26]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_27 (bypass_en, D_scff_out[27], Q[27]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_28 (bypass_en, D_scff_out[28], Q[28]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_29 (bypass_en, D_scff_out[29], Q[29]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_30 (bypass_en, D_scff_out[30], Q[30]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim bypass_path_31 (bypass_en, D_scff_out[31], Q[31]);

endmodule


`suppress_faults
module ST_DPHD_HIPERF_2048x32m4_Tlmr_mem_inst (MEM_EN1_inst, MEM_EN2_inst, CK1, A1, CK2, A2, D1, D2 , Q1_CORE, Q2_CORE, WEN1, WEN2);


parameter
    Words = 2048,
    Bits  = 32,
    Addr  = 11;

parameter
    read_margin_size = 3,
    write_margin_size = 4; 
 parameter
    repair_address_bus_width =   9 ;

parameter max_address_bits = 11;

parameter
   scanlen_ctrl_port1 = 14, 
   scanlen_ctrl_port2 = 14,
   scanlen_d1l = 16,
   scanlen_d1r = 16,
   scanlen_d2l = 16,
   scanlen_d2r = 16;  

  // Output of ports
   
   output [Bits-1:0] Q1_CORE, Q2_CORE;

  // Inputs
   input MEM_EN1_inst, MEM_EN2_inst;
   input  [Bits-1:0] D1, D2;
   input  [Addr-1:0] A1, A2;
   input  CK1,CK2, WEN1, WEN2;


    trireg (medium) [Addr-1 : 0] A1_gated, A2_gated;
    wire [Addr-1 : 0] A1_rw, A2_rw;
    trireg (medium) WEN1_rw, WEN2_rw;
    

ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_0 (MEM_EN1_inst, A1[0], A1_gated[0]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_1 (MEM_EN1_inst, A1[1], A1_gated[1]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_2 (MEM_EN1_inst, A1[2], A1_gated[2]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_3 (MEM_EN1_inst, A1[3], A1_gated[3]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_4 (MEM_EN1_inst, A1[4], A1_gated[4]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_5 (MEM_EN1_inst, A1[5], A1_gated[5]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_6 (MEM_EN1_inst, A1[6], A1_gated[6]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_7 (MEM_EN1_inst, A1[7], A1_gated[7]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_8 (MEM_EN1_inst, A1[8], A1_gated[8]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_9 (MEM_EN1_inst, A1[9], A1_gated[9]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a1_10 (MEM_EN1_inst, A1[10], A1_gated[10]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_0 (1'b0, 1'b0, !CK1, A1_gated[0], A1_rw[0]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_1 (1'b0, 1'b0, !CK1, A1_gated[1], A1_rw[1]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_2 (1'b0, 1'b0, !CK1, A1_gated[2], A1_rw[2]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_3 (1'b0, 1'b0, !CK1, A1_gated[3], A1_rw[3]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_4 (1'b0, 1'b0, !CK1, A1_gated[4], A1_rw[4]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_5 (1'b0, 1'b0, !CK1, A1_gated[5], A1_rw[5]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_6 (1'b0, 1'b0, !CK1, A1_gated[6], A1_rw[6]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_7 (1'b0, 1'b0, !CK1, A1_gated[7], A1_rw[7]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_8 (1'b0, 1'b0, !CK1, A1_gated[8], A1_rw[8]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_9 (1'b0, 1'b0, !CK1, A1_gated[9], A1_rw[9]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a1_10 (1'b0, 1'b0, !CK1, A1_gated[10], A1_rw[10]);

ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_0 (MEM_EN2_inst, A2[0], A2_gated[0]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_1 (MEM_EN2_inst, A2[1], A2_gated[1]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_2 (MEM_EN2_inst, A2[2], A2_gated[2]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_3 (MEM_EN2_inst, A2[3], A2_gated[3]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_4 (MEM_EN2_inst, A2[4], A2_gated[4]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_5 (MEM_EN2_inst, A2[5], A2_gated[5]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_6 (MEM_EN2_inst, A2[6], A2_gated[6]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_7 (MEM_EN2_inst, A2[7], A2_gated[7]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_8 (MEM_EN2_inst, A2[8], A2_gated[8]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_9 (MEM_EN2_inst, A2[9], A2_gated[9]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_a2_10 (MEM_EN2_inst, A2[10], A2_gated[10]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_0 (1'b0, 1'b0, !CK2, A2_gated[0], A2_rw[0]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_1 (1'b0, 1'b0, !CK2, A2_gated[1], A2_rw[1]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_2 (1'b0, 1'b0, !CK2, A2_gated[2], A2_rw[2]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_3 (1'b0, 1'b0, !CK2, A2_gated[3], A2_rw[3]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_4 (1'b0, 1'b0, !CK2, A2_gated[4], A2_rw[4]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_5 (1'b0, 1'b0, !CK2, A2_gated[5], A2_rw[5]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_6 (1'b0, 1'b0, !CK2, A2_gated[6], A2_rw[6]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_7 (1'b0, 1'b0, !CK2, A2_gated[7], A2_rw[7]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_8 (1'b0, 1'b0, !CK2, A2_gated[8], A2_rw[8]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_9 (1'b0, 1'b0, !CK2, A2_gated[9], A2_rw[9]);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_a2_10 (1'b0, 1'b0, !CK2, A2_gated[10], A2_rw[10]);

ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_wen1 (MEM_EN1_inst, WEN1, WEN1_rw);
ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim sw_wen2 (MEM_EN2_inst, WEN2, WEN2_rw);




ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_0 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[0]), .D2(D2[0]) , .Q1_CORE(Q1_CORE[0]), .Q2_CORE(Q2_CORE[0]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_1 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[1]), .D2(D2[1]) , .Q1_CORE(Q1_CORE[1]), .Q2_CORE(Q2_CORE[1]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_2 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[2]), .D2(D2[2]) , .Q1_CORE(Q1_CORE[2]), .Q2_CORE(Q2_CORE[2]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_3 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[3]), .D2(D2[3]) , .Q1_CORE(Q1_CORE[3]), .Q2_CORE(Q2_CORE[3]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_4 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[4]), .D2(D2[4]) , .Q1_CORE(Q1_CORE[4]), .Q2_CORE(Q2_CORE[4]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_5 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[5]), .D2(D2[5]) , .Q1_CORE(Q1_CORE[5]), .Q2_CORE(Q2_CORE[5]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_6 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[6]), .D2(D2[6]) , .Q1_CORE(Q1_CORE[6]), .Q2_CORE(Q2_CORE[6]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_7 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[7]), .D2(D2[7]) , .Q1_CORE(Q1_CORE[7]), .Q2_CORE(Q2_CORE[7]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_8 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[8]), .D2(D2[8]) , .Q1_CORE(Q1_CORE[8]), .Q2_CORE(Q2_CORE[8]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_9 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[9]), .D2(D2[9]) , .Q1_CORE(Q1_CORE[9]), .Q2_CORE(Q2_CORE[9]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_10 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[10]), .D2(D2[10]) , .Q1_CORE(Q1_CORE[10]), .Q2_CORE(Q2_CORE[10]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_11 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[11]), .D2(D2[11]) , .Q1_CORE(Q1_CORE[11]), .Q2_CORE(Q2_CORE[11]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_12 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[12]), .D2(D2[12]) , .Q1_CORE(Q1_CORE[12]), .Q2_CORE(Q2_CORE[12]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_13 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[13]), .D2(D2[13]) , .Q1_CORE(Q1_CORE[13]), .Q2_CORE(Q2_CORE[13]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_14 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[14]), .D2(D2[14]) , .Q1_CORE(Q1_CORE[14]), .Q2_CORE(Q2_CORE[14]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_15 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[15]), .D2(D2[15]) , .Q1_CORE(Q1_CORE[15]), .Q2_CORE(Q2_CORE[15]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_16 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[16]), .D2(D2[16]) , .Q1_CORE(Q1_CORE[16]), .Q2_CORE(Q2_CORE[16]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_17 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[17]), .D2(D2[17]) , .Q1_CORE(Q1_CORE[17]), .Q2_CORE(Q2_CORE[17]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_18 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[18]), .D2(D2[18]) , .Q1_CORE(Q1_CORE[18]), .Q2_CORE(Q2_CORE[18]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_19 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[19]), .D2(D2[19]) , .Q1_CORE(Q1_CORE[19]), .Q2_CORE(Q2_CORE[19]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_20 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[20]), .D2(D2[20]) , .Q1_CORE(Q1_CORE[20]), .Q2_CORE(Q2_CORE[20]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_21 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[21]), .D2(D2[21]) , .Q1_CORE(Q1_CORE[21]), .Q2_CORE(Q2_CORE[21]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_22 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[22]), .D2(D2[22]) , .Q1_CORE(Q1_CORE[22]), .Q2_CORE(Q2_CORE[22]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_23 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[23]), .D2(D2[23]) , .Q1_CORE(Q1_CORE[23]), .Q2_CORE(Q2_CORE[23]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_24 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[24]), .D2(D2[24]) , .Q1_CORE(Q1_CORE[24]), .Q2_CORE(Q2_CORE[24]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_25 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[25]), .D2(D2[25]) , .Q1_CORE(Q1_CORE[25]), .Q2_CORE(Q2_CORE[25]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_26 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[26]), .D2(D2[26]) , .Q1_CORE(Q1_CORE[26]), .Q2_CORE(Q2_CORE[26]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_27 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[27]), .D2(D2[27]) , .Q1_CORE(Q1_CORE[27]), .Q2_CORE(Q2_CORE[27]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_28 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[28]), .D2(D2[28]) , .Q1_CORE(Q1_CORE[28]), .Q2_CORE(Q2_CORE[28]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_29 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[29]), .D2(D2[29]) , .Q1_CORE(Q1_CORE[29]), .Q2_CORE(Q2_CORE[29]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_30 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[30]), .D2(D2[30]) , .Q1_CORE(Q1_CORE[30]), .Q2_CORE(Q2_CORE[30]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );

ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst rw_31 (.CK1(CK1), .A1(A1_rw), .CK2(CK2), .A2(A2_rw), .D1(D1[31]), .D2(D2[31]) , .Q1_CORE(Q1_CORE[31]), .Q2_CORE(Q2_CORE[31]), .WEN1(WEN1_rw), .WEN2(WEN2_rw) );



endmodule
//---mem_inst
`nosuppress_faults

//----1 bit memory model-----

`suppress_faults
`define readaddrx xfill_async_out_all
`define read_write readx
`define write_write xword

module ST_DPHD_HIPERF_2048x32m4_Tlmr_1b_inst (CK1, A1, CK2, A2, D1, D2 , Q1_CORE, Q2_CORE, WEN1, WEN2) ;

  parameter addrbits = 11;
  parameter databits = 1; 
  parameter words = 2048;
  parameter addrmax = 2048;


  output [databits-1 : 0] Q1_CORE, Q2_CORE;
  input [databits-1 : 0] D1, D2;

  input [addrbits-1 : 0] A1,A2;
  input CK1;
  input CK2;
  input WEN1, WEN2;


  reg [databits-1 : 0] DO1,DO2, D1_dummy, D2_dummy ;

  reg [databits-1 : 0] memory [0 : addrmax-1];


    
    buf (write1_mp,!WEN1);
    buf (write2_mp,!WEN2);
    

// port1 
  always @ (posedge CK1) 
       if (WEN1) begin
          DO1 = memory[A1]; 
       end
    
    always @ (posedge CK1) 
       if (write1_mp) begin
          memory[A1] = D1[0];
       end

 

// port 2
  always @ (posedge CK2) 
       if (WEN2) begin
          DO2 = memory[A2]; 
       end
    
    always @ (posedge CK2) 
       if (write2_mp) begin
          memory[A2] = D2[0];
       end

 


 buf (Q1_CORE, DO1);
 buf (Q2_CORE, DO2);


endmodule

`undef readaddrx 
`undef read_write
`undef write_write
`nosuppress_faults


//---------------------------
//redundancy related:




`celldefine

module ST_DPHD_HIPERF_2048x32m4_Tlmr_CGCprim (EN, CK, CK_gated);
input EN, CK;
output CK_gated;
wire EN_latch;

ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_cgc (1'b0, 1'b0, !CK, EN, EN_latch);
and (CK_gated, CK, EN_latch);

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_SCFF (D,TI,TE,CP,Q);
input D,TI,TE,CP;
output Q;

ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim mux_in_scff (TE, D, TI, temp);
ST_DPHD_HIPERF_2048x32m4_Tlmr_DFFprim dff_in_scff (1'b0, 1'b0, CP, temp, Q);

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_lock_up_latch (CK, D, Q);
input CK,D;
output Q;

ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim dlat_lockup (1'b0, 1'b0, CK, D, Q);

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_DFFprim (SET,CLR,CK,D,Q);
output Q;
input D,SET,CLR,CK;

_DFF dff (SET,CLR,CK,D,Q);

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_DFFprim_blocking (SET,CLR,CK,D,Q);
output Q;
input D,SET,CLR,CK;

_DFF dff (SET,CLR,CK,D,Q);

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_DLATprim (SET,CLR,CK,D,Q);
output Q;
input D,SET,CLR,CK;

_DLAT dlat (SET,CLR,CK,D,Q);

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_SWprim (control,in,out);
output out;
input control,in;

_SW sw (control, in, out);

endmodule

module ST_DPHD_HIPERF_2048x32m4_Tlmr_TSDprim (control,in,out);
input control, in;
output out;

_TSD tsd (control, in, out);

endmodule


module ST_DPHD_HIPERF_2048x32m4_Tlmr_MUXprim (SEL, A, B, Z);
input SEL, A, B;
output Z;

ST_DPHD_HIPERF_2048x32m4_Tlmr_TSDprim tsd_mux_path0 (!SEL,A,Z);
ST_DPHD_HIPERF_2048x32m4_Tlmr_TSDprim tsd_mux_path1 (SEL,B,Z);

endmodule


`endcelldefine




