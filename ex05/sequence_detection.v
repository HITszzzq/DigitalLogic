module sequence_detection (
    input  wire       clk   ,
	input  wire       rst   ,
	input  wire       button,
	input  wire [7:0] switch,
	output reg        led
);

parameter IDLE = 3'd0,
           S0 = 3'd1,
           S1 = 3'd2,
           S2 = 3'd3,
           S3 = 3'd4,
           S4 = 3'd5,
           S5 = 3'd6;
           
reg [2:0] current_state, next_state;

reg [3:0] count = 'd7;

reg flag = 1'b0;

reg [7:0] switch_t = 00000000;

always @(posedge clk) begin
	if(switch_t != switch)begin
		switch_t <= switch;
	end
end

always @(posedge clk or negedge rst) begin
    if(rst || button) begin
        count <= 'd7;
    end
    else if(switch != switch_t)
	   count <= 'd7;
    else begin
        count <= count - 'd1;
    end
end

always @(posedge clk or negedge rst) begin
    if(rst) begin
        current_state <= IDLE;
        flag <= 1'b0;
    end
    else if(button) begin
        flag <= 1'b1;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    if(switch != switch_t)
	   next_state = S0;
	else
    case(current_state)
        IDLE: begin
            if(flag) next_state = S0;
            else       next_state = IDLE;
        end
        S0: begin
            if(switch[count]) next_state = S1;
            else       next_state = S0;
        end
        S1: begin
            if(switch[count]) next_state = S1;
            else       next_state = S2;
        end
        S2: begin
            if(switch[count]) next_state = S1;
            else       next_state = S3;
        end
        S3: begin
            if(switch[count]) next_state = S4;
            else       next_state = S0;
        end
        S4: begin
            if(~switch[count]) next_state = S5;
            else       next_state = S1;
        end
        S5: begin
            next_state = S5;
        end
        default:next_state = IDLE;
    endcase
end

always @(posedge clk or negedge rst) begin
    if(rst) led <= 1'b0;
    else if(current_state == S5) led <= 1'b1;
    else led <= 1'b0;
end
		   
endmodule