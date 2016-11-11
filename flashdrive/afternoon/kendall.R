## TS topic 3: Kendall tests

# setwd('mypath')

# load SWMPr, nutrient data
library(SWMPr)
load(file = 'data/noczbnut.RData')

# rename, qaqc clean up, subset
nut <- noczbnut
nut <- qaqc(nut, qaqc_keep = c(0, 4)) 
nut <- subset(nut, select = 'chla_n')
nut <- na.omit(nut)
head(nut)

# plot raw data
plot(nut)

# load libraries, add decimal date
library(EnvStats)
library(lubridate)
nut$dec_yr <- decimal_date(nut$datetimestamp) 

# run test
ests_k1 <- kendallTrendTest(chla_n ~ dec_yr, nut)
ests_k1$estimate
ests_k1$p.value

# check for seasonality
plot_summary(nut, param = 'chla_n')

# get annual averages
nutyr <- aggreswmp(nut, by = 'years')

# convert datetimestamp to numeric for year
nutyr$yr <- year(nutyr$datetimestamp)

# run test
ests_k2 <- kendallTrendTest(chla_n ~ yr, nutyr)
ests_k2$estimate
ests_k2$p.value

# some additional prep for season and year columns
nut$season <- month(nut$datetimestamp)
nut$yr <- year(nut$datetimestamp)

# run test
ests_sk <- kendallSeasonalTrendTest(chla_n ~ season + yr, data = nut)
ests_sk$estimate
ests_sk$p.value

# compare results for the three tests
ests_k1$estimate
ests_k1$p.value
ests_k1$interval$limits
ests_k2$estimate
ests_k2$p.value
ests_k2$interval$limits
ests_sk$estimate
ests_sk$p.value
ests_sk$interval$limits


