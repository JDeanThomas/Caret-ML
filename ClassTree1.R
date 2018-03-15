library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rpart)
install.packages(rattle)

set.seed(125)

# Subset the data to a training set and testing set based on the Case variable in the data set.

inTrain <- createDataPartition(y = segmentationOriginal$Case, list = FALSE)
train <- subset(segmentationOriginal, Case == "Train")
test <- subset(segmentationOriginal, Case == "Test")

# Set the seed to 125 and fit a CART model with the rpart method using all 
# predictor variables and default caret settings. 

modFit <- train(Class ~ ., data = train, method = "rpart")
modFit$finalModel

plot(modFit$finalModel, uniform = TRUE, main = "Classification Tree")
text(modFit$finalModel, use.n = TRUE, all = TRUE, cex = .8)

fancyRpartPlot(modFit$finalModel)
fancyRpartPlot(modFit)


predict(modFit, newdata = train)