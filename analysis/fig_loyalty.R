# fig_loyalty.R
# generate a histogram of loyalty
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

# grab the loyalty values for the subset of participants who are
# cooperative members
lf.cols <- master_participants_dta %>% 
  select(loyalty) %>% 
  filter(!is.na(loyalty))

# generate the bar chart
ggplot(lf.cols) + geom_bar(aes(loyalty)) +
    labs(x="Number of Years Sold to Cooperative", 
       y="Number of Participants") +
  scale_x_continuous(limits=c(0,15))

# save the chart
ggsave(str_c(f.path.paper, "loyalty.png"))
ggsave(str_c(f.path.slides, "loyalty.png"))

