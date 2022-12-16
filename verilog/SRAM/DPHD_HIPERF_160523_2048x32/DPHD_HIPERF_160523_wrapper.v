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




/*********************************************************
--  Description		: verilog_wrapper_model
--  Last Modified in    : 1.4
--  Date 		: Sept, 2014
--  Last Modified By	: RSS
--  Changes Done        : IG1 and IG2 signals are internally tied to '0' which were floating earlier
**********************************************************/



module ST_DPHD_HIPERF_2048x32m4_Tlmr_wrapper (A1, A2, CK1, CK2, CSN1, CSN2, D1, D2 , INITN  , Q1, Q2, WEN1, WEN2);


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

   // Inputs 1
   
   input  [Bits-1:0] D1;
   input  [Addr-1:0] A1;
   input  CK1, CSN1, WEN1;


  // Inputs 2
   
   input  [Bits-1:0] D2;
   input  [Addr-1:0] A2;
   input  CK2, CSN2, WEN2;

      
   //Other Input Pins

   input INITN;


wire ATP, IG1, IG2;


wire MTCK;




wire SCTRLI1, SCTRLI2, SDLI1, SDLI2, SDRI1, SDRI2, SE;


wire STDBY1, STDBY2;

wire [Addr-1 : 0] TA1, TA2;
wire TBIST, TBYPASS, TCSN1, TCSN2, TED1, TED2, TOD1, TOD2;

wire TP;

wire TWEN1, TWEN2;


buf (ATP,1'b0);


buf (MTCK,1'b0);



buf (SCTRLI1,1'b0);
buf (SCTRLI2,1'b0);
buf (SDLI1,1'b0);
buf (SDLI2,1'b0);
buf (SDRI1,1'b0);
buf (SDRI2,1'b0);
buf (SE,1'b0);


buf (STDBY1,1'b0);
buf (STDBY2,1'b0);

buf (TA1[0],1'b0);
buf (TA1[1],1'b0);
buf (TA1[2],1'b0);
buf (TA1[3],1'b0);
buf (TA1[4],1'b0);
buf (TA1[5],1'b0);
buf (TA1[6],1'b0);
buf (TA1[7],1'b0);
buf (TA1[8],1'b0);
buf (TA1[9],1'b0);
buf (TA1[10],1'b0);
buf (TA2[0],1'b0);
buf (TA2[1],1'b0);
buf (TA2[2],1'b0);
buf (TA2[3],1'b0);
buf (TA2[4],1'b0);
buf (TA2[5],1'b0);
buf (TA2[6],1'b0);
buf (TA2[7],1'b0);
buf (TA2[8],1'b0);
buf (TA2[9],1'b0);
buf (TA2[10],1'b0);
buf (TBIST,1'b0);
buf (TBYPASS,1'b0);
buf (TCSN1,1'b0);
buf (TCSN2,1'b0);
buf (TED1,1'b0);
buf (TED2,1'b0);

buf (TOD1,1'b0);
buf (TOD2,1'b0);

buf (TP,1'b0);

buf (TWEN1,1'b0);
buf (TWEN2,1'b0);

buf (IG1,1'b0);
buf (IG2,1'b0);


ST_DPHD_HIPERF_2048x32m4_Tlmr inst1 (.A1(A1), .A2(A2), .ATP(ATP), .CK1(CK1), .CK2(CK2), .CSN1(CSN1), .CSN2(CSN2), .D1(D1), .D2(D2) , .IG1(IG1), .IG2(IG2), .INITN(INITN)   , .MTCK(MTCK)   , .Q1(Q1), .Q2(Q2)    ,.SCTRLI1(SCTRLI1), .SCTRLI2(SCTRLI2), .SCTRLO1(SCTRLO1), .SCTRLO2(SCTRLO2), .SDLI1(SDLI1), .SDLI2(SDLI2), .SDLO1(SDLO1), .SDLO2(SDLO2), .SDRI1(SDRI1), .SDRI2(SDRI2), .SDRO1(SDRO1), .SDRO2(SDRO2), .SE(SE)    , .STDBY1(STDBY1), .STDBY2(STDBY2)  , .TA1(TA1), .TA2(TA2), .TBIST(TBIST), .TBYPASS(TBYPASS), .TCSN1(TCSN1), .TCSN2(TCSN2), .TED1(TED1), .TED2(TED2)  , .TOD1(TOD1), .TOD2(TOD2)  , .TP(TP)  , .TWEN1(TWEN1), .TWEN2(TWEN2), .WEN1(WEN1), .WEN2(WEN2) );

endmodule



