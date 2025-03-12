module Median_Filter(clk, reset,
						   pixel_out, done);

	 parameter row = 256;
    parameter col = 256;
    parameter window = 3;
    parameter Pixel_Width = 8; 
    localparam Window_Size = window * window;

    input clk, reset;
    output reg [Pixel_Width-1:0] pixel_out;
    output reg done;

	 reg [Pixel_Width-1:0] Img_Pixels [0:row*col-1];
    reg [Pixel_Width-1:0] Window_Pixels [0:Window_Size-1];
    reg [Pixel_Width-1:0] temp;	
 
	
    // Region parameters
    parameter corner_tl=0, corner_tr=1, corner_bl=2, corner_br=3,
              edge_left=4, edge_right=5, edge_top=6, edge_bot=7,
              main_area=8;

    reg [3:0] region;
	 
    integer i, j, k; 
	 integer pixel_cnt;
	 integer row_offset, col_offset;
	 integer img_row, img_col;
	 
	 initial 
			$readmemh("C:/Final Project - Verilog/Addition files/Original_Img.mem",Img_Pixels);
			
			
	 always@(posedge clk or posedge reset)
	 begin
        if(reset) 
		  begin
            pixel_cnt = 0;
            pixel_out = 0;
            done = 0;
        end 
		  else 
		  begin
            // Determine the region
            if(pixel_cnt == 0)  
                region = corner_tl;
            else if(pixel_cnt == (col - 1)) 
                region = corner_tr;
            else if(pixel_cnt == (row*(col-1)))  
                region = corner_bl;
            else if(pixel_cnt == (row*col-1))  
                region = corner_br;
            else if((((pixel_cnt)%col) - (window/2) < 0) && (pixel_cnt > 0) && (pixel_cnt < (row*(col-1)))) 
                region = edge_left;
            else if((((pixel_cnt)%col) + (window/2) > col-1) && (pixel_cnt >= row) && (pixel_cnt < (row*col-1))) 
                region = edge_right;
            else if((((pixel_cnt)/col) - (window/2) < 0))
                region = edge_top;
            else if((((pixel_cnt)/col) + (window/2) > row-1)) 
                region = edge_bot;
            else
                region = main_area;

            if (region == main_area) 
					 Finds_Median(pixel_out);
				else
                pixel_out = Img_Pixels[pixel_cnt]; 

            pixel_cnt = pixel_cnt + 1;   

            if (pixel_cnt == row * col) 
                done = 1;
        end
    end

	task 	Finds_Median;
		output [Pixel_Width - 1:0] Median_Value;
		/* Create the relevant window */
		begin //For TB
      k = 0; // Reset window pixel index
      for (i = 0; i < window; i = i + 1) 
		begin
				for (j = 0; j < window; j = j + 1) 
				begin
						// Calculate indices relative to the center pixel
                  row_offset = i - (window / 2);
                  col_offset = j - (window / 2);

						// Calculate image indices with boundary checks
                  img_row = (pixel_cnt / col) + row_offset;
                  img_col = (pixel_cnt % col) + col_offset;

                  Window_Pixels[k] = Img_Pixels[img_row * col + img_col];  
                  k = k + 1; 
				end
		end
		for (i = 0; i < Window_Size - 1; i = i + 1) 
		begin
				 for (j = 0; j < Window_Size - 1 - i; j = j + 1)
				 begin
							if (Window_Pixels[j] > Window_Pixels[j + 1])
							begin
								   temp = Window_Pixels[j];
								   Window_Pixels[j] = Window_Pixels[j + 1];
								   Window_Pixels[j + 1] = temp;
						  end
				 end
		end 
		Median_Value = Window_Pixels[(Window_Size - 1) / 2];
	end	
	endtask 
	
endmodule
