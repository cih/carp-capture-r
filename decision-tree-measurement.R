#!/usr/bin/RScript

# Measuring supervised learning using a decision tree

# Usage

# ./decision-tree-measurement.R

# Require the libraries
library(rpart)
library(gdata)
library(caret)

# Read data from CSV
captures = read.csv('train.csv')
test_captures = read.csv('test.csv')

# Set a random seed
set.seed(1)

# Build a decision tree model
tree <- rpart(
  Label ~ AirPressure + Temperature + WindDirection,
  data = captures, method = "class"
)

# Predict the label of the unseen observation
pred = predict(tree, test_captures, type="class")

conf_table = table(test_captures$Label, pred)

matrix = confusionMatrix(conf_table)

print(conf_table)
print(matrix)
