
wd_filmfreeway <- 
  jsonlite::fromJSON("json/wd_filmfreeway.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    filmfreeway = value$value)
  
write_csv(wd_filmfreeway, "datasets/event/wd_filmfreeway.csv")

wd_filmaffinity <- 
  jsonlite::fromJSON("json/wd_filmaffinity.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    eidr = value$value)

write_csv(wd_filmaffinity, "datasets/film/wd_filmaffinity.csv")

wd_letterboxd <- 
  jsonlite::fromJSON("json/wd_letterboxd.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    letterboxd = value$value)

write_csv(wd_letterboxd, "datasets/film/wd_letterboxd.csv")

wd_tcm <- 
  jsonlite::fromJSON("json/wd_tcm.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    tcm = value$value)

write_csv(wd_tcm, "datasets/film/wd_tcm.csv")

wd_eidrparty <- 
  jsonlite::fromJSON("json/wd_eidrparty.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    eidrparty = value$value)

write_csv(wd_eidrparty, "datasets/companies/wd_eidrparty.csv")

wd_eidr <- 
  jsonlite::fromJSON("json/wd_eidr.json")$results$bindings %>%
  reframe(
    QID = basename(item$value),
    eidr = value$value)

write_csv(wd_eidr, "datasets/film/wd_eidr.csv")

