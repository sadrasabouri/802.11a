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
    reg Clock2;
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
        .Clock2(Clock2),
		.Reset(Reset),
		.Output(Output)
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
            " Start=%b", Start,
			" --- >",
			" Output:%b", Output);
    end

    integer i = 0;
    integer j = 0;
    integer N_PASS = 0;
    reg [1:625] DESIRED_OUT = 625'b1100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011000000000000000000000000000000000000000000000000000110100111010101001100100110010000110110010110110011010011011000001011010111100111000001110001101111111111011010011010010101001100101110101001101000010000000011101000010001100011100111001000000101010001111100111101000010010111000100110000010110100100111111001010001001111110110101011100101101011110100101011111000101010000011100110010011101011101001101001110100110110111010100110011111;
    reg [0:3] DATA_INPUT = 4'b1001;

    initial
    begin
		// Initialize Inputs
		$display("[START]");
		Clock = 0;
        Clock2 = 0;
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
        
        for (i = 1; i <= 625; i = i + 1)
        begin
            if (DESIRED_OUT[i] == Output)
            begin
                $display("[OK] (", i, "/", 625, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", i, "/", 625, ") Expected:%b  |  Got:%b", DESIRED_OUT[i], Output);
            #0.5;
        end

        if (N_PASS == 625)
            $display("ALL TEST PASSED. :)");
        else
            $display(625 - N_PASS, " test(s) failed. :(");
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

