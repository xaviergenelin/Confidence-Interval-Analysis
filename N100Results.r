ggplot(waldResults, aes(x = X1, y = X4)) + 
  geom_line(color = "blue") + 
  ggtitle("Proportion containing with n = 100 Wald ") +
  xlab("p") +
  ylab("Proportion") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_hline(yintercept = 0.95) 
ggplot(adjWaldResults, aes(x = X1, y = X4)) + 
  geom_line(color = "red") + 
  ggtitle("Proportion containing with n = 100 Adjusted Wald") +
  xlab("p") +
  ylab("Proportion") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_hline(yintercept = 0.95) 
ggplot(exactResults, aes(x = X1, y = X4)) + 
  geom_line(color = "orange") + 
  ggtitle("Proportion containing with n = 100 Exact") +
  xlab("p") +
  ylab("Proportion") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_hline(yintercept = 0.95) 
ggplot(scoreResults, aes(x = X1, y = X4)) + 
  geom_line(color = "black") + 
  ggtitle("Proportion containing with n = 100 Raw Precentile Bootstrap") +
  xlab("p") +
  ylab("Proportion") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_hline(yintercept = 0.95) 
ggplot(bootRawResults, aes(x = X1, y = X4)) + 
  geom_line(color = "green") + 
  ggtitle("Proportion containing with n = 100 Raw Percentile Bootstrap") +
  xlab("p") +
  ylab("Proportion") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_hline(yintercept = 0.95) 
ggplot(bootTResults, aes(x = X1, y = X4)) + 
  geom_line(color = "purple") + 
  ggtitle("Proportion containing with n = 100 Bootstrap T") +
  xlab("p") +
  ylab("Proportion") +
  xlim(0, 1) +
  ylim(0, 1) +
  geom_hline(yintercept = 0.95)

  ggplot() +
  geom_line(data = waldResults, aes(x = X1, y = X5), color = "blue") +
  geom_line(data = adjWaldResults, aes(x = X1, y = X5), color = "red") +
  geom_line(data = exactResults, aes(x = X1, y = X5), color = "orange") +
  geom_line(data = scoreResults, aes(x = X1, y = X5), color = "black") + 
  geom_line(data = bootRawResults, aes(x = X1, y = X5), color = "green") +
  geom_line(data= bootTResults, aes(x = X1, y = X5), color = "purple") +
  ggtitle("Average Width with n = 100") +
  xlab("p") +
  ylab("Proportion")