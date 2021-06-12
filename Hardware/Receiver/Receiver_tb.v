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
	reg Reset;
    reg Input;

	// Outputs
	wire Output;
    wire Error;

	// Instantiate the Unit Under Test (UUT)
	Receiver uut (
		.Input(Input),
		.Clock(Clock),
		.Reset(Reset),
		.Output(Output),
        .Error(Error),
    );
	
    localparam CLK_PERIOD = 0.5;

    always 
	begin
		 Clock = ~Clock;
		 #CLK_PERIOD;
	end

	always
	begin
        #1;
		$display($time, "ns |",
			" Reset=%b", Reset,
			" Input=%b", Input,
			" --- >",
            " Error=%b", Error,
			" Output:%b", Output);
    end

    integer i = 0;
    integer N_PASS = 0;
    reg [1:288] SEQ_IN = 288'b101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010110100000000100000000000000011101111001001011001000000100010011000101110101101100000110011010100111001111011010000101010111110100101000110111000111111100001110111100101100100100000010001001100;

    initial
    begin
		// Initialize Inputs
		$display("[START]");
		Clock = 0;
		Reset = 0;
        Input = SEQ_IN[1];
        #10

        Reset = 1;
        #1;
        Reset = 0;

        for (i = 2; i <= 127; i = i + 1)
        begin
            Input = SEQ_IN[i];
            // if (Output == 0)
            // begin
            //     $display("[OK] (", i-1, "/", 127, ")");
            //     N_PASS = N_PASS + 1;  
            // end
            // else
            //     $display("[FAILED] (", i-1, "/", 127, ") Expected:%b  |  Got:%b", 1'b0, Output);
            #1;
        end

        // if (Output == 0)
        // begin
        //     $display("[OK] (", i-1, "/", 127, ")");
        //     N_PASS = N_PASS + 1;  
        // end
        // else
        //     $display("[FAILED] (", i-1, "/", 127, ") Expected:%b  |  Got:%b", 1'b0, Output);
        
        // if (N_PASS == 127)
        //     $display("ALL TEST PASSED. :)");
        // else
        //     $display(127 - N_PASS, " test(s) failed. :(");
    end
endmodule
