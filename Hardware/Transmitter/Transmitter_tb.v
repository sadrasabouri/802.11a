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
    reg [1:576] DESIRED_OUT = 576'b110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100111010111001101110110000110111110010110000000000000000001110010111110011101001001011011010101011111000001011110111111111000010001111010011010111000001000101100001001001001010000000110010101100100111100010110001010100111001011011011000100000111110000111101110011010011101000001110111001101101110101000110001100110010101111100111010010001101010111110110101000010111101111111110000100011;
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
        
        for (i = 1; i <= 576; i = i + 1)
        begin
            if (DESIRED_OUT[i] == Output)
            begin
                $display("[OK] (", i, "/", 576, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", i, "/", 576, ") Expected:%b  |  Got:%b", DESIRED_OUT[i], Output);
            #0.5;
        end

        if (N_PASS == 576)
            $display("ALL TEST PASSED. :)");
        else
            $display(576 - N_PASS, " test(s) failed. :(");
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

