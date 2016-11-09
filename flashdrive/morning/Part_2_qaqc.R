#Part 2: Case Studies - Using SWMPr to deal with difficult data
#Case Study 1: Quality Control
#Written by Kim Cressman

#Step 1: Open SWMPr package and set your working directory
library(SWMPr)
setwd("C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016")

data.path<-"C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016"

#Step 2: Read in a single file and look at it
wqdat<-import_local(data.path,"gndpcwq2015")

head(wqdat)
tail(wqdat)
summary(wqdat)
str(wqdat)


#Step 3: Read in multiple files and generate a summary
wqdat<-import_local(data.path, "gndpcwq", trace=TRUE)
summary(wqdat)


#Step 4: Get specific QC codes that are in your file
qctable<-qaqcchk(wqdat)

#Take a look at the table you just generated
qctable

#See all unique values in the f_temp column (QC codes relating to temperature)
unique(wqdat$f_temp)

#Or you can count how many of each QC code you have!
table(wqdat$f_temp)


summary(wqdat$temp)

plot(temp ~ datetimestamp, data = wqdat,
     type = "l",
     col = "red",
     main = "Temperature at PC 2012 - 2015",
     xlab = "Date",
     ylab = "Temp (C)")

#Step 5: Keep only data flagged with a 0
wqdat2 <- qaqc(wqdat, qaqc_keep = 0)

summary(wqdat2)

plot(temp ~ datetimestamp, data = wqdat2,
     type = "l",
     col = "red",
     main = "Temperature at PC 2012 - 2015",
     xlab = "Date",
     ylab = "Temp (C)")

#Step 5b: Keep multiple flags and/or letter codes

#Start with specific numbers
wqdat2 <- qaqc(wqdat, qaqc_keep = c(0,1,5))

#Keep a specific letter code
wqdat2 <- qaqc(wqdat, qaqc_keep = c(0, 'STF'))
summary(wqdat2$temp)

#Try to keep a specific number-letter combination 
wqdat2 <- qaqc(wqdat, qaqc_keep = c(0, '<-3> [STF]'))
summary(wqdat2$temp)

#That didn't work. It's because of the brackets. Here's how to handle it:
wqdat2 <- qaqc(wqdat, qaqc_keep = c(0, '<-3> \\[STF\\]'))
summary(wqdat2$temp)

#Back to just keeping 0, 1, and 5 flags to see how the plot turns out.
wqdat2 <- qaqc(wqdat, qaqc_keep = c(0,1,5))

#Step 6: Plot the fruits of your labor!
plot(temp ~ datetimestamp, data = wqdat2,
     type = "l",
     col = "red",
     main = "Temperature at PC 2012 - 2015",
     xlab = "Date",
     ylab = "Temp (C)")

#This ends Case Study 1
#Next up is using aggreswmp to make data time steps more manageable

