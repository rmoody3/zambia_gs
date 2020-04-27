

##calculate distict mean across stack files

#Zonal Statistics by Districts
#Import district data, rasterize, and resample to planting/harvest data extent
data("distsr_rs")
data("crop_mask")
crop_mask[crop_mask == 0] <- NA
plantbrick <- brick("external/data/plantbrick.tif")
harvbrick <- brick("external/data/harvestbrick.tif")

##Calculating spatial mean before temporal
#Calculate mean planting/harvest dates by district
plantseas_zonemu <- zonal(x = plantbrick, z = distsr_rs, fun = "mean")
harvseas_zonemu <- zonal(x = harvbrick, z = distsr_rs, fun = "mean")

#Convert zonal statistics back into raster format
plantdistr_mu <- plant_zonemu %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")
harvdistr_mu <- harv_zonemu %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")
#save(plantdistr_mu,
#     file = "C:/Users/Rowan/Documents/R/zambiags/data/plantdistr_mu.rda")
#save(harvdistr_mu,
#     file = "C:/Users/Rowan/Documents/R/zambiags/data/harvdistr_mu.rda")
data("plantdistr_mu")
data("harvdistr_mu")

plant_mean_ds <- plantdistr_mu %>% calc(., mean)
harv_mean_ds <- harvdistr_mu %>% calc(., mean)
#Correct for multiyear season dates
plant_rasnegative <- (plant_mean_ds > 365) * -365
plant_mean_ds_corrected <- plant_mean_ds + plant_rasnegative
harv_rasnegative <- (harv_mean_ds > 365) * -365
harv_mean_ds_corrected <- harv_mean_ds + harv_rasnegative
#save(plant_mean_ds_corrected,
#     file = "C:/Users/Rowan/Documents/R/zambiags/data/plant_mean_ds_corrected.rda")
#save(harv_mean_ds_corrected,
#     file = "C:/Users/Rowan/Documents/R/zambiags/data/harv_mean_ds_corrected.rda")
data("plant_mean_ds_corrected")
data("harv_mean_ds_corrected")

#Plot mean planting/harvest dates by district
par(mfrow = c(1, 2), mar = c(0, 2, 1, 6))
plot(plant_mean_ds_corrected, main = "Mean Planting Date",
     axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))
plot(harv_mean_ds_corrected, main = "Mean Harvesting Date",
     axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))
