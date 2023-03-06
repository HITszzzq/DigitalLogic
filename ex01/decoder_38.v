/*module decoder_38 (
    input  wire       clk   ,
	input  wire       rst   ,
	input  wire [2:0] enable,
	input  wire [2:0] switch,
	output reg  [7:0] led
);

endmodule*/

module decoder_38(switch,enable,led,clk,rst);
    input [2:0] switch;
    input [2:0] enable;
    input  clk;
	input  rst;
    output [7:0] led;
    
    reg [7:0] led;
    
always @ (switch or enable)
    begin
        if(!enable[0] & !enable[1] & enable[2])
            case(switch)
            3'b000 : led = 8'b11111110;
            3'b001 : led = 8'b11111101;
            3'b010 : led = 8'b11111011;
            3'b011 : led = 8'b11110111;
            3'b100 : led = 8'b11101111;
            3'b101 : led = 8'b11011111;
            3'b110 : led = 8'b10111111;
            3'b111 : led = 8'b01111111;
            default: led = 8'b11111111;
        endcase
        else
            led = 8'b11111111;
            if(rst) led = 8'b11111111;
    end

endmodule