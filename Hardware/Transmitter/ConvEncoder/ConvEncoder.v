module ConvEncoder(Input, Reset, Clock, Output);
/*
 * Module `ConvEncoder`
 *
 * 802.11a IEEE Wifi PLCP DATA Convolutional Encoder (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)
 * g0 = (1011011)_2  ---> g_0(x) = x^1 + x^3 + x^4 + x^6 + x^7
 * g1 = (1111001)_2  ---> g_1(x) = x^1 + x^2 + x^3 + x^4 + x^7
 * With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (0, 0, 0, 0, 0, 0, 0)
 * 
 * parameters:
 * Input    [1]: Input data stream
 * Reset    [1]: Active high asynchronous reset
 * Clock    [1]: Input clock    (Which is 2*Main Clock)
 * Output   [1]: Output coded data stream
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Input;
    input wire Reset;
    input wire Clock;
    output wire Output;

    parameter INITIAL_STATE = 7'b0000000;

    reg [1:7] x;
    reg is_odd;

    //  Buffer Update
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
        begin
           x <= INITIAL_STATE;
           is_odd <= 1'b0; 
        end
        else
        begin
            if (is_odd)
                is_odd <= 1'b0;
            else
            begin
                x <= {{Input}, {x[1:6]}};
                is_odd <= 1'b1; 
            end
        end
    end

    //  Coding
    assign Output = is_odd ?
                    x[1] ^ x[3] ^ x[4] ^ x[6] ^ x[7] :
                    x[1] ^ x[2] ^ x[3] ^ x[4] ^ x[7] ;
endmodule
