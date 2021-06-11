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

	// Instantiate the Unit Under Test (UUT)
	Receiver uut (
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
    reg [1:127] SEQ_IN = 127'b0000111011110010110010010000001000100110001011101011011000001100110101001110011110110100001010101111101001010001101110001111111;

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
            if (Output == 0)
            begin
                $display("[OK] (", i-1, "/", 127, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", i-1, "/", 127, ") Expected:%b  |  Got:%b", 1'b0, Output);
            #1;
        end

        if (Output == 0)
        begin
            $display("[OK] (", i-1, "/", 127, ")");
            N_PASS = N_PASS + 1;  
        end
        else
            $display("[FAILED] (", i-1, "/", 127, ") Expected:%b  |  Got:%b", 1'b0, Output);
        
        if (N_PASS == 127)
            $display("ALL TEST PASSED. :)");
        else
            $display(127 - N_PASS, " test(s) failed. :(");
    end
endmodule
