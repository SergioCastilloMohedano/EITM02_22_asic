//  
//  
//  ------------------------------------------------------------
//    STMicroelectronics N.V. 2015
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
//    Project        : CMP_LUND_151009         
//    Division       : Not known               
//    Creation date  : 09 October 2015         
//    Generator mode : MemConfMAT10/distributed
//    
//    WebGen configuration              : C28SOI_MEM_SRAM_SPHD_HIPERF:781,20:MemConfMAT10/distributed:3.2-00
//  
//    HDL C28SOI_ST_SP Compiler version : 2.2@20150309.0 at Mar-09-2015 (PTBL date)                          
//    
//  
//  For more information about the cuts or the generation environment, please
//  refer to files uk.env and ugnGuiSetupDB in directory DESIGN_DATA.
//   
//  
//  





/**************************************************************************************************

--  Description         : Verilog_Wrapper_Model
--  ModelVersion        : 1.8
--  Date                : Sept, 2014
--  Changes Made by	: PS

***************************************************************************************************/


/******************** START OF HEADER****************************
   This Header Gives Information about the parameters & options present in the Model
   
   words = 4096
   bits  = 32
   mux   = 8 
   
   
   
   
   dft = Yes
   Bist Mux = Yes


 
   ---------------------------------------------------------------------------------------------
     Signal Name             | Description       |             Port Mode        | Active When
                             |                   |          r    |  w   | rw    |
   ----------------------------------------------------------------------------------------------


    A                            Address                     x      x      na       -
    CK                           Clock	                     x      x      na       Posedge
    CSN                          Chip Enable                 x      x      na       Low
    D 	                         Data in                     na     x      na       -  

    INITN                        INITN pin                   x      x      na       Low


    Q 	                         Data out	             x      na     na       -
    WEN                          Write Enable                 na      x     na        Low 

**********************END OF HEADER ******************************/


module ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT_wrapper (A, CK, CSN, D, INITN, Q, WEN);

        parameter
        Words = 4096,
        Bits = 32,
        mux = 8,
        Bits_Func =  32, 
        mask_bits =  32, 
        repair_address_width = 9, 
        
        Addr = 12; 

        parameter

        read_margin_size = 3,
        write_margin_size = 2;


        output [Bits_Func-1 : 0] Q;
        
       
        input [Addr-1 : 0] A;
        input CK;
        input CSN;
        input INITN;
        input [Bits_Func-1 : 0] D ;
	
        input WEN;
        
        
       

       

        wire ATP,IG,SCTRLI,SDLI,SDRI, SE,    STDBY,TBIST,TCSN,TED,TEM,TOD,TOM,TWEN, SDLO, SDRO,SCTRLO;
             
        wire TBYPASS;
        
        

        

        

        
        
        

        
        wire [Addr-1 :0 ] TA;

        wire SLEEP;
        buf (SLEEP, 1'b0);


        

        buf (ATP, 1'b0);
        buf (IG, 1'b0);
        buf (SCTRLI, 1'b0);
        buf (SDLI, 1'b0);
        buf (SDRI, 1'b0);
        buf (SE, 1'b0);
        
        
        
         
        buf (STDBY, 1'b0);
        buf (TBIST, 1'b0);
        buf (TBYPASS, 1'b0);
        buf (TCSN, 1'b0);
        buf (TED, 1'b0);
        buf (TEM, 1'b0);
        buf (TOD, 1'b0);
        buf (TOM, 1'b0);
        buf (TWEN, 1'b0);
        
        
        buf (TA[0], 1'b0);
buf (TA[1], 1'b0);
buf (TA[2], 1'b0);
buf (TA[3], 1'b0);
buf (TA[4], 1'b0);
buf (TA[5], 1'b0);
buf (TA[6], 1'b0);
buf (TA[7], 1'b0);
buf (TA[8], 1'b0);
buf (TA[9], 1'b0);
buf (TA[10], 1'b0);
buf (TA[11], 1'b0);
        

ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT I1 (.A(A), .ATP(ATP), .CK(CK), .CSN(CSN), .D(D), .IG(IG), .INITN(INITN) , .Q(Q), .SCTRLI(SCTRLI), .SCTRLO(SCTRLO), .SDLI(SDLI), .SDLO(SDLO), .SDRI(SDRI), .SDRO(SDRO), .SE(SE),  .STDBY(STDBY) , .TA(TA), .TBIST(TBIST), .TBYPASS(TBYPASS) , .TCSN(TCSN), .TED(TED) , .TOD(TOD), .TWEN(TWEN), .WEN(WEN));

endmodule