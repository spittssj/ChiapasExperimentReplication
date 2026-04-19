# tbl_descriptive_participant.R: build the summary statistics by participant level
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

library(gt)

# bring in the participant variables
ds.cols <- master_participants_dta %>% 
  select(read_write, percentage, sale, ball, 
         extra2, 
         female, edad, crra, edu_prep, edu_secondary, 
         ya_member, loyalty,
         practice_game, share_avg, cs_extensive) %>%
  mutate(cs_intensive = ifelse(share_avg==1, NA, share_avg))

# given a variable, return the stats
# N, Yes, No, Mean, SD
ds_row <- function(ds_col) {
    as_tibble_row(list(n=sum(!is.na(ds_col)),
         yes=sum(ds_col == 1, na.rm=TRUE),
         no=sum(ds_col == 0, na.rm=TRUE),
         mean=mean(ds_col, na.rm=TRUE),
         sd=sd(ds_col, na.rm=TRUE)))
}

# get the stats for all variables
map.out <- map(ds.cols, ds_row)

# now order them
ds_rows <- bind_rows(map.out$female,
                     map.out$edad,
                     map.out$edu_secondary,
                     map.out$edu_prep,
                     map.out$ya_member,
                     map.out$loyalty,
                     map.out$read_write,
                     map.out$sale,
                     map.out$percentage,
                     map.out$ball,
                     map.out$extra2,
                     map.out$crra,
                     map.out$practice_game,
                     map.out$share_avg,
                     map.out$cs_extensive,
                     map.out$cs_intensive)

# column names 
cvl <- tribble(~variable_name, ~variable_group,
         "Gender (1 = Female)", "Exit Survey",
         "Age", "Exit Survey",
         "Completed Only Middle School (1 = Yes)", "Exit Survey",
         "Completed High School (1 = Yes)", "Exit Survey",
         "Cooperative Member (1 = Yes)", "Administrative Data",
         "Years Sold to Cooperative", "Administrative Data",
         "Can read/write (1 = Yes)", "Preliminary Activities",
         "Understands arithmetic (1 = Yes)", "Preliminary Activities",
         "Understands percentages (1 = Yes)", "Preliminary Activities",
         "Understands probability (1 = Yes)", "Preliminary Activities",
         "Additional income treatment (1 = Yes)", "Preliminary Activities",
         "CRRA (from Eckel-Grossman Lottery)", "Preliminary Activities",
         "Practice game (1 = Yes)", "Preliminary Activities",
         "Overall Margin", "Outcome of Interest",
         "Extensive Margin", "Outcome of Interest",
         "Intensive Margin", "Outcome of Interest")

# put it together
ds_rows_2 <- bind_cols(cvl, ds_rows)

# fix age, CRRA, overall margin, intensive because they are not yes/no
ds_rows_2[c(2, 6, 12, 14, 16),][4:5] = list(NA,NA)

fnote1 <- "40 participants did not complete the practice game because of enumerator error."
fnote2 <- "Overall Margin is average allocation to certain-price buyer across 60 rounds."
fnote3 <- "Extensive Margin is 1 if a participant always allocates entire harvest to certain-price buyer across 60 rounds, 0 otherwise."
fnote4 <- "Intensive Margin is the average allocation for the subset of participants for whom Extensive Margin is not 1."

t.path.out.paper <- str_c(t.path.paper, "descriptive_participant.tex")
t.path.out.slides <- str_c(t.path.slides, "descriptive_participant.tex")

# for whatever reason, you have to use html below
ds.table <- gt(ds_rows_2, 
               caption=html("Descriptive statistics at the participant level\\label{tab:descriptive_participant}"),
               rowname_col="variable_name", groupname_col = "variable_group") %>%
  cols_label(n="N", yes="Yes", no="No", mean="Mean", sd="SD") %>%
  fmt_number(columns=c("mean", "sd"), decimals=3) %>%
  sub_missing()

ds.table %>% rm_caption() %>% gtsave(t.path.out.slides)

ds.table %>%
  tab_source_note(fnote1) %>%
  tab_source_note(fnote2) %>%
  tab_source_note(fnote3) %>%
  tab_source_note(fnote4) %>%
  gtsave(t.path.out.paper)
        
convert_longtable_file(t.path.out.slides)
eliminate_caption_file(t.path.out.slides)

convert_longtable_file(t.path.out.paper)

                     


