# Median Filter Implementation in Verilog
This project implements a median filter in Verilog for grayscale images, designed to support a configurable image size and filter window.

Additionally, MATLAB scripts are provided for image preprocessing — converting an image into a memory file for hardware processing — and for visualizing the filtered output.

Main Project Files:

Median_Filter.v – Top module implementing the median filter.

Median_Filter_TB.v – Testbench for verifying the implementation and generating the filtered image as a file.

Additional Files:

HextoImage.m – Converts an image into a memory file.

ImagetoHex.m – Converts a memory file back into an image.
