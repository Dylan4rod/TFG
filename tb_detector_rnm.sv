`timescale 1ns/1ps

module tb_edge_detector_rnm;

  // Señales
  logic clk;
  logic reset;
  wreal a_i;
  logic rising_edge_o;
  logic falling_edge_o;

  // Parámetros para la señal analógica
  real time_step = 1.0;      // cada 1ns
  real period = 20.0;        // periodo de la onda = 20ns
  real amplitude = 1.0;
  real v_value = 0.0;

  // Instanciación del DUT
  edge_detector_rnm dut (
    .a_i(a_i),
    .clk(clk),
    .reset(reset),
    .rising_edge_o(rising_edge_o),
    .falling_edge_o(falling_edge_o)
  );

  // Generador de reloj digital (10ns período)
  always #5 clk = ~clk;

  // Generador de señal analógica tipo onda cuadrada
  initial begin
    v_value = 0.0;
    forever begin
      #10;
      v_value = (v_value == 0.0) ? amplitude : 0.0;
      a_i = v_value;
    end
  end

  // Proceso principal de simulación
  initial begin
    // Inicialización
    clk = 0;
    reset = 1;
    a_i = 0.0;

    // Esperar un poco y liberar el reset
    #15 reset = 0;

    // Simular por 200ns
    #200 $finish;
  end

  // Monitor para visualizar el comportamiento
  always @(posedge clk) begin
    $display("t=%0t | a_i=%.2f | rising=%b | falling=%b", 
              $time, a_i, rising_edge_o, falling_edge_o);
  end

endmodule
