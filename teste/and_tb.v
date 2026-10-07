`timescale 1ns / 1ps

module and_gate_tb;

    // Sinais para ligar ao módulo em teste
    reg  a;
    reg  b;
    wire y;

    // Instanciação do módulo sob teste (UUT - Unit Under Test)
    and_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    // Bloco de estímulos
    initial begin
        $dumpfile("and.vcd"); // Nome do ficheiro de saída
        $dumpvars(0, and_gate_tb);  // Guardar todos os sinais a partir do nível e estrutura do testbench
        // Monitoriza e imprime no terminal sempre que as variáveis mudarem
        $monitor("Tempo = %0t ns | a = %b, b = %b => y = %b", $time, a, b, y);

        // Teste 1: 0 AND 0 = 0
        a = 0; b = 0;
        #10;

        // Teste 2: 0 AND 1 = 0
        a = 0; b = 1;
        #10;

        // Teste 3: 1 AND 0 = 0
        a = 1; b = 0;
        #10;

        // Teste 4: 1 AND 1 = 1
        a = 1; b = 1;
        #10;

        // Terminar a simulação
        $finish;
    end

endmodule
