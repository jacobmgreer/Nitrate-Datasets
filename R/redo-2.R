files <-
  list.files(
    path = "json/monitoring",
    pattern = ".json",
    recursive = T,
    full.names = T
  )

for (i in files) {
  filepath = str_replace(str_replace(i, "json/", "datasets/"), ".json", ".parquet")
  tryCatch({
    write_parquet(
      x = 
        jsonlite::fromJSON(i)$results$bindings %>%
        reframe(
          QID = basename(item$value),
          value = value$value
        ), 
      sink = filepath
    )
  }, error = function(err){})
}