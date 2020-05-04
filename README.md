# zambiags
## Authors: Rowan Moody & Brandon Shafer
Repository for the Zambia Growing Season final project, Spring 2020.

### Project Overview:
This project is designed to gain a better understanding of the agricultural trends in Zambia on multiple scales. Through the analysis of eighteen growing seasons between 2000 and 2018, we calculated the mean harvesting and planting dates as well as the mean season length, averaged across the eighteen seasons by pixel. The outputs of these operations are then aggregated by mean within Zambia's districts, allowing for easier identification of regional trends across the country.

For further research, it would be interesting to look at how the planting and harvesting dates and season lengths have changed over time. We can see a clear latitudinal dependence on season length, but it would be interesting to see if there have been any trends over the past 18 years and if these trends show a similar spatial pattern. Other variables could be included in the analysis to understand influencial variables on growing seasons, such as elevation and land surface temperature. In this study we only looked at how cropland and growing seasons for all crops are quantified, but it would be interesting and useful to analyze the spatial distribution patterns of specific crops, such as maize, wheat, or sorghum.

To build the Final Report vignette, run the following code in R.

```{r}
library(devtools)
install_github("agroimpacts/zambiags", build_vignettes = TRUE)
browseVignettes("zambiags")
```

To view the slides used in presenting this projcet, follow the external/slides folder path.

To access the Phenology data used in this analysis, follow the link below.  
https://airg.app.box.com/s/6cvc4cb4h4d0b1iny5jlmzbxk1phako3
