module ST_SPHD_HIPERF_8192x32m16_Tlmr (ATP,CK,CSN,IG,INITN,SCTRLI,SCTRLO,SDLI,SDLO,
 SDRI,SDRO,SE,STDBY,TBIST,TBYPASS,TCSN,TED,TOD,TWEN,
 WEN,A,D,Q,TA );
 input ATP,CK,CSN,IG,INITN,SCTRLI,SDLI,SDRI,SE,
 STDBY,TBIST,TBYPASS,TCSN,TED,TOD,TWEN,WEN;
 input [12:0] A;
 input [31:0] D;
 input [12:0] TA;
 output SCTRLO,SDLO,SDRO;
 output [31:0] Q;
endmodule
