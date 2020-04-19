library(geospaar)

#plant_mean <- raster("plant_mean.tif")
#plant_mean <- plant_masked2 %>% calc(., mean)
#harv_mean <- harv_masked2 %>% calc(., mean)
#plot_noaxes(plant_mean)
#plot_noaxes(harv_mean)


plant_rasnegative <- (plant_mean > 365) * -365
plant_mean_corrected <- plant_mean + plant_rasnegative
harv_rasnegative <- (harv_mean > 365) * -365
harv_mean_corrected <- harv_mean + harv_rasnegative


#hist(plant_mean_corrected, plot = TRUE)
#hist(harv_mean_corrected, plot = TRUE)

#zonal statistics by district
districts <- system.file("extdata/districts.shp", package = "geospaar") %>%
  st_read
zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
values(zamr) <- 1:ncell(zamr)
districts <- districts %>% mutate(ID = 1:nrow(.))
distsr <- districts %>% rasterize(x = ., y = zamr, field = "ID") %>% print()



distsr_rs <- resample(x = distsr, y = plant_mean_corrected, method = "ngb")
plant_zonemu <- zonal(x = plant_mean_corrected, z = distsr_rs, fun = "mean")
harv_zonemu <- zonal(x = harv_mean_corrected, z = distsr_rs, fun = "mean")

distr_plmu <- plant_zonemu %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")
#distr_hamu <- harv_zonemu %>% data.frame %>% select(1:2) %>%
#  subs(x = distsr_rs, y = ., by = "zone")
