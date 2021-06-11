`include "Scrambler/Scrambler.v"

module Transmitter(Start, Input, Reset, Clock, Output);
/*
 * Module `Transmitter`
 *
 * 802.11a IEEE Transmitter
 * 
 * Sub modules:
 * + Scrambler/Scrambler.v
 *
 * parameters:
 * Start    [1]: Active high one-shot start
 * Input    [1]: Input data stream
 * Reset    [1]: Active high asynchronous reset
 * Clock    [1]: Input clock
 * Output   [1]: Output Wifi data frame
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Start;
    input wire Input;
    input wire Reset;
    input wire Clock;

    output reg Output;
    reg transmitter_out;
    reg is_scramble;

    //  Scrambler Instatiation:
    wire scrambler_out;
    wire scrambler_reset;
    reg scrambler_in;
    Scrambler scrambler(
        .Input(scrambler_in),
        .Reset(scrambler_reset),
        .Clock(Clock),
        .Output(scrambler_out)
    );


    //  Output MUX:
    always @(scrambler_out, transmitter_out, is_scramble)
        Output <= is_scramble ? scrambler_out : transmitter_out;


    //  Wifi-Frame FSM:
    reg CURRENT_STATE;
    parameter IDLE_STATE = 0;
    parameter PLCP_PREAMBLE_STATE = 1;
    reg TURNS_PLCP_PREAMBLE = 8'h00;
    parameter MAX_TURNS_PLCP_PREAMBLE = 96; //  = 12 * 8 (12 Symbols, each symbol a byte)
    parameter [0:8*12-1] PREAMBLE_SYMBOLS = {8'hAA, 8'hAA, 8'hAA, 8'hAA,
                                             8'hAA, 8'hAA, 8'hAA, 8'hAA,
                                             8'hAA, 8'hAA, 8'hAA, 8'hAA};

    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)      //  Reset State
        begin
            transmitter_out <= 1'b0;
            is_scramble <= 1'b0;
            CURRENT_STATE <= IDLE_STATE; 
        end
        else if (Start) //  Start State
        begin
            CURRENT_STATE <= PLCP_PREAMBLE_STATE;
            is_scramble <= 1'b0;
            transmitter_out <= 1'b0;
            TURNS_PLCP_PREAMBLE <= 8'h00;
        end
        else
        begin
            
        end
    end
endmodule
