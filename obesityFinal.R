library(DBI)
library(RMySQL)
library(ggplot2)
library(ggmap)
library(maptools)
library(maps)
library(lubridate)
library(dplyr)
library(stringr)
library(stringi)

df_obesity = read.csv("C:\\Users\\student\\Desktop\\SYS2202\\Final\\original_weight_data.csv")

#extract two columns that we are using: state abbreviation and obesity value
location <- df_obesity$LocationDesc
obesity_rating <- df_obesity$Data_Value

#Create a new data frame with desired columns
obesity_clean <- data.frame(location, obesity_rating)

#Omit rows with null values
obesity_clean<- na.omit(obesity_clean)

#find the average obesity value for each location
obesity_clean<- aggregate(obesity_clean$obesity_rating, by = list(obesity_clean$location), mean)

View(obesity_clean)
