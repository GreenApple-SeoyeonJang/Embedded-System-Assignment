 `timescale 1 ns/1 ns
 `define A_WIDTH 15
 `define D_WIDTH 8

 module Testbench();
   reg Go_s;
   wire [(`A_WIDTH-1):0] A_Addr_s, B_Addr_s;
   wire [(`D_WIDTH-1):0] A_Data_s, B_Data_s, A_Di_s, B_Di_s;

   wire RW_s, En_s, Done_s; 
   reg Clk_s, Rst_s, Rst_m;
   wire [31:0] SAD_Out_s;
    
   parameter ClkPeriod = 20;

   SAD CompToTest(Go_s, A_Addr_s, A_Data_s, B_Addr_s, B_Data_s, C_Addr_s, IRW_s, IEn_s, ORW_s, OEn_s,Done_s, SAD_Out_s, Clk_s, Rst_s);
   Sram_Operand SADMemA(A_Di_s, A_Data_s, A_Addr_s, RW_s, En_s, Clk_s, Rst_m);
   Sram_Operand SADMemB(B_Di_s, B_Data_s, B_Addr_s, RW_s, En_s, Clk_s, Rst_m);

   // Clock Procedure
   always begin
      Clk_s <= 1'b0; #(ClkPeriod/2);
      Clk_s <= 1'b1; #(ClkPeriod/2);
   end
   // Initialize Arrays
   initial $readmemh("MemA.txt", SADMemA.Memory);
   initial $readmemh("MemB.txt", SADMemB.Memory);

   // Vector Procedure
   initial begin
      Rst_m <= 1'b0; Rst_s <= 1'b1; Go_s <= 1'b0;     
      @(posedge Clk_s);
      Rst_s <= 1'b0; Go_s <= 1'b1;
      @(posedge Clk_s);
       Go_s <= 1'b0;
      @(posedge Clk_s);
      while(Done_s != 1'b1) 
          @(posedge Clk_s); 
      if (SAD_Out_s != 4)
	$display("SAD failed with %d -- should equal to 4", SAD_Out_s);
      else 
	$display("SAD is %d!", SAD_Out_s);
      $stop; 
   end
 endmodule
