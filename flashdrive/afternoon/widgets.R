## SWMPrats and widgets

library(SWMPr)

## import data
data(apacpnut)
dat <- qaqc(apacpnut)

## plot
plot_summary(dat, param = 'chla_n', years = c(2007, 2013))

## get individaul plots
plots <- plot_summary(dat, param = 'chla_n', years = c(2007, 2013),
  plt_sep = TRUE)

plots[[1]] # top left
plots[[3]] # middle
plots[[6]] # bottom right

## get summary data
plot_summary(dat, param = 'chla_n', year = c(2007, 2013), sum_out = TRUE)

