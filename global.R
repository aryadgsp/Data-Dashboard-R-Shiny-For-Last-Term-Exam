
library(shiny) # shiny features
library(shinydashboard) # shinydashboard functions
library(DT)  # for DT tables
library(dplyr)  # for pipe operator & data manipulations
library(plotly) # for data visualization and plots using plotly 
library(ggplot2) # for data visualization & plots using ggplot2
library(ggtext) # beautifying text on top of ggplot
library(ggcorrplot) # for correlation plot
library(shinycssloaders) # to add a loader while graph is populating


df <- read.csv('dataecom.csv')
my_data <- df


c1 = df %>% 
  select(-"E.Commerce") %>% 
  names()

c2 = df %>% 
  select(-"E.Commerce") %>% 
  names()

c3 = df %>% names()