#require(RCurl, quietly=TRUE)
#require(plyr, quietly=TRUE)
#require(reshape2, quietly=TRUE)
#require(lubridate, quietly=TRUE)
#require(stringr, quietly=TRUE)
#require(RODBC, quietly=TRUE)
#require(shiny)
require(REDCapR, quietly=TRUE)  


redcapUri <- "https://bbmc.ouhsc.edu/redcap/api/"
token <- "E497206264440C1545DFDAF41D241A0C"

system.time(gcFirst=T, expr={
  readResult <- redcap_read(batch_size=100L, interbatch_delay=.6, redcap_uri=redcapUri, token=token)
})
ds <- readResult$data

ds$RowID <- as.integer(row.names(ds))
object.size(ds)

rm(redcapUri, token)


