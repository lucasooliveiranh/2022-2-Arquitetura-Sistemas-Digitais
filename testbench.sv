module ula ();
    reg  [7:0] a, b;
    reg  [2:0] sel;
    wire [7:0] sa, ss, sn, so, sx, st, out;
    wire couta, couts;

    add8 a8 (a, b, 1'b0, sa, couta);
    sub8 s8 (a, b, 1'b0, ss, couts);
    and8 n8 (sn, a, b);
    or8  o8 (so, a, b);
    xor8 x8 (sx, a, b);
    not8 t8 (st, a);

    mux4 m4 (sa, ss, sn, so, sel[1:0], out);
    /* mux8 m8 (sa, ss, sn, so, sx, st, 8'b0, 8'b0, sel, out); */

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);

        a = 8'd5; b = 8'd3; sel = 3'b000;
        #10;
        $display("sel: %b, a: %b, b: %b, out: %b", sel, a, b, out);
        $display("sel: %b, a: %d, b: %d, out: %d", sel, a, b, out);

        a = 8'd5; b = 8'd3; sel = 3'b001;
        #10;
        $display("sel: %b, a: %b, b: %b, out: %b", sel, a, b, out);
        $display("sel: %b, a: %d, b: %d, out: %d", sel, a, b, out);

        a = 8'd5; b = 8'd3; sel = 3'b010;
        #10;
        $display("sel: %b, a: %b, b: %b, out: %b", sel, a, b, out);
        $display("sel: %b, a: %d, b: %d, out: %d", sel, a, b, out);

        a = 8'd5; b = 8'd3; sel = 3'b011;
        #10;
        $display("sel: %b, a: %b, b: %b, out: %b", sel, a, b, out);
        $display("sel: %b, a: %d, b: %d, out: %d", sel, a, b, out);
    end
endmodule
