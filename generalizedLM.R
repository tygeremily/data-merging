setwd('~/RStudio')

library(readstata13)
library(ggplot2)
library(stargazer)
library(dplyr)
library(binaryLogic)

df <- read.csv("final_dataset.csv")
View(df)

# binary dependent variable democracy_bin
typeof(df$democracy_bin) # integer 
df$democracy_bin <- ifelse(df$democracy_bin > 1, 1, 0)
typeof(df$democracy_bin) # double 

# Linear Regression at t + 1 
head(df)
t1 <- lead(df$democracy_bin, n= 1)
f1 = glm(t1 ~ misconduct + regime_openness + numberprev + 
           prior_lib_t + gdp_perCAP + FDI + foreign_aid + gdp_growth + incumbent_running + 
           alternation_in_power + region + opposition_mobilization + coalition,
         family = 'binomial'(link = 'logit'),
         data = df)
f1

# Odds Ratio at t + 1
orf1_w = exp(f1$coefficients[1] + f1$coefficients[2]) / (1 + exp(f1$coefficients[1] + f1$coefficients[2]))
orf1_w

# Predicted probability of independent variables of interest at t + 1
dfpr = with(df, data.frame(misconduct = misconduct,
                          regime_openness = regime_openness,
                          numberprev = mean(numberprev),
                          prior_lib_t = prior_lib_t,
                          gdp_perCAP = gdp_perCAP,
                          FDI = FDI,
                          foreign_aid = foreign_aid,
                          gdp_growth = gdp_growth,
                          incumbent_running = incumbent_running,
                          alternation_in_power = alternation_in_power,
                          region = region,
                          opposition_mobilization = opposition_mobilization,
                          coalition = coalition))
dfpr$coalition_pr <- predict(f1, newdata = dfpr, type = 'response')
View(dfpr)

# Visualization
pr_pr_p1 = ggplot(dfpr, aes(x = coalition, y = coalition_pr)) + 
  geom_line()
pr_pr_p1
# Error bar visualization
pr_pr_p2 = ggplot(dfpr, aes(x = coalition, y = coalition_pr)) + 
  geom_errorbar(aes(ymin = 1, ymax = 100), size = 4) + 
  geom_point(size = 5) + 
  ylim(0,1) + 
  theme(legend.position = 'none') 
pr_pr_p2

# Logistic Regression at t + 4 
t4<- lead(df$democracy_bin, n= 4)
f4 = glm(democracy_bin ~ misconduct + regime_openness + numberprev + 
           prior_lib_t + gdp_perCAP + FDI + foreign_aid + gdp_growth + incumbent_running + 
           alternation_in_power + region + opposition_mobilization + coalition,
         family = 'binomial'(link = 'logit'),
         data = df)
f4

# Odds ratio at t + 4
orf4_w = exp(f4$coefficients[1] + f4$coefficients[2]) / (1 + exp(f4$coefficients[1] + f4$coefficients[2]))
orf4_w

# Predicted probability at t + 4 
dfpr$coalition_pr4 <- predict(f4, newdata = dfpr, type = 'response')

# Visualization
pr_pr_p3 = ggplot(dfpr, aes(x = coalition, y = coalition_pr4)) + 
  geom_line()
pr_pr_p3

# Error bar visualization
pr_pr_p4 = ggplot(dfpr, aes(x = coalition, y = coalition_pr)) + 
  geom_errorbar(aes(ymin = 1, ymax = 100), size = 4) + 
  geom_point(size = 5) + 
  ylim(0,1) + 
  theme(legend.position = 'none') 
pr_pr_p4


# Multiple Regression corrections 
rt1<- lead(df$democracy_cont, n= 1) # t + 1
rfit1 = lm(democracy_cont ~ misconduct + regime_openness + numberprev + 
             prior_lib_t + gdp_perCAP + FDI + foreign_aid + gdp_growth + incumbent_running + 
             alternation_in_power + region + opposition_mobilization + coalition, data = df)
summary(rfit1)

rt4<- lead(df$democracy_cont, n= 4) # t + 4
rfit4 = lm(democracy_cont ~ misconduct + regime_openness + numberprev + 
             prior_lib_t + gdp_perCAP + FDI + foreign_aid + gdp_growth + incumbent_running + 
             alternation_in_power + region + opposition_mobilization + coalition, data = df)
summary(rfit4)

# outputs with stargazer 
stargazer(f1, f4, rfit1, rfit4, type = 'html',
          title = "Comparison of Logistic Regression and Multiple Regression Results", 
          out = 'logregression.htm')

library(ggpubr)
# Visualizations with ggpubr
pr_t1 <- ggarrange(pr_pr_p1, pr_pr_p2 + font("x.text", size = 10),
                    ncol = 1, nrow = 2)
annotate_figure(pr_t1,
                top = text_grob("Visualizing Coalition", color = "black", face = "bold", size = 14),
                fig.lab = "Figures at t + 1", fig.lab.face = "bold")

pr_t4 <- ggarrange(pr_pr_p3, pr_pr_p4 + font("x.text", size = 10),
                   ncol = 1, nrow = 2)
annotate_figure(pr_t4,
                top = text_grob("Visualizing Coalition", color = "black", face = "bold", size = 14),
                fig.lab = "Figures at t + 4", fig.lab.face = "bold")
