rain.train <- read.csv("small_train_2013.csv")
library(data.table)
library(plyr)

##########################################################################################
# flatten composite columns
##########################################################################################

#flatten RR2

RR2 <- data.frame(rain.train$Id, rain.train$RR2)
names(RR2) <- c("count", "RR2")
 

RR2 <- data.table(RR2)
RR2$RR2 <- as.character(RR2$RR2)
RR2 <- RR2[, list(RR2f = unlist(strsplit(RR2, " "))), by = count]

RR2$RR2f <- as.character(RR2$RR2f)
RR2$RR2f[RR2$RR2f=="-99900.0"] <- NA

RR2 <- data.frame(RR2)
# RR2 <- RR2[complete.cases(RR2),]

expected <- data.frame(rain.train$Expected, rain.train$Id)
names(expected) <- c("expected", "count")

  
RR2$RR2f <- as.numeric(RR2$RR2f)
RR2$count <- as.factor(RR2$count)

works <- ddply(RR2, .(count), summarise,
                      RR2 = mean(RR2f,na.rm=TRUE))

final <- merge(works, expected, by.x = "count", by.y = "count")
final <- final[order(final$count),] 

##########################################################################################
# flatten rr1
##########################################################################################
RR1 <- data.frame(rain.train$Id, rain.train$RR1)
names(RR1) <- c("count", "RR1")

 

RR1 <- data.table(RR1)
RR1$RR1 <- as.character(RR1$RR1)
RR1 <- RR1[, list(RR1f = unlist(strsplit(RR1, " "))), by = count]

RR1$RR1f <- as.character(RR1$RR1f)
RR1$RR1f[RR1$RR1f=="-99900.0"] <- NA

RR1 <- data.frame(RR1)
#RR1 <- RR1[complete.cases(RR1),]


  
RR1$RR1f <- as.numeric(RR1$RR1f)
RR1$count <- as.factor(RR1$count)

works <- ddply(RR1, .(count), summarise,
               RR1 = mean(RR1f))
final$RR1 <- works$RR1

##########################################################################################
# distance to radar
##########################################################################################

DistanceToRadar <- data.frame(rain.train$Id, rain.train$DistanceToRadar)
names(DistanceToRadar) <- c("count", "DistanceToRadar")

 

DistanceToRadar <- data.table(DistanceToRadar)
DistanceToRadar$DistanceToRadar <- as.character(DistanceToRadar$DistanceToRadar)
DistanceToRadar <- DistanceToRadar[, list(DistanceToRadarf = unlist(strsplit(DistanceToRadar, " "))), by = count]

DistanceToRadar$DistanceToRadarf <- as.character(DistanceToRadar$DistanceToRadarf)
DistanceToRadar$DistanceToRadarf[DistanceToRadar$DistanceToRadarf=="-99900.0"] <- NA

DistanceToRadar <- data.frame(DistanceToRadar)
#DistanceToRadar <- DistanceToRadar[complete.cases(DistanceToRadar),]


  
DistanceToRadar$DistanceToRadarf <- as.numeric(DistanceToRadar$DistanceToRadarf)
DistanceToRadar$count <- as.factor(DistanceToRadar$count)

worksDistanceToRadar <- ddply(DistanceToRadar, .(count), summarise,
               DistanceToRadar = mean(DistanceToRadarf))
final$DistanceToRadar <- worksDistanceToRadar$DistanceToRadar

##########################################################################################
# HybridScan
##########################################################################################

Composite <- data.frame(rain.train$Id, rain.train$Composite)
names(Composite) <- c("count", "Composite")

 

Composite <- data.table(Composite)
Composite$Composite <- as.character(Composite$Composite)
Composite <- Composite[, list(Compositef = unlist(strsplit(Composite, " "))), by = count]

Composite$Compositef <- as.character(Composite$Compositef)
Composite$Compositef[Composite$Compositef=="-99900.0"] <- NA

Composite <- data.frame(Composite)
#Composite <- Composite[complete.cases(Composite),]


  
Composite$Compositef <- as.numeric(Composite$Compositef)
Composite$count <- as.factor(Composite$count)

worksComposite <- ddply(Composite, .(count), summarise,
                              Composite = mean(Compositef))
final$Composite <- worksComposite$Composite

##########################################################################################
# Hybrid Scan
##########################################################################################

HybridScan <- data.frame(rain.train$Id, rain.train$HybridScan)
names(HybridScan) <- c("count", "HybridScan")

 

HybridScan <- data.table(HybridScan)
HybridScan$HybridScan <- as.character(HybridScan$HybridScan)
HybridScan <- HybridScan[, list(HybridScanf = unlist(strsplit(HybridScan, " "))), by = count]

HybridScan$HybridScanf <- as.character(HybridScan$HybridScanf)
HybridScan$HybridScanf[HybridScan$HybridScanf=="-99900.0"] <- NA

HybridScan <- data.frame(HybridScan)
#HybridScan <- HybridScan[complete.cases(HybridScan),]


  
HybridScan$HybridScanf <- as.numeric(HybridScan$HybridScanf)
HybridScan$count <- as.factor(HybridScan$count)

worksHybridScan <- ddply(HybridScan, .(count), summarise,
                        HybridScan = mean(HybridScanf))
final$HybridScan <- worksHybridScan$HybridScan

##########################################################################################
# HydrometeorType
##########################################################################################

HydrometeorType <- data.frame(rain.train$Id, rain.train$HydrometeorType)
names(HydrometeorType) <- c("count", "HydrometeorType")

 

HydrometeorType <- data.table(HydrometeorType)
HydrometeorType$HydrometeorType <- as.character(HydrometeorType$HydrometeorType)
HydrometeorType <- HydrometeorType[, list(HydrometeorTypef = unlist(strsplit(HydrometeorType, " "))), by = count]

HydrometeorType$HydrometeorTypef <- as.character(HydrometeorType$HydrometeorTypef)
HydrometeorType$HydrometeorTypef[HydrometeorType$HydrometeorTypef=="-99900.0"] <- NA

HydrometeorType <- data.frame(HydrometeorType)
#HydrometeorType <- HydrometeorType[complete.cases(HydrometeorType),]


  
HydrometeorType$HydrometeorTypef <- as.numeric(HydrometeorType$HydrometeorTypef)
HydrometeorType$count <- as.factor(HydrometeorType$count)

worksHydrometeorType <- ddply(HydrometeorType, .(count), summarise,
                         HydrometeorType = mean(HydrometeorTypef))
final$HydrometeorType <- worksHydrometeorType$HydrometeorType

##########################################################################################
# Kdp
##########################################################################################

Kdp <- data.frame(rain.train$Id, rain.train$Kdp)
names(Kdp) <- c("count", "Kdp")

 

Kdp <- data.table(Kdp)
Kdp$Kdp <- as.character(Kdp$Kdp)
Kdp <- Kdp[, list(Kdpf = unlist(strsplit(Kdp, " "))), by = count]

Kdp$Kdpf <- as.character(Kdp$Kdpf)
Kdp$Kdpf[Kdp$Kdpf=="-99900.0"] <- NA

Kdp <- data.frame(Kdp)
#Kdp <- Kdp[complete.cases(Kdp),]


  
Kdp$Kdpf <- as.numeric(Kdp$Kdpf)
Kdp$count <- as.factor(Kdp$count)

worksKdp <- ddply(Kdp, .(count), summarise,
                              Kdp = mean(Kdpf))
final$Kdp <- worksKdp$Kdp

##########################################################################################
# Radar Quality Index
##########################################################################################

RadarQualityIndex <- data.frame(rain.train$Id, rain.train$RadarQualityIndex)
names(RadarQualityIndex) <- c("count", "RadarQualityIndex")

 

RadarQualityIndex <- data.table(RadarQualityIndex)
RadarQualityIndex$RadarQualityIndex <- as.character(RadarQualityIndex$RadarQualityIndex)
RadarQualityIndex <- RadarQualityIndex[, list(RadarQualityIndexf = unlist(strsplit(RadarQualityIndex, " "))), by = count]

RadarQualityIndex$RadarQualityIndexf <- as.character(RadarQualityIndex$RadarQualityIndexf)
RadarQualityIndex$RadarQualityIndexf[RadarQualityIndex$RadarQualityIndexf=="-99900.0"] <- NA

RadarQualityIndex <- data.frame(RadarQualityIndex)
#RadarQualityIndex <- RadarQualityIndex[complete.cases(RadarQualityIndex),]


  
RadarQualityIndex$RadarQualityIndexf <- as.numeric(RadarQualityIndex$RadarQualityIndexf)
RadarQualityIndex$count <- as.factor(RadarQualityIndex$count)

worksRadarQualityIndex <- ddply(RadarQualityIndex, .(count), summarise,
                  RadarQualityIndex = mean(RadarQualityIndexf))
final$RadarQualityIndex <- worksRadarQualityIndex$RadarQualityIndex

##########################################################################################
# RR3
##########################################################################################

RR3 <- data.frame(rain.train$Id, rain.train$RR3)
names(RR3) <- c("count", "RR3")

 

RR3 <- data.table(RR3)
RR3$RR3 <- as.character(RR3$RR3)
RR3 <- RR3[, list(RR3f = unlist(strsplit(RR3, " "))), by = count]

RR3$RR3f <- as.character(RR3$RR3f)
RR3$RR3f[RR3$RR3f=="-99900.0"] <- NA

RR3 <- data.frame(RR3)
#RR3 <- RR3[complete.cases(RR3),]


  
RR3$RR3f <- as.numeric(RR3$RR3f)
RR3$count <- as.factor(RR3$count)

worksRR3 <- ddply(RR3, .(count), summarise,
                                RR3 = mean(RR3f))
final$RR3 <- worksRR3$RR3

##########################################################################################
# Reflectivity
##########################################################################################

Reflectivity <- data.frame(rain.train$Id, rain.train$Reflectivity)
names(Reflectivity) <- c("count", "Reflectivity")

 

Reflectivity <- data.table(Reflectivity)
Reflectivity$Reflectivity <- as.character(Reflectivity$Reflectivity)
Reflectivity <- Reflectivity[, list(Reflectivityf = unlist(strsplit(Reflectivity, " "))), by = count]

Reflectivity$Reflectivityf <- as.character(Reflectivity$Reflectivityf)
Reflectivity$Reflectivityf[Reflectivity$Reflectivityf=="-99900.0"] <- NA

Reflectivity <- data.frame(Reflectivity)
#Reflectivity <- Reflectivity[complete.cases(Reflectivity),]


  
Reflectivity$Reflectivityf <- as.numeric(Reflectivity$Reflectivityf)
Reflectivity$count <- as.factor(Reflectivity$count)

worksReflectivity <- ddply(Reflectivity, .(count), summarise,
                  Reflectivity = mean(Reflectivityf))
final$Reflectivity <- worksReflectivity$Reflectivity

##########################################################################################
# ReflectivityQC
##########################################################################################

ReflectivityQC <- data.frame(rain.train$Id, rain.train$ReflectivityQC)
names(ReflectivityQC) <- c("count", "ReflectivityQC")

 

ReflectivityQC <- data.table(ReflectivityQC)
ReflectivityQC$ReflectivityQC <- as.character(ReflectivityQC$ReflectivityQC)
ReflectivityQC <- ReflectivityQC[, list(ReflectivityQCf = unlist(strsplit(ReflectivityQC, " "))), by = count]

ReflectivityQC$ReflectivityQCf <- as.character(ReflectivityQC$ReflectivityQCf)
ReflectivityQC$ReflectivityQCf[ReflectivityQC$ReflectivityQCf=="-99900.0"] <- NA

ReflectivityQC <- data.frame(ReflectivityQC)
#ReflectivityQC <- ReflectivityQC[complete.cases(ReflectivityQC),]


  
ReflectivityQC$ReflectivityQCf <- as.numeric(ReflectivityQC$ReflectivityQCf)
ReflectivityQC$count <- as.factor(ReflectivityQC$count)

worksReflectivityQC <- ddply(ReflectivityQC, .(count), summarise,
                           ReflectivityQC = mean(ReflectivityQCf))
final$ReflectivityQC <- worksReflectivityQC$ReflectivityQC

##########################################################################################
# RhoHv
##########################################################################################

RhoHV <- data.frame(rain.train$Id, rain.train$RhoHV)
names(RhoHV) <- c("count", "RhoHV")

 

RhoHV <- data.table(RhoHV)
RhoHV$RhoHV <- as.character(RhoHV$RhoHV)
RhoHV <- RhoHV[, list(RhoHVf = unlist(strsplit(RhoHV, " "))), by = count]

RhoHV$RhoHVf <- as.character(RhoHV$RhoHVf)
RhoHV$RhoHVf[RhoHV$RhoHVf=="-99900.0"] <- NA

RhoHV <- data.frame(RhoHV)
#RhoHV <- RhoHV[complete.cases(RhoHV),]


  
RhoHV$RhoHVf <- as.numeric(RhoHV$RhoHVf)
RhoHV$count <- as.factor(RhoHV$count)

worksRhoHV <- ddply(RhoHV, .(count), summarise,
                             RhoHV = mean(RhoHVf))
final$RhoHV <- worksRhoHV$RhoHV

##########################################################################################
# Velocity
##########################################################################################

Velocity <- data.frame(rain.train$Id, rain.train$Velocity)
names(Velocity) <- c("count", "Velocity")

 

Velocity <- data.table(Velocity)
Velocity$Velocity <- as.character(Velocity$Velocity)
Velocity <- Velocity[, list(Velocityf = unlist(strsplit(Velocity, " "))), by = count]

Velocity$Velocityf <- as.character(Velocity$Velocityf)
Velocity$Velocityf[Velocity$Velocityf=="-99900.0"] <- NA

Velocity <- data.frame(Velocity)
#Velocity <- Velocity[complete.cases(Velocity),]


  
Velocity$Velocityf <- as.numeric(Velocity$Velocityf)
Velocity$count <- as.factor(Velocity$count)

worksVelocity <- ddply(Velocity, .(count), summarise,
                    Velocity = mean(Velocityf))
final$Velocity <- worksVelocity$Velocity

##########################################################################################
# Zdr
##########################################################################################

Zdr <- data.frame(rain.train$Id, rain.train$Zdr)
names(Zdr) <- c("count", "Zdr")

 

Zdr <- data.table(Zdr)
Zdr$Zdr <- as.character(Zdr$Zdr)
Zdr <- Zdr[, list(Zdrf = unlist(strsplit(Zdr, " "))), by = count]

Zdr$Zdrf <- as.character(Zdr$Zdrf)
Zdr$Zdrf[Zdr$Zdrf=="-99900.0"] <- NA

Zdr <- data.frame(Zdr)
#Zdr <- Zdr[complete.cases(Zdr),]


  
Zdr$Zdrf <- as.numeric(Zdr$Zdrf)
Zdr$count <- as.factor(Zdr$count)

worksZdr <- ddply(Zdr, .(count), summarise,
                       Zdr = mean(Zdrf))
final$Zdr <- worksZdr$Zdr

##########################################################################################
# LogWaterVolume
##########################################################################################

LogWaterVolume <- data.frame(rain.train$Id, rain.train$LogWaterVolume)
names(LogWaterVolume) <- c("count", "LogWaterVolume")

LogWaterVolume$LogWaterVolume[LogWaterVolume$LogWaterVolume==""] <- NA


LogWaterVolume <- data.table(LogWaterVolume)
LogWaterVolume$LogWaterVolume <- as.character(LogWaterVolume$LogWaterVolume)
LogWaterVolume <- LogWaterVolume[, list(LogWaterVolumef = unlist(strsplit(LogWaterVolume, " "))), by = count]

LogWaterVolume$LogWaterVolumef <- as.character(LogWaterVolume$LogWaterVolumef)
LogWaterVolume$LogWaterVolumef[LogWaterVolume$LogWaterVolumef=="-99900.0"] <- NA

LogWaterVolume <- data.frame(LogWaterVolume)
#LogWaterVolume <- LogWaterVolume[complete.cases(LogWaterVolume),]


  
LogWaterVolume$LogWaterVolumef <- as.numeric(LogWaterVolume$LogWaterVolumef)
LogWaterVolume$count <- as.factor(LogWaterVolume$count)

worksLogWaterVolume <- ddply(LogWaterVolume, .(count), summarise,
                  LogWaterVolume = mean(LogWaterVolumef))
final$LogWaterVolume <- worksLogWaterVolume$LogWaterVolume

##########################################################################################
# MassWeightedMean
##########################################################################################

MassWeightedMean <- data.frame(rain.train$Id, rain.train$MassWeightedMean)
names(MassWeightedMean) <- c("count", "MassWeightedMean")

MassWeightedMean$MassWeightedMean[MassWeightedMean$MassWeightedMean==""] <- NA


MassWeightedMean <- data.table(MassWeightedMean)
MassWeightedMean$MassWeightedMean <- as.character(MassWeightedMean$MassWeightedMean)
MassWeightedMean <- MassWeightedMean[, list(MassWeightedMeanf = unlist(strsplit(MassWeightedMean, " "))), by = count]

MassWeightedMean$MassWeightedMeanf <- as.character(MassWeightedMean$MassWeightedMeanf)
MassWeightedMean$MassWeightedMeanf[MassWeightedMean$MassWeightedMeanf=="-99900.0"] <- NA

MassWeightedMean <- data.frame(MassWeightedMean)
#MassWeightedMean <- MassWeightedMean[complete.cases(MassWeightedMean),]


MassWeightedMean$MassWeightedMeanf <- as.numeric(MassWeightedMean$MassWeightedMeanf)
MassWeightedMean$count <- as.factor(MassWeightedMean$count)

worksMassWeightedMean <- ddply(MassWeightedMean, .(count), summarise,
                             MassWeightedMean = mean(MassWeightedMeanf))
final$MassWeightedMean <- worksMassWeightedMean$MassWeightedMean

##########################################################################################
# MassWeightedSD
##########################################################################################

MassWeightedSD <- data.frame(rain.train$Id, rain.train$MassWeightedSD)
names(MassWeightedSD) <- c("count", "MassWeightedSD")

MassWeightedSD$MassWeightedSD[MassWeightedSD$MassWeightedSD==""] <- NA

MassWeightedSD <- data.table(MassWeightedSD)
MassWeightedSD$MassWeightedSD <- as.character(MassWeightedSD$MassWeightedSD)
MassWeightedSD <- MassWeightedSD[, list(MassWeightedSDf = unlist(strsplit(MassWeightedSD, " "))), by = count]

MassWeightedSD$MassWeightedSDf <- as.character(MassWeightedSD$MassWeightedSDf)
MassWeightedSD$MassWeightedSDf[MassWeightedSD$MassWeightedSDf=="-99900.0"] <- NA

MassWeightedSD <- data.frame(MassWeightedSD)
#MassWeightedSD <- MassWeightedSD[complete.cases(MassWeightedSD),]


MassWeightedSD$MassWeightedSDf <- as.numeric(MassWeightedSD$MassWeightedSDf)
MassWeightedSD$count <- as.factor(MassWeightedSD$count)

worksMassWeightedSD <- ddply(MassWeightedSD, .(count), summarise,
                               MassWeightedSD = mean(MassWeightedSDf))
final$MassWeightedSD <- worksMassWeightedSD$MassWeightedSD


##########################################################################################
# And Expected
##########################################################################################

final$Expected <- rain.train$Expected

# write to Exce(l
write.csv(final, "average-value-for-each-composite-column-without-time-to-end.csv")