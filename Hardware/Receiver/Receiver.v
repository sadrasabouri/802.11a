`include "DeScrambler/DeScrambler.v"

module Transmitter(Input, Reset, Clock, Output);
/*
 * Module `Receiver`
 *
 * 802.11a IEEE Receiver
 * 
 * Sub modules:
 * + DeScrambler/DeScrambler.v
 *
 * parameters:
 * Input    [1]: Input Wifi frame
 * Reset    [1]: Active high asynchronous reset
 * Clock    [1]: Input clock
 * Output   [1]: Output data
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Input;
    input wire Reset;
    input wire Clock;

    output wire Output;

    DeScrambler descrambler(
        .Input(Input),
        .Reset(Reset),
        .Clock(Clock),
        .Output(Output)
    );
endmodule
