### Bootstrap t Interval
B <- 200 # Bootstrap samples
sizes <- c(15, 100, 200)
N <- 1500
bootTResults <- data.frame(matrix(ncol = 2*length(sizes) + 1, nrow = length(probabilities))) # creates an empty data frame to store the results
bootTResults[,1] <- probabilities # stores the probabilities in column 1 
column <- 1
for(n in sizes){
  element <- 0 # resets the element value to 0 so we end up with 99 values at the end for the proportion and avgWidths vectors
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
    tStats <- as.numeric() # creates an empty vector to store the tStats values from the bootstrap
    bootSE <- as.numeric() # craetes an empty vector to store the bootSE values from the bootstrap
    SEphat <- as.numeric() # creates an empty vector to store the SEphat values from the bootstrap
    for(i in 1:B){
      phat[i] <- bootData[i]/n # loops through the 200 bootstrap values and stores them in the vector phat
      bootSE[i] <- sqrt((phat[i]*(1-phat[i]))/n) # Create a standard error for each of the bootstrap samples
      tStats[i] <- (phat[i] - p0)/bootSE[i] # Create a tStat for each of the 200 bootstraps
    }
    phat <- phat[!is.na(phat)] # Remove any phat values that are NA
    SEphat <- sqrt((1/B)*sum((phat-mean(phat))^2)) # Calculate the standard error for alpha hat to be used in the interval calculation
    tStats <- tStats[!is.infinite(tStats)] # Remove any Inf or -Inf values from the tStats
    bootCIs[j,2] <- p0-quantile(tStats, 0.025, na.rm = TRUE)*SEphat
    bootCIs[j,1] <- p0-quantile(tStats, 0.975, na.rm = TRUE)*SEphat
  }
  bootCIs <- na.omit(bootCIs)
  contained <- (bootCIs[,1] < p) & (p < bootCIs[,2]) # calculates the number of p values contained within the bootstrap intervals
  contained <- sum(contained)
  proportion[element] <- contained/N # Calculate the proportion contained in the interval for each p value
  avgWidths[element] <- mean(bootCIs[,2] - bootCIs[,1]) # Calculate the average widths of each interval and take the average for each p value

}
  
  bootTResults[,column] <- proportion # Store the proportion contained for size n in the even columns
  column <- column + 1
  bootTResults[,column] <- avgWidths # Sore the average width of the interval for size n in the odd columns
}