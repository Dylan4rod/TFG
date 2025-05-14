`timescale 1ns/1ps
`include "generator.vams"
`include "driver.vams"
`include "monitor.vams"
`include "checker.vams"
`include "scoreboard.vams"
`include "agent.vams"

module tb_detector;

  // Declaración de los mailboxes
  mailbox gen2drv, drv2dut, dut2mon, mon2chk, chk2sb;

  // Instancias de los módulos
  generator gen_inst(gen2drv);                // Generador de señales
  agent agent_inst(gen2drv, drv2dut, dut2mon, mon2chk);  // Agente que conecta los módulos
  driver drv_inst(drv2dut, gen2drv);          // Driver que maneja señales hacia el DUT
  monitor mon_inst(dut2mon, mon2chk);         // Monitor para observar las señales del DUT
  checker chk_inst(mon2chk, chk2sb);          // Checker que verifica las señales
  scoreboard sb_inst(chk2sb);                 // Scoreboard para la verificación final

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
