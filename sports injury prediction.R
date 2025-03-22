


#Step 1: Loading the dataset
library(readr)
data<- read.csv("C:/Users/kidig/OneDrive/Desktop/r packages/injurydataset.csv")
head(data)

#Step 3: Convert the target variable to a factor
data$Likelihood_of_Injury <- as.factor(data$Likelihood_of_Injury)

#step 2: Exploring the data
summary(data)  # Summary statistics
str(data)      # Data structure


# Checking for missing values
sum(is.na(data))

# Step 3: Preprocessing the data
install.packages("caret")
library(caret)
# Normalize numerical features
preprocess_params <- preProcess(data[, c("Player_Age", "Player_Weight", "Player_Height", "Training_Intensity", "Recovery_Time")], method = c("center", "scale"))
data_normalized <- predict(preprocess_params, data)

# Step 4: Spliting the data into training and testing sets
set.seed(123)  # For reproducibility
split_index <- createDataPartition(data_normalized$Likelihood_of_Injury, p = 0.8, list = FALSE)
train_data <- data_normalized[split_index, ]
test_data <- data_normalized[-split_index, ]

# Step 5: Training a machine learning model (e.g., logistic regression)
model <- train(
  Likelihood_of_Injury ~ .,  # Predict injury likelihood using all other columns
  data = train_data,
  method = "glm",           # Generalized Linear Model (logistic regression)
  family = "binomial",       # For binary classification
  trControl = trainControl(method = "cv", number = 5)  # 5-fold cross-validation
)

# Step 8: Evaluate the model
predictions <- predict(model, newdata = test_data)
confusionMatrix(predictions, test_data$Likelihood_of_Injury)  # Confusion matrix

# ROC-AUC analysis
install.packages("ggplot2")   # For visualization
install.packages("pROC")      # For ROC-AUC analysis
library(dplyr)
library(ggplot2)
library(pROC)
roc_curve <- roc(test_data$Likelihood_of_Injury, as.numeric(predictions))
plot(roc_curve, main = "ROC Curve")
auc(roc_curve)  # Area under the curve

# Step 8: Feature importance (if using a tree-based model)
library(caret)
varImp(model)  # View feature importance

# Step 10: Save the model (optional)
saveRDS(model, "injury_prediction_model.rds")



