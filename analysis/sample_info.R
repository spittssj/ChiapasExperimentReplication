# sample_info.R : some static tibbles about
# the sample that are helpful

library(stringr)

# where are the coop files
#coop.path <- "DataCollection/data/cooperative/"

# where are the input files
#raw.path <- "DataCollection/data/kobotoolbox/"

# where do we put the working files
#i.path <- "DataCollection/data/intermediate/"

# where do we put finished products
d.path <- "data/"

# here is one finished product
master_dta_file <- str_c(d.path, "master_reduced.dta")
master_participants_dta_file <- str_c(d.path, "master_participants_reduced.dta")

# where do we put graphs
f.path <- "figures/"
f.path.paper <- str_c(f.path, "paper/")
f.path.slides <- str_c(f.path, "slides/")

# where do we put tables
t.path <- "tables/"
t.path.paper <- str_c(t.path, "paper/")
t.path.slides <- str_c(t.path, "slides/")