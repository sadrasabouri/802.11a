module Interleaver(Input, Reset, Clock, Output);
/*
 * Module `Interleaver`
 *
 * 802.11a IEEE Wifi PLCP DATA Scrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)
 *
 * In N_CBPS = 48 we have these index mappings:
 * 0 --> 0
 * 1 --> 3
 * 2 --> 6
 * 3 --> 9
 * 4 --> 12
 * 5 --> 15
 * 6 --> 18
 * 7 --> 21
 * 8 --> 24
 * 9 --> 27
 * 10 --> 30
 * 11 --> 33
 * 12 --> 36
 * 13 --> 39
 * 14 --> 42
 * 15 --> 45
 * 16 --> 1
 * 17 --> 4
 * 18 --> 7
 * 19 --> 10
 * 20 --> 13
 * 21 --> 16
 * 22 --> 19
 * 23 --> 22
 * 24 --> 25
 * 25 --> 28
 * 26 --> 31
 * 27 --> 34
 * 28 --> 37
 * 29 --> 40
 * 30 --> 43
 * 31 --> 46
 * 32 --> 2
 * 33 --> 5
 * 34 --> 8
 * 35 --> 11
 * 36 --> 14
 * 37 --> 17
 * 38 --> 20
 * 39 --> 23
 * 40 --> 26
 * 41 --> 29
 * 42 --> 32
 * 44 --> 35
 * 45 --> 38
 * 46 --> 41
 * 47 --> 44
 * 
 * parameters:
 * Input    [1]: Input data stream
 * Reset    [1]: Active high asynchronous reset
 * Clock    [1]: Input clock
 * Output   [1]: Output scrambled data stream
 *
 *************************************************
 * @author : sadrasabouri(sabouri.sadra@gmail.com)
 *************************************************
 */
    input wire Input;
    input wire Reset;
    input wire Clock;
    output reg Output;

    parameter N_CBPS = 48;
    parameter N_COLS = 16;
    parameter N_ROWS = N_CBPS / 16;

    reg [3:0] j_col_IN;
    reg [1:0] i_row_IN;
    reg [0:15] MEM_IN [0:2];
    reg [3:0] j_col_OUT;
    reg [1:0] i_row_OUT;
    reg [0:15] MEM_OUT [0:2];
    reg [7:0] counter;

    integer k;
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
        begin
            j_col_IN <= 4'b0000;
            i_row_IN <= 2'b00;
            for(k = 0; k < N_ROWS; k = k + 1)               //  Memory Initilizing
                MEM_IN[k] <= 16'h0000;
            j_col_OUT <= 4'b0000;
            i_row_OUT <= 2'b00;
            for(k = 0; k < N_ROWS; k = k + 1)               //  Memory Initilizing
                MEM_OUT[k] <= 16'h0000;
            counter <= 8'h01;
        end
        else
        begin
            counter <= counter + 8'h01;
            if (counter == N_CBPS)
            begin
                $display("[INNER_TEST]: (MEM_OUT <= MEM_IN)");
                for(k = 0; k < N_ROWS; k = k + 1)           //  Copy Memory
                begin
                    MEM_OUT[k] <= MEM_IN[k];
                    $display("%b", MEM_IN[k]);
                end
                j_col_IN <= 4'b0000;
                i_row_IN <= 2'b00;
                j_col_OUT <= 4'b0000;
                i_row_OUT <= 2'b00;
                counter <= 8'h01;
            end
            else
            begin
                //  Input Memory Mapping:
                MEM_IN[i_row_IN][j_col_IN] <= Input;
                j_col_IN <= j_col_IN + 4'b0001;
                if (j_col_IN == 4'b1111)
                    i_row_IN <= i_row_IN + 2'b01;
                
                //  Output Memory Mapping:
                i_row_OUT <= i_row_OUT + 2'b01;
                if (i_row_OUT + 2'b01 == N_ROWS)
                begin
                    j_col_OUT <= j_col_OUT + 4'b0001;
                    i_row_OUT <= 2'b00;
                end 
            end
        end
    end

    //  Output Update:
    always @(posedge Clock, posedge Reset)
    begin
        if (Reset)
            Output <= 1'b0;
        else
            Output <= MEM_OUT[i_row_OUT][j_col_OUT];
    end
endmodule
