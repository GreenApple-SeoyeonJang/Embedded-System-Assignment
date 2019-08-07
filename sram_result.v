module Sram_Result(Data_In, Data_Out, Addr, RW, En, Clk, Rst);
   input [6:0] Addr;
   input RW;
   input En;
   input Clk;
   input Rst;
   input [31:0] Data_In;
   output reg [31:0] Data_Out;

endmodule;