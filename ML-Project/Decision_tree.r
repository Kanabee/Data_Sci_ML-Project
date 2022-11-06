### decision tree

install.packages("rpart.plot")
library(rpart.plot)

tree_model <- train(diabetes ~ .,
                      data = train_data,
                      method = "rpart"
                      )
tree_model



rpart.plot(tree_model$finalModel)

varImp(tree_model)
