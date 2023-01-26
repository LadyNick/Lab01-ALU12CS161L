//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Nicole Navarro 
// Email: nnava026@ucr.edu 
// 
// Assignment name: Lab01-ALU
// Lab section: 021
// TA: Jincong Lu
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
            3'b000: begin //Unsigned Add
                {carryout, result} = A + B;
                if(result == 0)
                    zero = 1;
                else 
                    zero = 0;
                overflow = 0;
            end
            3'b001: begin //Signed Add
                result = $signed(A) + $signed(B);
                if(result == 0)
                    zero = 1;
                else
                    zero = 0;
                carryout = 0;
                if( $signed(A) >= 0 && $signed(B) >= 0 && $signed(result) < 0)
                    overflow = 1;
                else if( $signed(A) < 0 && $signed(B) < 0 && $signed(result) >= 0)
                    overflow = 1;
                else
                    overflow = 0;   
            end
            3'b010: begin //Unsigned Sub
                {carryout, result} = A - B;
                if(result == 0)
                    zero = 1;
                else
                    zero = 0;
                overflow = 0;
            end
            3'b011: begin // Signed Sub
                result = $signed(A) - $signed(B);
                if(result == 0)
                    zero = 1;
                else
                    zero = 0;
                carryout = 0;
                if($signed(A) >= 0 && $signed(B) < 0 && $signed(result) < 0)
                    overflow = 1;
                else if( $signed(A) < 0 && $signed(B) >= 0 && $signed(result) >= 0)
                    overflow = 1;
                else
                    overflow = 0;
            end
            3'b100: begin //AND
                result = A & B;
                if(result == 0)
                    zero = 1;
                else
                    zero = 0;
                carryout = 0;
                overflow = 0;
            end
            3'b101: begin //OR
                result = A | B;
                if(result == 0)
                    zero = 1;
                else
                    zero = 0;
                carryout = 0;
                overflow = 0;
            end
            3'b110: begin //XOR
                result = A ^ B;
                if(result == 0)
                    zero = 1;
                else
                    zero = 0;
                carryout = 0;
                overflow = 0;
            end
            3'b111: begin //Divide A by 2
                result = A / 2;
                if(result == 0)
                    zero = 1;
                else
                    zero = 0;
                carryout = 0;
                overflow = 0;
            end
            default: begin
                result = 0;
                zero = 0;
                carryout = 0;
                overflow = 0;
            end 
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
