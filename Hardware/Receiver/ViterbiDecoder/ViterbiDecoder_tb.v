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

    integer is_even = 0;
	always
	begin
        #1;
		$display($time, "ns |",
			" Reset=%b", Reset,
			" Input=%b", Input,
			" --- >",
			" Output:%b", Output);
        if (is_even)
        begin
            $display($time, "ns | "," -------------------------------------- >",
			" Output:%b", Output);
            is_even = 0;
        end
        else
            is_even = 1;
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
endmodule
