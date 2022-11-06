install.packages("caret")
library(caret)

mtcars

# split data
train_test_split <- function(data) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(n, size=0.8*n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list(train_data, test_data))
}

split_data <- train_test_split(mtcars)

split_data[[1]]  ## Train_data
split_data[[2]]  ## Test_data

# train model
lm_model <- train(mpg ~ hp, 
                  data = split_data[[1]],
                  method = "lm")

lm_model

# score and evaluate

p <- predict(lm_model, newdata=split_data[[2]]) ## predict 

p

error <- split_data[[2]]$mpg - p
rmse <- sqrt(mean(error**2))
rmse

lm_model
