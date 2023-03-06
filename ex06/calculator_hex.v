module calculator_hex(
input wire clk,
input wire rst,
input wire button,
input wire [2:0] func,
input wire [7:0] num1,
input wire [7:0] num2,
output wire [31:0] cal_result
    );

reg flag = 'd0;
reg flag_button = 'd0;
reg [31:0] myresult = 32'b0;
assign cal_result = myresult;


always@(posedge clk) begin
    if(rst) begin
        myresult <= 32'b0;
        flag <= 'd0;
        flag_button <= 'd0;
    end
    else if(button) begin
        flag_button <= 'd1;
    end
    else if(flag_button == 'd1) begin
        if(flag == 'd0)begin
        case(func)
        3'b000:begin
            myresult <= num1 + num2;
        end
        3'b001:begin
            myresult <= num1 - num2;
        end
        3'b010:begin
            myresult <= num1 * num2;
        end
        3'b011:begin
            myresult <= num1 / num2;
        end
        3'b100:begin
            myresult <= num1 % num2;
        end
        3'b101:begin
            myresult <= num1 * num1;
        end
        default:begin
        end
        endcase
        flag <= 'd1;
        end
        else begin
        case(func)
        3'b000:begin
            myresult <= myresult + num2;
        end
        3'b001:begin
            myresult <= myresult - num2;
        end
        3'b010:begin
            myresult <= myresult * num2;
        end
        3'b011:begin
            myresult <= myresult / num2;
        end
        3'b100:begin
            myresult <= myresult % num2;
        end
        3'b101:begin
            myresult <= myresult * myresult;
        end
        default:begin
        end
        endcase
        end
        flag_button <= 'd0;
    end        
end     

endmodule


//以下为带消抖处理的代码，延时消抖会对仿真造成一定的影响
/*
module calculator_hex(
input wire clk,
input wire rst,
input wire button,
input wire [2:0] func,
input wire [7:0] num1,
input wire [7:0] num2,
output wire [31:0] cal_result
    );

reg flag = 'd0;
reg flag_button = 'd0;
reg [31:0] myresult = 32'b0;
assign cal_result = myresult;

reg [31:0] counter = 0;
always @(posedge clk) begin
	if(rst)
	counter <= 0;
	else if(button)
	counter <= 0;
	else if(counter != 1000000)
	counter <= counter + 1;
end

always@(posedge clk) begin
    if(rst) begin
        myresult <= 32'b0;
        flag <= 'd0;
        flag_button <= 'd0;
    end
    else if(button) begin
        flag_button <= 'd1;
    end
    else if(counter == 1000000)begin
        if(flag_button == 'd1) begin
        if(flag == 'd0)begin
        case(func)
        3'b000:begin
            myresult <= num1 + num2;
        end
        3'b001:begin
            myresult <= num1 - num2;
        end
        3'b010:begin
            myresult <= num1 * num2;
        end
        3'b011:begin
            myresult <= num1 / num2;
        end
        3'b100:begin
            myresult <= num1 % num2;
        end
        3'b101:begin
            myresult <= num1 * num1;
        end
        default:begin
        end
        endcase
        flag <= 'd1;
        end
        else begin
        case(func)
        3'b000:begin
            myresult <= myresult + num2;
        end
        3'b001:begin
            myresult <= myresult - num2;
        end
        3'b010:begin
            myresult <= myresult * num2;
        end
        3'b011:begin
            myresult <= myresult / num2;
        end
        3'b100:begin
            myresult <= myresult % num2;
        end
        3'b101:begin
            myresult <= myresult * myresult;
        end
        default:begin
        end
        endcase
        end
        flag_button <= 'd0;
    end
    end        
end     

endmodule
*/

