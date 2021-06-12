module DeScrambler(Input, Reset, Init, Clock, Output);
/*
 * Module `DeScrambler`
 *
 * 802.11a IEEE Wifi PLCP DATA DeScrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)
 * S(x) = x ^ 7 + x ^ 4 + 1
 * With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (1, 1, 1, 1, 1, 1, 1)
 * 
 * parameters:
 * Input    [1]: Input data stream
 * Reset    [1]: Active high asynchronous reset
 * Init     [1]: Initial state of descrambler
 * Clock    [1]: Input clock
 * Output   [1]: Output descrambled data stream
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Input;
    input wire Reset;
    input wire [7:1] Init; 
    input wire Clock;

    output wire Output;

    reg [7:1] string;
    wire S_x;

    //  Loop-Back value of string (S(x) = x ^ 7 + x ^ 4 + 1)
    assign S_x = string[7] ^ string[4];

    //  string update
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
            string <= Init;
        else
        begin
            string[7:5] <= string[6:4];
            string[4:1] <= {{string[3:1]}, {S_x}};
        end
    end

    //  Scrambling 
    assign Output = S_x ^ Input;
endmodule
