`include "Transmitter/Transmitter.v"
`include "Receiver/Receiver.v"

module DUT(Start, Input, Reset, Clock, Antenna, Output);
/*
 * Module `DUT`
 *
 * 802.11a IEEE whole module desing under test which make a closed loop
 * path from transmitter ro reciever and checks if the sending data and 
 * it's receving are the same or not 
 *
 * Sub modules:
 * + Transmitter/Transmitter.v
 * + Receiver/Receiver.v
 *
 * parameters:
 * Start    [1]: Active high one-shot start
 * Input    [1]: Input data stream
 * Reset    [1]: Active high asynchronous reset
 * Clock    [1]: Input clock
 * Antenna  [1]: transmitter output, reciever input
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

    output wire Antenna;
    output wire Output;

    Transmitter transmitter(
        .Start(Start),
        .Input(Input),
        .Reset(Reset),
        .Clock(Clock),
        .Output(Antenna)
    );

    Receiver receiver(
        .Input(Antenna),
        .Reset(Reset),
        .Clock(Clock),
        .Output(Output)
    );
endmodule
