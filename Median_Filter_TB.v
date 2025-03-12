`define CLK_PER 0.1
`timescale 100ns/10ns
module Median_Filter_TB;
	
	parameter row = 428, col = 320;
	parameter window = 7;
	parameter Pixel_Width = 8;
	
	// Definition of signals and parameters.
	reg clk, reset;
	wire [Pixel_Width - 1:0] pixel_out;
	wire done;
	
	reg write;
	integer f;
	initial
	begin
		f = $fopen("C:/Final Project - Verilog/Addition files/ImgAfterMedianFilter.txt", "w");
		if (f == 0) 
		begin
        $display("Error: File could not be opened.");
        $stop;
		end
		reset = 1;
		clk = 0;
		write = 0;
		#(9 * `CLK_PER) 	
		reset = ~reset;
		#`CLK_PER
		write = ~write;
	end
	
	generate
	if(window == 3)
	begin
		Median_Filter #(row, col, 3, Pixel_Width)
		mf3x3(clk, reset, pixel_out, done);
	end
	else if (window == 5)
	begin
		Median_Filter #(row, col, 5, Pixel_Width)
		mf5x5(clk, reset, pixel_out, done);
	end
	else if( window == 7)
	begin
		Median_Filter #(row, col, 7, Pixel_Width)
		mf7x7(clk, reset, pixel_out, done);
	end
	endgenerate	
		
	// Define a clock with frequency of 50MHz
	always
	#(`CLK_PER / 2) clk = ~clk;

	always@(posedge clk)
	begin
		if(write)  // For the first pixel!!!
	     $fwrite(f,"%X\n",pixel_out);
		 if(done)
		 begin
			$fclose(f);
			write = 0;
		   $display("File successfully written and closed.");
			$finish;
		 end
	end
	
endmodule