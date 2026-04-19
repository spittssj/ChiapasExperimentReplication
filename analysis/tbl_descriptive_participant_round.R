# tbl_descriptive_participant_round.R: 
# build the descriptive statistics at the participant-round level
# we break these down by game
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

library(gt)

# bring in the participant-round variables and
# turn them into dummies for the table
dsr.cols <- game.cols %>% 
  select(clave, game, starts_with("cosecha"), starts_with("escenario"), share)

# by-game mean
dsr.cols.game <- dsr.cols %>% group_by(game) 
dsr.cols.game.mean <- dsr.cols.game %>% 
  summarize(across(starts_with("cosecha"), mean),
            across(starts_with("escenario"), mean),
            across(share, mean)) %>%
  pivot_longer(values_to="mean", 
               cols=c(starts_with("cosecha"), starts_with("escenario"), share)) %>%
  pivot_wider(names_from="game", values_from="mean", names_prefix="mean")

# by-game sd
dsr.cols.game.sd <- dsr.cols.game %>% 
  summarize(across(starts_with("cosecha"), sd),
            across(starts_with("escenario"), sd),
            across(share,sd)) %>%
  pivot_longer(values_to="sd", 
               cols=c(starts_with("cosecha"), starts_with("escenario"), share)) %>%
  pivot_wider(names_from="game", values_from="sd", names_prefix="sd")

# overall means
dsr.summary.mean <- dsr.cols %>% 
  summarize(across(starts_with("cosecha"), mean), 
            across(starts_with("escenario"), mean),
            across(share, mean)) %>%
  pivot_longer(values_to="overallmean", cols=everything())

# overall sd
dsr.summary.sd <- dsr.cols %>% 
  summarize(across(starts_with("cosecha"), sd), 
            across(starts_with("escenario"), sd),
            across(share, sd)) %>%
  pivot_longer(values_to="overallsd", cols=everything())

# column names
description_mapping <- tribble(~name, ~description, 
                               "cosecha_2", "Harvest 2 quintals (1 = Yes)", 
                               "cosecha_4", "Harvest 4 quintals (1 = Yes)", 
                               "cosecha_6", "Harvest 6 quintals (1 = Yes)", 
                               "cosecha_8", "Harvest 8 quintals (1 = Yes)",
                               "escenario_1", "Mean of Uncertain-Price Buyer MXN 45 (1 = Yes)",
                               "escenario_2", "Mean of Uncertain-Price Buyer MXN 50 (1 = Yes)", 
                               "escenario_3", "Mean of Uncertain-Price Buyer MXN 55 (1 = Yes)",
                               "share", "Allocation to Certain-Price Buyer")

# put them together
dsr.df <- dsr.cols.game.mean %>% 
  left_join(dsr.summary.mean) %>% 
  left_join(dsr.cols.game.sd) %>% 
  left_join(dsr.summary.sd) %>% 
  left_join(description_mapping) %>%
  select(description, mean1, sd1, mean2, sd2, 
         mean3, sd3, overallmean, overallsd) 

# build the table
#fnote1 <- "Results from two participants missing because of surveyor error."

t.path.out <- str_c(t.path, "descriptive_participant_round.tex")

gt(dsr.df, caption=html("Descriptive statistics at the participant-round level\\label{tab:descriptive_participant_round}")) %>% 
  cols_label(description="", 
             mean1="Mean", mean2="Mean", mean3="Mean",
             overallmean="Mean") %>%
  cols_label(sd1="SD", sd2="SD", sd3="SD", overallsd="SD") %>%
  tab_spanner("Game 1", columns=c("mean1", "sd1")) %>%
  tab_spanner("Game 2", columns=c("mean2", "sd2")) %>%
  tab_spanner("Game 3", columns=c("mean3", "sd3")) %>%
  tab_spanner("Pooled", columns=c("overallmean", "overallsd")) %>%
  fmt_number(decimals=3) %>%
  fmt_number(column=c("sd1", "sd2", "sd3", "overallsd"),
              decimals=3, pattern="({x})") %>%
  rows_add(description="Participants", mean1=268, 
           mean2=268, mean3=268,  
           overallmean=268) %>% 
  rows_add(description="Rounds", mean1=5360, mean2=5360, mean3=5360,
           overallmean=16080) %>%
  sub_missing() %>%
  tab_row_group(label="Observations", rows=9:10) %>%
  tab_row_group(label="Outcome of Interest", rows=8) %>%
  tab_row_group(label="Experimental Variables", rows=1:7) %>%
#  tab_footnote(fnote1) %>%
  gtsave(t.path.out)

eliminate_caption_file(t.path.out)
convert_longtable_file(t.path.out)



