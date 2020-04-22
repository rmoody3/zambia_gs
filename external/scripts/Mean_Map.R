## This is a separate script
# new script after building package
#Calculate mean planting and harvest dates across seasons
library(zambiags)
plantbrick <- brick("external/data/plantbrick.tif")
plant_mean <- plantbrick %>% calc(., mean)
rm(plant_ras)

harvbrick <- brick("external/data/harvestbrick.tif")
harv_mean <-  harvbrick %>% calc(., mean)
rm(harv_ras)

#Correct for multiyear season dates
plant_rasnegative <- (plant_mean > 365) * -365
plant_mean_corrected <- plant_mean + plant_rasnegative
harv_rasnegative <- (harv_mean > 365) * -365
harv_mean_corrected <- harv_mean + harv_rasnegative
#save(plant_mean_corrected, file = "C:/Users/Rowan/Documents/R/zambiags/data/plant_mean_corrected")
#save(harv_mean_corrected, file = "C:/Users/Rowan/Documents/R/zambiags/data/harv_mean_corrected")

#Plot Zambia mean planting and harvest dates
par(mfrow = c(1, 2), mar = c(0, 2, 1, 5))
plot(st_geometry(districts), col = "lightgrey", reset = FALSE,
     main = "Mean Planting Date")
plot(plant_mean_corrected, axes = FALSE, box = FALSE, add = TRUE)
plot(st_geometry(districts), col = "lightgrey", reset = FALSE,
     main = "Mean Harvesting Date")
plot(harv_mean_corrected, axes = FALSE, box = FALSE, add = TRUE)
#Zonal Statistics by Districts
#Import district data, rasterize, and resample to planting/harvest data extent
zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
values(zamr) <- 1:ncell(zamr)
districts <- districts %>% mutate(ID = 1:nrow(.))
distsr <- districts %>% rasterize(x = ., y = zamr, field = "ID") %>% print()
distsr_rs <- resample(x = distsr, y = plant_mean_corrected, method = "ngb")

#Calculate mean planting/harvest dates by district
plant_zonemu <- zonal(x = plant_mean_corrected, z = distsr_rs, fun = "mean")
harv_zonemu <- zonal(x = harv_mean_corrected, z = distsr_rs, fun = "mean")

#Convert zonal statistics back into raster format
distr_plmu <- plant_zonemu %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")
distr_hamu <- harv_zonemu %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")
#save(distr_plmu, file = "C:/Users/Rowan/Documents/R/zambiags/data/distr_plmu.rda")
#save(distr_hamu, file = "C:/Users/Rowan/Documents/R/zambiags/data/distr_hamu.rda")

#Plot mean planting/harvest dates by district
par(mfrow = c(1, 2), mar = c(0, 2, 1, 6))
plot(distr_plmu, main = "Mean Planting Date",
     axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))
plot(distr_hamu, main = "Mean Harvesting Date",
     axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))
