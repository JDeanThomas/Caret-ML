set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Fit lasso model to predict Compressive Strength. 
library(caret)

set.seed(233)


fit <- train(CompressiveStrength ~ ., data = training, method = "lasso")


plot.enet(fit$finalModel, xvar = "penalty", use.color = TRUE)
