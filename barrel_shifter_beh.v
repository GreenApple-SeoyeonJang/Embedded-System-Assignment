`timescale 1 ns/1 ns

module Barrel_Shifter(SH_DIR, SH_AMT, D_IN, D_OUT);

 input SH_DIR;
 input [4:0] SH_AMT; 
 input [31:0] D_IN;
 output [31:0] D_OUT; 

 reg [31:0] D_OUT;
 reg [5:0] Index_A;

 always @(SH_DIR, SH_AMT, D_IN) begin

  case(SH_DIR)

    0: begin //SHIFT_LEFT
      for (Index_A = 6'b000000; Index_A < 6'b100000; Index_A = Index_A + 6'b000001) begin
        if(Index_A < SH_AMT)
	  D_OUT[Index_A] <= 0;
        else                                                                                                                                                      
	  D_OUT[Index_A] <= D_IN[Index_A - SH_AMT];
      end
    end

    1: begin //SHIFT_RIGHT
      if (D_IN[31]) begin //Negative Value
        for (Index_A = 6'b000000; Index_A < 6'b100000; Index_A = Index_A + 6'b000001) begin
         if(Index_A < 6'b100000 - SH_AMT)
	   D_OUT[Index_A] <= D_IN[Index_A + SH_AMT];
         else
	   D_OUT[Index_A] <= 1;
         end
      end

      else begin //Positive Value
        for (Index_A = 6'b000000; Index_A < 6'b100000; Index_A = Index_A + 6'b000001) begin
         if(Index_A < 6'b100000 - SH_AMT)
	   D_OUT[Index_A] <= D_IN[Index_A + SH_AMT];
         else
	   D_OUT[Index_A] <= 0;
         end
      end

    end

  endcase

 end

endmodule
