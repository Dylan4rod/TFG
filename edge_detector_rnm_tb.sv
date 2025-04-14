`timescale 1ns/1ps
`include "constants.vams"
`include "disciplines.vams"

module edge_detector_rnm_tb;

  logic clk;
  logic reset;
  wreal a_i;  // señal de entrada ahora es tipo wreal
  logic rising_edge_o;
  logic falling_edge_o;

  // Instancia del DUT RNM
  edge_detector_rnm DUT (
    .clk(clk),
    .reset(reset),
    .a_i(a_i),
    .rising_edge_o(rising_edge_o),
    .falling_edge_o(falling_edge_o)
  );

  // Generación del reloj (10 ns)
  always begin
    clk = 1'b0; #5;
    clk = 1'b1; #5;
  end

  // Estímulo
  initial begin
    reset = 1'b1;
    a_i = 1.0;  // valor real
    @(posedge clk);
    reset = 1'b0;
    @(posedge clk);

    for (int i = 0; i < 32; i++) begin
      a_i = ($random % 2) ? 1.0 : 0.0;  // valores tipo real
      @(posedge clk);
    end

    $finish;
  end

endmodule