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
	reg Clock2;
	reg Reset;
    reg Input;
    reg Start;

	// Outputs
	wire Output;
    wire Antenna;
    wire Error;

	DUT dut (
        .Start(Start),
		.Input(Input),
		.Clock(Clock),
		.Clock2(Clock2),
        .Reset(Reset),
        .Antenna(Antenna),
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
            " | Antenna:%b |", Antenna,
			" Output:%b - ", Output);
    end

    integer i = 0;
    integer N_PASS = 0;
    integer j = 0;
    reg [0:3] DATA_INPUT = 4'b1001;

    //  Sending and Receiving Data
    initial
    begin
		#10
        #1;
        
        #137;   //  When you should start sending...
        $display("[DATA_INPUT::START]");
        for (j = 0; j < 4; j = j + 1)
        begin
            Input = DATA_INPUT[j];
            #1;
        end
        Input = 0;
        $display("[DATA_INPUT::END]");
    end
    
    initial
    begin
		// Initialize Inputs
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
        
		$display("[START]");
        Start = 0;
        #1;

        #486.5; //  When you should start getting...
        $display("[DATA::START]");
        for (j = 0; j < 4; j = j + 1)
        begin
            if (Output == DATA_INPUT[j])
            begin
                $display("[OK] (", j, "/", 4, ")");
                N_PASS = N_PASS + 1;  
            end
            else
                $display("[FAILED] (", j, "/", 4, ") Expected:%b  |  Got:%b", DATA_INPUT[j], Output);
            #0.5;
        end

        if (N_PASS == 4)
            $display("ALL TEST PASSED. :)");
        else
            $display(4 - N_PASS, " test(s) failed. :(");

        $display("[DATA::END]");
    end
endmodule
