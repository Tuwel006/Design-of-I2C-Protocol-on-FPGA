`timescale 1ns / 10ps

module i2c_testbench;

	// Inputs
	reg clk;
	reg rst;
	reg [6:0] addr;
	reg [7:0] data_in;
	reg enable;
	reg rw;

	// Outputs
	wire [7:0] read_data;
        wire [7:0] recived_addr;
        wire [7:0] write_data;
	wire ready;
        wire [3:0] state;
        wire i2c_clk;

	// Bidirs
	wire i2c_sda;
	wire i2c_scl;

	// Instantiate the Unit Under Test (UUT)
	i2c_master master (
		.clk(clk), 
		.rst(rst), 
		.addr(addr), 
		.data_in(data_in), 
		.enable(enable), 
		.rw(rw), 
		.read_data(read_data), 
		.ready(ready), 
                .state(state),
                .i2c_clk(i2c_clk),
		.i2c_sda(i2c_sda), 
		.i2c_scl(i2c_scl)
	);
	
		
	i2c_slave slave (
    .recived_addr(recived_addr),
    .write_data(write_data),
    .sda(i2c_sda), 
    .scl(i2c_scl)
    );
	
	initial begin
		clk = 0;
		forever begin
			clk = #5 ~clk;
		end		
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		rst = 0;		
		addr = 7'b0101010;
		data_in = 8'b11101011;
		rw = 0;	
		enable = 1;
		#10;
		//enable = 0;
				
		#190
		rw=1;
		#300
		$finish;
		
	end      
endmodule