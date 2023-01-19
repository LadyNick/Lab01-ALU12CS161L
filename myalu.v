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

//  Constant definitions 

module myalu # ( parameter NUMBITS = 16 ) (
    input wire clk, 
    input wire reset ,  
    input  wire[NUMBITS-1:0] A, 
    input  wire[NUMBITS-1:0] B, 
    input wire [2:0]opcode, 
    output reg [NUMBITS-1:0] result,  
    output reg carryout ,
    output reg overflow , 
    output reg zero  );

// ------------------------------
// Insert your solution below
// ------------------------------ 
    
    //opcodes in order: unsigned add, signed add,
    //unsigned sub, signed sub, AND, OR, XOR, Divide by 2


    always @(posedge clk) begin
        case(opcode)
            3b'000: begin //Unsigned Add
                {carryout, result} = A + B;
                if(result == 0){
                    zero = 1;
                }
                else{
                    zero = 0;
                }
                overflow = 0;
            end
            3b'001: begin //Signed Add
            end
            3b'010: begin //Unsigned Sub
                {carryout, result} = A - B;
                if(result == 0){
                    zero = 1;
                }
                else{
                    zero = 0;
                }
                overflow = 0;
            end
            3b'011: begin // Signed Sub
            end
            3b'100: begin //AND
                result = A & B;
                if(result == 0){
                    zero = 1;
                }
                else{
                    zero = 0;
                }
                carryout = 0;
                overflow = 0;
            end
            3b'101: begin //OR
                result = A | B;
                if(result == 0){
                    zero = 1;
                }
                else{
                    zero = 0;
                }
                carryout = 0;
                overflow = 0;
            end
            3b'110: begin //XOR
                result = A ^ B;
                if(result == 0){
                    zero = 1;
                }
                else{
                    zero = 0;
                }
                carryout = 0;
                overflow = 0;
            end
            3b'111: begin //Divide A by 2
                result = A / 2;
                if(result == 0){
                    zero = 1;
                }
                else{
                    zero = 0;
                }
                carryout = 0;
                overflow = 0;
            end
            default: 
        endcase
    end

    //use nanland case statement

    //We can use these kinds of things
    /*always @(posedge clk) begin
        result = A & B;
        if(result == 0)
    end

    //

    //{carryout,result} = A+B; stuff he wrote
 */

endmodule
