module comparator_1bit(
	input wire a, b,
	output wire greater, less, equal
);

	assign greater = a & ~b;
	assign less = ~a & b;
	assign equal = a ~^ b;
endmodule

