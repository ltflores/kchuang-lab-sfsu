Author: Lorenzo Flores
Date: April 5, 2011
//////////////////////////////

Directories:

root
	meanshift
		output_23-Mar-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-20_photbl-200
			index-1
	threshold
		output_23-Mar-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-20_photbl-200
	src
	
/////////////////////////////
matlab files (src)

mshift.m
	input: image h k th
	output: transformed image
	Computes meanshift over a 2D image using h, k, and th.
	h - gaussian kernel width
	k - number of iterations, the higher the closer each intensity will get to maximum likelihood.
	th - threshold specifying acceptible ratios between the meanshift of a particular intensity and gaussian width.
	

remove_noise.m
	input: file_name [index] [threshold]
	output: binary_image
	Reads in an image specified by file_name, if it's a multi-image tiff and no index is specified remove_noise will return a 3D matrix containing each transofrmed image within the tiff. If no threshold given, the script will use Otsu's method.
	
write_remove_noise.m
	input: data_dir file_name out_file_name [threshold]
	output: void
	Computes binary transformation over each image in a multi-image tiff, saves as out_file_name in data_dir. Convovles data with average filter.
	
write_remove_noise_no_filter.m
	input: data_dir file_name out_file_name [threshold]
	output: void
	Same as write_remove_noise but uses convolution.
	
