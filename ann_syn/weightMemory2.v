module weightMemory2(clk,address,weights);

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
    memory[0] = 32'hbca08236 ;
    memory[1] = 32'hbde0c38a ;
    memory[2] = 32'h3c2aebc8 ;
    memory[3] = 32'hbe1a77de ;
    memory[4] = 32'hbcd0198a ;
    memory[5] = 32'h3d80cdda ;
    memory[6] = 32'hbe28c33b ;
    memory[7] = 32'hbd7042a0 ;
    memory[8] = 32'h3d55a9b4 ;
    memory[9] = 32'hbd0805a8 ;
    memory[10] = 32'h3c1702be ;
    memory[11] = 32'h3dc98d3f ;
    memory[12] = 32'hbe039ff0 ;
    memory[13] = 32'hbe2ef8cf ;
    memory[14] = 32'hbe031d28 ;
    memory[15] = 32'h3cc02e52 ;
    memory[16] = 32'hbcc496a1 ;
    memory[17] = 32'hbdaadfbf ;
    memory[18] = 32'hbde39e44 ;
    memory[19] = 32'hbd60baa3 ;
    memory[20] = 32'hbe35ad08 ;
    memory[21] = 32'h3e0b8f42 ;
    memory[22] = 32'hbe2ec61b ;
    memory[23] = 32'h3da802ba ;
    memory[24] = 32'hbdf8f2fa ;
    memory[25] = 32'h3d79a773 ;
    memory[26] = 32'hbe02bbb9 ;
    memory[27] = 32'hbddcc137 ;
    memory[28] = 32'h3c8fa1af ;
    memory[29] = 32'h3d6c70c9 ;
    memory[30] = 32'hbe119599 ;
    memory[31] = 32'h3cb1d563 ;
    memory[32] = 32'hbe37e736 ;
    memory[33] = 32'h3c3ce899 ;
    memory[34] = 32'hbdb5818a ;
    memory[35] = 32'h3d166dba ;
    memory[36] = 32'hbde9a069 ;
    memory[37] = 32'h3c3febe6 ;
    memory[38] = 32'h3e0a20cf ;
    memory[39] = 32'h3ce4be9b ;
    memory[40] = 32'hbe347797 ;
    memory[41] = 32'hbc2152ca ;
    memory[42] = 32'hbe0db1bd ;
    memory[43] = 32'h3d452b7e ;
    memory[44] = 32'h3c751939 ;
    memory[45] = 32'h3dc3c205 ;
    memory[46] = 32'hbdc46430 ;
    memory[47] = 32'h3e023359 ;
    memory[48] = 32'hbd8c1c8a ;
    memory[49] = 32'hbbcad94b ;
    memory[50] = 32'h3db94cf7 ;
    memory[51] = 32'h3e4529c2 ;
    memory[52] = 32'hbdc77dd1 ;
    memory[53] = 32'hbb7b81a0 ;
    memory[54] = 32'h3e0df28e ;
    memory[55] = 32'hbde6d568 ;
    memory[56] = 32'hbe130a19 ;
    memory[57] = 32'h3dfa1adc ;
    memory[58] = 32'h3d0be50f ;
    memory[59] = 32'h3dfeaa54 ;
    memory[60] = 32'hbe039c4b ;
    memory[61] = 32'hbe0a48b3 ;
    memory[62] = 32'h3e12d2e5 ;
    memory[63] = 32'h3da0610a ;
    memory[64] = 32'h3de94611 ;
    memory[65] = 32'hbde04607 ;
    memory[66] = 32'h3e0e4791 ;
    memory[67] = 32'h3e2f34de ;
    memory[68] = 32'hbdc66ccb ;
    memory[69] = 32'h3c010e6e ;
    memory[70] = 32'h3cf7ca91 ;
    memory[71] = 32'hbca60f7e ;
    memory[72] = 32'h3e11fb95 ;
    memory[73] = 32'h3dd1bfce ;
    memory[74] = 32'hbe3dfd5f ;
    memory[75] = 32'hbbcd43c7 ;
    memory[76] = 32'h3d25c832 ;
    memory[77] = 32'h3c7ca91e ;
    memory[78] = 32'h3ae10129 ;
    memory[79] = 32'hbe09d94e ;
    memory[80] = 32'hbe3aff82 ;
    memory[81] = 32'hbd66047f ;
    memory[82] = 32'h3e23a52f ;
    memory[83] = 32'hbdefe57f ;
    memory[84] = 32'h3e05cc0a ;
    memory[85] = 32'hbe22ea1f ;
    memory[86] = 32'hbd5f7b87 ;
    memory[87] = 32'hbc90be29 ;
    memory[88] = 32'hbe0d5791 ;
    memory[89] = 32'hbe4e7da5 ;
    memory[90] = 32'h3da70502 ;
    memory[91] = 32'h3da69bbf ;
    memory[92] = 32'hbe36c0a0 ;
    memory[93] = 32'h3db2258a ;
    memory[94] = 32'h3df55f2c ;
    memory[95] = 32'h3df2ac1b ;
    memory[96] = 32'h3e3e0249 ;
    memory[97] = 32'hbc1d1d14 ;
    memory[98] = 32'hbe09ad6e ;
    memory[99] = 32'hbd020c3a ;
    memory[100] = 32'h3e246d18 ;
    memory[101] = 32'h3e3494f0 ;
    memory[102] = 32'h3e1eefe7 ;
    memory[103] = 32'h3c5c2798 ;
    memory[104] = 32'hbd694718 ;
    memory[105] = 32'h3cfaa702 ;
    memory[106] = 32'hbd5aba7e ;
    memory[107] = 32'h3cfcdbce ;
    memory[108] = 32'h3c39ae4e ;
    memory[109] = 32'hbe18a1f9 ;
    memory[110] = 32'h3dc12b03 ;
    memory[111] = 32'h3c74af3f ;
    memory[112] = 32'h3cd295af ;
    memory[113] = 32'h3e2bc751 ;
    memory[114] = 32'h3c556b92 ;
    memory[115] = 32'h3df40af8 ;
    memory[116] = 32'hbe136595 ;
    memory[117] = 32'h3da773bb ;
    memory[118] = 32'hbd839a33 ;
    memory[119] = 32'h3e41f082 ;
    memory[120] = 32'hbcdb1bfa ;
    memory[121] = 32'hbe270959 ;
    memory[122] = 32'hbe2116a5 ;
    memory[123] = 32'h3d316e50 ;
    memory[124] = 32'hbe330855 ;
    memory[125] = 32'hbe11437e ;
    memory[126] = 32'h3e25c0eb ;
    memory[127] = 32'h3e36e996 ;
    memory[128] = 32'h3d932474 ;
    memory[129] = 32'h3de28bb6 ;
    memory[130] = 32'hbe266430 ;
    memory[131] = 32'h3e0ff7fa ;
    memory[132] = 32'h3ce3de2b ;
    memory[133] = 32'h3e45e1c7 ;
    memory[134] = 32'h3e0ed87b ;
    memory[135] = 32'hbd8d20ab ;
    memory[136] = 32'h3e1dc518 ;
    memory[137] = 32'hbdd60695 ;
    memory[138] = 32'hbe1abfa3 ;
    memory[139] = 32'hbdd8819b ;
    memory[140] = 32'h3dd06c45 ;
    memory[141] = 32'hbda5ae43 ;
    memory[142] = 32'hbd604d4a ;
    memory[143] = 32'hbcbd6620 ;
    memory[144] = 32'hbe0342b2 ;
    memory[145] = 32'hbd9a38ed ;
    memory[146] = 32'h3d7d0a92 ;
    memory[147] = 32'h3ddcfc73 ;
    memory[148] = 32'hbd3bc696 ;
    memory[149] = 32'hbc782d93 ;
    memory[150] = 32'hbdb350f7 ;
    memory[151] = 32'hbe215454 ;
    memory[152] = 32'hbdf59a29 ;
    memory[153] = 32'h3e1dffc7 ;
    memory[154] = 32'h3dd878cb ;
    memory[155] = 32'h3d80abb9 ;
    memory[156] = 32'h3d8342c4 ;
    memory[157] = 32'hbd8c69ac ;
    memory[158] = 32'hbd8d6314 ;
    memory[159] = 32'hbe0c8802 ;
    memory[160] = 32'hbe118f26 ;
    memory[161] = 32'hbd8606fc ;
    memory[162] = 32'hbd4882a3 ;
    memory[163] = 32'hbdcfc971 ;
    memory[164] = 32'h3d869497 ;
    memory[165] = 32'hbe15ff65 ;
    memory[166] = 32'hbde73db4 ;
    memory[167] = 32'hbe5a3da5 ;
    memory[168] = 32'hbdb0ec6f ;
    memory[169] = 32'h3c3169c4 ;
    memory[170] = 32'hbe18da42 ;
    memory[171] = 32'hbdb5f3b1 ;
    memory[172] = 32'hbe1f0d86 ;
    memory[173] = 32'h3de40297 ;
    memory[174] = 32'hbd0e1d7b ;
    memory[175] = 32'h3d05a38a ;
    memory[176] = 32'hbe1b09c4 ;
    memory[177] = 32'hbdce8e9f ;
    memory[178] = 32'h3dbc87ef ;
    memory[179] = 32'h3e3bb3b1 ;
    memory[180] = 32'hbcd91135 ;
    memory[181] = 32'h3d257895 ;
    memory[182] = 32'hbdd91399 ;
    memory[183] = 32'hbe0ac54c ;
    memory[184] = 32'hbc21fd5c ;
    memory[185] = 32'hbd7ea749 ;
    memory[186] = 32'hbd874441 ;
    memory[187] = 32'h3e1b707f ;
    memory[188] = 32'h3e12bc5c ;
    memory[189] = 32'h3dedfdbf ;
    memory[190] = 32'hbd86aaa9 ;
    memory[191] = 32'h3cc2b1fa ;
    memory[192] = 32'hbdfd2245 ;
    memory[193] = 32'h3de8fa6b ;
    memory[194] = 32'h3d4c65fc ;
    memory[195] = 32'h3d1a563c ;
    memory[196] = 32'h3d07e61c ;
    memory[197] = 32'h3da962d9 ;
    memory[198] = 32'hbdde6047 ;
    memory[199] = 32'hbd9fc3f3 ;
    memory[200] = 32'h3df6cebc ;
    memory[201] = 32'h3d5f6b47 ;
    memory[202] = 32'hbdfe7892 ;
    memory[203] = 32'hbd4c4483 ;
    memory[204] = 32'h3cdefbee ;
    memory[205] = 32'h3dfb5479 ;
    memory[206] = 32'h3e2b66fb ;
    memory[207] = 32'hbd1868ee ;
    memory[208] = 32'hbe15a51b ;
    memory[209] = 32'h3d4a279e ;
    memory[210] = 32'hbe2f8154 ;
    memory[211] = 32'hbbea19da ;
    memory[212] = 32'hbd935cd1 ;
    memory[213] = 32'h3d9f7712 ;
    memory[214] = 32'hbc6feddb ;
    memory[215] = 32'h3e22aa62 ;
    memory[216] = 32'hbe14848c ;
    memory[217] = 32'hbc79a499 ;
    memory[218] = 32'hbdd8e764 ;
    memory[219] = 32'hbcc45602 ;
    memory[220] = 32'hbb55c72e ;
    memory[221] = 32'h3d69fdd7 ;
    memory[222] = 32'h3d678d88 ;
    memory[223] = 32'hbdac3476 ;
    memory[224] = 32'hbe025a5e ;
    memory[225] = 32'h3c4d1393 ;
    memory[226] = 32'hbe2d298e ;
    memory[227] = 32'h3dfe84ce ;
    memory[228] = 32'h3deab054 ;
    memory[229] = 32'hbe0617e0 ;
    memory[230] = 32'hbde4ae6b ;
    memory[231] = 32'hbdd71934 ;
    memory[232] = 32'hbc12a24b ;
    memory[233] = 32'h3dffaeb2 ;
    memory[234] = 32'hbcb54153 ;
    memory[235] = 32'h3d04a26a ;
    memory[236] = 32'hbd85ec9a ;
    memory[237] = 32'hbdda8f7d ;
    memory[238] = 32'hbddd68c2 ;
    memory[239] = 32'hbdd390fd ;
    memory[240] = 32'h3cd69007 ;
    memory[241] = 32'hbe331e25 ;
    memory[242] = 32'hbe3095f2 ;
    memory[243] = 32'hbb9b50ff ;
    memory[244] = 32'hbd21360e ;
    memory[245] = 32'hbd4b46b0 ;
    memory[246] = 32'hbd20611b ;
    memory[247] = 32'h3d3b87ba ;
    memory[248] = 32'h3d345eda ;
    memory[249] = 32'hbdc0f657 ;
    memory[250] = 32'hbe027c90 ;
    memory[251] = 32'hbd3323a3 ;
    memory[252] = 32'hbd42abb8 ;
    memory[253] = 32'hbe4e54dc ;
    memory[254] = 32'h3e17e4b1 ;
    memory[255] = 32'h3deb55c7 ;
    memory[256] = 32'hbe22f92b ;
    memory[257] = 32'h3e4b94f7 ;
    memory[258] = 32'hbb9ef6b4 ;
    memory[259] = 32'hbc33d3c6 ;
    memory[260] = 32'h3e1b9c27 ;
    memory[261] = 32'h3e2385b8 ;
    memory[262] = 32'hbd8a4af2 ;
    memory[263] = 32'h3e595f72 ;
    memory[264] = 32'hbde2dbc8 ;
    memory[265] = 32'hbda5b147 ;
    memory[266] = 32'h3d7f6690 ;
    memory[267] = 32'hbdf177fd ;
    memory[268] = 32'h3d9b3169 ;
    memory[269] = 32'hbd8c58b7 ;
    memory[270] = 32'hbcbf2beb ;
    memory[271] = 32'hbdaaaeb4 ;
    memory[272] = 32'h3e16dc18 ;
    memory[273] = 32'hbc332e5d ;
    memory[274] = 32'h3d193565 ;
    memory[275] = 32'hbcbeddef ;
    memory[276] = 32'h3e11c11d ;
    memory[277] = 32'h3dc8c79f ;
    memory[278] = 32'hbcd04243 ;
    memory[279] = 32'h3e125d6a ;
    memory[280] = 32'h3da74117 ;
    memory[281] = 32'h3d4c32e8 ;
    memory[282] = 32'hbce50c21 ;
    memory[283] = 32'h3c3c0f2d ;
    memory[284] = 32'hbdff527b ;
    memory[285] = 32'h3ddc573f ;
    memory[286] = 32'h3e0b0dca ;
    memory[287] = 32'hbe4dc0de ;
    memory[288] = 32'h3d9de346 ;
    memory[289] = 32'hbe2b4d3a ;
    memory[290] = 32'h3cdd6693 ;
    memory[291] = 32'h3dca9f6b ;
    memory[292] = 32'h3da4147f ;
    memory[293] = 32'h3d8e38fe ;
    memory[294] = 32'h3e02a274 ;
    memory[295] = 32'hbe196c62 ;
    memory[296] = 32'hbbb8d346 ;
    memory[297] = 32'hbe12e534 ;
    memory[298] = 32'h3e2541cf ;
    memory[299] = 32'hbdd0ac96 ;
    memory[300] = 32'hbd664524 ;
    memory[301] = 32'h3d913572 ;
    memory[302] = 32'hbceb4129 ;
    memory[303] = 32'hbcbdd571 ;
    memory[304] = 32'h3e018a87 ;
    memory[305] = 32'h3dec1b88 ;
    memory[306] = 32'h3bd2da1e ;
    memory[307] = 32'h3de62400 ;
    memory[308] = 32'hbcf40062 ;
    memory[309] = 32'hbdf196a5 ;
    memory[310] = 32'h3d94a986 ;
    memory[311] = 32'h3de14f1a ;
    memory[312] = 32'hbdac2089 ;
    memory[313] = 32'h3b1f9611 ;
    memory[314] = 32'hbe19e70d ;
    memory[315] = 32'h3d7c74cb ;
    memory[316] = 32'h3dc76a68 ;
    memory[317] = 32'h3dab8de4 ;
    memory[318] = 32'hbd97f024 ;
    memory[319] = 32'hbc70e9a9 ;
end



endmodule
