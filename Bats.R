#Load the data on the number of visitors to the instructors blog from here: 
#  https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv

library(forecast)
library(quantmod)
library(lubridate)  

dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

# Fit a model using the bats() function in the forecast package to 
# the training time series. Then forecast tmodel.

# fit model
fit <- bats(tstrain)

# check how long the test set is, so you can predict beyond trainign
h <- dim(testing)[1]

# forecast model for remaining time points
fcast <- forecast(fit, level = 95, h = h)

# get accuracy
accuracy(fcast, testing$visitsTumblr)


# What percentage of times that the actual number of 
# visitors was within 95% CI?

result <- c()
l <- length(fcast$lower)

for (i in 1:l){
  x <- testing$visitsTumblr[i]
  a <- fcast$lower[i] < x & x < fcast$upper[i]
  result <- c(result, a)
}

sum(result)/l * 100
