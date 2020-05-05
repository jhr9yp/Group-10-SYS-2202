# this file aggregates by state all of our individual tables (income, fast food, and obesity) into one data table
# we plotted each variable against one another and then determined the correlation coefficient

# this code was written by Alice Warner

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

#PUTTING ALL DATA INTO ONE TABLE (obesity, fast food count, income)
df_final <- data.frame(income_clean$Location, income_clean$`Avg Income (2015)`, income_clean$`Avg Income (2016)`,
                       income_clean$`Income Rate Change`, income_clean$`Average Income`,
                       obesity_clean_final$`Avg Obesity Rate (2015)`, obesity_clean_final$`Avg Obesity Rate (2016)`,
                       obesity_clean_final$`Obesity Rate Change`, obesity_clean_final$`Average Obesity`,
                       food_clean_final$`Fast Food Count (2015)`, food_clean_final$`Fast Food Count (2016)`,
                       food_clean_final$`Fast Food Count Increase`, food_clean_final$`Fast Food Rate Change`, food_clean_final$`Average Fast Food Count`)

names(df_final) <- c("Location", "Avg Income (2015)", "Avg Income (2016)", "Income Rate Change", "Avg Income", 
                     "Avg Obesity Rate (2015)", "Avg Obesity Rate (2016)", "Obesity Rate Change", "Avg Obesity",
                     "Fast Food Count (2015)", "Fast Food Count (2016)", "Fast Food Count Increase", "Fast Food Rate Change", "Avg Fast Food Count")
View(df_final)


#plotting average obesity and fast food data
ob_food <- ggplot(data=df_final, (aes(x=`Avg Obesity`, y=`Avg Fast Food Count`))) + geom_point() + ggtitle("Fast Food Count vs. Obesity")
ob_food
lm(df_final$`Avg Fast Food Count` ~ df_final$`Avg Obesity`)
ob_food + geom_smooth(method = "lm")
#correlation between obesity and fast food count = -0.37092
cor(df_final$`Avg Obesity`, df_final$`Avg Fast Food Count`)


#plotting average obesity and income
ob_inc <- ggplot(data=df_final, (aes(x=`Avg Obesity`, y=`Avg Income`))) + geom_point() + ggtitle("Income vs. Obesity")
ob_inc
lm(df_final$`Avg Income`~ df_final$`Avg Obesity`)
ob_inc + geom_smooth(method = "lm")
#correlation between obesity and income = -0.73544
cor(df_final$`Avg Obesity`, df_final$`Avg Income`)


#plotting average income and fast food count
inc_food <- ggplot(data=df_final, (aes(x=`Avg Income`, y=`Avg Fast Food Count`))) + geom_point() + ggtitle("Fast Food Count vs. Income")
inc_food
lm(df_final$`Avg Fast Food Count`~ df_final$`Avg Income`)
inc_food + geom_smooth(method = "lm")
#correlation between income and fast food count = 0.3999
cor(df_final$`Avg Income`, df_final$`Avg Fast Food Count`)


#plotting all three variables, with the color of the data points representing fast food count
joint <- ggplot(data=df_final, (aes(x=`Avg Obesity`, y=`Avg Income`, color = `Avg Fast Food Count`))) + geom_point() + ggtitle("Income vs. Obesity (color coded by Fast Food Count)")
joint
lm(df_final$`Avg Income`~ df_final$`Avg Obesity`)
joint + geom_smooth(method = "lm")


#plotting rates of change
ROC <- ggplot(data=df_final, (aes(x=`Fast Food Rate Change`, y=`Obesity Rate Change`))) + geom_point() + ggtitle("Comparing Rate of Change of Obesity and Fast Food Count")
ROC

R <- ggplot(data=df_final, (aes(x=`Income Rate Change`, y=`Obesity Rate Change`))) + geom_point() + ggtitle("Comparing Rate of Change of Obesity and Income")
lm(df_final$`Obesity Rate Change`~ df_final$`Income Rate Change`)
R + geom_smooth(method = "lm")
cor(df_final$`Income Rate Change`, df_final$`Obesity Rate Change`) #-.00225

ggplot(data=df_final, (aes(x=`Fast Food Rate Change`, y=`Income Rate Change`))) + geom_point() + ggtitle("Comparing Rate of Change of Income and Fast Food Count")
