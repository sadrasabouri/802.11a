`timescale 1ns / 1ps
module ConvEncoder_tb;
/*
* Module `ConvEncoder_tb`
*
* A Unit test for ConvEncoder.v
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
	ConvEncoder uut (
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
    reg [1:16] DESIRED_OUT = 16'b1110011010001111;

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

        for (i = 1; i <= 16; i = i + 1)
        begin
            if (DESIRED_OUT[i] == Output)
            begin
                $display("[OK] (", i, "/", 16, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", i, "/", 16, ") Expected:%b  |  Got:%b", DESIRED_OUT[i], Output);
            #1;
        end

        if (N_PASS == 16)
            $display("ALL TEST PASSED. :)");
        else
            $display(16 - N_PASS, " test(s) failed. :(");
    end
endmodule
