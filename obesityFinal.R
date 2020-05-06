#Created by Jane Romness

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
year<- df_obesity$YearStart


#Create a new data frame with desired columns
obesity_clean <- data.frame(year, location, obesity_rating)

#omit locations that are not states
obesity_clean <- obesity_clean %>% filter(location != "District of Columbia")
obesity_clean <- obesity_clean %>% filter(location != "Puerto Rico")
obesity_clean <- obesity_clean %>% filter(location != "Virgin Islands")
obesity_clean <- obesity_clean %>% filter(location != "National")
obesity_clean <- obesity_clean %>% filter(location != "Guam")

#Omit rows with null values
obesity_clean<- na.omit(obesity_clean)

#create new columns for specific year and category
location2015 <-NULL
rate2015 <- NULL
location2016 <-NULL
rate2016 <- NULL

#create a loop to get data from 2015 and 2016
for (i in 1:nrow(obesity_clean)){
  if (obesity_clean[i,1] == "2015"){
    location2015 <- append(location2015, as.character(obesity_clean[i,2]))
    rate2015 <- append(rate2015, obesity_clean[i,3])
  }
  if (obesity_clean[i,1] == "2016"){
    location2016 <- append(location2016, as.character(obesity_clean[i,2]))
    rate2016 <- append(rate2016, obesity_clean[i,3])
  }
}

#create clean 2015 data by joining columns
obesity_clean2015 <- data.frame(location2015, rate2015)
#find the average obesity value for each location
obesity_clean2015<- aggregate(obesity_clean2015$rate2015, by = list(obesity_clean2015$location2015), mean)
#change the column names to be more descriptive
names(obesity_clean2015) <- c("Location2015", "Avg_Obesity_Rate2015")

#create clean 2016 data by joining columns
obesity_clean2016 <- data.frame(location2016, rate2016)
#find the average obesity value for each location
obesity_clean2016<- aggregate(obesity_clean2016$rate2016, by = list(obesity_clean2016$location2016), mean)
#change the column names to be more descriptive
names(obesity_clean2016) <- c("Location2016", "Avg_Obesity_Rate2016")

obesity_difference <- NULL
for (i in 1: nrow(obesity_clean2015)){
  obesity_difference = append( obesity_difference, obesity_clean2016[i,2]-obesity_clean2015[i,2])
}

#create one dataset 
obesity_clean_final <- 
  data.frame(obesity_clean2015$Location2015, obesity_clean2015$Avg_Obesity_Rate2015, 
             obesity_clean2016$Avg_Obesity_Rate2016, obesity_difference)
names(obesity_clean_final) <- c("Location", "Avg Obesity Rate (2015)", "Avg Obesity Rate (2016)", "Obesity Rate Change")

#View final dataset
View(obesity_clean_final)
