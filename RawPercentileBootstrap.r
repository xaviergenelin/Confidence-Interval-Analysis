### Bootstrap Raw Percentile ###
# Trying for all sizes 
B <- 200 # Bootstrap samples
sizes <- c(15, 100, 200)
N <- 1500
bootRawResults <- data.frame(matrix(ncol = 2*length(sizes) + 1, nrow = length(probabilities)))
bootRawResults[,1] <- probabilities
column <- 1
for(n in sizes){
  element <- 0
  column <- column + 1
  proportion <- as.numeric()
  avgWidths <- as.numeric()
    for(p in probabilities){
      element <- element + 1 # used later to save the proportion contained in a vector
      x <- rbinom(n = N, size = n, prob = p) # Generates 1500 samples of size n and probability p in the loop
      bootCIs <- data.frame(matrix(ncol = 2, nrow = length(N))) # creates an empty data frame to store the bootstrap results
      for(j in 1:N){
        p0 <- x[j]/n # creates our sampled proportion p for j in the 1500 samples created
        bootData <- rbinom(n = B, size = n, prob = p0) # creates 200 bootstrap samples from the p0
        phat <- as.numeric() # creates an empty vector to store the phat values from the bootstrap
        for(i in 1:B){
          phat[i] <- bootData[i]/n # loops through the 200 bootstrap values and stores them in the vector phat
        }
        bootCIs[j,1] <- quantile(phat, 0.025) # gets the lower limit of the bootstrap phat values
        bootCIs[j,2] <- quantile(phat, 0.975) # gets the upper limit of the bootstrap phat values
      }
      contained <- (bootCIs[,1] < p) & (p < bootCIs[,2]) # calculates the number of p values contained within the bootstrap intervals
      contained <- sum(contained)
      proportion[element] <- contained/N # Calculate the proportion contained in the interval for each p value
      avgWidths[element] <- mean(bootCIs[,2] - bootCIs[,1]) # Calculate the average widths of each interval and take the average for each p value
    
    }
  
  bootRawResults[,column] <- proportion
  column <- column + 1
  bootRawResults[,column] <- avgWidths
}