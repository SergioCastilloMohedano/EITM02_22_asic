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




/****************************************************************
--  Description         : Emulator Model 
--  ModelVersion        : 2.1
--  Date                : Dec, 2014
--  Changes Made by	: RSS
****************************************************************/


/************************************** START OF HEADER *****************************************
   This Header Gives Information about the parameters & options present in the Model
   
   words = 4096
   bits  = 32
   mux   = 8 
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


//********************************************//
//        ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT Emulator model
//********************************************//


module ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT (A, ATP, CK, CSN, D , IG, INITN , Q, SCTRLI,SCTRLO,SDLI,SDLO,SDRI,SDRO,SE, STDBY ,TA,TBIST, TBYPASS ,TCSN,TED  ,TOD  , TWEN, WEN);   

parameter
        `ifdef ST_MEM_CONFIGFAULT
                ConfigFault = 1,
        `else
                ConfigFault = 0,
        `endif
        
        `ifdef ST_NO_MSG_MODE  
                p_debug_level = 2'b00,
        `elsif ST_ALL_MSG_MODE  
                p_debug_level = 2'b11,
        `elsif ST_ERROR_ONLY_MODE 
                p_debug_level = 2'b01,
        `else 
                p_debug_level = 2'b10,
        `endif
        power_pins_config = 2'b00,
        Fault_file_name = "ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT_faults.txt",
        max_faults = 4096+2,
        MEM_INITIALIZE  = 1'b0,
        BinaryInit = 1'b0,
        InitFileName = "ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT.cde",
        Debug_mode = "all_warning_mode",
        File_load_time=0,
        InstancePath = "ST_SPHD_HIPERF_4096x32m8_Tlmr_HIPERF_CUT",
        p_pswsmallma_settling_time = 0,
        p_pswlargema_settling_time = 0,
        p_pswsmallmp_settling_time = 0,
        p_pswlargemp_settling_time = 0,
        message_control_time = 0,
        mem_block_ctrl_time = 0;
    parameter
        words = 4096,
        bits = 32,
        Addr = 12,
        max_address_bits = 12,
        
        mux = 8,
        Logmux = 3,
        mux_bits=3,
        bank_bits=0,
        RedWords = mux * 2 * 1,
        Rows = words/mux,
        repair_address_width = 9,
        write_margin_size = 2, 
        read_margin_size = 3;

    parameter 
       scanlen_ctrl=17,
       
       scanlen_r=16,
       scanlen_l=16;
        

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
        
        
        
        output SCTRLO, SDLO, SDRO;
        
        
        

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
        
        

//-------------------------------------------------------------------------------
//                      INTERNAL VARIABLE DECLARATION
//-------------------------------------------------------------------------------

 reg [bits-1 : 0] Mem [words-1 : 0];
 reg [bits-1 : 0] Qreg;



//-------------------------------------------------------------------------------
//                      READ/WRITE FUNCTIONALITY STARTS
//-------------------------------------------------------------------------------

`ifdef empty

`elsif dummy

assign Q = 32'b0;

`else

genvar i;
generate
for (i=0; i < bits ; i=i+1) begin : MEM
always @ (posedge CK)
  begin
  if ( STDBY == 1'b0 && INITN == 1'b1) begin   
   if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 ) ) begin
    if (CSN == 0 && IG == 1'b0) begin  
     if (WEN == 1'b0) begin     
      
        //Write Cycle
        Mem[A][i] <= D[i];
      
     end //if (WEN== 1'b0)
     else if(WEN == 1'b1) begin        
        //Read Cycle
        Qreg[i] <= Mem[A][i];
     end //else if(WEN 
    end //if (CSN == 0
   end //if (ATP == 1'b0
  end  //if ( STDBY == 1'b0
 end  // always @ (pos
end // for (i=0; 
endgenerate
assign Q =  Qreg;

`endif

//-------------------------------------------------------------------------------
//                       READ/WRITE FUNCTIONALITY ENDS
//-------------------------------------------------------------------------------
 
endmodule







/****************************************************************
--  Description         : Emulator Model 
--  ModelVersion        : 2.1
--  Date                : Dec, 2014
--  Changes Made by	: RSS
****************************************************************/


/************************************** START OF HEADER *****************************************
   This Header Gives Information about the parameters & options present in the Model
   
   words = 1024
   bits  = 32
   mux   = 4 
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


//********************************************//
//        ST_SPHD_HIPERF_1024x32m4_Tlmr Emulator model
//********************************************//


module ST_SPHD_HIPERF_1024x32m4_Tlmr (A, ATP, CK, CSN, D , IG, INITN , Q, SCTRLI,SCTRLO,SDLI,SDLO,SDRI,SDRO,SE, STDBY ,TA,TBIST, TBYPASS ,TCSN,TED  ,TOD  , TWEN, WEN);   

parameter
        `ifdef ST_MEM_CONFIGFAULT
                ConfigFault = 1,
        `else
                ConfigFault = 0,
        `endif
        
        `ifdef ST_NO_MSG_MODE  
                p_debug_level = 2'b00,
        `elsif ST_ALL_MSG_MODE  
                p_debug_level = 2'b11,
        `elsif ST_ERROR_ONLY_MODE 
                p_debug_level = 2'b01,
        `else 
                p_debug_level = 2'b10,
        `endif
        power_pins_config = 2'b00,
        Fault_file_name = "ST_SPHD_HIPERF_1024x32m4_Tlmr_faults.txt",
        max_faults = 1024+2,
        MEM_INITIALIZE  = 1'b0,
        BinaryInit = 1'b0,
        InitFileName = "ST_SPHD_HIPERF_1024x32m4_Tlmr.cde",
        Debug_mode = "all_warning_mode",
        File_load_time=0,
        InstancePath = "ST_SPHD_HIPERF_1024x32m4_Tlmr",
        p_pswsmallma_settling_time = 0,
        p_pswlargema_settling_time = 0,
        p_pswsmallmp_settling_time = 0,
        p_pswlargemp_settling_time = 0,
        message_control_time = 0,
        mem_block_ctrl_time = 0;
    parameter
        words = 1024,
        bits = 32,
        Addr = 10,
        max_address_bits = 11,
        
        mux = 4,
        Logmux = 2,
        mux_bits=2,
        bank_bits=0,
        RedWords = mux * 2 * 1,
        Rows = words/mux,
        repair_address_width = 8,
        write_margin_size = 2, 
        read_margin_size = 3;

    parameter 
       scanlen_ctrl=17,
       
       scanlen_r=16,
       scanlen_l=16;
        

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
        
        
        
        output SCTRLO, SDLO, SDRO;
        
        
        

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
        
        

//-------------------------------------------------------------------------------
//                      INTERNAL VARIABLE DECLARATION
//-------------------------------------------------------------------------------

 reg [bits-1 : 0] Mem [words-1 : 0];
 reg [bits-1 : 0] Qreg;



//-------------------------------------------------------------------------------
//                      READ/WRITE FUNCTIONALITY STARTS
//-------------------------------------------------------------------------------

`ifdef empty

`elsif dummy

assign Q = 32'b0;

`else

genvar i;
generate
for (i=0; i < bits ; i=i+1) begin : MEM
always @ (posedge CK)
  begin
  if ( STDBY == 1'b0 && INITN == 1'b1) begin   
   if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 ) ) begin
    if (CSN == 0 && IG == 1'b0) begin  
     if (WEN == 1'b0) begin     
      
        //Write Cycle
        Mem[A][i] <= D[i];
      
     end //if (WEN== 1'b0)
     else if(WEN == 1'b1) begin        
        //Read Cycle
        Qreg[i] <= Mem[A][i];
     end //else if(WEN 
    end //if (CSN == 0
   end //if (ATP == 1'b0
  end  //if ( STDBY == 1'b0
 end  // always @ (pos
end // for (i=0; 
endgenerate
assign Q =  Qreg;

`endif

//-------------------------------------------------------------------------------
//                       READ/WRITE FUNCTIONALITY ENDS
//-------------------------------------------------------------------------------
 
endmodule







/****************************************************************
--  Description         : Emulator Model 
--  ModelVersion        : 2.1
--  Date                : Dec, 2014
--  Changes Made by	: RSS
****************************************************************/


/************************************** START OF HEADER *****************************************
   This Header Gives Information about the parameters & options present in the Model
   
   words = 3072
   bits  = 32
   mux   = 8 
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


//********************************************//
//        ST_SPHD_HIPERF_3072x32m8_Tlmr Emulator model
//********************************************//


module ST_SPHD_HIPERF_3072x32m8_Tlmr (A, ATP, CK, CSN, D , IG, INITN , Q, SCTRLI,SCTRLO,SDLI,SDLO,SDRI,SDRO,SE, STDBY ,TA,TBIST, TBYPASS ,TCSN,TED  ,TOD  , TWEN, WEN);   

parameter
        `ifdef ST_MEM_CONFIGFAULT
                ConfigFault = 1,
        `else
                ConfigFault = 0,
        `endif
        
        `ifdef ST_NO_MSG_MODE  
                p_debug_level = 2'b00,
        `elsif ST_ALL_MSG_MODE  
                p_debug_level = 2'b11,
        `elsif ST_ERROR_ONLY_MODE 
                p_debug_level = 2'b01,
        `else 
                p_debug_level = 2'b10,
        `endif
        power_pins_config = 2'b00,
        Fault_file_name = "ST_SPHD_HIPERF_3072x32m8_Tlmr_faults.txt",
        max_faults = 3072+2,
        MEM_INITIALIZE  = 1'b0,
        BinaryInit = 1'b0,
        InitFileName = "ST_SPHD_HIPERF_3072x32m8_Tlmr.cde",
        Debug_mode = "all_warning_mode",
        File_load_time=0,
        InstancePath = "ST_SPHD_HIPERF_3072x32m8_Tlmr",
        p_pswsmallma_settling_time = 0,
        p_pswlargema_settling_time = 0,
        p_pswsmallmp_settling_time = 0,
        p_pswlargemp_settling_time = 0,
        message_control_time = 0,
        mem_block_ctrl_time = 0;
    parameter
        words = 3072,
        bits = 32,
        Addr = 12,
        max_address_bits = 12,
        
        mux = 8,
        Logmux = 3,
        mux_bits=3,
        bank_bits=0,
        RedWords = mux * 2 * 1,
        Rows = words/mux,
        repair_address_width = 9,
        write_margin_size = 2, 
        read_margin_size = 3;

    parameter 
       scanlen_ctrl=17,
       
       scanlen_r=16,
       scanlen_l=16;
        

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
        
        
        
        output SCTRLO, SDLO, SDRO;
        
        
        

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
        
        

//-------------------------------------------------------------------------------
//                      INTERNAL VARIABLE DECLARATION
//-------------------------------------------------------------------------------

 reg [bits-1 : 0] Mem [words-1 : 0];
 reg [bits-1 : 0] Qreg;



//-------------------------------------------------------------------------------
//                      READ/WRITE FUNCTIONALITY STARTS
//-------------------------------------------------------------------------------

`ifdef empty

`elsif dummy

assign Q = 32'b0;

`else

genvar i;
generate
for (i=0; i < bits ; i=i+1) begin : MEM
always @ (posedge CK)
  begin
  if ( STDBY == 1'b0 && INITN == 1'b1) begin   
   if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 ) ) begin
    if (CSN == 0 && IG == 1'b0) begin  
     if (WEN == 1'b0) begin     
      
        //Write Cycle
        Mem[A][i] <= D[i];
      
     end //if (WEN== 1'b0)
     else if(WEN == 1'b1) begin        
        //Read Cycle
        Qreg[i] <= Mem[A][i];
     end //else if(WEN 
    end //if (CSN == 0
   end //if (ATP == 1'b0
  end  //if ( STDBY == 1'b0
 end  // always @ (pos
end // for (i=0; 
endgenerate
assign Q =  Qreg;

`endif

//-------------------------------------------------------------------------------
//                       READ/WRITE FUNCTIONALITY ENDS
//-------------------------------------------------------------------------------
 
endmodule







/****************************************************************
--  Description         : Emulator Model 
--  ModelVersion        : 2.1
--  Date                : Dec, 2014
--  Changes Made by	: RSS
****************************************************************/


/************************************** START OF HEADER *****************************************
   This Header Gives Information about the parameters & options present in the Model
   
   words = 2048
   bits  = 32
   mux   = 8 
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


//********************************************//
//        ST_SPHD_HIPERF_2048x32m8_Tlmr Emulator model
//********************************************//


module ST_SPHD_HIPERF_2048x32m8_Tlmr (A, ATP, CK, CSN, D , IG, INITN , Q, SCTRLI,SCTRLO,SDLI,SDLO,SDRI,SDRO,SE, STDBY ,TA,TBIST, TBYPASS ,TCSN,TED  ,TOD  , TWEN, WEN);   

parameter
        `ifdef ST_MEM_CONFIGFAULT
                ConfigFault = 1,
        `else
                ConfigFault = 0,
        `endif
        
        `ifdef ST_NO_MSG_MODE  
                p_debug_level = 2'b00,
        `elsif ST_ALL_MSG_MODE  
                p_debug_level = 2'b11,
        `elsif ST_ERROR_ONLY_MODE 
                p_debug_level = 2'b01,
        `else 
                p_debug_level = 2'b10,
        `endif
        power_pins_config = 2'b00,
        Fault_file_name = "ST_SPHD_HIPERF_2048x32m8_Tlmr_faults.txt",
        max_faults = 2048+2,
        MEM_INITIALIZE  = 1'b0,
        BinaryInit = 1'b0,
        InitFileName = "ST_SPHD_HIPERF_2048x32m8_Tlmr.cde",
        Debug_mode = "all_warning_mode",
        File_load_time=0,
        InstancePath = "ST_SPHD_HIPERF_2048x32m8_Tlmr",
        p_pswsmallma_settling_time = 0,
        p_pswlargema_settling_time = 0,
        p_pswsmallmp_settling_time = 0,
        p_pswlargemp_settling_time = 0,
        message_control_time = 0,
        mem_block_ctrl_time = 0;
    parameter
        words = 2048,
        bits = 32,
        Addr = 11,
        max_address_bits = 12,
        
        mux = 8,
        Logmux = 3,
        mux_bits=3,
        bank_bits=0,
        RedWords = mux * 2 * 1,
        Rows = words/mux,
        repair_address_width = 8,
        write_margin_size = 2, 
        read_margin_size = 3;

    parameter 
       scanlen_ctrl=17,
       
       scanlen_r=16,
       scanlen_l=16;
        

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
        
        
        
        output SCTRLO, SDLO, SDRO;
        
        
        

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
        
        

//-------------------------------------------------------------------------------
//                      INTERNAL VARIABLE DECLARATION
//-------------------------------------------------------------------------------

 reg [bits-1 : 0] Mem [words-1 : 0];
 reg [bits-1 : 0] Qreg;



//-------------------------------------------------------------------------------
//                      READ/WRITE FUNCTIONALITY STARTS
//-------------------------------------------------------------------------------

`ifdef empty

`elsif dummy

assign Q = 32'b0;

`else

genvar i;
generate
for (i=0; i < bits ; i=i+1) begin : MEM
always @ (posedge CK)
  begin
  if ( STDBY == 1'b0 && INITN == 1'b1) begin   
   if (ATP == 1'b0 || ( ATP == 1'b1 && TBYPASS == 1'b0 && SE == 1'b0 ) ) begin
    if (CSN == 0 && IG == 1'b0) begin  
     if (WEN == 1'b0) begin     
      
        //Write Cycle
        Mem[A][i] <= D[i];
      
     end //if (WEN== 1'b0)
     else if(WEN == 1'b1) begin        
        //Read Cycle
        Qreg[i] <= Mem[A][i];
     end //else if(WEN 
    end //if (CSN == 0
   end //if (ATP == 1'b0
  end  //if ( STDBY == 1'b0
 end  // always @ (pos
end // for (i=0; 
endgenerate
assign Q =  Qreg;

`endif

//-------------------------------------------------------------------------------
//                       READ/WRITE FUNCTIONALITY ENDS
//-------------------------------------------------------------------------------
 
endmodule



