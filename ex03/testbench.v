`timescale 1ns/1ps

`define MEM_ENA u_memory_top.u_led_mem.ena
`define MEM_WEA u_memory_top.u_led_mem.wea
`define MEM_ADDRA u_memory_top.u_led_mem.addra
`define MEM_DOUTA u_memory_top.u_led_mem.douta

module testbench (
);
						 
reg        clk           ;
reg        rst_n         ;
reg        locked_ff     ;
reg [ 3:0] cnt           ;
reg        wrong         ;
reg [15:0] result [15:0] ;
reg        mem_rd_ff     ; 
reg [ 3:0] mem_rd_addr   ;
reg [ 3:0] mem_rd_addr_ff;

wire        clk_g ;
wire        locked;
wire [15:0] led   ;

wire rst = ~rst_n;

initial begin
    clk   = 0;
    rst_n = 0;
    #20;
    rst_n = 1;
    #200000;
    $finish;
end

always #5 clk = ~clk;

clk_div u_clk_div (
    .clk_in1  (clk   ),
	.clk_out1 (clk_g ),
	.locked   (locked)
);

always @ (posedge clk_g or negedge rst_n) begin
    if (~rst_n) locked_ff <= 1'b0;
	else        locked_ff <= locked;
end

wire button_pos = locked & ~locked_ff;

wire mem_rd = `MEM_ENA & ~`MEM_WEA;

always @ (posedge clk_g or negedge rst_n) begin
    if (~rst_n) mem_rd_ff <=1'b0;
	else        mem_rd_ff <= mem_rd;
end

always @ (posedge clk_g or negedge rst_n) begin
    if (~rst_n) mem_rd_addr <= 4'h0;
	else        mem_rd_addr <= (`MEM_ADDRA + 4'h1);
end

wire cnt_end = (cnt == 4'hf);

always @ (posedge clk_g or negedge rst_n) begin
    if (~rst_n)       cnt <= 4'h0;
	else if (cnt_end) cnt <= 4'h0;
	else if (mem_rd)  cnt <= cnt + 4'h1;
end
 
integer i;
always @ (posedge clk_g or negedge rst_n) begin
    if (~rst_n) begin
	    for (i=0;i<=15;i=i+1)
		   result[i] <= 32'h0;
	end
	else begin
		result[1]  <= 16'h0001;
		result[2]  <= 16'h0003;
		result[3]  <= 16'h0007;
		result[4]  <= 16'h000F;
		result[5]  <= 16'h001F;
		result[6]  <= 16'h003F;
		result[7]  <= 16'h007F;
		result[8]  <= 16'h00FF;
		result[9]  <= 16'h01FF;
		result[10] <= 16'h03FF;
		result[11] <= 16'h07FF;
		result[12] <= 16'h0FFF;
		result[13] <= 16'h1FFF;
		result[14] <= 16'h3FFF;
		result[15] <= 16'h7FFF;
	end
end

always @ (posedge clk_g or negedge rst_n) begin
    if (~rst_n) wrong <= 1'b0;
	else if (mem_rd_ff) begin
		wrong <= ~(result[mem_rd_addr] == `MEM_DOUTA);
    end
end	

always @ (posedge clk_g or negedge rst_n) begin
    if (~rst_n) mem_rd_addr_ff <= 4'h0;
	else        mem_rd_addr_ff <= mem_rd_addr;
end

wire [3:0] cnt_w = cnt - 4'h1;

always @(posedge clk_g) begin
    if(cnt_end) begin
	    $display("index %x finished",cnt_w);
        if(cnt == 4'hf) begin
	        $display("====================================");
	        $display("Test end!");
            $display("----PASS!!!");
	        $finish;
        end
    end
    else if(wrong) begin
	    $display("wrong at index %x",cnt_w);
	    $display("=====================================");
	    $display("Test end!");
        $display("----FAIL!!!");
        $display("reference  : %x",result[mem_rd_addr_ff]);
        $display("test module: %x",`MEM_DOUTA);
	    $finish;
    end
end

memory_top u_memory_top (
    .clk    (clk       ),
	.rst    (rst       ),
	.button (button_pos),
	.led    (led       ) 
);                     

endmodule