# tbl_participant_level_outcomes.R
# this file generates the tables for the participant-level outcomes
# right now, it generates three tables
# -- participant_level_outcomes.tex
# -- participant_level_outcomes_coop.tex
# -- participant_level_outcomes_coop_no.tex

source("analysis/sample_info.R")
source("analysis/analysis_common.R")

# so we can output latex tables
library(stargazer)

# this is a new deliverable that's helpful for some tables
mp_clave_share <- master_participants_dta 

# the intensive margin -- eliminate 0's from that
mp_clave_share_im <- mp_clave_share %>% filter(cs_extensive == 0)

# and here is one for cooperative members
mp_clave_share.coop <- mp_clave_share %>% filter(ya_member == 1)
mp_clave_share.coop.im <- mp_clave_share %>% filter(ya_member == 1, 
                                                    cs_extensive == 0)

# and for cooperative no-members 
mp_clave_share.coop.no <- mp_clave_share %>% filter(ya_member == 0)
mp_clave_share.coop.no.im <- mp_clave_share %>% filter(ya_member == 0,
                                                       cs_extensive == 0)

# overall margin linear model
tm.reg <- share_avg ~ extra2 + female + edad + 
  edu_secondary + edu_prep + 
  factor(game_order) + practice_game + ball + read_write + lottery_winnings_before

# extensive margin model just changes dependent variable
em.reg <- update.formula(tm.reg, cs_extensive ~ .)

# intensive margin model uses om.reg but with a subset
cms.reg.tm <- lm(tm.reg, mp_clave_share)
cms.reg.em <- lm(em.reg, mp_clave_share)
cms.reg.im <- lm(tm.reg, mp_clave_share_im)

se.all <- map(list(cms.reg.tm, cms.reg.em, cms.reg.im),
              se.participant)

dvl <- c("Overall Margin", "Extensive Margin", "Intensive Margin")
cvl <- c("MXN 3000 Additional Income", "Female (1=Yes)", "Age", 
         "Completed Only Middle School (1=Yes)", "Completed High School (1=Yes)",
         "Played Practice Game (1=Yes)", "Understands Probability (1=Yes)", 
         "Can Read/Write (1=Yes)")
dvc <- "Average Allocation to Certain-Price Buyer Over 60 Rounds"

order.fe.notes <- c("Game Order, Lottery Position, Lottery Outcome Controls", 
                    "Y", "Y", "Y")
notes <- c( "In column (2), the dependent variable is a dummy which equals 1 if the participant allocates the entire",
            "harvest to the certain-price buyer in all rounds; 0 otherwise. Column (3) presents the same",
            "regression as column (1) on the subset of participants for whom the dummy variable is 0.",
            "All three columns present heteroskedasticity-robust standard errors.")

t.path.paper.out1 <- str_c(t.path.paper, "participant_level_outcomes.tex")
t.path.slides.out1 <- str_c(t.path.slides, "participant_level_outcomes.tex")

stargazer(cms.reg.tm, cms.reg.em, cms.reg.im,
            title = "Participant Level Outcomes",
            label = "participant_level_outcomes",
            single.row = TRUE,
            se = se.all, 
            type="latex", out=t.path.paper.out1,
            covariate.labels = cvl, omit = c("factor\\(game_order\\).*", "lottery_winnings"),
            notes = notes, notes.align="l", notes.label = "",
            add.lines = list(order.fe.notes),
            keep.stat = c("n", "rsq"),
            dep.var.caption = dvc, dep.var.labels = dvl)

stargazer(cms.reg.tm, cms.reg.em, cms.reg.im,
          single.row = TRUE,
          se = se.all, 
          type="latex", out=t.path.slides.out1,
          covariate.labels = cvl, omit = c("factor\\(game_order\\).*", "lottery_winnings"),
          notes = notes, notes.align="l", notes.label = "",
          add.lines = list(order.fe.notes),
          keep.stat = c("n", "rsq"),
          dep.var.caption = dvc, dep.var.labels = dvl)

eliminate_caption_file(t.path.slides.out1)

# now do it for coop members
cms.reg.tm.coop <- lm(tm.reg, mp_clave_share.coop)
cms.reg.em.coop <- lm(em.reg, mp_clave_share.coop)
cms.reg.im.coop <- lm(tm.reg, mp_clave_share.coop.im)

t.path.paper.out2 <- str_c(t.path.paper, "participant_level_outcomes_coop.tex")
t.path.slides.out2 <- str_c(t.path.slides, "participant_level_outcomes_coop.tex")

se.all.coop <- map(list(cms.reg.tm.coop, cms.reg.em.coop, cms.reg.im.coop),
              se.participant)

stargazer(cms.reg.tm.coop, cms.reg.em.coop, cms.reg.im.coop,
            title = "Participant Level Outcomes (Cooperative Members)",
            label = "participant_level_outcomes_coop",
            se = se.all.coop,
            single.row = TRUE,
            type="latex", out=t.path.paper.out2,
            covariate.labels = cvl, omit = c("factor\\(game_order\\).*", "lottery_winnings"),
            notes = notes, notes.align="l", notes.label = "",
            add.lines = list(order.fe.notes),
            keep.stat = c("n", "rsq"),
            dep.var.caption = dvc, dep.var.labels = dvl)

stargazer(cms.reg.tm.coop, cms.reg.em.coop, cms.reg.im.coop,
          single.row = TRUE,
          se = se.all.coop, 
          type="latex", out=t.path.slides.out2,
          covariate.labels = cvl, omit = c("factor\\(game_order\\).*", "lottery_winnings"),
          notes = notes, notes.align="l", notes.label = "",
          add.lines = list(order.fe.notes),
          keep.stat = c("n", "rsq"),
          dep.var.caption = dvc, dep.var.labels = dvl)

eliminate_caption_file(t.path.slides.out2)

# and coop nonmembers 
cms.reg.tm.coop.no <- lm(tm.reg, mp_clave_share.coop.no)
cms.reg.em.coop.no <- lm(em.reg, mp_clave_share.coop.no)
cms.reg.im.coop.no <- lm(tm.reg, mp_clave_share.coop.no.im)

t.path.paper.out3 <- str_c(t.path.paper, "participant_level_outcomes_coop_no.tex")
t.path.slides.out3 <- str_c(t.path.slides, "participant_level_outcomes_coop_no.tex")

se.all.coop.no <- map(list(cms.reg.tm.coop.no, 
                           cms.reg.em.coop.no, 
                           cms.reg.im.coop.no),
                   se.participant)

stargazer(cms.reg.tm.coop.no, cms.reg.em.coop.no, cms.reg.im.coop.no,
            title = "Participant Level Outcomes (Cooperative Non-Members)",
            label = "participant_level_outcomes_coop_no",
            se = se.all.coop.no,
            single.row = TRUE,
            type="latex", out=t.path.paper.out3,
            covariate.labels = cvl, omit = c("factor\\(game_order\\).*", "lottery_winnings"),
            notes = notes, notes.align="l", notes.label = "",
            add.lines = list(order.fe.notes),
            keep.stat = c("n", "rsq"),
            dep.var.caption = dvc, dep.var.labels = dvl)

stargazer(cms.reg.tm.coop.no, cms.reg.em.coop.no, cms.reg.im.coop.no,
          single.row = TRUE,
          se = se.all.coop.no,
          type="latex", out=t.path.slides.out3,
          covariate.labels = cvl, omit = c("factor\\(game_order\\).*", "lottery_winnings"),
          notes = notes, notes.align="l", notes.label = "",
          add.lines = list(order.fe.notes),
          keep.stat = c("n", "rsq"),
          dep.var.caption = dvc, dep.var.labels = dvl)

eliminate_caption_file(t.path.slides.out3)
