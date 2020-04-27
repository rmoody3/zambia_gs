library(geospaar)
data("plant_mean_corrected")
data("harv_mean_corrected")

data("distr_plmu")
data("distr_hamu")


#plot mean point season lengths
season_lng_pt_abs <- abs(plant_mean_corrected - harv_mean_corrected)

par(mar = c(0, 0, 1, 0))
plot(st_geometry(districts), col = "lightgrey", reset = FALSE,
     main = "Season Length 1")
plot(season_lng_pt_abs, axes = FALSE, box = FALSE, add = TRUE)

#plot mean district season lengths
season_lng_dist <- distr_plmu - distr_hamu
#save(season_lng_dist,
#     file = "C:/Users/Rowan/Documents/R/zambiags/data/season_lng_dist.rda")

data("season_lng_dist")
  plot_noaxes(season_lng_dist, main = "Mean Season Length",
              axes = FALSE, box = FALSE, col = rev(terrain.colors(10)))
  #plot(season_lng_pt_abs, axes = FALSE, box = FALSE, add = TRUE)
