### Initial Setup ###
library(ggplot2)
library(plyr)
library(gridExtra)
N <- 1500
B <- 200
sizes <- c(15, 100, 200)
probabilities <- seq(from = 0.01, to = 0.99, by = 0.01)