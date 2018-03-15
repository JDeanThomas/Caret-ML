library(ElemStatLearn)
library(randomForest)
library(caret)
data(vowel.train)
data(vowel.test) 

# Fit a random forest predictor relating the factor variable y 
# to the remaining variables and a boosted predictor using 
# the "gbm" method.

vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)

set.seed(33833)

# create models
fit1 <- train(y ~ ., data = vowel.train, method = "rf", trControl = trainControl(number = 4))
fit2 <- train(y ~ ., data = vowel.train, method = "gbm")

# predict test
predict1 <- predict(fit1, newdata = vowel.test)
predict2 <- predict(fit2, newdata = vowel.test)

# combine predictions
DF_combined <- data.frame(predict1, predict2, y = vowel.test$y)
fit_combined <- train(y ~ ., data = DF_combined, method = "gam")
predict3 <- predict(fit_combined, newdata = vowel.test)

# confusion matrixes
c1 <- confusionMatrix(predict1, vowel.test$y)
c2 <- confusionMatrix(predict2, vowel.test$y)
c3 <- confusionMatrix(predict3, DF_combined$y)

