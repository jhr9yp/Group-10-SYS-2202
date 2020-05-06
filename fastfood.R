library(readr)
library(maps)
library(ggplot2)
library(dplyr)
library(anytime)

#upload data as a csv file
df_food = read_csv("FastFoodRestaurants.csv")
View(df_food)

#using only the province and fast food name columns
location <- df_food$province
name <- df_food$name
date <- df_food$dateAdded

#Creating a new data table with just the two columns
food_clean <- data.frame(location, name, date)

#getting just the year from the date and updating data table
year <- substring(food_clean$date,1,4)
food_clean <- data.frame(location, name, year)

#removing Co Spgs and DC as a state
food_clean <- food_clean %>% filter(location != "Co Spgs" & location != "DC")

#omitting empty rows
food_clean <- na.omit(food_clean)


#create a loop to get data from 2015 and 2016 
for (i in 1:nrow(food_clean)){
  if (food_clean[i,1] == "2015" ){
    location2015 <- append(location2015, as.character(food_clean[i,2]))
    rate2015 <- append(rate2015, obesity_clean[i,3])
  }
  if (food_clean[i,1] == "2016"){
    location2016 <- append(location2016, as.character(food_clean[i,2]))
    rate2016 <- append(rate2016, food_clean[i,3])
  }
}

#create clean 2015 data by joining columns
food_clean2015 <- data.frame(location2015, rate2015)
#find the total number of fast food restaurants added in 2015
food_clean2015 <- count(food_clean2015, vars = location2015)

#change the column names to be more descriptive
names(food_clean2015) <- c("Location2015", "FastFood_Count2015")

#create clean 2016 data by joining columns
food_clean2016 <- data.frame(location2016, rate2016)
#find total number of fast food restaurants added in 2016
food_clean2016 <- count(food_clean2016, vars = location2016)
#change the column names to be more descriptive
names(food_clean2016) <- c("Location2016", "FastFood_Count2016")

#since year 2016 should include restaurants added prior to 2016, it sums both 2015 and 2016
food_clean2016$sum2016 <- rowSums(cbind(food_clean2016$FastFood_Count2016,food_clean2015$FastFood_Count2015),na.rm=TRUE)

#making new table from all info
food_clean_final <- 
  data.frame(food_clean2015$Location2015, food_clean2015$FastFood_Count2015, food_clean2016$sum2016,
             food_clean2016$FastFood_Count2016)
names(food_clean_final) <- c("Location", "Fast Food Count (2015)", "Fast Food Count (2016)", "Fast Food Count Increase")

#finding the average fast food restaurants between the years
food_clean_final$countAvg <- as.integer(rowMeans(food_clean_final[c("Fast Food Count (2015)", "Fast Food Count (2016)")], na.rm=TRUE))

#finalizing data table with average
names(food_clean_final)[5] = "Average Fast Food Count"

View(food_clean_final)


