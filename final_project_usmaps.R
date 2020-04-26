library(usmap)
library(ggplot2)
View(statepop)
filler = statepop
filler <- filler[c(1,4)]

#pulling columns from other scripts so that they can be added to the new dataset filler (emily)
avg_income_2015 = income_clean$`Avg Income (2015)`
avg_income_2016 = income_clean$`Avg Income (2016)`
avg_obesity_2015 = obesity_clean_final$`Avg Obesity Rate (2015)`
avg_obesity_2016 = obesity_clean_final$`Avg Obesity Rate (2016)`
fastfood_2015 = food_clean_final$`Fast Food Count (2015)`
fastfood_2016 = food_clean_final$`Fast Food Count (2016)`

#appending the column of data to the filler data (emily)
filler$avg_income_2015<-avg_income_2015
filler$avg_income_2016<-avg_income_2016
filler$avg_obesity_2015<-avg_obesity_2015
filler$avg_obesity_2016<-avg_obesity_2016
filler$fastfood_2015<-fastfood_2015
filler$fastfood_2016<-fastfood_2016
filler<-filler[,-c(2)]
View(filler)


#Income Plots (james)
plot_usmap(data = filler, values = "avg_income_2015", color = "black") + 
  scale_fill_continuous(name = "Average Income (2015)", label = scales::comma) + 
  theme(legend.position = "right")

plot_usmap(data = filler, values = "avg_income_2016", color = "black") + 
  scale_fill_continuous(name = "Average Income (2016)", label = scales::comma) + 
  theme(legend.position = "right")


#Obesity Plots (james)
plot_usmap(data = filler, values = "avg_obesity_2015", color = "black") + 
  scale_fill_continuous(name = "Average Obesity (2015)", label = scales::comma) + 
  theme(legend.position = "right")

plot_usmap(data = filler, values = "avg_obesity_2016", color = "black") + 
  scale_fill_continuous(name = "Average Obesity (2016)", label = scales::comma) + 
  theme(legend.position = "right")


#Fast Food Plots (james)
plot_usmap(data = filler, values = "fastfood_2015", color = "black") + 
  scale_fill_continuous(name = "Fast Food Resturants (2015)", label = scales::comma) + 
  theme(legend.position = "right")

plot_usmap(data = filler, values = "fastfood_2016", color = "black") + 
  scale_fill_continuous(name = "Fast Food Resturants (2016)", label = scales::comma) + 
  theme(legend.position = "right")

