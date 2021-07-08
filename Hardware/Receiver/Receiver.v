`include "DeScrambler/DeScrambler.v"
`include "ViterbiDecoder/ViterbiDecoder.v"
`include "DeInterleaver/DeInterleaver.v"

module Receiver(Input, Reset, Clock, Clock2, Output, Error);
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
 * Clock2   [1]: Input clock2 (2*Main clock)
 * Output   [1]: Output data
 * Error    [1]: Error bit which uses for exception rasing
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Input;
    input wire Reset;
    input wire Clock;
    input wire Clock2;

    output wire Output;
    output reg Error;


    parameter MAX_TURNS_PLCP_PREAMBLE = 95; //  = 12 * 8 - 1 (12 Symbols, each symbol's a byte)
    parameter N_CBPS = 48;
    //  Current state register:
    reg [3:0] CURRENT_STATE;

    reg [0:MAX_TURNS_PLCP_PREAMBLE] Input_buffer;
    wire INPUT_BUFF_CLCK;
    assign INPUT_BUFF_CLCK = CURRENT_STATE ? Clock2 : Clock ;
    always @(posedge INPUT_BUFF_CLCK, posedge Reset)  //  Save last 96 bit for preambles
        if (Reset)
            Input_buffer <= 96'b0;
        else
            Input_buffer <= {{Input_buffer[1:MAX_TURNS_PLCP_PREAMBLE]}, {Input}};


    //  DeScrambler Instatiation:
    reg descrambler_reset;
    reg [7:1] descrambler_init;
    reg [-1:6] decoded_buffer;
    DeScrambler descrambler(
        .Input(decoded_buffer[-1]),           //  Which is used to descramble given data
        .Reset(descrambler_reset),
        .Init(descrambler_init),
        .Clock(Clock2),
        .Output(Output)
    );


    //  ViterbiDecoder Instatiation:
    reg viterbi_reset;
    wire viterbi_in;
    wire viterbi_out;
    ViterbiDecoder viterbidecoder(
        .Input(viterbi_in),           //  Last input for clock problem
        .Reset(viterbi_reset),
        .Clock(Clock2),
        .Output(viterbi_out)
    );


    //  DeInterleaver Instantiation:
    reg deinterleaver_reset;
    DeInterleaver deinterleaver(
        .Input(Input_buffer[94]),
        .Clock(Clock2),
        .Reset(deinterleaver_reset),
        .Output(viterbi_in)
    );


    always @(posedge Clock2, posedge Reset)  //  Scrambler routine
    begin
        if (Reset)
        begin
            decoded_buffer <= 8'h0;
            descrambler_init <= 7'b0000000;
        end
        else
        begin
            decoded_buffer <= {decoded_buffer[0:6], viterbi_out};
            descrambler_init[1] <= decoded_buffer[2] ^ decoded_buffer[6];     //  X[1] = D[2] ^ D[6]
            descrambler_init[2] <= decoded_buffer[1] ^ decoded_buffer[5];     //  X[2] = D[1] ^ D[5]
            descrambler_init[3] <= decoded_buffer[0] ^ decoded_buffer[4];     //  X[3] = D[0] ^ D[4]
            descrambler_init[4] <= decoded_buffer[2] ^ decoded_buffer[3] ^    //  X[4] = D[2] ^ D[3] ^
                                   decoded_buffer[6];                         //         D[6]
            descrambler_init[5] <= decoded_buffer[1] ^ decoded_buffer[2] ^    //  X[5] = D[1] ^ D[2] ^
                                   decoded_buffer[5];                         //         D[5]
            descrambler_init[6] <= decoded_buffer[1] ^ decoded_buffer[0] ^    //  X[6] = D[1] ^ D[0] ^
                                   decoded_buffer[4];                         //         D[4]
            descrambler_init[7] <= decoded_buffer[0] ^ decoded_buffer[2] ^    //  X[7] = D[0] ^ D[2] ^
                                   decoded_buffer[3] ^ decoded_buffer[6];     //         D[3] ^ D[6]
        end
    end


    //  Wifi-Frame - Parameters:
    //      IDLE state:
    parameter [3:0] IDLE_STATE = 0;
    parameter [0:8*12-1] PREAMBLE_SYMBOLS = {8'hAA, 8'hAA, 8'hAA, 8'hAA,
                                             8'hAA, 8'hAA, 8'hAA, 8'hAA,
                                             8'hAA, 8'hAA, 8'hAA, 8'hAA};

    //      WAIT4VITERBI:
    parameter [3:0] WAIT4VITERBI = 1;
    reg [10:1] WAIT4VITERBI_counter;
    //      Signal state:
    //          Rate state:
    parameter [3:0] SIGNAL_RATE_STATE = 2;
    reg [1:0] TURNS_RATE_STATE;
    reg [0:3] RATE;                      // [Data Rate (Big Endian)]
    //          Reserved:
    parameter [3:0] SIGNAL_RESERVERD_STATE = 3;
    //          LENGTH:
    parameter [3:0] SIGNAL_LENGTH_STATE = 4;
    reg [3:0] TURNS_LENGTH_STATE;
    reg [0:11] LENGTH;                  // [Octet Numbers of Data (Big Endian)]
    //          PARITY:
    parameter [3:0] SIGNAL_PARITY_STATE = 5;
    //          TAIL:
    parameter [3:0] SIGNAL_TAIL_STATE = 6;
    reg [2:0] TURNS_TAIL_STATE;
    //      Data state:
    //          Service:
    parameter [3:0] DATA_SERVICE_STATE = 7;
    reg [3:0] TURNS_SERVICE_STATE;
    //          PSDU:
    parameter [3:0] DATA_PSDU_STATE = 8;
    reg [14:0] TURNS_PSDU_STATE;            //  Maximum is 8 * (2 ^ 12 - 1)
    //          Tail:
    parameter [3:0] DATA_TAIL_STATE = 9;
    //          PAD_BITS:
    //          WAIT4INTER:
    parameter [3:0] WAIT4INTER_STATE = 10;
    reg [7:0] WAIT4INTER_counter;
    //          WAIT4DEINTER:
    parameter [3:0] WAIT4DEINTER_STATE = 11;
    reg [7:0] WAIT4DEINTER_counter;


    always @(posedge INPUT_BUFF_CLCK, posedge Reset)
    begin
        if (Reset)
        begin
            descrambler_reset = 1'b1;
            CURRENT_STATE <= IDLE_STATE;
            TURNS_RATE_STATE <= 2'b00;
            RATE <= 4'b1101;                // =6
            TURNS_LENGTH_STATE <= 4'h0;
            LENGTH <= 12'h010;              // =16
            TURNS_TAIL_STATE <= 3'b000;
            TURNS_SERVICE_STATE <= 4'b0000;
            TURNS_PSDU_STATE <= 15'b000_0000_0000_0000;
            Error <= 1'b0;
            viterbi_reset <= 1'b0;
            WAIT4VITERBI_counter <= 10'b0;
            deinterleaver_reset <= 1'b0;
            WAIT4INTER_counter <= 8'h00;
            WAIT4DEINTER_counter <= 8'h00;
        end
        else
        begin
            case (CURRENT_STATE)
                IDLE_STATE:
                begin
                    descrambler_reset = 1'b0;
                    $display("%h ?= %h", Input_buffer, PREAMBLE_SYMBOLS);
                    if (Input_buffer == PREAMBLE_SYMBOLS)
                    begin
                        CURRENT_STATE <= WAIT4INTER_STATE;
                        // viterbi_reset <= 1'b1;
                        $display("New Sequence Found.");
                    end
                end
                WAIT4INTER_STATE:
                begin
                    WAIT4INTER_counter <= WAIT4INTER_counter + 8'h01;
                    if (WAIT4INTER_counter == N_CBPS)     //  Extra zeros generated when interleaving
                    begin
                        CURRENT_STATE <= WAIT4DEINTER_STATE;
                        deinterleaver_reset <= 1'b1;
                        $display("DeInterleaver Reseted.");
                    end
                end
                WAIT4DEINTER_STATE:
                begin
                    deinterleaver_reset <= 1'b0;
                    WAIT4DEINTER_counter <= WAIT4DEINTER_counter + 8'h01;
                    if (WAIT4DEINTER_counter == N_CBPS)
                    begin
                        viterbi_reset <= 1'b1;
                        CURRENT_STATE <= WAIT4VITERBI;
                        $display("Start Decoding.");
                    end
                end
                //  ------------------------------------
                //  Wait for Viterbi Decoder to decode input sequence
                //  ------------------------------------
                WAIT4VITERBI:
                begin
                    viterbi_reset <= 1'b0;
                    if (WAIT4VITERBI_counter == 0)
                        $display("Viterbi Reseted.");
                    WAIT4VITERBI_counter <= WAIT4VITERBI_counter + 10'b00_0000_0001;
                    if (WAIT4VITERBI_counter == 645)
                    begin
                        CURRENT_STATE <= SIGNAL_RATE_STATE;
                        $display("Here we start to get decoded seq!");    
                    end
                end
                //  ------------------------------------
                //  PLCP_PREAMBLE::END     SIGNAL::START
                //  ------------------------------------
                SIGNAL_RATE_STATE:
                begin
                    RATE[TURNS_RATE_STATE] <= viterbi_out;

                    //  Reached to the end of Rate sub-frame
                    if (TURNS_RATE_STATE == 2'b11)
                    begin
                        $display("RATE = %b", RATE);
                        CURRENT_STATE <= SIGNAL_RESERVERD_STATE;
                        TURNS_RATE_STATE <= 2'b00;
                    end
                    else
                        TURNS_RATE_STATE <= TURNS_RATE_STATE + 2'b01;
                end
                SIGNAL_RESERVERD_STATE:
                begin
                    CURRENT_STATE <= SIGNAL_LENGTH_STATE;
                end
                SIGNAL_LENGTH_STATE:
                begin
                    LENGTH[TURNS_LENGTH_STATE] <= viterbi_out;  

                    //  Reached to the end of lenght sub-frame
                    if (TURNS_LENGTH_STATE >= 11)   //  12 - 1
                    begin
                        $display("LEN = %b", LENGTH);
                        CURRENT_STATE <= SIGNAL_PARITY_STATE;
                        TURNS_LENGTH_STATE <= 2'b00;
                    end
                    else
                        TURNS_LENGTH_STATE <= TURNS_LENGTH_STATE + 2'b01;
                end
                SIGNAL_PARITY_STATE:
                begin
                    if(viterbi_out != ^{ {RATE},   //  4  bits Data Rate
                                       {1'b0},   //  1  bit Reserved
                                       {LENGTH}  //  12 bits Data LENGTH
                                       })
                        Error <= 1'b1;

                    //  Reached to the end of Parity sub-frame
                    CURRENT_STATE <= SIGNAL_TAIL_STATE;
                end
                SIGNAL_TAIL_STATE:
                begin
                    //  Reached to the end of tail sub-frame
                    if (TURNS_TAIL_STATE >= 5)      //  6 - 1
                    begin
                        CURRENT_STATE <= DATA_SERVICE_STATE;
                        TURNS_TAIL_STATE <= 3'b000;
                    end
                    else
                        TURNS_TAIL_STATE <= TURNS_TAIL_STATE + 3'b001;
                end
                //  ------------------------------------
                //  SIGNAL::END             DATA::START
                //  ------------------------------------
                DATA_SERVICE_STATE:
                begin
                    //  Reseting DeScrambler when initial values are aready
                    if (TURNS_SERVICE_STATE == 8)
                    begin
                        $display("INIT=%b", descrambler_init);
                        descrambler_reset <= 1'b1;
                    end
                    if (TURNS_SERVICE_STATE == 9)
                    begin
                        $display("Scrambler Reseted.");
                        descrambler_reset <= 1'b0;
                    end
                        
                    //  Reached to the end of service sub-frame
                    if (TURNS_SERVICE_STATE >= 15)
                    begin
                        CURRENT_STATE <= DATA_PSDU_STATE;
                        TURNS_SERVICE_STATE <= 4'b0000;
                    end
                    else
                        TURNS_SERVICE_STATE <= TURNS_SERVICE_STATE + 4'b0001;
                end
                DATA_PSDU_STATE:
                begin
                    //  Reached to the end of psdu sub-frame (LENGHT bytes = LENGHT << 3 bits)
                    if (TURNS_PSDU_STATE + 15'b000_0000_0000_0001 >= {{LENGTH}, {3'b000}})
                    begin
                        CURRENT_STATE <= DATA_TAIL_STATE;
                        TURNS_PSDU_STATE <= 15'b000_0000_0000_0000;
                    end
                    else
                        TURNS_PSDU_STATE <= TURNS_PSDU_STATE + 15'b000_0000_0000_0001;
                end
                DATA_TAIL_STATE:
                begin
                    //  Reached to the end of tail sub-frame
                    if (TURNS_TAIL_STATE >= 6)
                    begin
                        CURRENT_STATE <= IDLE_STATE;
                        TURNS_TAIL_STATE <= 3'b000;
                    end
                    else
                        TURNS_TAIL_STATE <= TURNS_TAIL_STATE + 3'b001;
                end
                default:
                begin
                    descrambler_reset = 1'b0;
                    if (Input_buffer == PREAMBLE_SYMBOLS)
                        CURRENT_STATE <= SIGNAL_RATE_STATE;
                end 
            endcase
        end
    end
endmodule
