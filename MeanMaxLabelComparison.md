#Comparison of two labelling techniques on data binarized with hard threshold values.

# Introduction #

## Basic Process ##
For each data run the following algorithm
  * binarize data with threshold values ranging between 0.1 and 0.9 with incremental steps of 0.1
  * label connected regions
  * for each region find an intensity value to label with a green pixel using one of two methods
    * mean (x,y) coordinates
    * (x,y) coordinates with the maximum local intensity

## Data ##
Simulated data with the following values:
  * std = 10, 40, 80
  * photobleaching = 0, 200


# Results #
**NTOE** the label markers are supposed to be green but the color gets lost when converting to animated gifs.

Parameters:
  * STD = standard deviation
  * P = photobleaching
  * T = thresholding, set to 0.7 for the data shown since that seemed to be the best intensity for all cases. 0.8 contained more false negatives and I think we want to lean more toward false positives.

| **STD** | **P** | **T** | **Binary** | **Spatial Mean** | **Max  Intensity** |
|:--------|:------|:------|:-----------|:-----------------|:-------------------|
| 10 | 0 | 0.7 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-0_t-0.7-4.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/thresh_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-0_t-0.7-3.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/max-int_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-0_t-0.7-1.gif' /> |
| 10 | 200 | 0.7 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/max-int_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/thresh_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-10_photbl-200_t-0.7.gif' /> |
| 40 | 0 | 0.7 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-0_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/thresh_output_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-0_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/max-int_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-0_t-0.7.gif' /> |
| 40 | 200 | 0.7 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/thresh_output_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/max-int_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-40_photbl-200_t-0.7.gif' /> |
| 80 | 0 | 0.7 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-0_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/thresh_output_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-0_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/max-int_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-0_t-0.7.gif' /> |
| 80 | 200 | 0.7 | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/bin_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/thresh_output_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-200_t-0.7.gif' /> | <img src='http://www.floresproductions.com/huanglab/thresh-max_int-comparison/max-int_output_08-Apr-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-80_photbl-200_t-0.7.gif' /> |

# Analysis #

The motivation for using maximum intensity was to to see if it was more stable than the average (x,y) coordinates for each region. Unfortunately, it doesn't seem that simple. It seems the maximum intensity moves just as sporadically as the region means. There's a chance that in those areas there are high noise spikes but I'll need to examine local intensity peaks of successive frames to verify.