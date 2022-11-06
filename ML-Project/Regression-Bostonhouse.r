install.packages("mlbench")
install.packages("BostonHousing")
install.packages("PimaIndianDiabetes")
install.packages("dplyr")
install.packages("caret")

library(caret)

library(mlbench)
library(dplyr)
data("BostonHousing")

mean(complete.cases(BostonHousing))

## Train test split


split_data <-train_test_split(BostonHousing)
train_data <- split_data[[1]]
test_data <- split_data[[2]]

nrow(train_data);nrow(test_data)

## Train model

model <- train(medv ~ crim + indus +rm,
               data = train_data,
               method = "lm")


#### Train KNN 

ctrl <- trainControl(method = "repeatedCV",
                     number =5,
                     repeats =5,
                     verboseIter = TRUE)

### grid search

grid <- data.frame(k = c(3,5,9))

model_knn <- train(medv ~ lstat+rm+indus,
               data = train_data,
               method = "knn",
               metrix = "Rsquared",
               trControl = ctrl,
               tuneGrid = grid )

model_knn

### Score

p <- predict(model_knn,
             newdata = test_data)


RMSE(p,test_data$medv)

### Feature Important

varImp(model_knn)
