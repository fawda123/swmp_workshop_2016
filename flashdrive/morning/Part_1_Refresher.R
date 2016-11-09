#Part 1: Refresher on reading in data and beginning to plot
#Written by Kim Cressman

#Step 1: Set your working directory, where you tell R to search for your saved data files
setwd("C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016")

#Step 2: Reads in a file
read.csv("GNDPCWQ2015.csv")
wqdat <- read.csv("GNDPCWQ2015.csv")

#Step 3: See what your new object looks like
head(wqdat)
head(wqdat, 10)
tail(wqdat)
summary(wqdat)
names(wqdat)
str(wqdat)

#Step 4: Make a plot
#Don't actually make this one; just watch what happens on the instructors' computer.
#plot(Temp~DateTimeStamp, data=wqdat)

#Error! We have to first make our date change froma  factor to a date
str(wqdat$Temp)
str(wqdat$DateTimeStamp)
wqdat$DateTime <- as.POSIXct(wqdat$DateTimeStamp, format="%m/%d/%Y %H:%M", tz="America/Regina")
head(wqdat)

#Let's try plotting again!
plot(Temp ~ DateTime, data=wqdat)

#Change the plotting parameters to make more interesting
plot(Temp ~ DateTime, data = wqdat,
     type = "l",
     col = "red",
     main = "Temperature at PC in 2015",
     xlab = "Date",
     ylab = "Temp (C)")

plot(Temp ~ DateTime, data = wqdat,
     type = "l",
     col = "red",
     main = "Temperature at PC in 2015",
     xlab = "Date",
     ylab = "Temp (C)",
     ylim = c(-5, 40))

plot(Temp ~ DateTime, data = wqdat,
     type = "l",
     col = "red",
     main = "Temperature at PC in 2015",
     xlab = "Date",
     ylab=expression(paste("Temperature (",degree,"C)")), 
     ylim = c(-5, 40))

#Step 5: Install the SWMPr package
install.packages("SWMPr")
library(SWMPr)

#This ends the Refresher! 
#Now we will use SWMPr to read in and QC some real data

