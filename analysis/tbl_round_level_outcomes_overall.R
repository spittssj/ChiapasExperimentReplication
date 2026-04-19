# round_level_outcomes_overall.R
# this file generates the tables for the overall outcomes
library(tidyverse)
library(stargazer)
library(plm)

source("analysis/sample_info.R")
source("analysis/analysis_common.R")

# a standard panel of this -- for the fixed effects models
game.panel <- pdata.frame(game.cols, index=c("clave", "ronda"))
game.panel.coop <- pdata.frame(game.cols.coop, 
                               index=c("clave", "ronda"))
game.panel.no_coop <- pdata.frame(game.cols.no_coop, 
                                  index=c("clave", "ronda"))

# for the random effects models
game.panel.re <- pdata.frame(game.cols.re, index=c("clave", "ronda"))
game.panel.re.coop <- pdata.frame(game.cols.re.coop, index=c("clave", "ronda"))
game.panel.re.no_coop <- pdata.frame(game.cols.re.no_coop, index=c("clave", "ronda"))

# this regression also has game dummies (equation 3 in the text)
formula3 <- share ~ cosecha_2 + cosecha_6 + cosecha_8 + escenario_1 + 
  escenario_3 + game_2 + game_3 + round

model3.all <- plm(formula3, data=game.panel, model="within", effect="individual")
model3.all.se <- map(list(model3.all), se.group)

# this regression has random effects as well
formula4 <- update.formula(formula3, . ~ . + extra2 + female + edad + 
                             crra + edu_secondary + edu_prep + 
                             factor(game_order) + practice_game + ball + read_write)

model4.all <- plm(formula4, data=game.panel.re, model="random", method="walrus")
model4.se <- map(list(model4.all), se.group)

# we run this for the cooperative members and non-members (fixed effects)
model3.coop <- plm(formula3, data=game.panel.coop, 
                   model="within", effect="individual")
model3.no_coop <- plm(formula3, data=game.panel.no_coop, 
                   model="within", effect="individual")
model3.coop.se <- map(list(model3.coop, model3.no_coop), se.group)

# we run this for the cooperativ members and non-members (random effects)
model4.coop <- plm(formula4, data=game.panel.re.coop, 
                   model="random", method="walrus")
model4.no_coop <- plm(formula4, data=game.panel.re.no_coop, 
                      model="random", method="walrus")
model4.coop.se <- map(list(model4.coop, model4.no_coop), se.group)

# labels for Stargazer
source("analysis/round_level_notes.R")

# generate the output tables
# round-level outcomes for whole sample with fixed effects
t.path.paper.out <- str_c(t.path.paper, "round_level_outcomes_overall.tex")
t.path.slides.out <- str_c(t.path.slides, "round_level_outcomes_overall.tex")

stargazer(model3.all, se=model3.all.se,
          covariate.labels=cvl.formula3, dep.var.labels=dvc, 
          title="Impact on Share to Certain-Price Buyer",
          label="round_level_outcomes_overall",
          notes=c(clustering.notes), 
          notes.align="l", notes.append=TRUE, notes.label = "",
          keep.stat = c("n"),
          single.row = TRUE,
          add.lines=list(s.fe.3, s.notes.3, r.notes.3, b.notes.3),
          type="latex", out=t.path.paper.out)

stargazer(model3.all, se=model3.all.se,
          covariate.labels=cvl.formula3, dep.var.labels=dvc, 
          notes=c(clustering.notes), 
          notes.align="l", notes.append=TRUE, notes.label = "",
          keep.stat = c("n"),
          single.row = TRUE,
          add.lines=list(s.fe.3, s.notes.3, r.notes.3, b.notes.3),
          type="latex", out=t.path.slides.out)

eliminate_caption_file(t.path.slides.out)

# round-level outcomes for whole sample with random effects
# for now these are appendix so I haven't updated them
#stargazer(model4.all, se=model4.se,
#          covariate.labels=cvl.formula4, dep.var.labels=dvc, 
#          title="Impact on Share to Certain Price Buyer (Random Effects)",
#          label="round_level_outcomes_overall_re",
#          notes=c(clustering.notes, covariate.notes, scenario.notes), 
#          notes.align="l", notes.append=TRUE, notes.label = "",
#          keep.stat = c("n"),
#          omit = "factor\\(game_order\\).*",
#          single.row = TRUE,
#          add.lines=list(s.re.4, s.god.4, s.notes.3, r.notes.3),
#          type="latex", out=str_c(t.path.paper, "round_level_outcomes_overall_re.tex"))

# round level outcomes for coop member / nonmember with fixed effects
# for now these are appendix so I haven't updated them

t.path.paper.out <- str_c(t.path.paper, "round_level_outcomes_coop.tex")

stargazer(model3.coop, model3.no_coop, 
          se=model3.coop.se,
          covariate.labels=cvl.formula3,
          column.labels = dvl.coop,
          dep.var.labels = dvc,
          title="Impact on Share to Certain-Price Buyer by Cooperative Membership Status",
          label="round_level_outcomes_coop",
          notes=c(clustering.notes), 
          notes.align="l", notes.append=TRUE, notes.label = "",
          keep.stat = c("n"),
          single.row = TRUE,
          add.lines=list(s.fe.3.coop, s.notes.3.coop, r.notes.3.coop),
          type="latex", out=t.path.paper.out)

t.path.slides.out <- str_c(t.path.slides, "round_level_outcomes_coop.tex")

stargazer(model3.coop, model3.no_coop, 
          se=model3.coop.se,
          covariate.labels=cvl.formula3,
          column.labels = dvl.coop,
          dep.var.labels = dvc,
          notes=c(clustering.notes), 
          notes.align="l", notes.append=TRUE, notes.label = "",
          keep.stat = c("n"),
          single.row = TRUE,
          add.lines=list(s.fe.3.coop, s.notes.3.coop, r.notes.3.coop),
          type="latex", out=t.path.slides.out)

eliminate_caption_file(t.path.slides.out)


# round level outcomes for coop member / nonmember with random effects
# for now these are appendix so I haven't updated them
#stargazer(model4.coop, model4.no_coop, se=model4.coop.se,
#          covariate.labels=cvl.formula4, dep.var.labels=dvc, 
#          column.labels=dvl.coop,
#          title="Impact on Share by Cooperative Membership Status (Random Effects)",
#          label="round_level_outcomes_coop_re",
#          notes=c(clustering.notes, scenario.notes), 
#          notes.align="l", notes.append=TRUE, notes.label = "",
#          keep.stat = c("n"),
#          omit = "factor\\(game_order\\).*",
#          add.lines=list(s.re.4.coop, s.notes.3.coop, r.notes.3.coop),
#          type="latex", out=str_c(t.path.paper, "round_level_outcomes_coop_re.tex"))