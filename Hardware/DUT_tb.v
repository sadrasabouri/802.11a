`timescale 1ns / 1ps
module DUT_tb;
/*
* Module `DUT_tb`
*
* A Integration test for whole project
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
    wire Antenna;

	DUT dut (
        .Start(Start),
		.Input(Input),
		.Clock(Clock),
		.Reset(Reset),
        .Antenna(Antenna),
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
            "Antenna:%b |", Antenna,
			" Output:%b", Output);
    end

    integer i = 0;
    integer N_PASS = 0;

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

        for (i = 1; i <= 127; i = i + 1)
        begin
            if (Output == 1'b0)
            begin
                $display("[OK] (", i, "/", 127, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", i, "/", 127, ") Expected:%b  |  Got:%b", 1'b0, Output);
            #1;
        end

        if (N_PASS == 127)
            $display("ALL TEST PASSED. :)");
        else
            $display(127 - N_PASS, " test(s) failed. :(");
    end
endmodule
