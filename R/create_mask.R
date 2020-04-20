library("raster")
maskr <- raster("external/data/cropland/CropZmb1V1_2015_16_fullagree.tif")
plant <- dir("external/data/phenology/season_planting_date_30perc/", full.names = TRUE)
harv <- dir("external/data/phenology/season_end_30perc/", full.names = TRUE)
plant_ras <- lapply(plant, raster)
plant_stack <- brick(plant_ras)
harv_ras <- lapply(harv, raster)
harv_stack <- brick(harv_ras)

mask_proj <- projectRaster(from = maskr, to = harv_masked)
crop_mask <- reclassify(mask_proj, c(.75, 1, 1, -1, .7499, NA))

plant_masked <- mask(x = plant_stack, mask = crop_mask)
harv_masked <- mask(x = harv_stack, mask = crop_mask)
cellStats(plant_masked, stat = 'mean', na.rm = TRUE)

plant_mean
negative_ras <- (plant_mean > 365) * -365
plant_mean_corrected <- plant_mean + negative_ras
plant_mean_corrected
