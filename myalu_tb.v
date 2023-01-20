//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Nicole Navarro  
// Email: nnava026@ucr.edu
// 
// Assignment name: Lab01-ALU
// Lab section: 022
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module myalu_tb;
    parameter NUMBITS = 8;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    reg [2:0] opcode;

    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire carryout;
    wire overflow;
    wire zero;

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab01.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
    myalu #(.NUMBITS(NUMBITS)) uut (
        .clk(clk),
        .reset(reset) ,  
        .A(A), 
        .B(B), 
        .opcode(opcode), 
        .result(result), 
        .carryout(carryout), 
        .overflow(overflow), 
        .zero(zero)
    );

    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // Additional test cases
        // ---------------------------------------------
        // Testing unsigned additions 
        // --------------------------------------------- 
        $write("Test Group 1: Testing unsigned additions ... \n");
        opcode = 3'b000;

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1: Unsigned Add ... ");
        A = 8'hFF;
        B = 8'h01;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b1 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        
		// Add more tests here
        totalTests = totalTests + 1;
        $write("\tTest Case 1.2: Unsigned Add ... ");
        A = 8'hFF;
        B = 8'hFF;
        expected_result = 8'hFE;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b0 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        totalTests = totalTests + 1;
        $write("\tTest Case 1.3: Unsigned Add ... ");
        A = 8'h0D;
        B = 8'h02;
        expected_result = 8'h0F;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b0 || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        /*
        // ---------------------------------------------
        // Testing unsigned subs 
        // --------------------------------------------- 
        $write("Test Group 2: Testing unsigned subs ...\n");
        opcode = 3'b010; 
        
		// Add more tests here
        totalTests = totalTests + 1;
        $write("\tTest Case 2.1: Unsigned Sub ... ");
        A = 8'h1A;
        B = 8'h0C;
        expected_result = 8'h0E;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b0 || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 2.2: Unsigned Sub ... ");
        A = 8'hAC;
        B = 8'h54;
        expected_result = 8'h58;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b0 || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        ////I need to test for carry out but i dont fucken know what to do
        totalTests = totalTests + 1;
        $write("\tTest Case 2.3: Unsigned Sub ... ");
        A = 8'hFF;
        B = 8'h01;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b1 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // ---------------------------------------------
        // Testing signed adds 
        // --------------------------------------------- 
        $write("Test Group 3: Testing signed adds ...\n");
        opcode = 3'b001; 

		// Add more tests here
        totalTests = totalTests + 1;
        $write("\tTest Case 3.1: Signed Add ... ");
        A = 8'h;
        B = 8'h;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b1 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 3.2: Signed Add ... ");
        A = 8'h;
        B = 8'h;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b1 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 3.3: Signed Add ... ");
        A = 8'h;
        B = 8'h;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b1 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // ---------------------------------------------
        // Testing signed subs 
        // --------------------------------------------- 
        $write("Test Group 4: Testing signed subs ...\n");
        opcode = 3'b011; 
                
		// Add more tests here
        totalTests = totalTests + 1;
        $write("\tTest Case 4.1: Signed Sub ... ");
        A = 8'h88;
        B = 8'h4A;
        expected_result = 8'hD2;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b0 || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 4.2: Signed Sub ... ");
        A = 8'h;
        B = 8'h;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b1 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 4.3: Signed Sub ... ");
        A = 8'h;
        B = 8'h;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || zero !== 1'b1 || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 


        // ---------------------------------------------
        // Testing ANDS 
        // --------------------------------------------- 
        $write("Test Group 5: Testing ANDs ...\n");
        opcode = 3'b100; 

        totalTests = totalTests + 1;
        $write("\tTest Case 5.1: AND ... ");
        A = 8'h00;
        B = 8'hFF;
        expected_result = 8'h00;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait                

        totalTests = totalTests + 1;
        $write("\tTest Case 5.2: AND ... ");
        A = 8'hAA;
        B = 8'hFF;
        expected_result = 8'hAA;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait

        totalTests = totalTests + 1;
        $write("\tTest Case 5.3: AND ... ");
        A = 8'hCA;
        B = 8'hAC;
        expected_result = 8'h88;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait  

		// Add more tests here

        // ----------------------------------------
        // ORs 
        // ---------------------------------------- 
        $write("Test Group 6: Testing ORs ...\n");
        opcode = 3'b101; 
        
		// Add more tests here
        totalTests = totalTests + 1;
        $write("\tTest Case 6.1: OR ... ");
        A = 8'h00;
        B = 8'hFF;
        expected_result = 8'hFF;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 6.2: OR ... ");
        A = 8'h00;
        B = 8'h88;
        expected_result = 8'h88;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 6.2: OR ... ");
        A = 8'hAA;
        B = 8'h55;
        expected_result = 8'hFF;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait 


        // ----------------------------------------
        // XORs 
        // ---------------------------------------- 
        $write("Test Group 7: Testing XORs ...\n");
        opcode = 3'b110; 
        
		// Add more tests here
        totalTests = totalTests + 1;
        $write("\tTest Case 7.1: XOR ... ");
        A = 8'h00;
        B = 8'hFF;
        expected_result = 8'hFF;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 7.2: XOR ... ");
        A = 8'hFF;
        B = 8'hFF;
        expected_result = 8'h00;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 7.3: XOR ... ");
        A = 8'hAA;
        B = 8'hFF;
        expected_result = 8'h55;

        #100; //Wait
        if (expected_result !== result) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10;// Wait 

        // ----------------------------------------
        // Div 2 
        // ----------------------------------------
        $write("Test Group 8: Testing DIV 2 ...\n");
        opcode = 3'b111; 
        */
		// Add more tests here

        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule