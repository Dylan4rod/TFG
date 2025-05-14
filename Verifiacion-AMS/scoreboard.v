module scoreboard(mailbox chk2sb);

  wreal rising_edge;
  wreal falling_edge;
  wreal freq_out;

  always begin
    chk2sb.get({rising_edge, falling_edge, freq_out});  // Recibir señales del checker
    // Aquí puedes comparar las señales con los valores esperados
    $display("Scoreboard - Rising Edge: %0.2f, Falling Edge: %0.2f, Frequency: %0.2f Hz",
             rising_edge, falling_edge, freq_out);
  end

endmodule

