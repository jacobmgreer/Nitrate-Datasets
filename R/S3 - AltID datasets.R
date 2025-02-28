tryCatch({
  wd_filmfreeway <- 
    jsonlite::fromJSON("json/wd_filmfreeway.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      filmfreeway = value$value)
    
  # write_csv(wd_filmfreeway, "datasets/event/wd_filmfreeway.csv")
  saveRDS(
    wd_filmfreeway, 
    file = "datasets/event/wd_filmfreeway.rds"
  )

  wd_tmdb_person <- 
    jsonlite::fromJSON("json/wd_tmdb_person.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      tmdb = value$value,
      updated = date$value)
    
  saveRDS(
    wd_tmdb_person, 
    file = "datasets/people/wd_tmdb_person.rds"
  )

  wd_tmdb_movie <- 
    jsonlite::fromJSON("json/wd_tmdb_movie.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      tmdb = value$value,
      updated = date$value)
    
  saveRDS(
    wd_tmdb_movie, 
    file = "datasets/film/wd_tmdb.rds"
  )
  
  wd_filmaffinity <- 
    jsonlite::fromJSON("json/wd_filmaffinity.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      eidr = value$value)
  
  # write_csv(wd_filmaffinity, "datasets/film/wd_filmaffinity.csv")
  saveRDS(
    wd_filmaffinity, 
    file = "datasets/film/wd_filmaffinity.rds"
  )
  
  wd_letterboxd <- 
    jsonlite::fromJSON("json/wd_letterboxd.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      letterboxd = value$value)
  
  # write_csv(wd_letterboxd, "datasets/film/wd_letterboxd.csv")
  saveRDS(
    wd_letterboxd, 
    file = "datasets/film/wd_letterboxd.rds"
  )
  
  wd_tcm <- 
    jsonlite::fromJSON("json/wd_tcm.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      tcm = value$value)
  
  # write_csv(wd_tcm, "datasets/film/wd_tcm.csv")
  saveRDS(
    wd_tcm, 
    file = "datasets/film/wd_tcm.rds"
  )

  wd_tmdbparty <- 
    jsonlite::fromJSON("json/wd_tmdb_companies.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      tmdbparty = value$value,
      updated = date$value)
  
  saveRDS(
    wd_tmdbparty, 
    file = "datasets/companies/wd_tmdbparty.rds"
  )
  
  wd_eidrparty <- 
    jsonlite::fromJSON("json/wd_eidrparty.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      eidrparty = value$value,
      updated = date$value)
  
  # write_csv(wd_eidrparty, "datasets/companies/wd_eidrparty.csv")
  saveRDS(
    wd_eidrparty, 
    file = "datasets/companies/wd_eidrparty.rds"
  )
  
  wd_eidr <- 
    jsonlite::fromJSON("json/wd_eidr.json")$results$bindings %>%
    reframe(
      QID = basename(item$value),
      eidr = value$value)
  
  # write_csv(wd_eidr, "datasets/film/wd_eidr.csv")
  saveRDS(
    wd_eidr, 
    file = "datasets/film/wd_eidr.rds"
  )
}, error = function(err){})
