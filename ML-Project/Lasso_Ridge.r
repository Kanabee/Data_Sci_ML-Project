# predict disbetes Lasso Ridge



set.seed(42)

ctrl <- trainControl(method =  "cv",
                     number = 5 ,
                     verboseIter = TRUE)

grid <- expand.grid(alpha = c(0,1),
                    lambda = seq(0, 1, by = 0.03)
                    )

glmnet_model <- train(diabetes ~ .,
                        data = train_data,
                        method = "glmnet",
                        trControl = ctrl,
                        metric = "Accuracy",
                        tuneGrid = grid)
glmnet_model

## evaluate model

p <- predict(glmnet_model , newdata = test_data)

confusionMatrix(p,test_data$diabetes)
