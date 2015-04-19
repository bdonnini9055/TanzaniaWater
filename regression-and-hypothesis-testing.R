training <- read.csv("train-with-numbers.csv")

fit <- lm(numStatus ~ amount_tsh + construction_year + longitude + latitude + numSource + numQuantity, data=training)
summary(fit) # show results

library(leaps)

regsubsets.out <-
  regsubsets(numStatus ~ amount_tsh + gps_height + population + construction_year + longitude + latitude + numSource + 
               numBasin + numQuantity + numLga + numExtraction_type + numPayment_type + numWater_quality + numQuantity + numWaterpoint_type, data = training)
regsubsets.out

summary.out <- summary(regsubsets.out)
as.data.frame(summary.out$outmat)

plot(regsubsets.out, scale = "adjr2", main = "Adjusted R^2")

#both
length(training[training$amount_tsh == 0 & training$construction_year == 0,1])

#just tsh
length(training[training$amount_tsh == 0,1])

#just construction_Year
length(training[training$construction_year == 0,1])


#For construction year
fit2 <- lm(construction_year ~ amount_tsh + gps_height + longitude +  latitude +  population + num_private, data=training)
summary(fit2) # show results 

numExtract <- read.csv("fullNumericExtract.csv")
training$numExtractType <- numExtract$value

# for constructoin year
library(leaps)

regsubsets.out2 <-
  regsubsets(construction_year ~ amount_tsh + gps_height + population + longitude + latitude + numExtractType, data = training)
regsubsets.out2

summary.out <- summary(regsubsets.out2)
as.data.frame(summary.out$outmat)

plot(regsubsets.out2, scale = "adjr2", main = "Adjusted R^2")


