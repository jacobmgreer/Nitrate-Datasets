required <- c("tidyverse", "magrittr")
lapply(required, require, character.only = TRUE)
options(readr.show_col_types = FALSE)
options(timeout = 5*60)

wd_imdb_ref <- 
  # https://w.wiki/A7tY 
  # currently first 500 films with IMDb
  jsonlite::fromJSON("https://query.wikidata.org/sparql?query=SELECT%20DISTINCT%0A%20%20%3Fitem%20%3Fimdb%20%3FwikiprojLabel%0A%20%20%3FretrievedLabel%20%3Fobject_named_asLabel%0A%20%20%3Fdep_rankLabel%20%3Falt_nameLabel%0A%20%20%3FrefCountryLabel%20%3FarchiveurlLabel%20%3FsubjectnameLabel%0AWHERE%0A%7B%0A%20%20%7B%0A%20%20%20%20SELECT%20%3Fitem%20%3Fimdb%0A%20%20%20%20WHERE%20%7B%0A%20%20%20%20%20%20%3Fitem%20wdt%3AP345%20%3Fimdb.%0A%20%20%20%20%20%20%3Fitem%20p%3AP345%20%3Fcheck.%0A%20%20%20%20%20%20%3Fcheck%20prov%3AwasDerivedFrom%20%3Frefc.%0A%20%20%20%20%7D%0A%20%20%20%20LIMIT%20500%20OFFSET%200%0A%20%20%7D%0A%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP143%20%3Fwikiproj%20%5D%20%5D%20%7D%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP813%20%3Fretrieved%20%5D%20%5D%20%7D%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP1932%20%3Fobject_named_as%20%5D%20%5D%20%7D%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP2241%20%3Fdep_rank%20%5D%20%5D%20%7D%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP4970%20%3Falt_name%20%5D%20%5D%20%7D%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP17%20%3FrefCountry%20%5D%20%5D%20%7D%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP1065%20%3Farchiveurl%20%5D%20%5D%20%7D%0A%20%20OPTIONAL%20%7B%3Fitem%20p%3AP345%20%5B%20prov%3AwasDerivedFrom%20%5B%20pr%3AP1810%20%3Fsubjectname%20%5D%20%5D%20%7D%0A%0A%20%20SERVICE%20wikibase%3Alabel%20%7B%20bd%3AserviceParam%20wikibase%3Alanguage%20%22en%22.%20%7D%0A%7D%0A&format=json")$results$bindings %T>%
  write.csv(., "output/special_queries/wd_imdb_ref_example.csv", row.names = FALSE)

rm(required)
