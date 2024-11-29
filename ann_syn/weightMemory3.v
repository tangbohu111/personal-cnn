module weightMemory3(clk,address,weights);

parameter DATA_WIDTH = 32;
parameter INPUT_NODES = 100;
parameter OUTPUT_NODES = 32;

localparam TOTAL_WEIGHT_SIZE = INPUT_NODES * OUTPUT_NODES;

input clk;
input [7:0] address;
output reg [DATA_WIDTH*OUTPUT_NODES-1:0] weights;

reg [DATA_WIDTH-1:0] memory [0:TOTAL_WEIGHT_SIZE-1];

integer i;

always @ (posedge clk) begin	
	if (address > INPUT_NODES-1 || address < 0) begin
		weights = 0;
	end else begin
		for (i = 0; i < OUTPUT_NODES; i = i + 1) begin
			weights[(OUTPUT_NODES-1-i)*DATA_WIDTH+:DATA_WIDTH] = memory[(address*OUTPUT_NODES)+i];
		end
	end
end

always@(*) begin
    memory[0] = 32'hbe9b2694 ;
    memory[1] = 32'hbe71ad69 ;
    memory[2] = 32'h3e90ea1d ;
    memory[3] = 32'h3caae06b ;
    memory[4] = 32'hbe401b17 ;
    memory[5] = 32'h3ea91096 ;
    memory[6] = 32'hbd26b4f8 ;
    memory[7] = 32'h3be0881d ;
    memory[8] = 32'hbe0959aa ;
    memory[9] = 32'h3e20223c ;
    memory[10] = 32'h3e0d74ab ;
    memory[11] = 32'hbe244486 ;
    memory[12] = 32'hbb640b23 ;
    memory[13] = 32'hbe862487 ;
    memory[14] = 32'hbce5c6d4 ;
    memory[15] = 32'h3ded1299 ;
    memory[16] = 32'hbd7258de ;
    memory[17] = 32'h3e6fb5d4 ;
    memory[18] = 32'hbcb36fbd ;
    memory[19] = 32'h3dbb862b ;
    memory[20] = 32'h3e0e7cb3 ;
    memory[21] = 32'h3cb068de ;
    memory[22] = 32'hbe86cceb ;
    memory[23] = 32'hbca802a9 ;
    memory[24] = 32'h3b262464 ;
    memory[25] = 32'h3de57cd1 ;
    memory[26] = 32'hbdaa02c4 ;
    memory[27] = 32'hbc73d7a5 ;
    memory[28] = 32'h3e9da512 ;
    memory[29] = 32'h3c5b3a36 ;
    memory[30] = 32'hbe98d306 ;
    memory[31] = 32'h3e168d34 ;
    memory[32] = 32'h3da6e823 ;
    memory[33] = 32'h3d71c9e5 ;
    memory[34] = 32'h3e4081ec ;
    memory[35] = 32'hbe8a58ca ;
    memory[36] = 32'h3e6b6128 ;
    memory[37] = 32'hbe66d93c ;
    memory[38] = 32'hbe79fc9e ;
    memory[39] = 32'hbe8a98ca ;
end



endmodule
