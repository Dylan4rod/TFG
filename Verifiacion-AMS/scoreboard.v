module scoreboard (
    input  wreal rising_edge,
    input  wreal falling_edge,
    input  clk,
    input  reset
);

    // Variables para almacenar las expectativas
    real expected_rising_edge;
    real expected_falling_edge;

    // Contadores para las ocurrencias de flancos
    integer rising_edge_count;
    integer falling_edge_count;

    // Registro para mostrar el resultado final
    integer total_rising_edges;
    integer total_falling_edges;

    // Inicialización
    initial begin
        rising_edge_count = 0;
        falling_edge_count = 0;
        total_rising_edges = 0;
        total_falling_edges = 0;
        expected_rising_edge = 0.0;
        expected_falling_edge = 0.0;
    end

    // Lógica para verificar flancos
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rising_edge_count <= 0;
            falling_edge_count <= 0;
        end
        else begin
            // Verificación del flanco ascendente
            if (rising_edge == 1.0) begin
                rising_edge_count = rising_edge_count + 1;
                total_rising_edges = total_rising_edges + 1;
                $display("Flanco ascendente detectado");
            end

            // Verificación del flanco descendente
            if (falling_edge == 1.0) begin
                falling_edge_count = falling_edge_count + 1;
                total_falling_edges = total_falling_edges + 1;
                $display("Flanco descendente detectado");
            end
        end
    end

    // Al finalizar, se puede agregar una verificación final
    always @(posedge clk) begin
        // Al final de la simulación, mostrar los resultados
        if (total_rising_edges > 0 || total_falling_edges > 0) begin
            $display("Simulación completada.");
            $display("Total de flancos ascendentes detectados: %d", total_rising_edges);
            $display("Total de flancos descendentes detectados: %d", total_falling_edges);
        end
    end

endmodule

