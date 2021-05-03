The goal of the project was to estimate the probability of success, p, from a Binomial random sample and compare different interval procedures that attempt to catpure p. The following methods were used in this project:
* Wald Interval
* Adjusted Wald Interval
* Clopper-Pearson (exact) Interval
* Score Interval
* Raw Percentile Interval using a parametric bootstrap
* Bootstrap t Interval using a parametric bootstrap

We are checking each interval for multiple values of p (0.01 to 0.99 in increments of 0.01) as well as using various sample sizes (15, 100, 200). From each interval, we get the proportion of intervals that capture the true value and the average length of the interval and do a comparison to see which interval is best.