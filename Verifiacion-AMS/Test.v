module test;

  import "DPI-C" function void assign_wreal(input wreal net, input real value);

  // Mailboxes
  mailbox gen2drv = new();
  mailbox mon2chk = new();
  mailbox chk2sb  = new();
  mailbox test2sb = new();

  // Señales RNM
  wreal a_in;
  wreal rising_edge;
  wreal falling_edge;

  // DUT
  detector_flancos_rnm dut (
    .a_in(a_in),
    .rising_edge(rising_edge),
    .falling_edge(falling_edge)
  );

  // Instancias
  agente a (.gen2drv(gen2drv));
  driver d (.a_in(a_in), .mb(gen2drv));
  monitor m (.a_in(a_in), .rising(rising_edge), .falling(falling_edge), .mb(mon2chk));
  checker c (.mb_in(mon2chk), .mb_out(chk2sb));
  scoreboard sb (.test2sb(test2sb), .checker2sb(chk2sb));

  // Estímulo desde el test
  initial begin
    for (int i = 0; i < 20; i++) begin
      real value = (i % 2 == 0) ? 1.0 : 0.0;
      test2sb.put(value);
      gen2drv.put(value);
      #10;
    end
    #50 $finish;
  end

endmodule
