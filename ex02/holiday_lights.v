module holiday_lights (
    input  wire        clk   ,
	input  wire        rst   ,
	input  wire        button,
    input  wire [ 2:0] switch,
	output reg  [15:0] led
);

parameter LED_TIME = 50000000;

reg [25:0] cnt;

wire cnt_1s = (cnt == LED_TIME-1);

always @ (posedge clk,negedge button) begin
if(~button)
    cnt <= 'd0;
else if(cnt == LED_TIME-1)
    cnt <= 'd0;
else
    cnt <= cnt + 1'b1;
end
    
always @ (posedge clk,negedge button,negedge rst) begin
if(~button) begin
    case(switch)
        3'b000 : led = 16'b0000000000000001;
        3'b001 : led = 16'b0000000000000011;
        3'b010 : led = 16'b0000000000000111;
        3'b011 : led = 16'b0000000000001111;
        3'b100 : led = 16'b0000000000011111;
        3'b101 : led = 16'b0000000000111111;
        3'b110 : led = 16'b0000000001111111;
        3'b111 : led = 16'b0000000011111111;
        default: led = 16'b0000000000000000;
    endcase
    end
else if(rst) begin
    case(switch)
        3'b000 : led = 16'b0000000000000001;
        3'b001 : led = 16'b0000000000000011;
        3'b010 : led = 16'b0000000000000111;
        3'b011 : led = 16'b0000000000001111;
        3'b100 : led = 16'b0000000000011111;
        3'b101 : led = 16'b0000000000111111;
        3'b110 : led = 16'b0000000001111111;
        3'b111 : led = 16'b0000000011111111;
        default: led = 16'b0000000000000000;
    endcase
    end
else if(cnt_1s)
    led <= {led[14:0],led[15]};
end

endmodule