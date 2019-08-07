`timescale 1 ns/1 ns

module Testbench();

reg SH_DIR;
reg [4:0] SH_AMT;
reg [31:0] D_IN;
reg Clk;
wire [31:0] D_OUT;

Barrel_Shifter CompToTest(SH_DIR, SH_AMT, D_IN, D_OUT);

//Clock Procedure
always begin
 Clk <= 0;
 #10;
 Clk <= 1;
 #10;
end

reg [5:0] Index;

 initial begin
 $display("# 1.Shift-Right Operation Test with Negative Value!");
   for(Index=6'b000000; Index < 6'b100000; Index=Index+6'b000001)
   begin
     @(posedge Clk);
     #5
     SH_DIR <= 1;
     SH_AMT <= Index[4:0];
     D_IN <= 32'b10000000000000000000000000000000;

     @(posedge Clk);
     #5
     $display("# shift-right with amount %2d is %b", Index, D_OUT);
   end

 $display("# 2.Shift-Right Operation Test with Positive Value!");
   for(Index=6'b000000; Index < 6'b100000; Index=Index+6'b000001)
   begin
     @(posedge Clk);
     #5
     SH_DIR <= 1;
     SH_AMT <= Index[4:0];
     D_IN <= 32'b01000000000000000000000000000000;

     @(posedge Clk);
     #5
     $display("# shift-right with amount %2d is %b", Index, D_OUT);
   end

 $display("# 3.Shift-Left Operation Test with Number 1!");
   for(Index=6'b000000; Index < 6'b100000; Index=Index+6'b000001)
   begin
     @(posedge Clk);
     #5
     SH_DIR <= 0;
     SH_AMT <= Index[4:0];
     D_IN <= 32'b00000000000000000000000000000001;

     @(posedge Clk);
     #5
     $display("# shift-left with amount %2d is %b", Index, D_OUT);
   end

end


endmodule
