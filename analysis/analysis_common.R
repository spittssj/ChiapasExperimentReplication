# analysis_common.R
# shared code for all of the analysis tables and figures
library(tidyverse)
library(haven)
library(sandwich)
library(fastDummies)

# read in the master file
master_dta <- read_dta(master_dta_file) 

master_participants_dta <- read_dta(master_participants_dta_file) %>%
  # add extra as a factor for ggplot
  mutate(extra_fct = factor(extra2, labels=c("No", "Yes"))) %>%
  # add cooperative membership status
  mutate(ya_member_fct = factor(ya_member, labels=c("No", "Yes"))) %>%
  mutate(gender_fct = factor(female, labels=c("Male", "Female"))) %>%
  # add lottery position
  mutate(position = str_sub(game_order, 4)) %>% 
  mutate(position_fct = factor(position, labels=c("Before", "After"))) %>%
  mutate(lottery_winnings = sorteo / 1000) %>%
  mutate(lottery_winnings_before = (position == "antes") * lottery_winnings) %>%
  select(-sorteo)

# this dataframe is for the round-level analysis
master_dta_dc <- master_dta %>%
  dummy_cols(select_columns=c("cosecha", "escenario", "game")) %>%
  mutate(round = ronda)

game.cols <- master_dta_dc %>%
  select(share, clave, game, cosecha_2, cosecha_4, cosecha_6, cosecha_8,
         escenario_1, escenario_2, escenario_3, game_2, game_3, round, ronda,
         ya_member) 

game.cols.coop <- game.cols %>%
  filter(ya_member == 1) 

game.cols.no_coop <- game.cols %>%
  filter(ya_member == 0) 

game.cols.re <- master_dta_dc %>%
  select(share, clave, game, cosecha_2, cosecha_4, cosecha_6, cosecha_8,
         escenario_1, escenario_2, escenario_3, game_2, game_3, round, ronda,
         extra2, female, edad, edu_secondary, edu_prep, crra, ya_member,
         game_order, practice_game, ball, read_write)

game.cols.re.coop <- game.cols.re %>% filter(ya_member == 1)
game.cols.re.no_coop <- game.cols.re %>% filter(ya_member == 0)

# here are some convenience functions for calculating standard errors
# two convenience functions below
# cluster the standard errors by individual
vcv.group <- function(x) vcovHC(x, cluster="group")

# convert to a vector of SEs for Stargazer
se.group <- function(x) {
  x %>% vcv.group %>% diag %>% sqrt
}

# participant-level standard errors
se.participant <- function(x) {
  vcovHC(x, "HC2") %>% diag %>% sqrt
}

# eliminate the caption and label from a table
# useful for the tables on our slides
eliminate_caption_file <- function(path) {
  text <- readLines(path)
  
  text <- gsub("\\\\label\\{\\}", "", text)
  text <- gsub("\\\\caption\\{\\}", "", text)
  
  writeLines(text, path)
}

# from Jonathan Roth -> convert the longtable into a tabular
# this allows us to put a caption and a label on it
convert_longtable_file <- function(path){
  # Read in the text file, which is assumed to contain Latex
  text <- readLines(path)
  
  #If the file does not contain a longtable environment, return without doing anything else
  #if(!any(grepl("\\\\begin\\{longtable\\}", text))){
  #  return()
  #}
  
  # eliminate this line which gt sometimes puts
  text <- gsub("\\\\setlength\\{\\\\LTpost\\}\\{0mm\\}", "", text)
  
  # eliminate this line as well
  text <- gsub("\\\\fontsize\\{12.0pt\\}\\{14.4pt\\}\\\\selectfont", "", text)
  
  # Convert \begin{longtable} to \begin{tabular}
  text <- gsub("\\\\begin\\{longtable\\}", "\\\\begin\\{tabular\\}", text)
  
  # Convert \end{longtable} to \end{tabular}
  text <- gsub("\\\\end\\{longtable\\}", "\\\\end\\{tabular\\}", text)
  # Save the text into the file path
  writeLines(text, path)
}

#Create a function convert_longtable that takes a regular expression of filepaths

convert_longtable <- function(dir = ".",regex){
  # Get all files matching the regular expression
  files <- list.files(path = dir, pattern = regex, full.names = T)
  # Apply the convert_longtable_file function to each file matching the regular expression
  lapply(files, convert_longtable_file)
}

