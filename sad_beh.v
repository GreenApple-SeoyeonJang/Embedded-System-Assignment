`timescale 1 ns/1 ns
`define A_WIDTH 15
`define D_WIDTH 8

module SAD(Go, A_Addr, A_Data, B_Addr, B_Data, C_Addr, I_RW, I_En, O_RW, O_En, Done, SAD_Out, Clk, Rst);

   input Go;
   input [7:0] A_Data, B_Data;
   output reg [14:0] A_Addr, B_Addr;
   output reg [6:0] C_Addr;
   output reg I_RW, I_En, O_RW, O_En, Done; 
   output reg [31:0] SAD_Out;
   input Clk, Rst;

   parameter S0 = 3'b000, S1 = 3'b001,
             S2 = 3'b010, S3a = 3'b011, 
             S3 = 3'b100, S4 = 3'b101;

   reg [2:0] State;
   reg [31:0] Sum;
   integer i, j, k;

   function [(`D_WIDTH-1):0] ABSDiff;
      input [(`D_WIDTH-1):0] A;
      input [(`D_WIDTH-1):0] B;
      if (A>B) ABSDiff = A - B;
      else ABSDiff = B - A;
   endfunction

always @(posedge Clk) begin
      if (Rst==1'b1) begin
         A_Addr <= {`A_WIDTH{1'b0}};
         B_Addr <= {`A_WIDTH{1'b0}};
         I_RW <= 1'b0;
         I_En <= 1'b0;
         Done <= 1'b0;
         State <= S0;
         Sum <= 32'b0;
         SAD_Out <= 32'b0;
         i <= 0;
	 j <= 0;
	 k <= 0;
      end
      else begin
         A_Addr <= {`A_WIDTH{1'b0}};
         B_Addr <= {`A_WIDTH{1'b0}};
          I_RW <= 1'b0;
          I_En <= 1'b0;
          Done <= 1'b0;
          SAD_Out <= 32'b0;
           
          case (State)
               S0: begin
                    if (Go==1'b1)
                      State <= S1;
                    else
                      State <= S0;
                   end

               S1: begin
                    Sum <= 32'b0;
                    j <= 0;
                    State <= S2;
                   end

               S2: begin
                   if (!(j==256)) begin
                     State <= S3a;
                     A_Addr <= i;
                     B_Addr <= i;
                     I_RW <= 1'b0;
                     I_En <= 1'b1; 
                   end
                   else
                     State <= S4;
                   end
               S3a: 
                   State <= S3;
            
               S3: begin
                   Sum <= Sum + ABSDiff(A_Data, B_Data);
                   i <= i + 1;
		   j <= j + 1;
                   State <= S2;
                   end

               S4: begin
		   if(!(i < 32768)) begin
		     State <= S0;
		     SAD_Out <= Sum;
	 	     Done <= 1'b1;
		   end
		   else begin
                     State <= S1;
                   end

                   C_Addr <= k;
		   k <= k + 1;
		   I_RW <= 1'b0;
                   I_En <= 1'b1; 
                   
                   end
         endcase
      end
   end

 endmodule

