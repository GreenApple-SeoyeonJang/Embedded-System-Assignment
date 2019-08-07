`timescale 1 ns/1 ns

module Mux_4x1_2bit_gate(A1, A0, B1, B0, C1, C0, D1, D0, S1, S0, Out1, Out0);
    
   input A1, A0, B1, B0, C1, C0, D1, D0;
   input S1, S0;
   output Out1, Out0;

   wire N1, N2, N3, N4, N5, N6, N7, N8, N9 ,N10, N11, N12, N13, N14, N15, N16, N17, N18, N19, N20, N21, N22;

   not Inv_1(N1, S1);
   not Inv_2(N2, S0);

   and And_1(N3, A1, N1);
   and And_2(N4, N3, N2);
   and And_3(N5, B1, N1);
   and And_4(N6, N5, S0);
   and And_5(N7, C1, S1);
   and And_6(N8, N7, N2);
   and And_7(N9, D1, S1);
   and And_8(N10, N9, S0);

   or Or_1(N11, N4, N6);
   or Or_2(N12, N8, N10);
   or Or_3(Out1, N11, N12);


   and And_9(N13, A0, N1);
   and And_10(N14, N13, N2);
   and And_11(N15, B0, N1);
   and And_12(N16, N15, S0);
   and And_13(N17, C0, S1);
   and And_14(N18, N17, N2);
   and And_15(N19, D0, S1);
   and And_16(N20, N19, S0);

   or Or_4(N21, N14, N16);
   or Or_5(N22, N18, N20);
   or Or_6(Out0, N21, N22);

endmodule





