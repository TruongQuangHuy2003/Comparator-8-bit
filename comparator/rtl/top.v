module comparator (
	input wire [7:0] a, b,
	output reg greater, less, equal
);

wire [7:0] greater_internal, less_internal, equal_internal;
wire [7:0] eq_chain;

genvar i;
generate
	for( i = 0; i < 8; i = i + 1) begin
		comparator_1bit ic(
			.a(a[i]),
			.b(b[i]),
			.greater(greater_internal[i]),
			.less(less_internal[i]),
			.equal(equal_internal[i])
		);
	end
endgenerate

assign eq_chain[7] = 1'b1;
generate
	for(i = 6; i >= 0;i = i - 1) begin
		assign eq_chain[i] = eq_chain[i + 1] & equal_internal[i + 1];
	end
endgenerate

// Final output
always @(*) begin
	greater = |(greater_internal & eq_chain);
	less = |(less_internal & eq_chain);
	equal = &(equal_internal & eq_chain);
end
endmodule

