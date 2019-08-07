`timescale 1 ns/1 ns
 
module Mux_4x1_2bit_beh(A1, A0, B1, B0, C1, C0, D1, D0, S1, S0, Out1, Out0);

 input A1, A0, B1, B0, C1, C0, D1, D0;
 input S1, S0;
 output Out1, Out0;
 reg Out1, Out0;

 always @(A1, A0, B1, B0, C1, C0, D1, D0, S1, S0)
 begin
  if (S1==0 && S0==0)
   Out0 <= A0 ;
  else if (S1==0 && S0==1)
   Out0 <= B0;
  else if(S1==1 && S0==0)
   Out0 <= C0;
  else
   Out0 <= D0;

  if (S1==0 && S0==0)
   Out1 <= A1;
  else if (S1==0 && S0==1)
   Out1 <= B1;
  else if(S1==1 && S0==0)
   Out1 <= C1;
  else
   Out1 <= D1;

 end
endmodule