### Clopper-Pearson Exact Interval
exactResults <- data.frame(matrix(ncol = 2*length(sizes) + 1, nrow = length(probabilities))) # create an empty data frame to store the end results
proportion <- as.numeric()
avgWidths <- as.numeric()
exactResults[,1] <- probabilities # store the probabilities (0.01, 0.99) in the first column
element <- 0
column <- 1
for (n in sizes){
  element <- 0
  column <- column + 1
  proportion <- as.numeric() # empties the proportion vector
  avgWidths <- as.numeric() # empties the avgWidths vector
  for (p in probabilities){
    element <- element + 1 # as p cycles through the probabilities in (0.01, 0.99) this adds up
    x <- rbinom(n = 1500, size = n, prob = p)
    contained <- as.numeric() # empties the contained vecotr
    widths <- as.numeric() # empties the widths vector
    for(i in 1:1500){
        if(x[i] == 0){ # Sets the upper and lower limits to 0 if the value x from the binomial distrubtion is 0
          lowerLim <- 0
          upperLim <- 0
        } else
          if(x[i] == n){ # Sets the upper and lower limits to 1 if the value x from the binomial distrubtion is the same as the sample size n
            lowerLim <- 1
            upperLim <- 1
          } else{ # when x <> 0 or x <> n then use the exact interval
        lowerLim <- 1/(1 + (n - x[i] + 1) / (x[i] * qf(0.05/2, 2 * x[i], 2 * (n - x[i] + 1)))) # calculates the lower limit of the interval
        upperLim <- 1/(1 + (n - x[i]) / ((x[i] + 1) * qf(1-0.05/2, 2 * (x[i] + 1), 2 * (n - x[i])))) # calculates the upper limit of the interval
          }
        contained[i] <- (lowerLim < p) & (p < upperLim)
        widths[i] <- mean(upperLim - lowerLim)
    }
    proportion[element] <- mean(contained)
    avgWidths[element] <- mean(widths)
  }
  exactResults[,column] <- proportion
  column <- column + 1
  exactResults[,column] <- avgWidths
}