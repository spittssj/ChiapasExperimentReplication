# fig_pricedistribution.R
# Price distributions

library(tidyverse)

x_breaks <- seq(30,70,5)
pdist <- function(prices, color, filename) {
  p2.dist <- tibble(price2=prices)
  p2.plot <- ggplot(p2.dist) + 
    geom_histogram(aes(price2), fill=color, binwidth=2.5) + 
    xlab("Price") + ylab("Frequency") +
    scale_x_continuous(breaks=x_breaks,
                       limits=c(30,70))
  ggsave(filename, plot=p2.plot, width=9, height=9, units="in")
}

# the ones we used in the pilot
#pdist(c(30,50,50,70), "red", "p2_dist1.png")
#pdist(c(50,70,70,90), "red", "p2_dist2.png")
#pdist(c(70,90,90,110), "red", "p2_dist3.png")

# new ones
scenario1 <- c(40,45,45,45,50,50,50,50,55,55,55,60)
scenario2 <- scenario1 + 5
scenario3 <- scenario1 - 5

pdist(scenario1, "blue", "figures/scenario1.png")
pdist(scenario2, "blue", "figures/scenario2.png")
pdist(scenario3, "blue", "figures/scenario3.png")



