module scoreboard(input mailbox test2sb, input mailbox checker2sb);

  real sent, expected_rise, expected_fall;

  always begin
    test2sb.get(sent);
    checker2sb.get({expected_rise, expected_fall});
    $display("Input=%.2f | Expected Rising=%.2f | Expected Falling=%.2f", sent, expected_rise, expected_fall);
  end

endmodule
