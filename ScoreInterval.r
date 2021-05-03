### Score Interval 
scoreResults <- data.frame(matrix(ncol = 2*length(sizes)+1, nrow = length(probabilities))) #empty data frame for score interval results
proportion <- as.numeric()
avgWidths <- as.numeric()
scoreResults[,1]<- probabilities #store probabilities from 0.01 to 0.99 in first col
element <- 0
column <- 1
# Function to calculate the Score interval
scoreCI <-  function(y, n, alpha=0.05) {
  lower <- (y/n+qnorm(1-alpha/2)^2/(2*n)-qnorm(1-alpha/2)*sqrt((y/n*(1-y/n)+qnorm(1-alpha/2)^2/(4*n))/n)) / (1+qnorm(1-alpha/2)^2/n)
  upper <- (y/n+qnorm(1-alpha/2)^2/(2*n)+qnorm(1-alpha/2)*sqrt((y/n*(1-y/n)+qnorm(1-alpha/2)^2/(4*n))/n)) / (1+qnorm(1-alpha/2)^2/n)
  c(lower, upper)
}

for(n in sizes){
  alpha <- 0.05
  element <- 0
  column <- column + 1
  proportion <- as.numeric()
  avgWidths <- as.numeric()
  for(p in probabilities){
    element <- element + 1
    x <- rbinom(n = 1500, size = n, prob = p)
    contained <- as.numeric()
    widths <- as.numeric()
    for(i in 1:1500){
      scoreCIs <- scoreCI(x[i], n)
      contained[i] <- (scoreCIs[1] < p) & (p < scoreCIs[2])
      widths[i] <- mean(scoreCIs[2] - scoreCIs[1])
    }
    proportion[element] <- mean(contained)
    avgWidths[element] <- mean(widths)
  }
  scoreResults[,column] <- proportion
  column<- column + 1
  scoreResults[,column]<- avgWidths
}