// OSS-HAL : OPS-SAT Swansea Hardware Abstraction Layer
//
// author: stf (shane)

module oss_hal (
	input hal_clk,
	input hal_reset,

	// Register interface
	input logic reg_itf_write_in,
	input logic reg_itf_read_in,
	input logic [3:0] reg_itf_addr_in,
	output logic [31:0] reg_itf_readdata_out,
	input logic [31:0] reg_itf_writedata_in

);

// test signals for hooking up to the adder
logic [31:0] a;
logic [31:0] b;
logic [31:0] c;

// read register process
always_ff @(posedge hal_clk) begin
	// we have a read pulse
	if (reg_itf_read_in) begin
		case(reg_itf_addr_in) 
			4'd0: reg_itf_readdata_out <= a;
			4'd1: reg_itf_readdata_out <= b;
			4'd2: reg_itf_readdata_out <= c;
			4'd3: reg_itf_readdata_out <= 32'd0;
			4'd4: reg_itf_readdata_out <= 32'd0;
			4'd5: reg_itf_readdata_out <= 32'd0;
			4'd6: reg_itf_readdata_out <= 32'd0;
			4'd7: reg_itf_readdata_out <= 32'd0;
			4'd8: reg_itf_readdata_out <= 32'd0;
			4'd9: reg_itf_readdata_out <= 32'd0;
			4'd10: reg_itf_readdata_out <= 32'd0;
			4'd11: reg_itf_readdata_out <= 32'd0;
			4'd12: reg_itf_readdata_out <= 32'd0;
			4'd13: reg_itf_readdata_out <= 32'd0;
			4'd14: reg_itf_readdata_out <= 32'd0;
			4'd15: reg_itf_readdata_out <= 32'd0;
		endcase	
	end

	if(hal_reset) begin
		reg_itf_readdata_out <= 32'd0;
	end
end

logic [3:0] c_tmp;
add_test add_test_inst(
	.a_in(a),
	.b_in(b),
	.c_out(c_tmp)
);

// store the data coming out of the add_test_inst in a register
always_ff @(posedge hal_clk) begin
	c <= {28'd0, c_tmp};
	if(hal_reset) begin
		c <= 32'd0;
	end
end

// write register process
always_ff @(posedge hal_clk) begin
	if (reg_itf_write_in) begin
		case(reg_itf_addr_in)
			4'd0: a <= reg_itf_writedata_in;
			4'd1: b <= reg_itf_writedata_in;
			default: begin
			       // do nothing
			end	
		endcase		
	end

	if (hal_reset) begin
		a <= 32'd0;
		b <= 32'd0;
	end
end


endmodule /* oss_hal */ 