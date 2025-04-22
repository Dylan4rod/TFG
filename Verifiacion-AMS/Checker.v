module checker(input mailbox mb_in, output mailbox mb_out);

  typedef struct {
    real in_val;
    real rising;
    real falling;
  } data_t;

  data_t d;

  always begin
    mb_in.get(d);

    real expected_rise = (d.in_val > 0.5) ? 1.0 : 0.0;
    real expected_fall = (d.in_val < 0.5) ? 1.0 : 0.0;

    mb_out.put({expected_rise, expected_fall});
  end

endmodule
