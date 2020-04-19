library("geospaar")
maskrr <- raster("external/data/ZAM_crsipCrop_2015_b1.rst")
plant <- dir("external/data/phenology/season_planting_date_30perc/", full.names = TRUE)
harv <- dir("external/data/phenology/season_end_30perc/", full.names = TRUE)
plant_ras <- lapply(plant, raster)

#plot_noaxes(maskr)
#plant_ras[[1]]
#maskr_proj <- projectRaster(maskr, plant_ras[[1]])
#test1 <- resample(maskr, plant_ras[1])
#?resample

plant_stack <- stack(plant_ras)
harv_ras <- lapply(harv, raster)
harv_stack <- stackSelect(harv_ras)

mask_proj <- projectRaster(from = maskrr, to = plant_stack)
crop_mask <- reclassify(mask_proj, c(.75, 1, 1, -1, .7499, NA))

plant_masked <- mask(x = plant_stack, mask = crop_mask)
harv_masked <- mask(x = harv_stack, mask = crop_mask)
plot(maskr)
