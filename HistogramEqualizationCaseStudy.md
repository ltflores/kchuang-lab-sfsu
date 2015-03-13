#Details the results of equalizing the histogram for a sample simulated data

# Introduction #

I wanted to examine the effects of equalizing the histogram for simulated data. Below animated gifs for both the original and transformed data as well as histogram and cdf graphs for the first frame.

Images were processed as individual frames:
  * compute the CDF for the original data
  * map intensity values from input to output
    * x = intensity values from the original data
    * y = intensity values for output data
    * y = cdf(x)

# Data #

**Original Sample Parameters**
  * 155x70 pixels
  * Gaussian noise with std=20
  * photobleaching = 200

|  | **Original Data** | **Histogram Equalized Data** |
|:-|:------------------|:-----------------------------|
| **Animated GIF** | <img src='http://www.floresproductions.com/huanglab/output_23-Mar-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-20_photbl-200.gif' align='middle' /> | <img src='http://www.floresproductions.com/huanglab/output_23-Mar-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-20_photbl-200_hist-eq.gif' align='middle' /> |
| **First Frame** | <img src='http://www.floresproductions.com/huanglab/output_23-Mar-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-20_photbl-200.png' align='middle' /> | <img src='http://www.floresproductions.com/huanglab/output_23-Mar-2011_vertex_output_lr-0.75_23-Mar-2011_gausstd-20_photbl-200_hist-eq.png' align='middle' /> |
| **Histogram** | <img src='http://www.floresproductions.com/huanglab/original_histogram.png' align='middle' /> | <img src='http://www.floresproductions.com/huanglab/eq_histogram.png' align='middle' /> |
| **CDF** | <img src='http://www.floresproductions.com/huanglab/original_cdf.png' align='middle' /> | <img src='http://www.floresproductions.com/huanglab/eq_cdf.png' /> |

# Analysis #

It seems we have a disproportional amount of dark gray level values, essentially the background which renders brute force histogram equalization useless in enhancing the contrast. Moving forward, I'll cut the cdf top and bottom 5%, as mentioned by Tristan. If we choose to pursue histogram equalization further I can also test it with smoothing, an initial threshold to drop the first histogram peak, or regional histogram equalization.