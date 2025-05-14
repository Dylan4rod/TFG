`timescale 1ns/1ps
`include "generator.vams"
`include "driver.vams"
`include "monitor.vams"
`include "checker.vams"
`include "scoreboard.vams"
`include "agent.vams"
`include "disciplines.vams"

module tb_detector;

  // Declaración de los mailboxes
  mailbox gen2drv, drv2dut, dut2mon, mon2chk, chk2sb;

  // Instancias de los módulos
  generator gen_inst(gen2drv);
  agent agent_inst(gen2drv, drv2dut, dut2mon, mon2chk);
  driver drv_inst(drv2dut, gen2drv);
  monitor mon_inst(dut2mon, mon2chk);
  checker chk_inst(mon2chk, chk2sb);
  scoreboard sb_inst(chk2sb);

  // Inicialización del simulador
  initial begin
    // Crear los mailboxes
    gen2drv = new();
    drv2dut = new();
    dut2mon = new();
    mon2chk = new();
    chk2sb = new();

    // Simulación
    $display("Iniciando simulación...");
    #100 $finish;
  end

endmodule
