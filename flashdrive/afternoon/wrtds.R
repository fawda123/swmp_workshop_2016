## TS topics 1: WRTDS

# setwd('mypath')

# load SWMPr, nutrient data
library(SWMPr)
load(file = 'noczbnut.RData')

# rename, qaqc clean up, subset
nut <- noczbnut
nut <- qaqc(nut, qaqc_keep = c(0, 4)) 
nut <- subset(nut, select = 'chla_n')
head(nut)

# load wq data
load(file = 'noczbwq.RData')

# rename, qaqc clean up, subset
wq <- noczbwq
wq <- qaqc(wq, qaqc_keep = c(0, 4)) 
wq <- subset(wq, select = 'sal')
head(wq)

# combine at weekly time step
tomod <- comb(nut, wq, timestep = 'weeks')

# plot both
overplot(tomod, type = c('p', 'l'))

library(WRTDStidal)

# add arbitrary limit column, datetimestamp as date
tomod$lim <- -1e6
tomod$datetimestamp <- as.Date(tomod$datetimestamp)

# create tidalmean object, note if response is in log or not
tomod <- tidalmean(tomod, reslog = FALSE)
head(tomod)

# use modfit function
mod <- modfit(tomod)

wrtdsperf(mod)

fitplot(mod)

prdnrmplot(mod)

gridplot(mod, logspace = F, month = 'all', floscl = F)

