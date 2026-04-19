# analysis_master.R
# run all of the analysis

# FIGURES
# Figure 6: Outside Buyer Price Distributions
source("analysis/fig_pricedistributions.R")

# Figure 8: Lottery Gamble Choices by Gender
source("analysis/fig_lottery_gender.R")

# Figure 9: Lottery Gamble Choices by Cooperative Membership Status
source("analysis/fig_lottery_member.R")

# Figure 10: Lottery Gamble Choices by Position
source("analysis/fig_lottery_position.R")

# Figure 11: Cooperative Member Loyalty
source("analysis/fig_loyalty.R")

# Figure 12: Total Margin by Treatment Status
# Figure 13: Total Margin by Cooperative Mmebership Status
source("analysis/fig_avg_share_extra.R")

# TABLES
# Table 1: Participant-Level Variables
source("analysis/tbl_descriptive_participant.R")

# Table 2: Game Order
source("analysis/tbl_game_order.R")

# Table 4: Field visits to regional centers
source("analysis/tbl_field_visits.R")

# Table 5: Descriptive Statistics at the Participant-Round Level
source("analysis/tbl_descriptive_participant_round.R")

# Table 6: Impact on Share to Certain-Price Buyer by Game
source("analysis/tbl_round_level_outcomes_by_game.R")

# Table 7: Impact on Share to Certain-Price Buyer
# Table 10: Impact on Share by Cooperative Membership Status
source("analysis/tbl_round_level_outcomes_overall.R")

# Table 8: Participant Level Outcomes
# Table 11: Participant Level Outcomes (Cooperative Members)
# Table 12: Participant Level Outcomes (Cooperative Non-Members)
source("analysis/tbl_participant_level_outcomes.R")

# Table 9: Participant Level Outcomes CRRA
# Table 13: Participant Level Outcomes CRRA (Cooperative Members)
# Table 14: Participant Level Outcomes CRRA (Cooperative Non-Members)
source("analysis/tbl_participant_level_outcomes_crra.R")

# Table 15: Particpant Level Outcomes Loyalty (Cooperative Members)
source("analysis/tbl_participant_level_outcomes_loyalty.R")

