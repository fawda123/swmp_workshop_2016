#Part 2: Case Studies - Using SWMPr to deal with difficult data
#Case Study 2: Aggregating Data
#Written by Kari St.Laurent

#Step 1: The ususal, set your working directory and import data
library(SWMPr)

wd <-("C:/Users/kari.stlaurent/Documents/R_Directory/NERRS SWMPr course 2016")

sjmet <- import_local(wd, 'delsjmet', trace = T)

head(sjmet)

head(sjmet$atemp)

#Step 2: Let's Plot our data
plot(atemp ~ datetimestamp, data = sjmet,
     type = "o",
     lwd= 2,
     lty=3,
     col = "cornflowerblue",
     main = "Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"C)")),
     ylim = c(-15, 40))

#Step 3: Select the 0 QC flags for our data just for the practice!
qaqcchk(sjmet)

sjmet<-qaqc(sjmet, qaqc_keep = c('0'))

plot(atemp ~ datetimestamp, data = sjmet,
     type = "o",
     lwd= 2,
     lty=3,
     col = "cornflowerblue",
     main = "Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"C)")),
     ylim = c(-15, 40))

#Step 4a: Use Aggreswmp to convert the 15 minute into hourly data
hours<-aggreswmp(sjmet, 'hours', params = c('atemp')) 

class(hours)

names(hours)

plot(hours,
     type = "l",
     lwd= 2,
     lty=1,
     col = "cornflowerblue",
     main = "Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"C)")),
     ylim = c(-15, 40))

#Step 4b: Into monthly data
months<-aggreswmp(sjmet, 'months', params = c('atemp')) 

plot(months,
     type = "l",
     lwd= 2,
     lty=1,
     col = "cornflowerblue",
     main = "Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"C)")),
     ylim = c(-15, 40))

ticks <- seq(months$datetimestamp[1], months$datetimestamp[length(months$datetimestamp)], by = "months")
axis(1, at = ticks, labels = F, tcl = -0.3)

#Bonus: Change your x-axis to reflex your new time interval
plot(months,
     type = "l",
     lwd= 2,
     lty=1,
     col = "cornflowerblue",
     main = "Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"C)")),
     ylim = c(-15, 40),
     xaxt='n')
axis(side=1, at=months$datetimestamp, label=format(months$datetimestamp, "%b"), cex.axis=0.8)

#Step 4c: Stack all these plots onto one another 

colors<-c("pink","plum3","darkorchid4")

plot(atemp ~ datetimestamp, data = sjmet,
     type = "o",
     lwd= 2,
     lty=3,
     col = colors[1],
     main = "Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"C)")),
     ylim = c(-15, 40))
par(new=T)
plot(hours,
     type = "l",
     lwd= 2,
     lty=1,
     col = colors[2],
     main = "",
     xlab = "",
     ylab = "",
     ylim = c(-15, 40),
     xaxt='n',
     yaxt='n')
par(new=T)
plot(months,
     type = "l",
     lwd= 2,
     lty=1,
     col = colors[3],
     main = "",
     xlab = "",
     ylab = "",
     ylim = c(-15, 40),
     xaxt='n',
     yaxt='n')
#Step 5: Aggregate by a different operator, such as max value
hot<-aggreswmp(sjmet, by='weeks',FUN=max, params = c('atemp')) 

plot(hot, 
     type = "o",
     pch=14,
     col = colors[3],
     main = "Warmest Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"C)")),
     ylim = c(0, 40))

#Step 5a: Custom make your function, such as converting C to F
F<-aggreswmp(sjmet, by='months',FUN= function(x) mean(x, na.rm=T)*1.8+32, params = c('atemp')) 

plot(F, 
     type = "l",
     pch=14,
     col = colors[3],
     main = "Warmest Temperature at SJ 2012-2016",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"F)")),
     ylim = c(0, 100))

#Step 6: Subset
August<-aggreswmp(sjmet, by='hours',FUN= min, params = c('atemp')) 

cool<-subset(August, subset=c('2016-08-01 0:00', '2016-08-31 23:45'))

plot(cool, 
     type = "l",
     pch=14,
     col = colors[3],
     main = "Coolest August 2016 Temperatures at SJ",
     xlab = "Date",
     ylab = expression(paste("Temperature (",degree,"F)")),
     ylim = c(15, 40))

#Step 6a: Try it plotted as a histogram
hist(cool$atemp, col=rgb(1,0,0,0.5),
     xlim=c(10,40),
     ylim=c(0,200), 
     main="Coolest Air Temperature August 2016", 
     xlab=expression(paste("Temperature (",degree,"C)")))

#Step 7: Plotting multiple parameters
storm<-aggreswmp(sjmet, by='hours', params = c('totprcp', 'bp')) 

plot(storm$totprcp~storm$datetimestamp, 
     type = "l",
     pch=14,
     col = "darkturquoise",
     main = "Overplot Primer SJ 2012-2016",
     xlab = "Date",
     ylab = "Precipitation")
par(new=T)
plot(storm$bp~storm$datetimestamp, 
     type = "l",
     pch=14,
     col = "gold4",
     main = "",
     xlab = "",
     ylab = "Barometric Pressure")

#7a: Build a second y-axis

par(mar=c(4,4,4,4))

plot(storm$totprcp~storm$datetimestamp, 
     type = "l",
     pch=14,
     col = "darkturquoise",
     main = "Overplot Primer SJ 2012-2016",
     xlab = "Date",
     ylab = "Precipitation")
par(new=T)
plot(storm$bp~storm$datetimestamp, 
     type = "l",
     pch=14,
     col = "gold4",
     main = "",
     xlab = "",xaxt='n',
     ylab = "", yaxt='n')

axis(side = 4)
mtext(side = 4, line = 3, 'Barometric Pressure')

legend("topleft", legend=c("Precipitation", "Barometric Pressure"), 
       col = c("darkturquoise","gold4"),
       bty = "n", lty=1, lwd=2, pch=16)

#Step 8: Boxplot

head(sjmet)

aggreswmp(sjmet, 'months', params = c('atemp'), plot = T)

#Make it Prettier
par(mar=c(4,4,4,4))

temperature<-aggreswmp(sjmet, 'months', params = c('atemp'))
t.2012<-subset(temperature, subset=c('2012-01-01 0:00', '2012-12-31 23:45'))
t.2013<-subset(temperature, subset=c('2013-01-01 0:00', '2013-12-31 23:45'))
t.2014<-subset(temperature, subset=c('2014-01-01 0:00', '2014-12-31 23:45'))
t.2015<-subset(temperature, subset=c('2015-01-01 0:00', '2015-12-31 23:45'))

temperature<-data.frame(t.2012$atemp,t.2013$atemp,t.2014$atemp,t.2015$atemp)

colnames(temperature) <- c("2012", "2013", "2014","2015")

cols <- heat.colors(4)

boxplot(temperature, 
        main="Box Plot", 
        xlab=expression(paste("Temperature (",degree,"C)")),
        ylab="Year",
        col=cols)

#Or....

plot_summary(sjmet, param="atemp")
