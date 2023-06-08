// Divisor Entero de 4 Bits

module divisor_entero (
    input wire up,          // Incrementar el numero
    input wire down,        // Decrementar el numero
    input wire ok,          // Ejecutar la division
    //input wire selector,    // Selector par seleccionar la entrada (Divisor y Dividendo) 0 -> Dividendo 1-> Divisor
    input wire clock,
    input wire reset,

    output wire [3:0] cociente
    //output reg [3:0] resto
    );

    // Declaracion de señales internas
    reg [3:0] divisor;
    reg [3:0] numerador;

    // initial begin
    //     dividendo = 4'b0000;    // Asignar el valor por defecto
    //     divisor = 4'b0001;      // Asignar el valor por defecto
    // end

    // Logica para la carga de datos
    always @(posedge clock) begin
        if (reset) begin
            numerador <= 4'b0000;
            divisor <= 4'b0000;
        end
        if(~ok) begin
                if (up)
                    numerador <= numerador + 4'b0001;
                if (down)
                    numerador <= numerador - 4'b0001;
        end
        else
            if (up) begin
                if (divisor == 4'b1111)
                    divisor <= 4'b0001; //evito el cero
                else
                    divisor <= divisor+ 4'b0001;
            end
            if (down) begin
                if (divisor == 4'b0001)
                    divisor <= 4'b1111; //evito el cero
                else
                    divisor <= divisor - 4'b0001;
            end
        end
assign cociente = numerador;
endmodule
