tryCatch({
  wd_imdb <- 
    jsonlite::fromJSON("json/wd_imdb.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      imdb = value$value)
  
  review_imdb <-
    wd_imdb %>%
    mutate(first = substr(imdb, 1, 2)) %>%
    dplyr::count(first) %>%
    arrange(desc(n))
  
  # write_csv(review_imdb, "datasets/wd_imdb_review.csv")
  saveRDS(
    review_imdb, 
    file = "datasets/wd_imdb_review.rds")

  wd_imdb_event <-
    wd_imdb %>%
    filter(grepl("^ev", imdb)) %>%
    filter(!grepl("/", imdb))
  
  # write_csv(wd_imdb_event, "datasets/event/wd_imdb_event.csv")
  saveRDS(
    wd_imdb_event, 
    file = "datasets/event/wd_imdb_event.rds")
  
  wd_imdb_event_instance <-
    wd_imdb %>%
    filter(grepl("^ev", imdb)) %>%
    filter(grepl("/", imdb))
  
  # write_csv(wd_imdb_event_instance, "datasets/event/wd_imdb_event_instance.csv")
  saveRDS(
    wd_imdb_event_instance, 
    file = "datasets/event/wd_imdb_event_instance.rds")
  
  wd_imdb_films <-
    wd_imdb %>%
    filter(grepl("^tt", imdb)) %>%
    filter(!grepl("/", imdb))
  
  #write_csv(wd_imdb_films, "datasets/film/wd_imdb_films.csv")
  saveRDS(
    wd_imdb_films, 
    file = "datasets/film/wd_imdb_films.rds"
  )
  
  wd_imdb_companies <-
    wd_imdb %>%
    filter(grepl("^co", imdb))
  
  #write_csv(wd_imdb_companies, "datasets/companies/wd_imdb_companies.csv")
  saveRDS(
    wd_imdb_companies, 
    file = "datasets/companies/wd_imdb_companies.rds"
  )
}, error = function(err){})
