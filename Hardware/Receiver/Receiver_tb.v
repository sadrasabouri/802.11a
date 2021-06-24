`timescale 1ns / 1ps
module Receiver_tb;
/*
* Module `Receiver_tb`
*
* A Unit test for Receiver.v
*
*************************************************
* @author : sadrasabouri(sabouri.sadra@gmail.com)
*************************************************
*/
	// Inputs
	reg Clock;
    reg Clock2;
	reg Reset;
    reg Input;

	// Outputs
	wire Output;
    wire Error;

	// Instantiate the Unit Under Test (UUT)
	Receiver uut (
		.Input(Input),
		.Clock(Clock),
		.Clock2(Clock2),
		.Reset(Reset),
		.Output(Output),
        .Error(Error)
    );
	
    localparam CLK_PERIOD = 0.5;
    localparam CLK2_PERIOD = 0.25;

    always 
	begin
		 Clock = ~Clock;
		 #CLK_PERIOD;
	end

    always 
	begin
		 Clock2 = ~Clock2;
		 #CLK2_PERIOD;
	end

	always
	begin
        #0.5;
		$display($time, "ns |",
			" Reset=%b", Reset,
			" Input=%b", Input,
			" --- >",
            " Error=%b", Error,
			" Output:%b", Output);
    end

    integer i = 0;
    reg [1:480] SEQ_IN = 480'b101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010111010111001101110110000110111110010110000000000000000001110010111110011101001001011011010101011111000001011110111111111000010001111010011010111000001000101100001001001001010000000110010101100100111100010110001010100111001011011011000100000111110000111101110011010011101000001110111001101101110101000110001100110010101111100111010010001101010111110110101000010111101111111110000100011;

    initial
    begin
		// Initialize Inputs
		$display("[START]");
		Clock = 0;
        Clock2 = 0;
		Reset = 0;
        #10

        Reset = 1;
        #1;
        Reset = 0;

        for (i = 1; i <= 96; i = i + 1)
        begin
            Input = SEQ_IN[i];
            #1;
        end

        //  Coded Section:
        for (i = 97; i <= 480; i = i + 1)
        begin
            Input = SEQ_IN[i];
            #0.5;
        end
    end

    // integer j = 0;
    // integer N_PASS = 0;
    // reg [1:4] DESIRED_OUT = 4'b1001;
    // initial
    // begin
    //     #10;
    //     #1;

    //     #141;
    //     $display("[DATA::START]");
    //     for (j = 1; j <= 4; j = j + 1)
    //     begin
    //         if (Output == DESIRED_OUT[j])
    //         begin
    //             $display("[OK] (", j, "/", 4, ")");
    //             N_PASS = N_PASS + 1;  
    //         end
    //         else
    //             $display("[FAILED] (", j, "/", 4, ") Expected:%b  |  Got:%b", DESIRED_OUT[j], Output);
    //         #1;
    //     end

    //     if (N_PASS == 4)
    //         $display("ALL TEST PASSED. :)");
    //     else
    //         $display(4 - N_PASS, " test(s) failed. :(");

    //     $display("[DATA::END]");
    // end
endmodule
