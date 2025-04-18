`timescale 1ns/1ps
`include "disciplines.vams"

module tb_Detector;

  // Señales wreal
  wreal a_in;
  wreal rising_edge;
  wreal falling_edge;

  // Parámetros
  real amplitude = 1.0;
  real v_value = 0.0;
  integer i;

  // Asignación directa RNM
  assign a_in = v_value;

  // Instancia del DUT
  detector_flancos_rnm dut (
    .a_in(a_in),
    .rising_edge(rising_edge),
    .falling_edge(falling_edge)
  );

  // Estímulo digital sobre wreal
  initial begin
    v_value = 0.0;

    for (i = 0; i < 20; i = i + 1) begin
      #10;
      v_value = (v_value == 0.0) ? amplitude : 0.0;
    end

    #20 $finish;
  end

  // Monitor para observar la señal
  always @(a_in) begin
    $display("t=%0t | a_in=%.2f | rising=%.1f | falling=%.1f",
              $realtime, a_in, rising_edge, falling_edge);
  end

endmodule
