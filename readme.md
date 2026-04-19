# Replication Package

> Canonical replication repository for Pitts, Boyd, and Storer (2025), *Unpacking Side-Selling: Experimental Evidence from Rural Mexico*, **Agricultural Economics**. DOI: [10.1111/agec.70051](https://doi.org/10.1111/agec.70051).

### Author: Stephen Pitts <spitts@jesuits.org>

### Date: Last updated on 5 June 2024

This archive contains the replication materials for "Unpacking Side-Selling: Experimental Evidence from Rural Mexico." Below I describe the two data files and the R code that generates the figures and tables in the paper from this data.

## Data File 1: Participant Level Data

The file `data/master_participants_reduced.dta` contains 268 observations of 18 variables at the participant level. The order below matches that of *Table 1: Participant Level Variables* in the paper. 

|               | Initial Information                                          |
| ------------- | ------------------------------------------------------------ |
| clave         | Participant Id                                               |
| region        | Cooperative region (1 to 10)                                 |
| game_order    | Order of games and lottery placement                         |
|               | **Exit Survey**                                              |
| read_write    | Can read/write (1 =Yes)                                      |
| female        | Gender (1 = Female)                                          |
| edad          | Age                                                          |
| edu_secondary | Completed Only Middle School (1 if so)                       |
| edu_prep      | Participant completed preparatory education (1 if so; 0 if not) |
|               | **Administrative Data**                                      |
| ya_member     | Cooperative Member (1 if so; 0 if not)                       |
| loyalty       | Total number of years in 2013-24 that cooperative member is active |
|               | **Preliminary Activities**                                   |
| sale          | Understands arithmetic (1 = Yes)                             |
| percentage    | Understands percentages (1 = Yes)                            |
| ball          | Understands probability (1 = Yes)                            |
| extra2        | Additional Income Treatment (1 = Yes)                        |
| lottery       | Result of Eckel-Grossman Lottery (1 to 5)                    |
| crra          | Estimated CRRA based on lottery                              |
| practice_game | Completed practice game                                      |
|               | **Outcomes of Interest**                                     |
| share_avg     | Overall Margin (average allocation to certain-price buyer across 60 rounds) |
| cs_extensive  | Extensive Margin (1 if share_avg is 1; 0 otherwise)          |

## Data File 2: Participant-Round Level Data

The file `data/master_reduced.dta` contains 16080 (268 participants over 60 rounds) observations of 26 variables at the participant level.  We omit the participant level variables that are repeated from above and present the participant-round variables below. The order below corresponds to *Table 5: Descriptive Statistics at the Participant-Round Level* in the paper. 

|           | **Participant Information**                                  |
| --------- | ------------------------------------------------------------ |
| Clave     | Participant id                                               |
|           | **Round Information**                                        |
| Ronda     | Round (1 to 60)                                              |
| Cosecha   | Harvest (2, 4, 6, or 8)                                      |
| Escenario | Mean Price Offered by Uncertain-Price Buyer (1 = MXN 45, 2 = MXN 50, 3 = MXN 55) |
| Game      | Framing of Certain-Price Buyer (1 = certain price; 2 = certain price and microcredit; 3 = cooperative with certain price, microcredit, and technical assistance) |
|           | **Outcome of Interest**                                      |
| Share     | Allocation to certain price buyer (fraction from 0 to 1)     |

## **Code**

The file `analysis_master.R` runs all of the analysis files.

These analysis files generate the figures in the paper. Figure 1 is a static figure. Figure 2 comes from publically available data. Figures 3-5 come from confidential administrative data from our partner cooperative. Figure 7 is a static figure. 

| File                     | Figure                                                       |
| ------------------------ | ------------------------------------------------------------ |
| fig_pricedistributions.R | Figure 6: Outside Buyer Price Distributions                  |
| fig_lottery_gender.R     | Figure 8: Lottery Gamble Choices by Gender                   |
| fig_lottery_member.R     | Figure 9: Lottery Gamble Choices by Cooperative Membership Status |
| fig_lottery_position.R   | Figure 10: Lottery Gamble Choices by Position                |
| fig_loyalty.R            | Figure 11: Cooperative Member Loyalty                        |
| fig_avg_share_extra.R    | Figure 12: Total Margin by Treatment Status                  |
|                          | Figure 13: Total Margin by Cooperative Membership Status     |

These analysis files generate the tables in the paper. Table 3 is a static table.

| **File**                                 | **Table**                                                    |
| ---------------------------------------- | ------------------------------------------------------------ |
| tbl_descriptive_participant.R            | Table 1: Participant-Level Variables                         |
| tbl_game_order.R                         | Table 2: Game Order                                          |
| tbl_field_visits.R                       | Table 4: Field visits to regional centers                    |
| tbl_descriptive_participant_round.R      | Table 5: Descriptive Statistics at the Participant-Round Level |
| tbl_round_level_outcomes_by_game.R       | Table 6: Impact on Share to Certain-Price Buyer by Game      |
| tbl_round_level_outcomes_overall.R       | Table 7: Impact on Share to Certain-Price Buyer              |
|                                          | Table 10: Impact on Share by Cooperative Membership Status   |
| tbl_participant_level_outcomes.R         | Table 8: Participant Level Outcomes                          |
|                                          | Table 11: Participant Level Outcomes (Cooperative Members)   |
|                                          | Table 12: Participant Level Outcomes (Cooperative Non-Members) |
| tbl_participant_level_outcomes_crra.R    | Table 9: Participant Level Outcomes CRRA                     |
|                                          | Table 13: Participant Level Outcomes CRRA (Cooperative Members) |
|                                          | Table 14: Participant Level Outcomes CRRA (Cooperative Non-Members) |
| tbl_participant_level_outcomes_loyalty.R | Table 15: Particpant Level Outcomes Loyalty (Cooperative Members) |

## Requirements

The replication files require the following packages.

| Package     | Version |
| ----------- | ------- |
| R           | >=4.4.3 |
| tidyverse   | >=2.0.0 |
| haven       | >=2.5.4 |
| sandwich    | >=3.1   |
| fastDummies | >=1.7.5 |
| gt          | >=1.0.0 |
| stargazer   | >=5.2.3 |
| plm         | >=2.6   |

