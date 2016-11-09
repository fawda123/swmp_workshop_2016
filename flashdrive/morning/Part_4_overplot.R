#Part 2: Case Studies - Using SWMPr to deal with difficult data
#Case Study 3: Overplotting ISCO and WQ data
#Written by Kim Cressman

#Step 1: The normal stuff
library(SWMPr)

setwd("C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016")

data.path <- "C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016" 

#For simplicity, this is a prepared file
load(file="overplot_data.RData")

head(wqnut2,20)

unique(wqnut2$datetimestamp)

#Step 2: Subset for the date range you want
wqnut2.sept <- subset(wqnut2, subset = c("2012-09-17 4:00", "2012-09-18 12:00"))

head(wqnut2.sept)

#Step 3: Make your plot...overplot that is!
overplot(wqnut2.sept, select=c('po4f', 'sal', 'depth'), cols = c('red', 'blue', 'green'))

overplot(wqnut2, select=c('po4f', 'sal', 'depth'), 
         subset = c("2012-09-17 4:00", "2012-09-18 12:00"), cols = c('purple', 'red', 'orange'))


#Step 3b: Let's look at a different date range

overplot(wqnut2, select=c('po4f', 'sal', 'depth'), 
         subset = c("2012-10-01 0:00", "2012-10-31 23:45"), cols = c('purple', 'red', 'orange'))

#Step 3c: What about during Hurricane Isaac?
overplot(wqnut2, select=c('po4f', 'sal', 'depth'), 
         subset = c("2012-06-01 0:00", "2012-06-30 23:45"), cols = c('purple', 'red', 'orange'))


#Step 4: Let's look at a whole bunch of parameters
overplot(wqnut2, select=c('po4f', 'nh4f', 'chla_n', 'sal', 'depth'), 
         subset = c("2012-10-01 0:00", "2012-10-31 23:45"), cols = c('purple', 'red', 'orange', 'green', 'blue'))


#Hint: Use Overplotting wisely!

#You can also use points for parameters instead of lines.
#This is useful if you've kept all WQ data instead of only keeping timestamps that correspond to nutrient samples
overplot(wqnut2, 
         select=c('po4f', 'sal', 'depth'), 
         subset = c("2012-09-01 0:00", "2012-09-30 23:45"), 
         cols = c('purple', 'red', 'orange'),
         type = c('p','l','l'))


#Bonus Materials are availble for those who want even more overplotting!

