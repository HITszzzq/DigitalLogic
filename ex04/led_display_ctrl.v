module led_display_ctrl (
    input  wire       clk   ,
	input  wire       rst   ,
	input  wire       button,
	output reg  [7:0] led_en,
	output reg        led_ca,
	output reg        led_cb,
    output reg        led_cc,
	output reg        led_cd,
	output reg        led_ce,
	output reg        led_cf,
	output reg        led_cg,
	output wire       led_dp 
);

reg [31:0] cnt_1s = 32'b0;
reg [31:0] ledtime_1s = 'd100000000;
reg [31:0] ledtime_11s = 'd1100000000;
reg [31:0] cnt_2ms = 32'b0;
reg [31:0] ledtime_2ms = 'd20000;
reg [ 6:0] led_cx;

reg flag = 'd0;
reg count = 'd10;

parameter
    zero = 7'b1000000,
    one  = 7'b1111001,
    two  = 7'b0100100,
    three= 7'b0110000,
    four = 7'b0011001,
    five = 7'b0010010,
    six  = 7'b0000010,
    seven= 7'b1111000,
    eight= 7'b0000000,
    nine = 7'b0010000;
    
reg[6:0]
    ENB = zero,
    ENA = one;

parameter
    EN7 = 8'b01111111,  
    EN6 = 8'b10111111, 
    EN5 = 8'b11011111, 
    EN4 = 8'b11101111, 
    EN3 = 8'b11110111, 
    EN2 = 8'b11111011, 
    EN1 = 8'b11111101, 
    EN0 = 8'b11111110;   
always@(posedge clk)begin
    led_ca = led_cx[0];
    led_cb = led_cx[1];
    led_cc = led_cx[2];
    led_cd = led_cx[3];
    led_ce = led_cx[4];
    led_cf = led_cx[5];
    led_cg = led_cx[6];
end

always@(posedge clk or negedge rst)begin
    if(rst)
    cnt_1s <= 32'b0;
    else if(flag == 1)begin
        if(button)
            cnt_1s <= 32'b0;
        else if(cnt_1s == ledtime_11s)
            cnt_1s <= 32'b0;
        else
            cnt_1s <= cnt_1s + 1'b1;
    end
end

always@(posedge clk)begin
    if(cnt_2ms == ledtime_2ms)
    cnt_2ms <= 32'b0;
    else
    cnt_2ms <= cnt_2ms + 1'b1;
end
    
always@(posedge clk)begin
    if(cnt_2ms == ledtime_2ms)begin
        case(led_en)
        EN0:led_en<=EN1;
        EN1:led_en<=EN2;
        EN2:led_en<=EN3;
        EN3:led_en<=EN4;
        EN4:led_en<=EN5;
        EN5:led_en<=EN6;
        EN6:led_en<=EN7;
        EN7:led_en<=EN0;
        default:led_en<=EN0;
        endcase
    end
end

always@(posedge clk or negedge rst)begin
    if(rst)
        flag <= 'd0;
    else if(button) begin
        flag <= 'd1;
    end
end    
    
always@(posedge clk)begin
        case(led_en)
        EN0:led_cx <= zero;
        EN1:led_cx <= three;
        EN2:led_cx <= one;
        EN3:led_cx <= one;
        EN4:led_cx <= zero;
        EN5:led_cx <= two;
        EN6:led_cx <= ENB;
        EN7:led_cx <= ENA;
        default:led_cx <= eight;
        endcase
        
            case(cnt_1s)
                10*ledtime_1s:begin
                ENB <= zero;
                ENA <= zero;
                end
                9*ledtime_1s:begin
                ENB <= one;
                ENA <= zero;
                end
                8*ledtime_1s:begin
                ENB <= two;
                ENA <= zero;
                end
                7*ledtime_1s:begin
                ENB <= three;
                ENA <= zero;
                end
                6*ledtime_1s:begin
                ENB <= four;
                ENA <= zero;
                end
                5*ledtime_1s:begin
                ENB <= five;
                ENA <= zero;
                end
                4*ledtime_1s:begin
                ENB <= six;
                ENA <= zero;
                end
                3*ledtime_1s:begin
                ENB <= seven;
                ENA <= zero;
                end
                2*ledtime_1s:begin
                ENB <= eight;
                ENA <= zero;
                end
                1*ledtime_1s:begin
                ENB <= nine;
                ENA <= zero;
                end
                0:begin
                ENB <= zero;
                ENA <= one;
                end
                default:
                ;
                endcase    
        end

endmodule