# tbl_field_visits.R
# build a table of the different field visits we did
# turns out this is not necessary for the moment
source("analysis/sample_info.R")
source("analysis/analysis_common.R")

library(gt)

# the region codes, names, and dates of field visits
region_names_bm <- tribble(~region, ~region_name, ~dates, 
                           1,"Agua Dulce Tehuacan", "15 July",
                           2,"Chilón", "N/A",
                           3,"Coquilte'el", "20 July",
                           4,"Nuevo Progreso", "3 Aug; 22 Aug",
                           5,"Paraiso Chic'otanil", "14 July",
                           6,"San Jose Veracruz", "29 June; 2 Aug",
                           7,"Tzubute'el", "19 July",
                           8,"Yaxwinic", "30 June; 1 July",
                           9,"Ye'tal Ts'ahc", "N/A",
                           10,"Yochibha", "28 June")

# get the number of cooperative members and non-members in each region
region.members.count <- master_participants_dta %>% 
  select(clave, region, ya_member) %>% 
  group_by(region, ya_member) %>% 
  summarize(n=n()) %>% 
  pivot_wider(names_prefix="ya", names_from="ya_member", values_from="n") %>%
  mutate(total=ya0 + ya1) 

# join in this direction so we preserve the NA values here
sample.df <- region_names_bm %>% 
  left_join(region.members.count) %>%
  select(-region)

# build the whole table
fnote1 <- "Field visits were conducted in Summer 2022."
fnote2 <- "For logistical reasons, we could not visit two of the ten regional centers."
fnote3 <- "After all of the field visits were completed, we used the TX member list
  to determine whether experiment participants were in cooperative member families."

t.path.out <- str_c(t.path, "field_visits.tex")

fv_table <- gt(sample.df,
               rowname_col="region_name",
               caption=html("Field visits to regional centers served by Ts’umbal Xitalha’\\label{tab:field_visits}")) %>% 
  tab_spanner("Participants", columns=c("ya0", "ya1","total")) %>%
  cols_label(dates="Dates", 
             ya0="Non-Members", ya1="Members", total="Total") %>%
  sub_missing() %>%
  grand_summary_rows(columns=c(ya0, ya1, total),
               fns=list(id="total", label="Total" ) ~ sum(., na.rm=TRUE)) %>%
  tab_source_note(fnote1) %>%
  tab_source_note(fnote2) %>%
  tab_source_note(fnote3) %>%
  gtsave(t.path.out)

convert_longtable_file(t.path.out)
