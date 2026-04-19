# round_level_outcomes_by_game.R
# this file generates the tables for the round-level outcomes
# these are the outcomes with one column for each game

library(tidyverse)
library(stargazer)
library(plm)

source("analysis/sample_info.R")
source("analysis/analysis_common.R")

# break it up by game
t2.cols.g1 <- game.cols %>% filter(game==1)
t2.cols.g2 <- game.cols %>% filter(game==2)
t2.cols.g3 <- game.cols %>% filter(game==3)

# build the panels for each game
t2.panel.g1 <- pdata.frame(t2.cols.g1, index=c("clave", "ronda"))
t2.panel.g2 <- pdata.frame(t2.cols.g2, index=c("clave", "ronda"))
t2.panel.g3 <- pdata.frame(t2.cols.g3, index=c("clave", "ronda"))

# here are the regressions
# the base regression (equation 2 in the text)
# cosecha = 4 is the reference case
# escenario2 is the reference case
# this is used with individual fixed effects
formula2 <- share ~ cosecha_2 + cosecha_6 + cosecha_8 + escenario_1 + 
  escenario_3 + round 

# run the same regression on all three
model2.g1 <- plm(formula2, data=t2.panel.g1, model="within", effect="individual")
model2.g2 <- plm(formula2, data=t2.panel.g2, model="within", effect="individual")
model2.g3 <- plm(formula2, data=t2.panel.g3, model="within", effect="individual")

# get all of the standard errors
model2.se <- map(list(model2.g1, model2.g2, model2.g3), se.group)

# labels we use in Stargazer
source("analysis/round_level_notes.R")

# run it twice -- once for slides and once for paper
t.path.paper.out <- str_c(t.path.paper, "round_level_outcomes_by_game.tex")
t.path.slides.out <- str_c(t.path.slides, "round_level_outcomes_by_game.tex")

stargazer(model2.g1, model2.g2, model2.g3, se=model2.se,
          covariate.labels=cvl.formula2, dep.var.labels=dvc, column.labels = cl.3,
          title="Impact on Share to Certain-Price Buyer by Game",
          label="round_level_outcomes_by_game",
          notes=c(clustering.notes, scenario.notes), 
          notes.align="l", notes.append=TRUE, notes.label = "",
          single.row = TRUE,
          keep.stat = c("n"),
          add.lines=list(s.fe.2, s.notes.2, r.notes.2, b.notes.2),
          type="latex", out=t.path.paper.out)

stargazer(model2.g1, model2.g2, model2.g3, se=model2.se,
          covariate.labels=cvl.formula2, dep.var.labels=dvc, column.labels = cl.3.new,
          notes=c(clustering.notes, scenario.notes), 
          notes.align="l", notes.append=TRUE, notes.label = "",
          single.row = TRUE,
          keep.stat = c("n"),
          add.lines=list(s.fe.2, s.notes.2, r.notes.2, b.notes.2),
          type="latex", out=t.path.slides.out)

eliminate_caption_file(t.path.slides.out)
