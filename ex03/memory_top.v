module memory_top (
    input  wire        clk   ,
	input  wire        rst   ,
	input  wire        button,
	output wire [15:0] led   
);

wire        clk_g;
wire        reset;
wire        ena  ;
wire [ 0:0] wea  ;
wire [ 3:0] addra;
wire [15:0] dina ;
wire [15:0] douta;
wire        locked;

clk_div u_clk_div (
    .clk_in1   (clk   ),
    .clk_out1  (clk_g ),
    .locked    (locked)
);

memory_w_r u_memory_w_r (
  .clk_g(clk_g),
  .button(button),
  .reset(rst),
  .led(led),
  .douta(douta),
  .addra(addra),
  .dina(dina),
  .wea(wea),
  .ena(ena)
);

led_mem u_led_mem (
    .clka  (clk  ),
    .ena   (ena  ),
    .wea   (wea  ),
    .addra (addra),
    .dina  (dina ),
    .douta (douta)
);

endmodule