# fig_avg_share_histogram.R
# generate two figures we use in the data section
# average share by treatment status (extra income)
# these are histograms (which might be easier to read)
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

# group by decile and by extra income status
binned_extra <- master_participants_dta %>% 
  select(share_avg, extra_fct) %>% 
  mutate(bin=cut(share_avg, include.lowest=TRUE, breaks=seq(0,1,0.1))) %>% 
  group_by(bin, extra_fct) %>% summarize(n=n()) %>%
  ungroup() %>%
  complete(bin, extra_fct, fill=list(n=0), explicit=FALSE) %>%
  filter(!is.na(bin)) 

# generate a column chart
extra_hist_slides <- ggplot(binned_extra) + 
  geom_col(aes(bin, n, fill=extra_fct), position="dodge") +
  scale_x_discrete(guide=guide_axis(angle=45)) +
  labs(x="Average Share to Certain-Price Buyer over 60 Rounds", y="Count", 
              fill="Additional Income") +
  geom_vline(xintercept=8.2, show.legend = TRUE) +
  annotate("text", x=8, y=50, label="Sample Mean (82%)", angle=90)

ggsave(str_c(f.path.slides, "avg_share.extra.hist.png"),
       plot=extra_hist_slides)

extra_hist_paper <- extra_hist_slides + scale_fill_grey()

ggsave(str_c(f.path.paper, "avg_share.extra.hist.png"),
       plot=extra_hist_paper)


# we will weight the results below
# master_participants_dta %>% group_by(ya_member_fct) %>% summarize(n=n()) 
# result is 142 non-members and 126 members
f.no <- factor("No", levels=c("No", "Yes"))
f.yes <- factor("Yes", levels=c("No", "Yes"))

bins_total <- tribble(~ya_member_fct, ~total,
        f.no, 142, 
        f.yes, 126)

# group by decile and by cooperative membership status
binned_coop <- master_participants_dta %>% 
  select(share_avg, ya_member_fct) %>% 
  mutate(bin=cut(share_avg, include.lowest=TRUE, breaks=seq(0,1,0.1))) %>% 
  group_by(bin, ya_member_fct) %>% summarize(n=n()) %>%
  ungroup() %>%
  complete(bin, ya_member_fct, fill=list(n=0), explicit=FALSE) %>%
  filter(!is.na(bin)) %>%
  left_join(bins_total) %>% 
  mutate(n_weighted=n/total)

# generate a plot
member_hist_slides <- ggplot(binned_coop) + 
  geom_col(aes(bin, n_weighted, fill=ya_member_fct), position="dodge") +
  scale_x_discrete(guide=guide_axis(angle=45)) +
  geom_vline(xintercept=8.2, show.legend = TRUE) +
  annotate("text", x=8, y=0.5, label="Sample Mean (82%)", angle=90) +
  labs(x="Average Share to Certain-Price Buyer over 60 Rounds", y="Share", 
       fill="Cooperative Member") 

ggsave(str_c(f.path.slides, "avg_share.yamember.hist.png"),
       plot = member_hist_slides)

member_hist_paper <- member_hist_slides + scale_fill_grey()

ggsave(str_c(f.path.paper, "avg_share.yamember.hist.png"),
       plot=member_hist_paper)

