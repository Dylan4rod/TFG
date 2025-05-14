module checker(mailbox mon2chk, mailbox chk2sb);

  wreal rising_edge;
  wreal falling_edge;
  wreal freq_out;

  always begin
    mon2chk.get({rising_edge, falling_edge, freq_out});  // Recibir señales monitorizadas
    // Aquí puedes hacer las verificaciones según el comportamiento esperado de las señales
    $display("Rising Edge: %0.2f, Falling Edge: %0.2f, Frequency: %0.2f Hz",
             rising_edge, falling_edge, freq_out);
    chk2sb.put({rising_edge, falling_edge, freq_out});  // Enviar señales al scoreboard
  end

endmodule

