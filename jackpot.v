`timescale 1ns / 1ps
// slot machine game

module jackpot(
    output [3:0] LEDS,
    input [3:0] SWITCHES,
    input CLOCK,
    input RESET
    );
    wire divided_clk; // drive divided clock
    // Instantiate and Implement Divided Clock
    clk_divide #(.n(24)) new_clk  // was 26
    (
    .clk_out(divided_clk),
    .clk_in(CLOCK)
    );
    // LED Light States and Reset Conditions
    parameter S1 = 4'b0001; 
    parameter S2 = 4'b0010; 
    parameter S3 = 4'b0100; 
    parameter S4 = 4'b1000; 
    //parameter win = 4'b1100; //1100 win code
    parameter zero = 4'b1010; // was 0000 
    parameter flash = 4'b1111; // for win flash
    parameter no_flash=4'b0000; // for win flash
     
    reg [3:0] state; // this is to hold current state type
    
    wire switch_signal0, switch_signal1, switch_signal2, switch_signal3;
    pos_edge_detect ped0 ( // switch 0
    .signal(SWITCHES[0]),
    .clk(divided_clk),
    .pulse(switch_signal0)
    );
    
    pos_edge_detect ped1 ( // switch 1
    .signal(SWITCHES[1]),
    .clk(divided_clk),
    .pulse(switch_signal1)
    );
    
    pos_edge_detect ped2 ( // switch 2
    .signal(SWITCHES[2]),
    .clk(divided_clk),
    .pulse(switch_signal2)
    );
    
    pos_edge_detect ped3 ( // switch 3
    .signal(SWITCHES[3]),
    .clk(divided_clk),
    .pulse(switch_signal3)
    );
    
    // Case statements for  state logic
    always @ (posedge divided_clk)
        begin // always block begin
            if (RESET)
                state <= zero;
            else 
            // start of case statement
            case(state) 
                zero : state <= S1;
                S1 : begin 
                    if (switch_signal0==1 && LEDS[0]==1)
                        state <= flash;
                    else
                        state <= S2;
                end
                S2 : begin
                    if (switch_signal1==1 && LEDS[1]==1)
                        state <= flash;
                    else
                        state <= S3;
                end
                S3 : begin
                    if (switch_signal2==1 && LEDS[2]==1)
                        state <= flash;
                    else 
                        state <= S4;
                end
                S4 : begin
                    if (switch_signal3==1 && LEDS[3]==1)
                        state <= flash;
                    else
                        state <= S1;
                end
                // toggle between flash and no_flash states to get jackpot light flashing
                flash : state <= no_flash;
                no_flash : state <= flash;
            endcase  
        end // always block end
    assign LEDS = state; // continuous assignment
endmodule