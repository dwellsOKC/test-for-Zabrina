#rm(list=ls(all=TRUE))  #Clear the variables from previous runs.  UNcomment this only during testing, or else it will wipe out the calling code's memory.
require(RCurl, quietly=TRUE)
require(plyr, quietly=TRUE)
require(reshape2, quietly=TRUE)
require(lubridate, quietly=TRUE)
require(stringr, quietly=TRUE)
require(RODBC, quietly=TRUE)
require(shiny)
require(REDCapR, quietly=TRUE)  


#Packages needed if not already installed
#devtools::install_github(repo="OuhscBbmc/REDCapR")
# install.packages("devtools")
# devtools::install_github(repo="OuhscBbmc/REDCapR")


#############################
### Retrieve token and REDCap URL
#############################

#channel <- RODBC::odbcConnect(dsn="BbmcSecurity") #getSqlTypeInfo("Microsoft SQL Server") #odbcGetInfo(channel)
#redcapUri <- RODBC::sqlQuery(channel, "EXEC Security.prcUriStatic @UriName = 'RedcapBbmc'", stringsAsFactors=FALSE)[1, 'Value']
#token <- RODBC::sqlQuery(channel, "EXEC [Redcap].[prcToken] @RedcapProjectName = 'Gpav2'", stringsAsFactors=FALSE)[1, 'Token']
#RODBC::odbcClose(channel)
#Fields <- c("studyid", "redcap_event_name", "redcap_data_access_group", "whichdc", "start_time", "int_yn")
#rm(channel)

#############################
### Query REDCap API
#############################

redcapUri <- "https://bbmc.ouhsc.edu/redcap/api/"
token <- "E497206264440C1545DFDAF41D241A0C"

system.time(gcFirst=T, expr={
  readResult <- redcap_read(batch_size=100L, interbatch_delay=.6, redcap_uri=redcapUri, token=token)
})
ds <- readResult$data

ds$RowID <- as.integer(row.names(ds))
object.size(ds)

rm(redcapUri, token)

#############################
### Shiny Stuff
#############################

shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    x    <- ds[, 11]  # Old Faithful Geyser data
#    bins <- seq(min(x), max(x), length.out = input$bins)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    hist(x, breaks = 12, col = 'darkgray', border = 'white', main = "")
  })
})


