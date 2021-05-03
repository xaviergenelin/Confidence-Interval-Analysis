### Adjusted Wald Interval
# Function to calculate the adjusted Wald interval
adjustedWaldCI <- function(y, n, alpha = 0.05){
  cbind((y + 2)/(n + 4) - qnorm(1-alpha/2)*sqrt((((y + 2)/(n + 4))*(1-(y + 2)/(n + 4)))/(n + 4)),
  (y + 2)/(n + 4) + qnorm(1-alpha/2)*sqrt((((y + 2)/(n + 4))*(1-(y + 2)/(n + 4)))/(n + 4)))
}

# Works for all p values and all n
columnProb <- 0
columnAvg <- 1
adjWaldResults <- data.frame(matrix(ncol = 2*length(sizes)+1, nrow = length(probabilities)))
adjWaldResults[,1] <- probabilities

for(j in sizes){
  row <- 0 # resets the row count to 0
  columnProb <- columnProb + 2
  columnAvg <- columnAvg + 2
  for(i in probabilities){ # loops through all the probabilities from 0.01 to 0.99 in increments of 0.01
    row <- row + 1 # this will be used in the results matrix, each row will have the proportion contained in the CIs
    n <- j
    X <- rbinom(1500, n, i)
    adjWaldCIs <- adjustedWaldCI(X, n) # Store results in a matrix
    probContain <- mean((adjWaldCIs[,1] <= i)*(adjWaldCIs[,2]>= i)) # Determines the proportion contained within the CIs
    avgWidth <- mean(adjWaldCIs[,2]-adjWaldCIs[,1]) # Average width of the CIs
    adjWaldResults[row,columnProb] <- probContain # Stores the proportion contianed in the first column for probaility i
    adjWaldResults[row,columnAvg] <- avgWidth # Stores the average width of the CIs in the second column for probability i
  }
}