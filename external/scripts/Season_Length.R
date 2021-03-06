library(geospaar)

districts <- system.file("extdata/districts.shp", package = "geospaar")%>%
  st_read
plantbrick <- brick("external/data/plantbrick.tif")
harvbrick <- brick("external/data/harvestbrick.tif")

# overlay function for large raster bricks
slength <- overlay(harvbrick, plantbrick,
                   fun = function(b1, b2){return(b1 - b2)})
save(slength,
     file = "C:/Users/Rowan/Documents/R/zambiags/data/slength.rda")
data("slength")
slength_mean <- slength %>% calc(., mean)
save(slength_mean,
     file = "C:/Users/Rowan/Documents/R/zambiags/data/slength_mean.rda")

# Plot the mean Zambia season lengths
par(mfrow = c(1, 1), mar = c(0, 2, 1, 2))
plot(st_geometry(districts), col = "lightgrey", reset = FALSE,
     main = "Mean Season Length")
plot(slength_mean, axes = FALSE, box = FALSE,
     add = TRUE, col = rev(terrain.colors(10)))

# Rasterize and resample districts data to season length extent
zamr <- raster(x = extent(districts), crs = crs(districts), res = 0.1)
values(zamr) <- 1:ncell(zamr)
districts <- districts %>% mutate(ID = 1:nrow(.))
distsr <- districts %>% rasterize(x = ., y = zamr, field = "ID") %>% print()
distsr_rs <- resample(x = distsr, y = slength_mean, method = "ngb")

data("distsr_rs")
data("slength_mean")
# Calculate the zonal season length mean
slength_zonemu <- zonal(x = slength_mean, z = distsr_rs, fun = "mean")

# Rasterize zonal season length mean
distr_slmu <- slength_zonemu %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")
save(distr_slmu,
     file = "C:/Users/Rowan/Documents/R/zambiags/data/distr_slmu.rda")

# Plot zonal season length mean
par(mfrow = c(1, 1), mar = c(0, 2, 1.5, 2))
plot(distr_slmu, main = "Mean Season Length",
     axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))

