module flowing_water_lights (
    input  wire       clk   ,
	input  wire       rst   ,
	input  wire       button,
	output reg  [7:0] led
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
if(~button)
    led <= 8'b00000001;
else if(rst)
    led <= 8'b00000001;
else if(cnt_1s)
    led <= {led[6:0],led[7]};
end

endmodule