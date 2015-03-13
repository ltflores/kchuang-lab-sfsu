#Comparison between thresholding techniques

# Introduction #

We want to characterize the differences between thresholding technques; hard values and standard deviations.

## Basic Process ##
For each sample, binarize the image using hard threshold values and standard deviations from the mean with no preprocessing and with smoothing. Standard deviations and averages are computed on a frame by frame basis.

## Data ##
Simulated data with the following values:
  * std = 10, 40, 80
  * photobleaching = 0, 200


# Results #

Parameters:
  * **STD** = gaussian noise standard deviation in sample
  * **P** = photobleaching
  * **T0.7 Binary** = binary output with hard threshold = 0.7
  * **T\_STD4 Binary** = binary output with threshold 4 standard deviations above the mean
  * **T\_STD5 Binary** = binary output with threshold 5 standard deviations above the mean

| **STD** | **P** | **T0.7 Binary** | **T\_STD4 Binary** | **T\_STD5 Binary** |
|:--------|:------|:----------------|:-------------------|:-------------------|
| 10 | 0 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-0_t-0.7-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-0_stdt-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-0_stdt-5.gif' /> |
| 10 | 200 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-200_stdt-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-200_stdt-5.gif' /> |
| 40 | 0 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-0_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-0_stdt-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-0_stdt-5.gif' /> |
| 40 | 200 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-200_stdt-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-200_stdt-5.gif' /> |
| 80 | 0 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-0_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-0_stdt-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-0_stdt-5.gif' /> |
| 80 | 200 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-200_stdt-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/stdt_orig/output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-200_stdt-5.gif' /> |

# Analysis #
Binarization results don't seem to differ too much between using hard values vs. standard deviations above the mean. If we were to continue optimizing how we threshold for this data it seems to best option would be make thresholding a function of distance between points, frame, or time regardless of how values are determined. We would start with a large threshold and gradually scale down.