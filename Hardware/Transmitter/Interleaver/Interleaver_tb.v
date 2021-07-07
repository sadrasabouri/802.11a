`timescale 1ns / 1ps
module Interleaver_tb;
/*
* Module `Interleaver_tb`
*
* A Unit test for Interleaver.v
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

	// Instantiate the Unit Under Test (UUT)
	Interleaver uut (
		.Input(Input),
		.Clock(Clock),
		.Reset(Reset),
		.Output(Output)
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
			" Output:%b", Output);
    end

    integer i = 0;
    integer N_PASS = 0;
    reg [1:191] DESIRED_IN = 192'b111010111001101110110000110111110010110000000000000000001110010111110011101001001011011010101011111000001011110111111111000010001111010011010111000001000101100001001001001010000000110010101100;
    reg [1:192] DESIRED_OUT= 192'b110100111010101001100100110010000110110010110110011010011011000001011010111100111000001110001101111111111011010011010010101001100101110101001101000010000000011101000010001100011100111001000000;

    //  Inputs:
    initial
    begin
		// Initialize Inputs
		$display("[START]");
		Clock = 0;
		Reset = 0;
        Input = 1;
        #10

        Reset = 1;
        #1;
        Reset = 0;
        #1;

        $display("[INPUT::START]");
        for (i = 1; i <= 191; i = i + 1)
        begin
            Input = DESIRED_IN[i];
            #1;
        end
    end

    integer j = 0;
    //  Outputs:
    initial
    begin
        //  After a minimum delay:
        #60;
        $display("[Output::START]");
        for (j = 1; j <= 191; j = j + 1)
        begin
            if (DESIRED_OUT[j] == Output)
            begin
                $display("[OK] (", j, "/", 192, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", j, "/", 192, ") Expected:%b  |  Got:%b", DESIRED_OUT[j], Output);
            #1;
        end

        if (N_PASS == 192)
            $display("ALL TEST PASSED. :)");
        else
            $display(192 - N_PASS, " test(s) failed. :(");
    end
endmodule
