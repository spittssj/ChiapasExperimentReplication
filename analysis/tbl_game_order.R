# fig_game_order.R: create a figure with the game order
# to show that it was randomized correctly
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

library(gt)

description_mapping <- tribble(~game_order, ~game_order_text, ~lottery,
                               "123antes", "Lottery, Game 1, Game 2, Game 3", "Lottery Before",
                               "123despues", "Game 1, Game 2, Game 3, Lottery", "Lottery After",
                               "132antes", "Lottery, Game 1, Game 3, Game 2", "Lottery Before",
                               "132despues", "Game 1, Game 3, Game 2, Lottery", "Lottery After",
                               "213antes", "Lottery, Game 2, Game 1, Game 3", "Lottery Before",
                               "213despues", "Game 2, Game 1, Game 3, Lottery", "Lottery After",
                               "231antes", "Lottery, Game 2, Game 3, Game 1", "Lottery Before",
                               "231despues", "Game 2, Game 3, Game 1, Lottery", "Lottery After",
                               "312antes", "Lottery, Game 3, Game 1, Game 2", "Lottery Before",
                               "312despues", "Game 3, Game 1, Game 2, Lottery", "Lottery After",
                               "321antes", "Lottery, Game 3, Game 2, Game 1", "Lottery Before",
                               "321despues", "Game 3, Game 2, Game 1, Lottery", "Lottery After")
#                               "na", "Not entered (surveyor error)", "N/A",)

# generate the summary stats 
game_order_df <- master_participants_dta %>% 
#  mutate(game_order=ifelse(game_order == "", "na", game_order)) %>%
  group_by(game_order) %>% 
  summarize(n=n()) %>% 
  left_join(description_mapping) %>%
  select(-game_order) %>%
  mutate(game_order_text = factor(game_order_text)) %>%
  select(game_order_text, n, lottery) 

# build the table
fnote1 <- "All participants completed three games and an Eckel-Grossman 
  risk preference lottery before or after the three games."
fnote2 <- "The order of
  the lottery and the games was determined with a roll of a 12-sided die."

t.path.out.paper <- str_c(t.path.paper, "game_order.tex")
t.path.out.slides <- str_c(t.path.slides, "game_order.tex")

go.table <- gt(game_order_df, groupname_col = "lottery",
               caption=html("Game Order \\label{tab:game_order}")) %>%
  summary_rows(groups=c("Lottery Before","Lottery After"), 
               columns=n, fns = list(id = "sum", label="Subtotal", fn="sum")) %>%
  grand_summary_rows(columns=n, fns=list(id="grandsum", label="Total", fn="sum")) %>%
  cols_label(game_order_text="Order", n="Count") 
  

go.table %>% rm_caption() %>% gtsave(t.path.out.slides)

go.table %>%
  tab_source_note(fnote1) %>%
  tab_source_note(fnote2) %>%
  gtsave(t.path.out.paper)

convert_longtable_file(t.path.out.paper)
convert_longtable_file(t.path.out.slides)

