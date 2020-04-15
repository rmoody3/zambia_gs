library(geospaar)

plant_mean <- raster("plant_mean.tif")
plant_mean
negative_ras <- (plant_mean > 365) * -365
plant_mean_corrected <- plant_mean + negative_ras
plant_mean_corrected


#zonal statistics by district
districts <- system.file("extdata/districts.shp", package = "geospaar") %>%
  st_read
zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
values(zamr) <- 1:ncell(zamr)
districts <- districts %>% mutate(ID = 1:nrow(.))
distsr <- districts %>% rasterize(x = ., y = zamr, field = "ID") %>% print()

plot_noaxes(distsr)

distsr_rs <- resample(x = distsr, y = plant_mean_corrected, method = "ngb")
zonemu <- zonal(x = plant_mean_corrected, z = distsr_rs, fun = "mean")

distr_rfmu <- zonemu %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")
plot_noaxes(distr_rfmu)

?raster::extract
