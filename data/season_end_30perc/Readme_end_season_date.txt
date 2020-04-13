Author: Sitian
sxiong@clarku.edu

The folder contains estimated Zambia end-of-season date in Date of Year (DOY) format in 17 growing seasons: 2000/2001 to 2017/2018.
negative 1 (-1) indicates failed to extract season or no season found.

This Tiff is genergated from MODIS MOD13Q1， from 10/1/2000 to 9/30/2018.

#--seasons---------:
18 seasons total,
season 1 -->2017-2018
season 18 --> 2000-2001
#------------------

#----Other information--:
MOD13Q1 filtered by Qality band, took Qality= 0 (good) or 1 (moderate)
CRS: EPSG:4326 (wgs84)
col:5208
row:4402

datatype: 32-bit signed, or (float32)
#--------------------------:




#Key concepts of this dataset:
1) The end-of-season date is defined as the time at 70% green down of the NDVI curve for a given phenology curve.  In other words, each growing season has one up and down in the NDVI curve, and the peak NDVI is defined as 100%. As time goes, the percentage move away from 100% and decrease to 0% at the right-end of the curve. The end-of-season time is at 30% to the minimum on the right side.  This 70% green down is arbitary and not supported by any published article (Differently, for the planting date data, the 30% green up definition of planting date was supported by Urban et al 2018.  See Urban, D., Guan, K., & Jain, M. (2018). Estimating sowing dates from satellite data over the US Midwest: a comparison of multiple sensors and metrics. Remote sensing of environment, 211, 400-412.).

2) The dataset is derived from MODIS MOD13Q1 VI product (16-day, 250m).
Only "good" pixels defined by Quality bands was used.

3) Savitzky-golay filter is used to fill the gap and smooth the time-series NDVI.  A software called TIMESAT is used to implement the savitzky-golay filter.  


#DSSAT Processing parameters--:
seasonal information: small integral (see TIMESAT definition)
SG-filter window = 5
season inflection point: 30% 30%
envlope: 1
#--------------------


# season folder-------------------------------------------
306 images, 18 seasons  + 17 *2 dummy images (2 seasons) on begining and end
(TIMESAT states it will extract n-1 'center most' seasons. TIMESAT doc .p23,
Sitian found EITHER the first season OR last season will lost by experiement,
the time index is an reliable way to extract desired season:
dup the first and last seaosn, when extracting 1st season, use date range 17*1 to 17*2; when extracting last season, use date range 306 -17*2 to 306 - 17*1 )

2000-10-15 to -2018-06-26s
17 images/season + 2 dummy seasons
2000-2001(dup)   1-17
2000-2001  18    18-34    
2001-2002  17    35-51
2002-2003  16    52-68    
2003-2004  15    69-85
2004-2005  14    86-102    
2005-2006  13    103-119
2006-2007  12    120-136
2007-2008  11    137-153
2008-2009  10    154-170
2009-2010  9     171-187
2010-2011  8     188-204
2011-2012  7     205-221
2012-2013  6     222-238
2013-2014  5     239-255
2014-2015  4     256-272
2015-2016  3     273-289
2016-2017  2     290-306
2017-2018  1     307-323
2017-2018(dup)   324-340


Qality: 0(good)
CRS: EPSG:4326 (wgs84)

col:5208
row:4402
NA:32767