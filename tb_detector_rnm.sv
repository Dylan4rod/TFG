`timescale 1ns/1ps
`include "disciplines.vams"

module tb_Detector;

  // Señales wreal (analógicas)
  wreal a_in;
  wreal rising_edge;
  wreal falling_edge;

  // Parámetros
  real amplitude = 1.0;
  real v_value = 0.0;

  // Instancia del DUT
  Detector dut (
    .a_in(a_in),
    .rising_edge(rising_edge),
    .falling_edge(falling_edge)
  );

  // Estímulo tipo onda cuadrada usando 'real' en lugar de 'integer'
  initial begin
    real i;  // Usamos 'real' en lugar de 'integer'
    a_in = 0.0;
    v_value = 0.0;

    for (i = 0.0; i < 20.0; i = i + 1.0) begin  // Usamos 'real' en el bucle
      #10;
      v_value = (v_value == 0.0) ? amplitude : 0.0;
      a_in = v_value;
    end

    #20 $finish;
  end

  // Monitor para ver las señales
  always @(a_in) begin
    $display("t=%0t | a_in=%.2f | rising=%.1f | falling=%.1f",
              $realtime, a_in, rising_edge, falling_edge);
  end

endmodule
