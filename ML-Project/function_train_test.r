##function

train_test_split <- function(data , train_size =0.8){
    
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n ,size = n*train_size)
  train_data = data[id , ]
  test_data = data[-id, ]
  
  return(list(train_data,test_data))
    
}
