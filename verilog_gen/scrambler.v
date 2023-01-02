`timescale 1ns / 1ps

module scrambler(
	input	[63:0]	din,
	output	[63:0]	dout,
	input		en,

	input		resetn,
	input		clk
	);

	reg	[15:0]	ctx;
	wire	[63:0]	ctx_next;

	assign dout = ctx_next^din;

	always@(posedge clk) begin
		if (resetn == 0) ctx <= 16'hF0F6;
		else begin
			if (en) ctx <= ctx_next[63:48];
		end
	end

	assign ctx_next[63] = ctx[15] ^ ctx[11] ^ ctx[10] ^ ctx[8] ^ ctx[6] ^ ctx[4] ^ ctx[2];
	assign ctx_next[62] = ctx[14] ^ ctx[10] ^ ctx[9] ^ ctx[7] ^ ctx[5] ^ ctx[3] ^ ctx[1];
	assign ctx_next[61] = ctx[13] ^ ctx[9] ^ ctx[8] ^ ctx[6] ^ ctx[4] ^ ctx[2] ^ ctx[0];
	assign ctx_next[60] = ctx[15] ^ ctx[14] ^ ctx[8] ^ ctx[7] ^ ctx[5] ^ ctx[1];
	assign ctx_next[59] = ctx[14] ^ ctx[13] ^ ctx[7] ^ ctx[6] ^ ctx[4] ^ ctx[0];
	assign ctx_next[58] = ctx[15] ^ ctx[14] ^ ctx[13] ^ ctx[6] ^ ctx[5];
	assign ctx_next[57] = ctx[14] ^ ctx[13] ^ ctx[12] ^ ctx[5] ^ ctx[4];
	assign ctx_next[56] = ctx[13] ^ ctx[12] ^ ctx[11] ^ ctx[4] ^ ctx[3];
	assign ctx_next[55] = ctx[12] ^ ctx[11] ^ ctx[10] ^ ctx[3] ^ ctx[2];
	assign ctx_next[54] = ctx[11] ^ ctx[10] ^ ctx[9] ^ ctx[2] ^ ctx[1];
	assign ctx_next[53] = ctx[10] ^ ctx[9] ^ ctx[8] ^ ctx[1] ^ ctx[0];
	assign ctx_next[52] = ctx[15] ^ ctx[14] ^ ctx[12] ^ ctx[9] ^ ctx[8] ^ ctx[7] ^ ctx[3] ^ ctx[0];
	assign ctx_next[51] = ctx[15] ^ ctx[13] ^ ctx[12] ^ ctx[11] ^ ctx[8] ^ ctx[7] ^ ctx[6] ^ ctx[3] ^ ctx[2];
	assign ctx_next[50] = ctx[14] ^ ctx[12] ^ ctx[11] ^ ctx[10] ^ ctx[7] ^ ctx[6] ^ ctx[5] ^ ctx[2] ^ ctx[1];
	assign ctx_next[49] = ctx[13] ^ ctx[11] ^ ctx[10] ^ ctx[9] ^ ctx[6] ^ ctx[5] ^ ctx[4] ^ ctx[1] ^ ctx[0];
	assign ctx_next[48] = ctx[15] ^ ctx[14] ^ ctx[10] ^ ctx[9] ^ ctx[8] ^ ctx[5] ^ ctx[4] ^ ctx[0];
	assign ctx_next[47] = ctx[15] ^ ctx[13] ^ ctx[12] ^ ctx[9] ^ ctx[8] ^ ctx[7] ^ ctx[4];
	assign ctx_next[46] = ctx[14] ^ ctx[12] ^ ctx[11] ^ ctx[8] ^ ctx[7] ^ ctx[6] ^ ctx[3];
	assign ctx_next[45] = ctx[13] ^ ctx[11] ^ ctx[10] ^ ctx[7] ^ ctx[6] ^ ctx[5] ^ ctx[2];
	assign ctx_next[44] = ctx[12] ^ ctx[10] ^ ctx[9] ^ ctx[6] ^ ctx[5] ^ ctx[4] ^ ctx[1];
	assign ctx_next[43] = ctx[11] ^ ctx[9] ^ ctx[8] ^ ctx[5] ^ ctx[4] ^ ctx[3] ^ ctx[0];
	assign ctx_next[42] = ctx[15] ^ ctx[14] ^ ctx[12] ^ ctx[10] ^ ctx[8] ^ ctx[7] ^ ctx[4] ^ ctx[2];
	assign ctx_next[41] = ctx[14] ^ ctx[13] ^ ctx[11] ^ ctx[9] ^ ctx[7] ^ ctx[6] ^ ctx[3] ^ ctx[1];
	assign ctx_next[40] = ctx[13] ^ ctx[12] ^ ctx[10] ^ ctx[8] ^ ctx[6] ^ ctx[5] ^ ctx[2] ^ ctx[0];
	assign ctx_next[39] = ctx[15] ^ ctx[14] ^ ctx[11] ^ ctx[9] ^ ctx[7] ^ ctx[5] ^ ctx[4] ^ ctx[3] ^ ctx[1];
	assign ctx_next[38] = ctx[14] ^ ctx[13] ^ ctx[10] ^ ctx[8] ^ ctx[6] ^ ctx[4] ^ ctx[3] ^ ctx[2] ^ ctx[0];
	assign ctx_next[37] = ctx[15] ^ ctx[14] ^ ctx[13] ^ ctx[9] ^ ctx[7] ^ ctx[5] ^ ctx[2] ^ ctx[1];
	assign ctx_next[36] = ctx[14] ^ ctx[13] ^ ctx[12] ^ ctx[8] ^ ctx[6] ^ ctx[4] ^ ctx[1] ^ ctx[0];
	assign ctx_next[35] = ctx[15] ^ ctx[14] ^ ctx[13] ^ ctx[11] ^ ctx[7] ^ ctx[5] ^ ctx[0];
	assign ctx_next[34] = ctx[15] ^ ctx[13] ^ ctx[10] ^ ctx[6] ^ ctx[4] ^ ctx[3];
	assign ctx_next[33] = ctx[14] ^ ctx[12] ^ ctx[9] ^ ctx[5] ^ ctx[3] ^ ctx[2];
	assign ctx_next[32] = ctx[13] ^ ctx[11] ^ ctx[8] ^ ctx[4] ^ ctx[2] ^ ctx[1];
	assign ctx_next[31] = ctx[12] ^ ctx[10] ^ ctx[7] ^ ctx[3] ^ ctx[1] ^ ctx[0];
	assign ctx_next[30] = ctx[15] ^ ctx[14] ^ ctx[12] ^ ctx[11] ^ ctx[9] ^ ctx[6] ^ ctx[3] ^ ctx[2] ^ ctx[0];
	assign ctx_next[29] = ctx[15] ^ ctx[13] ^ ctx[12] ^ ctx[11] ^ ctx[10] ^ ctx[8] ^ ctx[5] ^ ctx[3] ^ ctx[2] ^ ctx[1];
	assign ctx_next[28] = ctx[14] ^ ctx[12] ^ ctx[11] ^ ctx[10] ^ ctx[9] ^ ctx[7] ^ ctx[4] ^ ctx[2] ^ ctx[1] ^ ctx[0];
	assign ctx_next[27] = ctx[15] ^ ctx[14] ^ ctx[13] ^ ctx[12] ^ ctx[11] ^ ctx[10] ^ ctx[9] ^ ctx[8] ^ ctx[6] ^ ctx[1] ^ ctx[0];
	assign ctx_next[26] = ctx[15] ^ ctx[13] ^ ctx[11] ^ ctx[10] ^ ctx[9] ^ ctx[8] ^ ctx[7] ^ ctx[5] ^ ctx[3] ^ ctx[0];
	assign ctx_next[25] = ctx[15] ^ ctx[10] ^ ctx[9] ^ ctx[8] ^ ctx[7] ^ ctx[6] ^ ctx[4] ^ ctx[3] ^ ctx[2];
	assign ctx_next[24] = ctx[14] ^ ctx[9] ^ ctx[8] ^ ctx[7] ^ ctx[6] ^ ctx[5] ^ ctx[3] ^ ctx[2] ^ ctx[1];
	assign ctx_next[23] = ctx[13] ^ ctx[8] ^ ctx[7] ^ ctx[6] ^ ctx[5] ^ ctx[4] ^ ctx[2] ^ ctx[1] ^ ctx[0];
	assign ctx_next[22] = ctx[15] ^ ctx[14] ^ ctx[7] ^ ctx[6] ^ ctx[5] ^ ctx[4] ^ ctx[1] ^ ctx[0];
	assign ctx_next[21] = ctx[15] ^ ctx[13] ^ ctx[12] ^ ctx[6] ^ ctx[5] ^ ctx[4] ^ ctx[0];
	assign ctx_next[20] = ctx[15] ^ ctx[11] ^ ctx[5] ^ ctx[4];
	assign ctx_next[19] = ctx[14] ^ ctx[10] ^ ctx[4] ^ ctx[3];
	assign ctx_next[18] = ctx[13] ^ ctx[9] ^ ctx[3] ^ ctx[2];
	assign ctx_next[17] = ctx[12] ^ ctx[8] ^ ctx[2] ^ ctx[1];
	assign ctx_next[16] = ctx[11] ^ ctx[7] ^ ctx[1] ^ ctx[0];
	assign ctx_next[15] = ctx[15] ^ ctx[14] ^ ctx[12] ^ ctx[10] ^ ctx[6] ^ ctx[3] ^ ctx[0];
	assign ctx_next[14] = ctx[15] ^ ctx[13] ^ ctx[12] ^ ctx[11] ^ ctx[9] ^ ctx[5] ^ ctx[3] ^ ctx[2];
	assign ctx_next[13] = ctx[14] ^ ctx[12] ^ ctx[11] ^ ctx[10] ^ ctx[8] ^ ctx[4] ^ ctx[2] ^ ctx[1];
	assign ctx_next[12] = ctx[13] ^ ctx[11] ^ ctx[10] ^ ctx[9] ^ ctx[7] ^ ctx[3] ^ ctx[1] ^ ctx[0];
	assign ctx_next[11] = ctx[15] ^ ctx[14] ^ ctx[10] ^ ctx[9] ^ ctx[8] ^ ctx[6] ^ ctx[3] ^ ctx[2] ^ ctx[0];
	assign ctx_next[10] = ctx[15] ^ ctx[13] ^ ctx[12] ^ ctx[9] ^ ctx[8] ^ ctx[7] ^ ctx[5] ^ ctx[3] ^ ctx[2] ^ ctx[1];
	assign ctx_next[9] = ctx[14] ^ ctx[12] ^ ctx[11] ^ ctx[8] ^ ctx[7] ^ ctx[6] ^ ctx[4] ^ ctx[2] ^ ctx[1] ^ ctx[0];
	assign ctx_next[8] = ctx[15] ^ ctx[14] ^ ctx[13] ^ ctx[12] ^ ctx[11] ^ ctx[10] ^ ctx[7] ^ ctx[6] ^ ctx[5] ^ ctx[1] ^ ctx[0];
	assign ctx_next[7] = ctx[15] ^ ctx[13] ^ ctx[11] ^ ctx[10] ^ ctx[9] ^ ctx[6] ^ ctx[5] ^ ctx[4] ^ ctx[3] ^ ctx[0];
	assign ctx_next[6] = ctx[15] ^ ctx[10] ^ ctx[9] ^ ctx[8] ^ ctx[5] ^ ctx[4] ^ ctx[2];
	assign ctx_next[5] = ctx[14] ^ ctx[9] ^ ctx[8] ^ ctx[7] ^ ctx[4] ^ ctx[3] ^ ctx[1];
	assign ctx_next[4] = ctx[13] ^ ctx[8] ^ ctx[7] ^ ctx[6] ^ ctx[3] ^ ctx[2] ^ ctx[0];
	assign ctx_next[3] = ctx[15] ^ ctx[14] ^ ctx[7] ^ ctx[6] ^ ctx[5] ^ ctx[3] ^ ctx[2] ^ ctx[1];
	assign ctx_next[2] = ctx[14] ^ ctx[13] ^ ctx[6] ^ ctx[5] ^ ctx[4] ^ ctx[2] ^ ctx[1] ^ ctx[0];
	assign ctx_next[1] = ctx[15] ^ ctx[14] ^ ctx[13] ^ ctx[5] ^ ctx[4] ^ ctx[1] ^ ctx[0];
	assign ctx_next[0] = ctx[15] ^ ctx[13] ^ ctx[4] ^ ctx[0];

endmodule
