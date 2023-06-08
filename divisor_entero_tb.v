
`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns
// timescale <time_unit> / <time_precision>

module divisor_entero_tb();

    //-- Simulation time: 1us (10 * 100ns)
    parameter DURATION = 10;

    //-- Clock signal. It is not used in this simulation
    reg clk = 0;
    always #0.5 clk = ~clk;

    // a ports
    reg test_up;
    reg test_down;
    reg test_ok;
    reg test_selector;
    wire [3:0] test_cociente;
    wire [3:0] test_resto;

    //-- Instantiate the unit to test
    divisor_entero UUT (
               .up(test_up),
               .down(test_down),
               .ok(test_ok),
               .selector(test_selector),
               .clock(clk),
               .cociente(test_cociente),
               .resto(test_resto)
             );

    initial begin
        //-- File were to store the simulation results
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, divisor_entero_tb);

        // Selecciono el dividendo
        #1
        test_selector = 1'b0;

        // Selecciono el numero (Busco el 5)
        #1
        test_up = 1'b1; //1
        test_down = 1'b0;

        #0.5
        test_up = 1'b1;//2
        test_down = 1'b0;

        #0.5
        test_up = 1'b1;//3
        test_down = 1'b0;
        #0.5
        test_up = 1'b1;//4
        test_down = 1'b0;

        #0.5
        test_up = 1'b1;//5
        test_down = 1'b0;

        #0.5
        test_up = 1'b1;//6
        test_down = 1'b0;

        #0.5
        test_up = 1'b1;//7
        test_down = 1'b0;

       
        // Hasta aqui llegó al 7 ahora bajo hasta el 5 (Es decir yo queria el 10 y me pasé entonces bajo)
        #0.5
        test_up = 1'b0;
        test_down = 1'b1;//6

        #0.5
        test_up = 1'b0;
        test_down = 1'b1;//5

        // Selecciono el divisor
        #1
        test_selector = 1'b1;

        // Busco el numero (Quiero el 5)
        #1
        test_up = 1'b1;//1
        test_down = 1'b0;

        #0.5
        test_up = 1'b1;//2
        test_down = 1'b0;

       #1
        test_ok = 1'b1;



        #(DURATION) $display("End of simulation");
        $finish;
    end

endmodule
