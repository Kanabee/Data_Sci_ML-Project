library(caret)

# load clean data
data("mtcars")

# prepare data
mtcars$am <- factor(mtcars$am, levels=c(0,1), labels=c("Auto", "Manual"))

# split data
split_data <- train_test_split(mtcars)

# train model
glm_model <- train(am ~ mpg, # classification 
                   data = split_data[[1]],
                   method = "glm")

# score and evaluate
p <- predict(glm_model, newdata=split_data[[2]])

acc <- mean(p == split_data[[2]]$am)

glm_model

acc
