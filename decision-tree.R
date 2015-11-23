#!/usr/bin/RScript

# Supervised learning using a decision tree

# Usage

# ./decision-tree.R --temp 20 --ap 1000 --wd NE

# Arguments

args <- commandArgs(trailingOnly = TRUE)
temp <- as.integer(args[2])
ap <- as.integer(args[4])
wd <- args[6]

# Require the libraries
library(rpart)
library(gdata)

# Read data from CSV
captures = read.csv('train.csv')

# Set a random seed
set.seed(1)

# If a model exists load it, else fit and save it
if(file.exists('dtree.rds')) {
    print('>> Reading saved model...')
    tree <- readRDS('dtree.rds')
} else {
  print('>> Fitting new model')
  tree <- rpart(
    Label ~ AirPressure + Temperature + WindDirection,
    data = captures, method = "class"
  )

  saveRDS(tree, file = 'dtree.rds')
}

# A dataframe containing unseen observations
unseen <- data.frame(
  Temperature = c(temp),
  AirPressure = c(ap),
  WindDirection = c(wd)
)

# Predict the label of the unseen observation
pred = predict(tree, unseen, type="class")

print(pred[1])
