module ViterbiDecoder(Input, Reset, Clock, Output);
/*
 * Module `ViterbiDecoder`
 *
 * As Document issued decoding the received sequence by the Viterbi algorithm is recommended.
 * 
 * parameters:
 * Input    [1]: Input data stream
 * Reset    [1]: Active high asynchronous reset
 * Clock    [1]: Input clock
 * Output   [1]: Output descrambled data stream
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Input;
    input wire Reset; 
    input wire Clock;

    output wire Output;


    //  Pre-Defines:
    parameter MAX_LENGTH = 192;         //  len({Signal, Data}) / BPSK
    reg [7:0] CostsTilNow [0:63];       //  Cost of each state till now. 
    reg [0:8*MAX_LENGTH-1] Path [0:63]; //  Paths wich used for traceback


    reg inBuff;
    //  Input buffer handler:
    //      Buffer would be = {inBuff, Input} for more efficiency
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
            inBuff <= 1'b0;
        else
            inBuff <= Input;
    end

    //  Viterbi FSM - Values:
    reg [1:0] CURRENT_SATE;
    //  0. BMC (Branch Metric Calculation):
    //      In this section branch metrics are calculated for each
    parameter BMC = 0;
    reg collect_buffer;

    //  Viterbit - Graph
    integer i;
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
        begin
            CURRENT_SATE <= BMC;
            inBuff <= 2'b00;
            for(i = 0; i < 64; i = i + 1)   //  Costs and Path Initilizing
            begin
                CostsTilNow[i] <= 8'b1111_1111;
                Path[i] <= $unsigned(0);    
            end
        end
    end
endmodule
