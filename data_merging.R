setwd("~/RStudio")

options(scipen = 999)
library(data.table)

# V-Dem
# country, year
# democracy (binary) v2x_regime is ordinal, can be recoded binary
# democracy (continuous)
df1 = readRDS("V-dem.rds")
df1a = subset( df1, select = c ('country_name',
                                'year',
                                'v2x_polyarchy',
                                'v2x_regime',
                                'e_fh_cl',
                                'e_fh_pr',
                                'v2mebias_ord',
                                'v2elfrfair_ord',
                                'v2psbars_ord'))

df1a$fhcivil = recode(df1a$e_fh_cl,
                      '7' = '1',
                      '6' = '2',
                      '5' = '3',
                      '4' = '4',
                      '3' = '5',
                      '2' = '6',
                      '1' = '7')

df1a$fhpolitical = recode(df1a$e_fh_pr,
                          '7' = '1',
                          '6' = '2',
                          '5' = '3',
                          '4' = '4',
                          '3' = '5',
                          '2' = '6',
                          '1' = '7')

df1a <- df1a %>%
  group_by(country_name) %>%
  mutate(lagfhcl = lag(fhcivil, order_by = year)) %>%
  mutate(lagfhcl2 = lag(fhcivil, order_by = year, n=2)) %>%
  mutate(lagfhpr = lag(fhpolitical, order_by = year)) %>%
  mutate(lagfhpr5 = lag(fhpolitical, order_by = year, n=5))

# number of previous elections (calculated by counting number of panels)
df1a <- df1a%>%
  group_by(country_name)%>%
  filter(!is.na(v2elfrfair_ord))%>%
  mutate(numberprev=row_number())

# misconduct intensity (create index) 
df1a$party = ifelse(df1a$v2psbars_ord == 4, 0, 1)
df1a$mebias = ifelse(df1a$v2mebias_ord == 4, 0, 1)
df1a$elfraud = ifelse(df1a$v2elfrfair_ord == 4, 0, 1)

df1a$misconduct = df1a$party + df1a$mebias + df1a$elfraud

# regime openness (recoded) (FH civil liberties continuous average t-1 and t-2-- scores inverted higher = more freedom)
df1a$lagfhcl = as.numeric(df1a$lagfhcl)
df1a$lagfhcl2 = as.numeric(df1a$lagfhcl2)
df1a$regime_openess = (df1a$lagfhcl + df1a$lagfhcl2)/2

# prior liberalization (recoded) (FH political rights continuous, difference in scores in 4 year period preceding election)
## also under H and R 
df1a$lagfhpr <- as.numeric(df1a$lagfhpr)
df1a$lagfhpr4 <- as.numeric(df1a$lagfhpr4)
df1a$prior_lib <- (df1a$lagfhpr4 - df1a$lagfhpr)
View(df1a)


# Donno
# GDP PCAP Current USD (WDI) (continuous)
# foreign direct investment (WDI FDI continuous)
# foreign aid (WDI Foreign aid continuous)
library(WDI)

df2 = WDI(country = 'all', 
          indicator = c ('NY.GDP.PCAP.CD',
                         'bx.klt.dinv.wd.gd.zs',
                         'dt.oda.alld.cd'))

# GDP growth (calculated) (WDI) (continuous and t-1 and t-2)
df2=df2%>%group_by(country)%>%
  mutate(gdp_2y_ago = lag(NY.GDP.PCAP.CD, order_by = year, n = 1))%>%
  mutate(gdp_1y_ago = lag(NY.GDP.PCAP.CD, order_by = year, n = 2))
df2$gdp_growth <- df2$gdp_1y_ago - df2$gdp_2y_ago
View(df2)


# DPI
# main election (recoded) (DPI) categorical
library(readstata13)
library(foreign)
library(dplyr)

df3 = read.dta13("DPI2017_stata13.dta")
df3a = df3 %>%
  select(countryname,
         year,
         system,
         yrsoffc)

df3a$parliamentary = ifelse(df3a$system == 0, 'presidential', 
                            'parliamentary')
View(df3a)

# incumbent running (recorded) (DPI) categorical years in office at t+1
df3a<-df3a%>% group_by(countryname)%>%
  mutate(incumbent_running = lead(yrsoffc, order_by = year))
df3a$incumbent_running = ifelse(df3a$incumbent_running>0,1,0)

# alternation in power (recoded) (DPI from yrsinoffice categorical)
df3a<-df3a%>%group_by(countryname)%>%
  mutate(alternation_in_power = lead(yrsoffc,order_by = year))
df3a$alternation_in_power = ifelse(df3a$alternation_in_power==0,1,0)


# Howard and Roessler 
# opposition mobilization (mass mob data, protestnumber continuous)
# region (many sources-- categorical from Mass Mob Dataset)
df4 = read.dta13("mmALL_020619_v15.dta")
df4a <- subset(df4,select = c("country","year","region","protestnumber"))
View(df4a)


# Final data frames
#Var Dem
df_vdem<- subset(df1a, select = c("country_name","year","v2x_polyarchy",
                                  "v2x_regime","misconduct","regime_openess",
                                  "numberprev"))

setnames(df_vdem,"country_name", "country")
setnames(df_vdem,"v2x_regime","Democracy_bin")
setnames(df_vdem,"v2x_polyarchy","Democracy_cont")
setnames(df_vdem,"regime_openess","Regime_openness")

# WDI
df2<-df2%>%
  setnames('NY.GDP.PCAP.CD',"GDP_PerCAP")%>%
  setnames('dt.oda.alld.cd',"Foreign_Aid")%>%
  setnames('bx.klt.dinv.wd.gd.zs',"FDI")

dfWDI <- subset(df2, select = c("country","year","GDP_PerCAP","FDI","Foreign_Aid","gdp_growth"))

# DPI
df3a<-na.omit(df3a)
df3a<-df3a%>%setnames("countryname","country")
df_DPI <- subset(df3a, select = c("country","year","incumbent_running",
                                  "alternation_in_power"))

# Mass Mobilization
setnames(df4a,"protestnumber","opposition_mobilization")


# Merge all 4 data frames 
temp_df <- list(df_vdem, dfWDI, df_DPI, df4a)
dataset_assignment <- Reduce(function(d1,d2) merge(d1,d2, by = c("country","year"), all.x = TRUE), temp_df)
View(dataset_assignment)
s
# Save
fwrite(dataset_assignment,'~/dataset_assignment.csv')


