`timescale 1 ns/1 ns

module Code_Detector(Start, Red, Green, Blue, Clk, Rst, U);

input Start, Red, Green, Blue;
output reg U; 
input Clk, Rst;

parameter s_wait = 0, s_start = 1, s_red1 = 2, s_blue = 3, s_green = 4, s_red2 = 5;

reg [2:0] State, StateNext;

//State Register
always @(posedge Clk) 
 begin
  if (Rst == 1)
	State <= s_wait;
  else
        State <= StateNext;
 end

//Combinational Logic 
always @(State, Start, Red, Green, Blue)
 begin
  case(State)
	s_wait: begin
	 U <= 0;
	 if (Start)
	  StateNext <= s_start;
	 else
	  StateNext <= s_wait;
	end
	
	s_start: begin
	 U <= 0;
	 if(Red & ~Blue & ~Green)
	  StateNext <= s_red1;
	 else if (~Red & ~Blue & ~Green)
	  StateNext <= s_start;
	 else if (Blue | Green)
	  StateNext <= s_wait;
	end

	s_red1: begin
	 U <= 0;
	 if(~Red & Blue & ~Green)
	  StateNext <= s_blue;
	 else if (~Red & ~Blue & ~Green)
	  StateNext <= s_red1;
	 else if (Red | Green)
	  StateNext <= s_wait;
	end

	s_blue: begin
	 U <= 0;
	 if(~Red & ~Blue & Green)
	  StateNext <= s_green;
	 else if (~Red & ~Blue & ~Green)
	  StateNext <= s_blue;
	 else if (Blue | Red)
	  StateNext <= s_wait;
	end

	s_green: begin
	 U <= 0;
	 if(Red & ~Blue & ~Green)
	  StateNext <= s_red2;
	 else if (~Red & ~Blue & ~Green)
	  StateNext <= s_green;
	 else if (Blue | Green)
	  StateNext <= s_wait;
	end

	s_red2: begin
	 U <= 1;
	 StateNext <= s_wait;
	end
  endcase
 end

endmodule