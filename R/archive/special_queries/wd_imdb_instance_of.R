# required <- c("tidyverse", "magrittr", "httr")
# lapply(required, require, character.only = TRUE)
# options(readr.show_col_types = FALSE)
# options(timeout = 10*60)
# 
# query <- 
#   read_csv("~/Downloads/query.csv") %>%
#   filter(grepl('^tt', value)) %>%
#   mutate(instance_of = str_replace(instance_of, "http://www.wikidata.org/entity/", ""))
# 
# # instance_review <-
# #   query %>%
# #   dplyr::count(instance_of) %T>%
# #   write.csv(., "instance_of.csv", row.names = FALSE)
#   
# instance_review <- read_csv("~/Downloads/instance%2Dof%2Dcsv%2Ecsv.txt")
# 
# query <-
#   query %>%
#   left_join(instance_review, by="instance_of") %T>%
#   write.csv(., "review_instances.csv", row.names = FALSE)
# 
# 
# rm(required)
