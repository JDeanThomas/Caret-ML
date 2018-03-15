library(AppliedPredictiveModeling)
data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Fit support vector machine using the e1071 package 
# to predict Compressive Strength using the default settings.
set.seed(325)

library(e1071)
library(caret)

fit <- train(CompressiveStrength ~ ., data = training, method = "svmRadial")

prediction <- predict(fit, testing)

accuracy(prediction, testing$CompressiveStrength)
