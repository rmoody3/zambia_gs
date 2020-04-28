plantbrick <- brick("external/data/plantbrick.tif")
harvbrick <- brick("external/data/harvestbrick.tif")

seasonlength <- lapply(1:18, function(x) {
  r <- harvbrick[[x]] - plantbrick[[x]]
  return(r)
})

seasonlength <- stack(seasonlength)

if(!canProcessInMemory(seasonlength)) {
  slength_brick <- brick(x = seasonlength, filename = "external/data/slength_brick.tif")
} else {
  slength_brick <- brick(seasonlength)
  save(slength_brick, file = "data/slength_brick.rda")
}

slength_brick <- brick("external/data/slength_brick.tif")
slength_mean <- slength_brick %>% calc(., mean)
save(slength_mean, file = "data/slength_mean.rda")

data("distsr_rs")
data("slength_mean")
slength_zonalmean <- zonal(x = slength_mean, z = distsr_rs, fun = "mean")
slength_distmean <- slength_zonalmean %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")

par( mar = c(0, 1, 1, 0))
plot(slength_distmean, main = "Mean Season Length",
     axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))

'''
slength <- overlay(harvbrick, plantbrick,
                   fun = function(b1, b2){return(b1 - b2)})
slength_mean <- slength %>% calc(., mean)

data("distsr_rs")
slength_zonalmean <- zonal(x = slength_mean, z = distsr_rs, fun = "mean")
slength_distmean <- slength_zonalmean %>% data.frame %>% select(1:2) %>%
  subs(x = distsr_rs, y = ., by = "zone")

par(mfrow = c(1, 2), mar = c(0, 1, 1, 1))
plot(slength_distmean, main = "Mean Season Length",
     axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))
'''
