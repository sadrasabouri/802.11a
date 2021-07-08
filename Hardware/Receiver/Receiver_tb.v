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
    reg [1:529] SEQ_IN = 529'b1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000110100111010101001100100110010000110110010110110011010011011000001011010111100111000001110001101111111111011010011010010101001100101110101001101000010000000011101000010001100011100111001000000101010001111100111101000010010111000100110000010110100100111111001010001001111110110101011100101101011110100101011111000101010000011100110010011101011101001101001110100110110111010100110011111;

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
        for (i = 97; i <= 529; i = i + 1)
        begin
            Input = SEQ_IN[i];
            #0.5;
        end
    end

    integer j = 0;
    integer N_PASS = 0;
    reg [1:4] DESIRED_OUT = 4'b1001;
    initial
    begin
        #10;
        #1;

        #486.5;
        $display("[DATA::START]");
        for (j = 1; j <= 4; j = j + 1)
        begin
            if (Output == DESIRED_OUT[j])
            begin
                $display("[OK] (", j, "/", 4, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", j, "/", 4, ") Expected:%b  |  Got:%b", DESIRED_OUT[j], Output);
            #0.5;
        end

        if (N_PASS == 4)
            $display("ALL TEST PASSED. :)");
        else
            $display(4 - N_PASS, " test(s) failed. :(");

        $display("[DATA::END]");
    end
endmodule
