`include "DeScrambler/DeScrambler.v"

module Receiver(Input, Reset, Clock, Output, Error);
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
 * Error    [1]: Error bit which uses for exception rasing
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Input;
    input wire Reset;
    input wire Clock;

    output wire Output;
    output reg Error;


    parameter MAX_TURNS_PLCP_PREAMBLE = 95; //  = 12 * 8 - 1 (12 Symbols, each symbol's a byte)
    
    reg [0:MAX_TURNS_PLCP_PREAMBLE] Input_buffer;
    always @(posedge Clock, posedge Reset)  //  Save last 96 bit for preambles
        if (Reset)
            Input_buffer <= 95'b0;
        else
            Input_buffer <= {{Input_buffer[1:MAX_TURNS_PLCP_PREAMBLE]}, {Input}};


    //  DeScrambler Instatiation:
    reg descrambler_reset;
    reg [7:1] descrambler_init;
    DeScrambler descrambler(
        .Input(Input_buffer[88]),           //  Which is used to descramble given data
        .Reset(descrambler_reset),
        .Init(descrambler_init),
        .Clock(Clock),
        .Output(Output)
    );


    always @(posedge Clock, posedge Reset)  //  Scrambler routine
    begin
        if (Reset)
        begin
            descrambler_init <= 7'b0000000;
        end
        else
        begin
            descrambler_init[1] <= Input_buffer[91] ^ Input_buffer[95];     //  X[1] = D[2] ^ D[6]
            descrambler_init[2] <= Input_buffer[90] ^ Input_buffer[94];     //  X[2] = D[1] ^ D[5]
            descrambler_init[3] <= Input_buffer[89] ^ Input_buffer[93];     //  X[3] = D[0] ^ D[4]
            descrambler_init[4] <= Input_buffer[91] ^ Input_buffer[92] ^    //  X[4] = D[2] ^ D[3] ^
                                   Input_buffer[95];                        //         D[6]
            descrambler_init[5] <= Input_buffer[90] ^ Input_buffer[91] ^    //  X[5] = D[1] ^ D[2] ^
                                   Input_buffer[94];                        //         D[5]
            descrambler_init[6] <= Input_buffer[90] ^ Input_buffer[89] ^    //  X[6] = D[1] ^ D[0] ^
                                   Input_buffer[93];                        //         D[4]
            descrambler_init[7] <= Input_buffer[89] ^ Input_buffer[91] ^    //  X[7] = D[0] ^ D[2] ^
                                   Input_buffer[92] ^ Input_buffer[95];     //         D[3] ^ D[6]
        end
    end


    //  Wifi-Frame - Parameters:
    //      Current state register:
    reg [3:0] CURRENT_STATE;
    //      IDLE state:
    parameter [3:0] IDLE_STATE = 0;
    parameter [0:8*12-1] PREAMBLE_SYMBOLS = {8'hAA, 8'hAA, 8'hAA, 8'hAA,
                                             8'hAA, 8'hAA, 8'hAA, 8'hAA,
                                             8'hAA, 8'hAA, 8'hAA, 8'hAA};

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


    always @(posedge Clock, posedge Reset)
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
        end
        else
        begin
            case (CURRENT_STATE)
                IDLE_STATE:
                begin
                    descrambler_reset = 1'b0;
                    if (Input_buffer == PREAMBLE_SYMBOLS)
                        CURRENT_STATE <= SIGNAL_RATE_STATE;
                end
                //  ------------------------------------
                //  PLCP_PREAMBLE::END     SIGNAL::START
                //  ------------------------------------
                SIGNAL_RATE_STATE:
                begin
                    RATE[TURNS_RATE_STATE] <= Input;

                    //  Reached to the end of Rate sub-frame
                    if (TURNS_RATE_STATE == 2'b11)
                    begin
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
                    LENGTH[TURNS_LENGTH_STATE] <= Input;  

                    //  Reached to the end of lenght sub-frame
                    if (TURNS_LENGTH_STATE >= 11)   //  12 - 1
                    begin
                        CURRENT_STATE <= SIGNAL_PARITY_STATE;
                        TURNS_LENGTH_STATE <= 2'b00;
                    end
                    else
                        TURNS_LENGTH_STATE <= TURNS_LENGTH_STATE + 2'b01;
                end
                SIGNAL_PARITY_STATE:
                begin
                    if(Input != ^{ {RATE},   //  4  bits Data Rate
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
                    if (TURNS_SERVICE_STATE == 6)
                        descrambler_reset <= 1'b1;
                    if (TURNS_SERVICE_STATE == 7)
                        descrambler_reset <= 1'b0;

                    //  Reached to the end of service sub-frame
                    if (TURNS_SERVICE_STATE >= 15)
                    begin
                        CURRENT_STATE <= DATA_PSDU_STATE;
                        TURNS_SERVICE_STATE <= 4'b0000;
                    end
                    else
                        TURNS_SERVICE_STATE <= TURNS_SERVICE_STATE + 4'b0001;
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
