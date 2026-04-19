# fig_lottery_member.R
# generate a figure we use in the data section
# lottery choice by before / after

source("analysis/sample_info.R")
source("analysis/analysis_common.R")

lf.cols <- master_participants_dta %>% 
  select(ya_member_fct, lottery) %>%
  filter(!is.na(lottery)) %>%
  group_by(ya_member_fct, lottery) %>% 
  summarize(n=n())

# a black and white version for print
ggplot(lf.cols) + geom_bar(stat="identity",position="dodge",
                           aes(lottery,n,fill=ya_member_fct)) +
  labs(x="Gamble Chosen", 
       y="Number of Participants", 
       fill="Cooperative Member") +
  scale_fill_grey()

ggsave(str_c(f.path.paper, "lottery.member.png"))

# a color version for the slides
ggplot(lf.cols) + geom_bar(stat="identity",position="dodge",
                           aes(lottery,n,fill=ya_member_fct)) +
  labs(x="Gamble Chosen", 
       y="Number of Participants", 
       fill="Cooperative Member") 

ggsave(str_c(f.path.slides, "lottery.member.png"))