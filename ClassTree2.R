library(caret)
library(pgmm)
data(olive)
olive = olive[,-1]
library(randomForest)

# Fit a classification tree where Area is the outcome variable. 
# Predict the value of area for the following data frame using the tree command.

model <- train(Area ~ ., data = olive, method = "rpart2")

newdata = as.data.frame(t(colMeans(olive)))

predict(model, newdata = newdata)

