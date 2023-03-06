module calculator_display(
input wire clk,
input wire rst,
input wire button,
input wire [31:0] cal_result,
output wire  [7:0] led_en,
output wire        led_ca,
output wire        led_cb,
output wire        led_cc,
output wire        led_cd,
output wire        led_ce,
output wire        led_cf,
output wire        led_cg,
output wire       led_dp 
    );
 


reg [7:0]
    char0,char1,char2,char3,char4,char5,char6,char7;

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
    nine = 7'b0010000,
    chA  = 7'b0001000,
    chB  = 7'b0000011,
    chC  = 7'b0100111,
    chD  = 7'b0100001,
    chE  = 7'b0000110,
    chF  = 7'b0001110,
    None = 7'b1111111,
    chR  = 7'b0101111,
    chO  = 7'b0100011;
    
parameter
    EN7 = 8'b01111111,  
    EN6 = 8'b10111111, 
    EN5 = 8'b11011111, 
    EN4 = 8'b11101111, 
    EN3 = 8'b11110111, 
    EN2 = 8'b11111011, 
    EN1 = 8'b11111101, 
    EN0 = 8'b11111110; 
    
reg [7:0] led_en_x = EN0;


    
reg [31:0] cnt_2ms = 32'b0;
reg [31:0] ledtime_2ms = 'd20000;
    
reg [6:0] led_cx;


assign led_en = led_en_x;
    
assign
    led_ca = led_cx[0],
    led_cb = led_cx[1],
    led_cc = led_cx[2],
    led_cd = led_cx[3],
    led_ce = led_cx[4],
    led_cf = led_cx[5],
    led_cg = led_cx[6];

always@(posedge clk)begin
    if(cnt_2ms == ledtime_2ms)
    cnt_2ms <= 32'b0;
    else
    cnt_2ms <= cnt_2ms + 1'b1;
end

always@(posedge clk)begin
    if(cnt_2ms == ledtime_2ms)begin
        case(led_en_x)
        EN0:led_en_x<=EN1;
        EN1:led_en_x<=EN2;
        EN2:led_en_x<=EN3;
        EN3:led_en_x<=EN4;
        EN4:led_en_x<=EN5;
        EN5:led_en_x<=EN6;
        EN6:led_en_x<=EN7;
        EN7:led_en_x<=EN0;
        default:led_en_x<=EN0;
        endcase
    end
end

always@(posedge clk)begin
        case(led_en_x)
        EN0:led_cx <= char0;
        EN1:led_cx <= char1;
        EN2:led_cx <= char2;
        EN3:led_cx <= char3;
        EN4:led_cx <= char4;
        EN5:led_cx <= char5;
        EN6:led_cx <= char6;
        EN7:led_cx <= char7;
        default:led_cx <= None;
        endcase
end

always@(posedge clk)begin
    case(cal_result[3:0])
    4'b0000:char0 <= zero;
    4'b0001:char0 <= one;
    4'b0010:char0 <= two;
    4'b0011:char0 <= three;
    4'b0100:char0 <= four;
    4'b0101:char0 <= five;
    4'b0110:char0 <= six;
    4'b0111:char0 <= seven;
    4'b1000:char0 <= eight;
    4'b1001:char0 <= nine;
    4'b1010:char0 <= chA;
    4'b1011:char0 <= chB;
    4'b1100:char0 <= chC;
    4'b1101:char0 <= chD;
    4'b1110:char0 <= chE;
    4'b1111:char0 <= chF;
    default:char0 <= None;
    endcase
    case(cal_result[7:4])
    4'b0000:char1 <= zero;
    4'b0001:char1 <= one;
    4'b0010:char1 <= two;
    4'b0011:char1 <= three;
    4'b0100:char1 <= four;
    4'b0101:char1 <= five;
    4'b0110:char1 <= six;
    4'b0111:char1 <= seven;
    4'b1000:char1 <= eight;
    4'b1001:char1 <= nine;
    4'b1010:char1 <= chA;
    4'b1011:char1 <= chB;
    4'b1100:char1 <= chC;
    4'b1101:char1 <= chD;
    4'b1110:char1 <= chE;
    4'b1111:char1 <= chF;
    default:char1 <= None;
    endcase
    case(cal_result[11:8])
    4'b0000:char2 <= zero;
    4'b0001:char2 <= one;
    4'b0010:char2 <= two;
    4'b0011:char2 <= three;
    4'b0100:char2 <= four;
    4'b0101:char2 <= five;
    4'b0110:char2 <= six;
    4'b0111:char2 <= seven;
    4'b1000:char2 <= eight;
    4'b1001:char2 <= nine;
    4'b1010:char2 <= chA;
    4'b1011:char2 <= chB;
    4'b1100:char2 <= chC;
    4'b1101:char2 <= chD;
    4'b1110:char2 <= chE;
    4'b1111:char2 <= chF;
    default:char2 <= None;
    endcase
    case(cal_result[15:12])
    4'b0000:char3 <= zero;
    4'b0001:char3 <= one;
    4'b0010:char3 <= two;
    4'b0011:char3 <= three;
    4'b0100:char3 <= four;
    4'b0101:char3 <= five;
    4'b0110:char3 <= six;
    4'b0111:char3 <= seven;
    4'b1000:char3 <= eight;
    4'b1001:char3 <= nine;
    4'b1010:char3 <= chA;
    4'b1011:char3 <= chB;
    4'b1100:char3 <= chC;
    4'b1101:char3 <= chD;
    4'b1110:char3 <= chE;
    4'b1111:char3 <= chF;
    default:char3 <= None;
    endcase
    case(cal_result[19:16])
    4'b0000:char4 <= zero;
    4'b0001:char4 <= one;
    4'b0010:char4 <= two;
    4'b0011:char4 <= three;
    4'b0100:char4 <= four;
    4'b0101:char4 <= five;
    4'b0110:char4 <= six;
    4'b0111:char4 <= seven;
    4'b1000:char4 <= eight;
    4'b1001:char4 <= nine;
    4'b1010:char4 <= chA;
    4'b1011:char4 <= chB;
    4'b1100:char4 <= chC;
    4'b1101:char4 <= chD;
    4'b1110:char4 <= chE;
    4'b1111:char4 <= chF;
    default:char4 <= None;
    endcase
    case(cal_result[23:20])
    4'b0000:char5 <= zero;
    4'b0001:char5 <= one;
    4'b0010:char5 <= two;
    4'b0011:char5 <= three;
    4'b0100:char5 <= four;
    4'b0101:char5 <= five;
    4'b0110:char5 <= six;
    4'b0111:char5 <= seven;
    4'b1000:char5 <= eight;
    4'b1001:char5 <= nine;
    4'b1010:char5 <= chA;
    4'b1011:char5 <= chB;
    4'b1100:char5 <= chC;
    4'b1101:char5 <= chD;
    4'b1110:char5 <= chE;
    4'b1111:char5 <= chF;
    default:char5 <= None;
    endcase
    case(cal_result[27:24])
    4'b0000:char6 <= zero;
    4'b0001:char6 <= one;
    4'b0010:char6 <= two;
    4'b0011:char6 <= three;
    4'b0100:char6 <= four;
    4'b0101:char6 <= five;
    4'b0110:char6 <= six;
    4'b0111:char6 <= seven;
    4'b1000:char6 <= eight;
    4'b1001:char6 <= nine;
    4'b1010:char6 <= chA;
    4'b1011:char6 <= chB;
    4'b1100:char6 <= chC;
    4'b1101:char6 <= chD;
    4'b1110:char6 <= chE;
    4'b1111:char6 <= chF;
    default:char6 <= None;
    endcase
    case(cal_result[31:27])
    4'b0000:char7 <= zero;
    4'b0001:char7 <= one;
    4'b0010:char7 <= two;
    4'b0011:char7 <= three;
    4'b0100:char7 <= four;
    4'b0101:char7 <= five;
    4'b0110:char7 <= six;
    4'b0111:char7 <= seven;
    4'b1000:char7 <= eight;
    4'b1001:char7 <= nine;
    4'b1010:char7 <= chA;
    4'b1011:char7 <= chB;
    4'b1100:char7 <= chC;
    4'b1101:char7 <= chD;
    4'b1110:char7 <= chE;
    4'b1111:char7 <= chF;
    default:char7 <= None;
    endcase

end

endmodule