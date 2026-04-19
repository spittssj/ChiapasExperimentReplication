# fig_avg_share_extra.R
# generate a figure we use in the data section
# average share by treatment status (extra income)
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

# build the figure -> outcome variable by extra income treatment
ggplot(master_participants_dta) + geom_density(aes(share_avg, after_stat(scaled), 
                                          linetype=extra_fct)) +
  labs(x="Average Share to Certain-Price Buyer over 60 Rounds", y="Density", 
       linetype="Additional Income Treatment")
ggsave(str_c(f.path.paper, "avg_share.extra.png"))

# build the figure -> outcome variable by cooperative membership status
ggplot(master_participants_dta) + 
  geom_density(aes(share_avg, after_stat(scaled), linetype=ya_member_fct)) +
  labs(x="Average Share to Certain-Price Buyer over 60 Rounds", y="Density", 
       linetype="Cooperative Member") 
ggsave(str_c(f.path.paper, "avg_share.yamember.png"))
