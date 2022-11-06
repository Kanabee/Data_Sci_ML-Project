### Random forest

ctrl <- trainControl(method = "cv",
                     number = 5,
                      verboseIter = TRUE)

grid <- data.frame(mtry = c(3,5))

rf_model <- train(diabetes ~ .,
                    data = train_data,
                    method = "rf",
                  trControl = ctrl,
                  tuneGrid = grid)
                  

rf_model
