rain.train <- read.csv("small_train_2013.csv")
library(data.table)
library(plyr)

#First, I need to do an example with just one variable so I can get the "count" column:

RR1 <- data.frame(rain.train$Id, rain.train$RR1)
names(RR1) <- c("count", "RR1")



RR1 <- data.table(RR1)
RR1$RR1 <- as.character(RR1$RR1)
RR1 <- RR1[, list(RR1f = unlist(strsplit(RR1, " "))), by = count]

RR1$RR1f <- as.character(RR1$RR1f)
RR1$RR1f[RR1$RR1f=="-99900.0"] <- NA

RR1 <- data.frame(RR1)


##########################################################################################
#flatten RR2
##########################################################################################

final <- data.frame(RR1$count, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
names(final) <- c("Id", "TimeToEnd", "DistanceToRadar", "Composite", "HybridScan", "HydrometerType", "Kdp", "RR1", "RR2", "RR3", 
                  "RadarQualityIndex", "Reflectivity", "ReflectivityQC", "RhoHV", "Velocity", "Zdr", "LogWaterVolume",
                  "MassWeightedMean", "MassWeightedSD", "Expected")

for (i in 3:16) {
var <- data.frame(rain.train$Id, rain.train[,i])
names(var) <- c("count", "var")

var <- data.table(var)
var$var <- as.character(var$var)
var <- var[, list(varf = unlist(strsplit(var, " "))), by = count]

var$varf <- as.character(var$varf)
var$varf[var$varf=="-99900.0"] <- NA
var$varf[var$varf=="-99901.0"] <- NA
var$varf[var$varf=="-99903.0"] <- NA
var$varf[var$varf=="999.0"] <- NA


var <- data.frame(var)

final[,i] <- var$varf
}

# We need to append LogWaterVolume, WMassWeightedMEan, and MassWeightedSD separately because they have
# empty cells

for (i in 17:19) {
MassWeightedSD <- data.frame(rain.train$Id, rain.train[,i])
names(MassWeightedSD) <- c("count", "MassWeightedSD")

MassWeightedSD$MassWeightedSD[MassWeightedSD$MassWeightedSD==""] <- NA

MassWeightedSD <- data.table(MassWeightedSD)
MassWeightedSD$MassWeightedSD <- as.character(MassWeightedSD$MassWeightedSD)
MassWeightedSD <- MassWeightedSD[, list(MassWeightedSDf = unlist(strsplit(MassWeightedSD, " "))), by = count]

MassWeightedSD$MassWeightedSDf <- as.character(MassWeightedSD$MassWeightedSDf)
MassWeightedSD$MassWeightedSDf[MassWeightedSD$MassWeightedSDf=="-99900.0"] <- NA
MassWeightedSD$MassWeightedSDf[MassWeightedSD$MassWeightedSDf=="-99901.0"] <- NA
MassWeightedSD$MassWeightedSDf[MassWeightedSD$MassWeightedSDf=="-99903.0"] <- NA
MassWeightedSD$MassWeightedSDf[MassWeightedSD$MassWeightedSDf=="999.0"] <- NA

MassWeightedSD <- data.frame(MassWeightedSD)

final[,i] <- MassWeightedSD$MassWeightedSDf
}

#Finally, append Expected:

for (i in 1:7916){
  row <- final$Id[i]
  final$Expected[i] <- rain.train$Expected[row]
}

# output
write.csv(final, "one-row-for-each-observation-without-time-to-end.csv")
