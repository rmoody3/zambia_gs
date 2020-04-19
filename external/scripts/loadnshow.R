library(geospaar)
districts <- system.file("extdata/districts.shp", package = "geospaar") %>%
  st_read
#load data by cell
data("plant_mean_corrected")
data("harv_mean_corrected")

#Plot Zambia mean planting and harvest dates
par(mfrow = c(1, 2), mar = c(0, 2, 1, 5))
plot(st_geometry(districts), col = "lightgrey", reset = FALSE, main = "Mean Planting Date")
plot(plant_mean_corrected, axes = FALSE, box = FALSE, legend = FALSE, add = TRUE)
plot(st_geometry(districts), col = "lightgrey", reset = FALSE, main = "Mean Harvesting Date")
plot(harv_mean_corrected, axes = FALSE, box = FALSE, add = TRUE)

#load data by district
data("distr_plmu")
data("distr_hamu")

#Plot mean planting/harvest dates by district
par(mfrow = c(1, 2), mar = c(0, 2, 1, 6))
plot(distr_plmu, main = "Mean Planting Date",
     axes = FALSE, box = FALSE)
plot(distr_hamu, main = "Mean Harvesting Date",
     axes = FALSE, box = FALSE)
