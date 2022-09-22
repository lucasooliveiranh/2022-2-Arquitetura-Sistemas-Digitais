module not8 (output [7:0] s,
             input  [7:0] i);
    not U1 (s[0:0], i[0:0]);
    not U2 (s[1:1], i[1:1]);
    not U3 (s[2:2], i[2:2]);
    not U4 (s[3:3], i[3:3]);
    not U5 (s[4:4], i[4:4]);
    not U6 (s[5:5], i[5:5]);
    not U7 (s[6:6], i[6:6]);
    not U9 (s[7:7], i[7:7]);
endmodule

module and8 (output [7:0] s,
             input  [7:0] a, b);
    and U1 (s[0:0], a[0:0], b[0:0]);
    and U2 (s[1:1], a[1:1], b[1:1]);
    and U3 (s[2:2], a[2:2], b[2:2]);
    and U4 (s[3:3], a[3:3], b[3:3]);
    and U5 (s[4:4], a[4:4], b[4:4]);
    and U6 (s[5:5], a[5:5], b[5:5]);
    and U7 (s[6:6], a[6:6], b[6:6]);
    and U9 (s[7:7], a[7:7], b[7:7]);
endmodule

module or8 (output [7:0] s,
            input  [7:0] a, b);
    or U1 (s[0:0], a[0:0], b[0:0]);
    or U2 (s[1:1], a[1:1], b[1:1]);
    or U3 (s[2:2], a[2:2], b[2:2]);
    or U4 (s[3:3], a[3:3], b[3:3]);
    or U5 (s[4:4], a[4:4], b[4:4]);
    or U6 (s[5:5], a[5:5], b[5:5]);
    or U7 (s[6:6], a[6:6], b[6:6]);
    or U9 (s[7:7], a[7:7], b[7:7]);
endmodule

module xor8 (output [7:0] s,
             input  [7:0] a, b);
    xor U1 (s[0:0], a[0:0], b[0:0]);
    xor U2 (s[1:1], a[1:1], b[1:1]);
    xor U3 (s[2:2], a[2:2], b[2:2]);
    xor U4 (s[3:3], a[3:3], b[3:3]);
    xor U5 (s[4:4], a[4:4], b[4:4]);
    xor U6 (s[5:5], a[5:5], b[5:5]);
    xor U7 (s[6:6], a[6:6], b[6:6]);
    xor U9 (s[7:7], a[7:7], b[7:7]);
endmodule

module add1 (input  a, b, cin,
             output s, cout);
  wire w1, w2, w3;

  xor U1 (w1, a, b);
  and U2 (w2, a, b);
  xor U3 (s, w1, cin);
  and U4 (w3, w1, cin);
  or  U5 (cout, w2, w3);
endmodule

module add8 (input  [7:0] a, b,
             input  cin,
             output [7:0] s,
             output cout);
  wire [7:0] carry;

  add1 fa1 (a[0:0], b[0:0], cin,        s[0:0], carry[0:0]);
  add1 fa2 (a[1:1], b[1:1], carry[0:0], s[1:1], carry[1:1]);
  add1 fa3 (a[2:2], b[2:2], carry[1:1], s[2:2], carry[2:2]);
  add1 fa4 (a[3:3], b[3:3], carry[2:2], s[3:3], carry[3:3]);
  add1 fa5 (a[4:4], b[4:4], carry[3:3], s[4:4], carry[4:4]);
  add1 fa6 (a[5:5], b[5:5], carry[4:4], s[5:5], carry[5:5]);
  add1 fa7 (a[6:6], b[6:6], carry[5:5], s[6:6], carry[6:6]);
  add1 fa8 (a[7:7], b[7:7], carry[6:6], s[7:7], carry[7:7]);

  assign cout = carry[7:7];
endmodule

module sub8 (input  [7:0] a, b,
             input  cin,
             output [7:0] s,
             output cout);
    wire [7:0] one_c_b, two_c_b;

    not8 U1 (one_c_b, b);
    add8 U2 (one_c_b, 8'd1, 1'd0, two_c_b, cout);
    add8 U3 (a, two_c_b, cin, s, cout);
endmodule

module mux2
    #(parameter width = 8)
     (input [width-1:0] a, b,
      input sel,
      output [width-1:0] out);

    assign out = sel ? b : a;
endmodule

module mux4
    #(parameter width = 8)
     (input [width-1:0] a, b, c, d,
      input [1:0] sel,
      output [width-1:0] out);

    wire [width-1:0] int_sel_a, int_sel_b;

    mux2 UM1 (a, b, sel[0:0], int_sel_a);
    mux2 UM2 (c, d, sel[0:0], int_sel_b);
    mux2 UM3 (int_sel_a, int_sel_b, sel[1:1], out);
endmodule

module mux8
    #(parameter width = 8)
     (input [width-1:0] a, b, c, d, e, f, g, h,
      input [2:0] sel,
      output [width-1:0] out);

    wire [width-1:0] int_sel_a, int_sel_b;

    mux4 UM1 (a, b, c, d, sel[1:0], int_sel_a);
    mux4 UM2 (e, f, g, h, sel[1:0], int_sel_b);
    mux2 UM3 (int_sel_a, int_sel_b, sel[2:2], out);
endmodule