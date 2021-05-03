### Wald Interval
# Function to calculate the Wald Interval
waldCI <- function(y, n, alpha = 0.05){
  cbind(y/n - qnorm(1-alpha/2)*sqrt(((y/n)*(1-y/n))/n),
  y/n + qnorm(1-alpha/2)*sqrt(((y/n)*(1-y/n))/n))
}

# Works for all p values and all n
columnProb <- 0
columnAvg <- 1
waldResults <- data.frame(matrix(ncol = 2*length(sizes)+1, nrow = length(probabilities)))
waldResults[,1] <- probabilities

for(n in sizes){
  row <- 0 # resets the row count to 0
  columnProb <- columnProb + 2
  columnAvg <- columnAvg + 2
  for(i in probabilities){ # loops through all the probabilities from 0.01 to 0.99 in increments of 0.01
    row <- row + 1 # this will be used in the results matrix, each row will have the proportion contained in the CIs
    X <- rbinom(1500, n, i)
    waldCIs <- waldCI(X, n) # Store results in a matrix
    probContain <- mean((waldCIs[,1] <= i)*(waldCIs[,2]>= i)) # Determines the proportion contained within the CIs
    avgWidth <- mean(waldCIs[,2]-waldCIs[,1]) # Average width of the CIs
    waldResults[row,columnProb] <- probContain # Stores the proportion contianed in the first column for probaility i 
    waldResults[row,columnAvg] <- avgWidth # Stores the average width of the CIs in the second column for probability i 
  }
}