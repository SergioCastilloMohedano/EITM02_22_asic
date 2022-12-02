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



/****************************************************************
--  Description         : Emulator Model
--  Last Updated in     : 1.4 
--  Date                : Sep, 2014
--  Changes Made by	: RSS
--  Changes             : Configuration variableadded 
****************************************************************/


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
// ST_DPHD_HIPERF_2048x32m4_Tlmr Emulator model
//********************************************//

module ST_DPHD_HIPERF_2048x32m4_Tlmr (A1, A2, ATP, CK1, CK2, CSN1, CSN2, D1, D2 , IG1, IG2, INITN   , MTCK   , Q1, Q2    ,SCTRLI1, SCTRLI2, SCTRLO1, SCTRLO2, SDLI1, SDLI2, SDLO1, SDLO2, SDRI1, SDRI2, SDRO1, SDRO2, SE   , STDBY1, STDBY2  , TA1, TA2, TBIST, TBYPASS, TCSN1, TCSN2, TED1, TED2  , TOD1, TOD2  , TP  , TWEN1, TWEN2, WEN1, WEN2      );

parameter
    p_debug_level = 2'b00,
    power_pins_config = 2'b11,
    Fault_file_name = "ST_DPHD_HIPERF_2048x32m4_Tlmr_faults.txt",
      ConfigFault = 0,
    max_faults = 20,
    MEM_INITIALIZE  = 1'b0,
    BinaryInit = 1'b0,
    File_load_time=0,
    Initn_reset_value={32{1'b0}},
    InitFileName = "ST_DPHD_HIPERF_2048x32m4_Tlmr.cde",
    InstancePath = "ST_DPHD_HIPERF_2048x32m4_Tlmr",
    p_pswsmallma_settling_time = 0,
    p_pswlargema_settling_time = 0,
    p_pswsmallmp_settling_time = 0,
    p_pswlargemp_settling_time = 0,
    message_control_time = 0,
    mem_block_ctrl_time = 0;
    
    
parameter
    Words = 2048,
    Bits  = 32,
    Addr  = 11;

parameter
    mux = 4,
    bank = 1,
    mux_bits=2,
    bank_bits= 0,  
//log1 = 0. so for single bank bank bit =0
    Rows = Words/mux;

parameter
    read_margin_size = 3,
    write_margin_size = 4;

parameter
     repair_address_bus_width =   9 ,
     no_of_red_rows_in_a_bank = 2,
     RedWords = (bank * no_of_red_rows_in_a_bank * mux) ;


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


 
 

  

//-------
reg [Bits-1 : 0] Mem [Words-1 : 0];
reg [Bits-1 : 0] Q1reg, Q2reg;

/*========================MEMORY R/W IMPLEMENTATION===========================*/


`ifdef empty

`elsif dummy

assign Q1 = 32'b0;
assign Q2 = 32'b0;

`else


genvar i;
generate
for (i=0; i < Bits ; i=i+1) begin : MEM



always @ (posedge CK1)
begin
 if ( IG1 == 1'b0 && INITN == 1'b1 && STDBY1 == 1'b0  ) begin
  if (CSN1 == 1'b0)
  begin
 
     if (WEN1 == 1'b0) //Write Cycle
      begin     
           if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 && TBIST == 1'b0) )   
           begin
         
            Mem[A1][i] <= D1[i];
         
       end //if (ATP
      end // if (WEN

     if (WEN1 == 1'b1) //read cycle
     begin
       if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 && TBIST == 1'b0) )   
       begin
           Q1reg[i] <= Mem[A1][i];
       end // if (ATP
     end //if(WEN  


  end //if (CSN =  
 end //if (INITN
end //


always @ (posedge CK2)
begin
 if ( IG2 == 1'b0 && INITN == 1'b1 && STDBY2 == 1'b0 ) begin
  if (CSN2 == 1'b0)
  begin
 
     if (WEN2 == 1'b0) //Write Cycle
      begin     
           if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 && TBIST == 1'b0) )   
           begin
         
            Mem[A2][i] <= D2[i];
           
         

       end //if (ATP
      end // if (WEN

     if (WEN2 == 1'b1) //read cycle
     begin
       if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 && TBIST == 1'b0) )   
       begin
            Q2reg[i] <= Mem[A2][i];
       end // if (ATP
     end //if(WEN  


  end //if (CSN =  
 end //if (INITN
end //

end // for (i=0; 
endgenerate

assign Q1 =  Q1reg;
assign Q2 =  Q2reg;

`endif
/*============================================================================*/

///************ Assertions to flag an read/write contention conditions*********///
  //assertions not supported 

endmodule



