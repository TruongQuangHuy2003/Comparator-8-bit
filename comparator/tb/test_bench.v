`timescale 1ns/1ps
module test_bench;
	reg [7:0] a, b;
	wire greater, less, equal;

	comparator dut(
		.a(a),
		.b(b),
		.greater(greater),
		.less(less),
		.equal(equal)
	);

	integer i;

	task verify;
		input exp_greater, exp_less, exp_equal;
		begin
			$display("At time: %t, a = 8'h%h, b = 8'h%h", $time, a, b);
			if(exp_greater == greater && exp_less == less && exp_equal == equal) begin
				$display("----------------------------------------------------------------------------------------------------------------");
				$display("PASSED: Expected Greater: 1'b%b, Got Greater: 1'b%b, Expected less: 1'b%b, Got 1'b%b, Expected equal: 1'b%b, Got equal: 1'b%b", exp_greater, greater, exp_less, less, exp_equal, equal);
				$display("----------------------------------------------------------------------------------------------------------------");
			end else begin
				$display("----------------------------------------------------------------------------------------------------------------");
				$display("FAILED: Expected Greater: 1'b%b, Got Greater: 1'b%b, Expected less: 1'b%b, Got 1'b%b, Expected equal: 1'b%b, Got equal: 1'b%b", exp_greater, greater, exp_less, less, exp_equal, equal);
				$display("----------------------------------------------------------------------------------------------------------------");
			end
		end
	endtask

	initial begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0, test_bench);


		$display("----------------------------------------------------------------------------------------------------------------");
		$display("---------------------- TESTBENCH FOR COMPARATOR 8 BIT ----------------------------------------------------------");
		$display("----------------------------------------------------------------------------------------------------------------");

		a = 8'hf0;
		b = 8'h0f;
		#1;
		verify(1,0,0);

		a = 8'haa;
		b = 8'hb0;
		#1;
		verify(0,1,0);

		a = 8'hff;
		b = 8'hff;
		#1;
		verify(0,0,1);

		for (i = 0; i < 20; i = i + 1) begin
			a = $random % 256;
			b = $random % 256;
			#1;
			if (a > b) begin
				verify(1,0,0);
				#1;
			end else if (a < b) begin
				verify(0,1,0);
				#1;
			end else begin
				verify(0,0,1);
				#1;
			end
		end

		$display("---------------------------- COMPLETED TEST --------------------------------------------------------------------");
		#20;
		$finish;
	end
endmodule

