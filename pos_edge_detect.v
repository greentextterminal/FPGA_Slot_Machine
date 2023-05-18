`timescale 1ns / 1ps
// detect the positive edge of a signal, or in our case create a pulse which lasts a single clock cycle when triggered

module pos_edge_detect(
    input signal, // for indiv switches
    input clk,
    output pulse
    );
    reg signal_delay;
    always @ (posedge clk)
        begin
            signal_delay <= signal;
        end
    assign pulse = signal & ~signal_delay;
endmodule
