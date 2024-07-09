required <- c("tidyverse", "magrittr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

wd_language_labels <- 
  # https://w.wiki/A7sW 
  # currently listing for films with TCM
  jsonlite::fromJSON("https://query.wikidata.org/sparql?query=SELECT%20%3Fitem%20%3FEen%20%3FEru%20%3FEfr%20%3FEde%20%3FEar%20%3FEja%0AWHERE%0A%7B%0A%20%20%3Fitem%20wdt%3AP3056%20%3Fvalue.%0A%20%20OPTIONAL%20%7B%0A%20%20%20%20%3Fitem%20rdfs%3Alabel%20%3FEen%20filter%20(lang(%3FEen)%20%3D%20%22en%22).%0A%20%20%7D%0A%20%20OPTIONAL%20%7B%0A%20%20%20%20%3Fitem%20rdfs%3Alabel%20%3FEen%20filter%20(lang(%3FEen)%20%3D%20%22en%22).%0A%20%20%7D%0A%20%20OPTIONAL%20%7B%0A%20%20%20%20%3Fitem%20rdfs%3Alabel%20%3FEru%20filter%20(lang(%3FEru)%20%3D%20%22ru%22).%0A%20%20%7D%0A%20%20OPTIONAL%20%7B%0A%20%20%20%20%3Fitem%20rdfs%3Alabel%20%3FEfr%20filter%20(lang(%3FEfr)%20%3D%20%22fr%22).%0A%20%20%7D%0A%20%20OPTIONAL%20%7B%0A%20%20%20%20%3Fitem%20rdfs%3Alabel%20%3FEde%20filter%20(lang(%3FEde)%20%3D%20%22de%22).%0A%20%20%7D%0A%20%20OPTIONAL%20%7B%0A%20%20%20%20%3Fitem%20rdfs%3Alabel%20%3FEar%20filter%20(lang(%3FEar)%20%3D%20%22ar%22).%0A%20%20%7D%0A%20%20OPTIONAL%20%7B%0A%20%20%20%20%3Fitem%20rdfs%3Alabel%20%3FEja%20filter%20(lang(%3FEja)%20%3D%20%22ja%22).%0A%20%20%7D%0A%7D&format=json")$results$bindings %T>%
  write.csv(., "output/special_queries/wd_language_labels_example.csv", row.names = FALSE)

rm(required)
