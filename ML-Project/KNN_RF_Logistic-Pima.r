install.packages("mlbench")
install.packages("PimaIndiansDiabetes")
install.packages("dplyr")
install.packages("caret")

library(mlbench)
data("PimaIndiansDiabetes")
library(dplyr)
library(caret)

df <- PimaIndiansDiabetes

df %>%
  count(diabetes)%>%
  mutate(pct = n/sum(n))

### Train test split

split_data <-train_test_split(df)
train_data <- split_data[[1]]
test_data <- split_data[[2]]

nrow(train_data);nrow(test_data)


### Train model
set.seed(42)
ctrl <- trainControl( method = "cv",
                     number =5 ,
                     verboseIter = TRUE)

model <- train(diabetes ~ .,
               data = train_data,
               method = "knn",
               trControl = ctrl,
               metric = "Accuracy")

model

p <- predict(model , newdata = test_data)

mean(p == test_data$diabetes)


### Build Random Forest Model

set.seed(42)
rf_model <- train(diabetes ~ .,
               data = train_data,
               method = "rf",
               trControl = ctrl,
               metric = "Accuracy")
rf_model

p2 <- predict(rf_model , newdata = test_data)

mean(p2 == test_data$diabetes)


### Build Logistic reg

set.seed(42)
logistic_model <- train(diabetes ~ .,
                  data = train_data,
                  method = "glm",
                  trControl = ctrl,
                  metric = "Accuracy")
logistic_model

p2 <- predict(logistic_model , newdata = test_data)

mean(p2 == test_data$diabetes)




list_model <- list(
  KNN = model,
  Random_forest = rf_model,
  Logistic = logistic_model
)
result <- resamples(list_model)
summary(result)


logistic_model$finalModel

