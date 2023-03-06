module memory_w_r(
input wire  clk_g,
input wire  button,
input wire  reset,
input wire[15:0] douta,
output wire[15:0] led,
output wire[ 3:0] addra,
output wire[15:0] dina,
output wire[ 0:0] wea,
output wire       ena
    );
reg [ 3:0]  temp_addra = 4'b0000;
reg [15:0]  temp_dina = 16'b1;
reg [31:0]  cnt = 32'b0;
reg temp_wea = 0;
reg temp_ena = 0;
reg [15:0] temp_led = 16'b0;
reg [31:0] ledtime = 10000000;
assign ena = temp_ena;
assign wea = temp_wea;
assign addra = temp_addra;
assign dina = temp_dina;
assign led = temp_led;
always@(posedge clk_g or negedge reset)begin
    if(reset)
    cnt <= 32'b0;
    else if(temp_wea == 0 && temp_ena == 1 && cnt == ledtime)
    cnt <= 32'b0;
    else if(temp_wea == 0 && temp_ena == 1)
    cnt <= cnt + 1'b1;
end
always@(posedge clk_g or negedge reset)begin
    if(reset)begin
    temp_wea <= 0;
    temp_ena <= 0;
    temp_led <= 16'b0;
    temp_addra <= 4'b0000;
    temp_dina <= 16'b1;
end
else if(button)begin
    temp_ena <= 1;
    temp_wea <= 1;
    temp_addra <= 4'b0000;
    temp_dina <= 16'b1;
end
else if(temp_ena && temp_wea)
begin
    if(temp_addra == 4'b1111)begin
    temp_addra <= 4'b0;
    temp_wea <= 0;
    end
    else begin
    temp_addra <= temp_addra + 4'b1;
    temp_dina <= {temp_dina[14:0] , temp_dina[15]} + 16'b1;
    end
end
else if(temp_wea == 0 && temp_ena == 1 && cnt == ledtime)begin    
    temp_led <= douta; 
    if(temp_addra != 4'b1111)begin
        temp_addra <= temp_addra + 4'b1;
    end
end
end
endmodule