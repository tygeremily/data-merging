setwd("~/RStudio")

options(scipen = 999)

library(dplyr)
library(ggplot2)
library(stargazer)

# Read Merge
df1 = read.csv("first_merge.csv")
View(df1)
# Read Coalition
df2 = read.csv("coalition.csv")
View(df2)

# code from class regression notes 
df3 <- list(df1, df2)
df4 <- Reduce(function(d1,d2) merge(d1,d2, by = c("country","year"), all.x = TRUE), df3)
View(df4)

# include only election years so I removed rows that have a missing coalition value 
# because only election years were counted in that table 
df5<-subset(df4, (!is.na(df4$coalition)))
View(df5)

#Submit final dataset
fwrite(df5,'~/final_dataset.csv')


# DV: democracy  (at t, t+1, and t+4) ** continuous measure of democracy
# prior_lib at t 
fit1 = lm(democracy_cont ~ prior_lib_t + misconduct + coalition + numberprev + gdp_growth + 
            regime_openness + foreign_aid + FDI, data = df5)
summary(fit1)

# prior_lib at t+1
fit2 = lm(democracy_cont ~ prior_lib_t.1 + misconduct + coalition + numberprev + gdp_growth + 
            regime_openness + foreign_aid + FDI, data = df5)
summary(fit2)

# prior_lib at t+4 
fit3 = lm(democracy_cont ~ prior_lib_t.4 + misconduct + coalition + numberprev + gdp_growth + 
            regime_openness + foreign_aid + FDI, data = df5)
summary(fit3)

stargazer(fit1, fit2, fit3, type = 'html',
          title = "Multiple Regression of Democracy", 
          out = 'regres.htm')


