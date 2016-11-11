## TS topics 2: decomposition

# setwd('mypath')

# load SWMPr
library(SWMPr)

# subset for daily decomposition
dat <- subset(apadbwq, subset = c('2013-07-01 00:00', '2013-07-31 00:00'), 
  select = 'do_mgl')
plot(dat)

# use decomp and plot
dat_add <- decomp(dat, param = 'do_mgl', frequency = 'daily', type = 'additive')
plot(dat_add)

# check structures
str(dat_add)
str(dat_add$trend)

# recreate original time series
add <- with(dat_add, seasonal + trend + random)
plot(add, dat$do_mgl)

# multiplicative decomp, plot
dat_mul <- decomp(dat, param = 'do_mgl', frequency = 'daily', 
  type = 'multiplicative')
plot(dat_mul)

# recreate original time series
mul <- with(dat_mul, seasonal * trend * random)
plot(mul, dat$do_mgl)

# use decomp_cj on nutrient data
apacpnut <- qaqc(apacpnut, qaqc_keep = c(0, 4))
decomp_cj(apacpnut, param = 'chla_n', type = 'add')

# get actual values
add <- decomp_cj(apacpnut, param = 'chla_n', type = 'add', vals_out = TRUE)
head(add)

# note differences in time step between original and decomposed
head(apacpnut)
head(add)

# see how missing data is treated (its not)
dat <- subset(apadbwq, subset = c('2013-06-01 00:00', '2013-07-31 00:00'))

test <- decomp(dat, param = 'do_mgl', frequency = 'daily')

# use na.approx to interpolate missing data
dat <- subset(apadbwq, subset = c('2013-06-01 00:00', '2013-07-31 00:00'))
dat <- na.approx(dat, params = 'do_mgl', maxgap = 10)

# decomposition and plot
dat_fl <- decomp(dat, param = 'do_mgl', frequency = 'daily')
plot(dat_fl)

