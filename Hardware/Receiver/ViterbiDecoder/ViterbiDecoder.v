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
    reg [0:7*MAX_LENGTH-1] Path [0:63]; //  Paths wich used for traceback


    reg inBuff;
    reg [9:0] input_counter;
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
    //  0. BPMC (Branch and Path Metric Calculation):
    //      In this section branch metrics are calculated for each
    parameter BPMC = 0;
    reg collect_buffer;
    //  1. TRCBCK (Trace Back Calculation)
    parameter TRCBCK = 1;

    //  Viterbit - Graph
    integer i;
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
        begin
            CURRENT_SATE <= BPMC;
            inBuff <= 2'b00;
            collect_buffer <= 1'b0;
            for(i = 0; i < 64; i = i + 1)   //  Costs and Path Initilizing
            begin
                CostsTilNow[i] <= 8'b1111_1111;
                Path[i] <= {MAX_LENGTH{7'b1000000}};    //  Unknow state    
            end
            input_counter <= 10'b00_0000_0000;
        end
        else
        begin
            case (CURRENT_SATE)
                BPMC:
                    if (collect_buffer)
                    begin
                        if (input_counter == 10'b00_0000_0000)  //  First State
                        begin
                            //  State 0 -> 0 | Output : 00
                            Path[6'b000000] <= {7'b0000000, Path[6'b000000][7:MAX_LENGTH-1]};
                            CostsTilNow[6'b000000] <= $unsigned((inBuff ^ 1'b0) + (Input ^ 1'b0)); 

                            //  State 0 -> 32 | Output : 11
                            Path[6'b100000] <= {7'b0000000, Path[6'b100000][7:MAX_LENGTH-1]};
                            CostsTilNow[6'b100000] <= $unsigned((inBuff ^ 1'b1) + (Input ^ 1'b1));
                        end
                        else if (input_counter < MAX_LENGTH)
                        begin
                            
                        end
                        else
                        begin
                            CURRENT_SATE <= TRCBCK;
                            input_counter <= 10'b00_0000_0000;
                        end
                        input_counter <= input_counter + 10'b00_0000_0001;
                    end
                default: 
                begin
                    CURRENT_SATE <= BPMC;
                    inBuff <= 2'b00;
                    collect_buffer <= 1'b0;
                    for(i = 0; i < 64; i = i + 1)   //  Costs and Path Initilizing
                    begin
                        CostsTilNow[i] <= 8'b1111_1111;
                        Path[i] <= {MAX_LENGTH{7'b1000000}};    //  Unknow state
                    end
                    input_counter <= 10'b00_0000_0000;
                end
            endcase
            collect_buffer <= ~collect_buffer;
        end
    end
endmodule
