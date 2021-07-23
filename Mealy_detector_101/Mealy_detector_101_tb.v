/* 
mealy detector module for sequence 101
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/

`timescale 1ns/1ns

module mealy_101_detector_tb ();

	reg x_tb, clk_tb, rst_tb;
	wire z_tb;
	
	// Declare a variable to store the file handler
	integer fh;
	
	mealy_101_detector DUT (x_tb, clk_tb, rst_tb, z_tb);
	
	initial begin
		// Open a new file by the name "my_file.txt"
		// with "write" permissions, and store the file
		// handler pointer in variable "fh"
		fh = $fopen("my_file.txt", "w");
		$fwrite(fh, "Value displayed with $fwrite\n");
		clk_tb = 0; x_tb = 0; rst_tb = 0;
		#22 rst_tb = 1;
		#5  x_tb = 1;   #4  x_tb = 0; 
		$fdisplay(fh,"[$fdisplay] time=%0t x_tb=0x%0h z_tb=0x%0h", $time, x_tb, z_tb);
		$fstrobe(fh, "[$fstrobe] time=%0t x_tb=0x%0h z_tb=0x%0h",  $time, x_tb, z_tb);
		$fmonitor(fh,"[$fmonitor] time=%0t x_tb=0x%0h z_tb=0x%0h", $time, x_tb, z_tb);
		#14 x_tb = 1;   #21 x_tb = 0; 
		#17 x_tb = 1;   #23 x_tb = 0;
		
		// Close the file handle pointed to by "fh"
		$fclose(fh);
	end
	always #5 clk_tb = ~clk_tb;
	
endmodule











