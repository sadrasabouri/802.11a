`timescale 1ns / 1ps
module ViterbiDecoder_tb;
/*
* Module `ViterbiDecoder_tb`
*
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
	ViterbiDecoder uut (
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
    reg [1:384] SEQ_IN = 384'b111010111001101110110000110111110010110000000000000000001110010111110011101001001011011010101011111000001011110111111111000010001111010011010111000001000101100001001001001010000000110010101100100111100010110001010100111001011011011000100000111110000111101110011010011101000001110111001101101110101000110001100110010101111100111010010001101010111110110101000010111101111111110000100011;

    initial
    begin
		// Initialize Inputs
		$display("[START]");
		Clock = 0;
		Reset = 0;
        #10

        Reset = 1;
        #1;
        Reset = 0;

        $display("[INPUT:START]");
        for (i = 1; i <= 384; i = i + 1)
        begin
            Input = SEQ_IN[i];
            #1;
        end
        $display("[INPUT:END]");
    end

    reg [1:192] DES_OUT = 192'b110100000000100000000000000011101111001001011001000000100010011000101110101101100000110011010100111001111011010000101010111110100101000110111000111111100001110111100101100100100000010001001100;

    initial
    begin
		// Initialize Inputs
        #656;

        for (i = 1; i <= 192; i = i + 1)
        begin
            if (Output == DES_OUT[i])
            begin
                $display("[OK] (", i, "/", 192, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", i, "/", 192, ") Expected:%b  |  Got:%b", DES_OUT[i], Output);
            #1;
        end

        if (N_PASS == 192)
            $display("ALL TEST PASSED. :)");
        else
            $display(192 - N_PASS, " test(s) failed. :(");
    end
endmodule
