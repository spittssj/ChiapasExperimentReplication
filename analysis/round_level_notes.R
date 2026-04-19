# round_level_notes.R
# I want to store these notes in one place so I don't copy/paste them

dvc <- "Share Sold to Certain-Price Buyer"

dvl.coop <- c("Members", "Non-Members")

cvl.formula2 <- c( "Harvest 2 quintals (1 = Yes)", 
                   "Harvest 6 quintals (1 = Yes)", 
                   "Harvest 8 quintals (1 = Yes)",
                   "Mean of Uncertain-Price Buyer MXN 45 (1 = Yes)", 
                   "Mean of Uncertain-Price Buyer MXN 55 (1 = Yes)",
                   "Linear Time Trend")

cvl.formula3 <- c( "Harvest 2 quintals (1 = Yes)", 
                   "Harvest 6 quintals (1 = Yes)", 
                   "Harvest 8 quintals (1 = Yes)",
                   "Mean of Uncertain-Price Buyer MXN 45 (1 = Yes)", 
                   "Mean of Uncertain-Price Buyer MXN 55 (1 = Yes)",
                   "Game 2 (Microcredit)",
                   "Game 3 (Coop with Microcredit and Technical Assistance)",
                   "Linear Time Trend")

cvl.formula4 <- c( "Harvest 2 quintals (1 = Yes)", 
                   "Harvest 6 quintals (1 = Yes)", 
                   "Harvest 8 quintals (1 = Yes)",
                   "Mean of Uncertain-Price Buyer MXN 45 (1 = Yes)", 
                   "Mean of Uncertain-Price Buyer MXN 55 (1 = Yes)",
                   "Game 2 (Microcredit)",
                   "Game 3 (Coop with Microcredit and Technical Assistance)",
                   "Linear Time Trend",
                   "MXN 3000 Additional Income", 
                   "Female (1=True)", 
                   "CRRA (Eckel-Grossman Lottery)", 
                   "Completed Only Middle School (1=Yes)", 
                   "Completed High School (1=Yes)",
                   "Played Practice Game (1=Yes)",
                   "Understands Probability (1=Yes)",
                   "Literate (1=Yes)")

s.fe.2 <- c("Participant Fixed Effects", "Y", "Y", "Y")
s.fe.3 <- c("Participant Fixed Effects", "Y", "Y")
s.fe.3.coop <- c("Participant Fixed Effects", "Y", "Y")
s.re.4 <- c("Participant Random Effects", "Y")
s.god.4 <- c("Game Order, Lottery Position, Lottery Outcome Controls", "Y")
s.re.4.coop <- c("Participant Random Effects", "Y", "Y")

s.notes.2 <- c("Participants", "268", "268", "268")
s.notes.3 <- c("Participants", "268")
s.notes.3.coop <- c("Participants", "126", "142")
s.notes.4 <- c("Participants", "268")

r.notes.2 <- c("Rounds", "60", "60", "60")
r.notes.3 <- c("Rounds", "60")
r.notes.3.coop <- c("Rounds", "60", "60")

b.notes.2 <- c("Baseline Allocation", "0.820", "0.826", "0.818")
b.notes.3 <- c("Baseline Allocation", "0.821")

clustering.notes <- c("Standard errors are clustered at the participant level.",
                      "Reference harvest is 4 quintals.",
                      "Reference mean of price offered by uncertain-price buyer is MXN 50.")
scenario.notes <- c("In columns (1), (2), and (3), certain-price buyer offers MXN 50.",
                    "In column (2), certain-price buyer also offered microcredit to participant last year.",
                    "In column (3), certain-price buyer is a cooperative that offered microcredit and technical assistance last year.")
covariate.notes <- c("40 participants did not play practice game.", 
                     "68 participants did not answer basic probability question correctly.")

cl.3 <- c("Game 1", "Game 2", "Game 3")

cl.3.new <- c("CP Alone", "CP+MC", "CP+Coop+MC+TA")


