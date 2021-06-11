`timescale 1ns / 1ps
module Transmitter_tb;
/*
* Module `Transmitter_tb`
*
* A Unit test for Transmitter.v
*
*************************************************
* @author : sadrasabouri(sabouri.sadra@gmail.com)
*************************************************
*/
	// Inputs
	reg Clock;
	reg Reset;
    reg Input;
    reg Start;

	// Outputs
	wire Output;

	// Instantiate the Unit Under Test (UUT)
	Transmitter uut (
        .Start(Start),
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
            " Start=%b", Start,
			" --- >",
			" Output:%b", Output);
    end

    integer i = 0;
    integer j = 0;
    integer N_PASS = 0;
    reg [1:288] DESIRED_OUT = 288'b101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010110100000000100000000000000011101111001001011001000000100010011000101110101101100000110011010100111001111011010000101010111110100101000110111000111111100001110111100101100100100000010001001100;
    reg [0:3] DATA_INPUT = 4'b1001;

    initial
    begin
		// Initialize Inputs
		$display("[START]");
		Clock = 0;
		Reset = 0;
        Input = 0;
        Start = 0;
        #10

        Reset = 1;
        #1;
        
        Reset = 0;
        Start = 1;
        #1;
        
        Start = 0;
        #1;
        
        for (i = 1; i <= 288; i = i + 1)
        begin
            if (DESIRED_OUT[i] == Output)
            begin
                $display("[OK] (", i, "/", 288, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", i, "/", 288, ") Expected:%b  |  Got:%b", DESIRED_OUT[i], Output);
            #1;
        end

        if (N_PASS == 288)
            $display("ALL TEST PASSED. :)");
        else
            $display(288 - N_PASS, " test(s) failed. :(");
    end

    initial
    begin
		#10
        #1;
        
        #137;
        $display("[DATA_INPUT::START]");
        for (j = 0; j < 4; j = j + 1)
        begin
            Input = DATA_INPUT[j];
            #1;
        end
        Input = 0;
        $display("[DATA_INPUT::END]");
    end
endmodule

