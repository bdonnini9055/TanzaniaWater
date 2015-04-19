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
