`timescale 1ns / 1ps
// 125 MHz input clock, need to divide to ~1Hz
// parameter controlled clock divider 

module clk_divide
    #(parameter n = 26) // was 26
    (
    output wire clk_out, 
    input wire clk_in
    );
    
    // determine how many bit needed to count for clock div ; do (126M) / (2^N) = 1
    reg [n:0] Count = 0; // count width init to zero
    // behavioral construct for clock
    always @ (posedge(clk_in)) // always block for a counter, triggered by rising edge of clk
        Count <= Count + 1 ; 
        
    assign clk_out = Count[n];
    
endmodule
