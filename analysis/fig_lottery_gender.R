# fig_lottery_gender.R
# generate a figure we use in the data section
# lottery choice by gender
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

lf.cols <- master_participants_dta %>% 
  select(gender_fct, lottery) %>%
  filter(!is.na(lottery)) %>%
  group_by(gender_fct, lottery) %>% 
  summarize(n=n())

# a black and white version for print
ggplot(lf.cols) + geom_bar(stat="identity",position="dodge",
                           aes(lottery,n,fill=gender_fct)) +
  labs(x="Gamble Chosen", 
       y="Number of Participants", 
       fill="Gender") +
  scale_fill_grey()

ggsave(str_c(f.path.paper, "lottery.gender.png"))

# a color version for the slides
ggplot(lf.cols) + geom_bar(stat="identity",position="dodge",
                           aes(lottery,n,fill=gender_fct)) +
  labs(x="Gamble Chosen", 
       y="Number of Participants", 
       fill="Gender") 

ggsave(str_c(f.path.slides, "lottery.gender.png"))
