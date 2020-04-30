
## This is one script
library(geospaar)

#Load data
plant <- dir("external/data/phenology/season_planting_date_30perc/",
             pattern = "season", full.names = TRUE)
harv <- dir("external/data/phenology/season_end_30perc/",
            pattern = "season", full.names = TRUE)
data("crop_mask")
districts <- system.file("extdata/districts.shp", package = "geospaar")%>%
  st_read
crop_mask[crop_mask == 0] <- NA

#Convert to raster and stack
#plant_ras <- lapply(plant, raster)
plant_ras <- lapply(plant, function(x) {  # x <- 1
  r <- raster(x)
  r[r < 0] <- NA
  r <- mask(x = r, mask = crop_mask)
  # plot(r)
  return(r)
})
plant_ras <- stack(plant_ras)

if(!canProcessInMemory(plant_ras)) {
  plantbrick <- brick(x = plant_ras, filename = "external/data/plantbrick.tif")
} else {
  plantbrick <- brick(plant_ras)
  save(plantbrick, file = "data/plantbrick.rda")
}


#harv_ras <- lapply(harv, raster)
harv_ras <- lapply(harv, function(x) {
  r <- raster(x)
  r[r < 0] <- NA
  r <- mask(x = r, mask = crop_mask)
  return(r)
})
harv_ras <- stack(harv_ras)

if(!canProcessInMemory(harv_ras)) {
  harvestbrick <- brick(harv_ras, filename = "external/data/harvestbrick.tif")
} else {
  harvestbrick <- brick(harv_ras)
  save(harvestbrick, file = "data/harvestbrick.rda")
}

#Mask to cropland area
# plant_masked2 <- mask(x = plant_stack, mask = crop_mask)
# harv_masked2 <- mask(x = harv_stack, mask = crop_mask)
# save(plant_masked2, file = "data/plant_masked2.rda")
# save(harv_masked2, file = "data/harv_masked2.rda")
