tryCatch({
  wd_imdb <- 
    jsonlite::fromJSON("json/wd_imdb.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      value = value$value,
      updated = date$value
    )

  imdb_review  <-
    wd_imdb %>%
    mutate(first = substr(value, 1, 2)) %>%
    dplyr::count(first) %>%
    arrange(desc(n))

  write_csv(imdb_review, "imdb_review.csv")

  imdb_awkward <-
    wd_imdb %>%
    filter(!substr(value, 1, 2) %in% c("tt", "nm", "ev", "co", "ch", "li", "ni"))
  
  write_csv(imdb_awkward, "imdb_awkward.csv")

  dir.create("datasets/imdb", recursive = T, showWarnings = F)

  wd_imdb_event <-
    wd_imdb %>%
    filter(grepl("^ev", value)) %>%
    filter(!grepl("/", value))
  
  write_parquet(
    x = wd_imdb_event, 
    sink = "datasets/imdb/wd_imdb_event.parquet")
  
  wd_imdb_event_instance <-
    wd_imdb %>%
    filter(grepl("^ev", value)) %>%
    filter(grepl("/", value))
  
  write_parquet(
    x = wd_imdb_event_instance, 
    sink = "datasets/imdb/wd_imdb_event_instance.parquet")
  
  wd_imdb_films <-
    wd_imdb %>%
    filter(grepl("^tt", value)) %>%
    filter(!grepl("/", value))
  
  write_parquet(
    x = wd_imdb_films, 
    sink = "datasets/imdb/wd_imdb_films.parquet")

  wd_imdb_people <-
    wd_imdb %>%
    filter(grepl("^nm", value))
  
  write_parquet(
    x = wd_imdb_people, 
    sink = "datasets/imdb/wd_imdb_people.parquet")
  
  wd_imdb_companies <-
    wd_imdb %>%
    filter(grepl("^co", value))
  
  write_parquet(
    x = wd_imdb_companies, 
    sink = "datasets/imdb/wd_imdb_companies.parquet")
  
}, error = function(err){})
