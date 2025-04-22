`timescale 1ns/1ps

module checker(input mailbox mon2chk,    // Del monitor al checker
               input mailbox chk2sb);    // Del checker al scoreboard

  real signal_rising, signal_falling;
  real expected_rising = 1.0;
  real expected_falling = 1.0;

  always @(mon2chk) begin
    mon2chk.get(signal_rising);
    mon2chk.get(signal_falling);

    // Compara las señales con los resultados esperados
    if (signal_rising == expected_rising) 
      $display("Rising edge detected correctly.");
    else 
      $display("Error en rising edge.");

    if (signal_falling == expected_falling) 
      $display("Falling edge detected correctly.");
    else 
      $display("Error en falling edge.");
      
    // Pasa los resultados al scoreboard
    chk2sb.put(signal_rising);
    chk2sb.put(signal_falling);
  end

endmodule

