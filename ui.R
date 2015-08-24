library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  titlePanel("Referral Sources"),
  fluidRow(
    dataTableOutput('table'))))