`timescale 1 ns/1 ns

module Testbench();

reg Start, Red, Green, Blue;
reg Clk, Rst;
wire U;

Code_Detector CompToTest(Start, Red, Green, Blue, Clk, Rst, U);
   
//Clock Procedure
always begin
 Clk <= 0;
 #10;
 Clk <= 1;
 #10;
end

reg [12:0] Index;
reg [12:0] Correct_Index;

 initial begin
  Rst <= 1;

  for(Index=13'b0000000000000; Index<13'b1000000000000; Index=Index+13'b0000000000001)
   begin
     @(posedge Clk);
     #5
     Rst <= 0;
     Start <= 1;

     @(posedge Clk);
     #5
     Start <= 0;
     Blue <= Index[0];
     Green <= Index[1];
     Red <= Index[2];

     @(posedge Clk);
     #5
     Blue <= Index[3];
     Green <= Index[4];
     Red <= Index[5];

     @(posedge Clk);
     #5
     Blue <= Index[6];
     Green <= Index[7];
     Red <= Index[8];

     @(posedge Clk);
     #5
     Blue <= Index[9];
     Green <= Index[10];
     Red <= Index[11];

     @(posedge Clk);
     #5
     if (U == 1)
      begin
       Correct_Index <= Index;
       $display("# %4d: %3b_%3b_%3b_%3b is correct!", Index, Index[11:9],Index[8:6],Index[5:3],Index[2:0]);
      end
     else 
      $display("# %4d: %3b_%3b_%3b_%3b is incorrect!", Index, Index[11:9],Index[8:6],Index[5:3],Index[2:0]); 
     Rst <= 1;

   end
   $display("# %4d: %3b_%3b_%3b_%3b is correct!", Correct_Index, Correct_Index[11:9],Correct_Index[8:6],Correct_Index[5:3],Correct_Index[2:0]);
   $stop;

end


endmodule

