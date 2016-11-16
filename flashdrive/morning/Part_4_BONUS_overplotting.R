#Part 2: Case Studies - Using SWMPr to deal with difficult data
#Case Study 3 BONUS: Overplotting ISCO and WQ data
#Written by Kim Cressman

#Step 1: The normal stuff
library(SWMPr)

setwd("C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016")

data.path <- "C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016" 

#Step 2: Read in and QC the files
wqdat <- import_local(data.path, "gndbcwq")

wqdat <- qaqc(wqdat, qaqc_keep = c(0,1))

names(wqdat)

nutdat <- import_local(data.path, "gndbcnut")

nutdat <- qaqc(nutdat, qaqc_keep = c(0,1,-4,5))

names(nutdat)

#Step 3: Combine the files
#Note: This is where the BONUS truly comes in!
wqnut <- comb(nutdat, wqdat, timestep = 15, method = "intersect")

head(wqnut,20)

#Step 4: We have to deal with those NAs
wqnut2 <- wqnut[!is.na(wqnut$po4f),]

head(wqnut2)

unique(wqnut2$datetimestamp)

#Step 5: Let's try subsetting in a different way
wqnut2.sept <- subset(wqnut2, subset = c("2012-09-17 4:00", "2012-09-18 12:00"))

head(wqnut2.sept)

#Step 6: Let's make the plot
overplot(wqnut2.sept, select=c('po4f', 'sal', 'depth'), cols = c('red', 'blue', 'green'))

#Step 6b: Combine the plot and the subsetting
overplot(wqnut2, select=c('po4f', 'sal', 'depth'), 
         subset = c("2012-09-17 4:00", "2012-09-18 12:00"), cols = c('purple', 'red', 'orange'))


overplot(wqnut2, select=c('po4f', 'sal', 'depth'), 
         subset = c("2012-10-01 0:00", "2012-10-31 23:45"), cols = c('purple', 'red', 'orange'))


overplot(wqnut2, select=c('po4f', 'sal', 'depth'), 
         subset = c("2012-06-01 0:00", "2012-06-30 23:45"), cols = c('purple', 'red', 'orange'))

overplot(wqnut2, select=c('po4f', 'nh4f', 'chla_n', 'sal', 'depth'), 
         subset = c("2012-10-01 0:00", "2012-10-31 23:45"), cols = c('purple', 'red', 'orange', 'green', 'blue'))


#Use overplotting wisely!





