#!/usr/bin/RScript

# Supervised learning using a decision tree

# Usage

# ./decision-tree.R --temp 20 --ap 1000 --wd NE --label SWSO

# Arguments

args <- commandArgs(trailingOnly = TRUE)
temp <- as.integer(args[2])
ap <- as.integer(args[4])
wd <- args[6]
lbl <- args[8]

# Require the libraries
library(rpart)
library(gdata)

# Set a random seed
set.seed(1)

# Read data from CSV
captures = read.csv('train.csv')

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
}

# A dataframe containing unseen observations
unseen <- data.frame(
  Temperature = c(temp),
  AirPressure = c(ap),
  WindDirection = c(wd),
  Label = c(lbl)
)

# Update the model with the latest observation
print('>> Updating saved model...')
updated_tree <- update(
  tree,
  Label ~ AirPressure + Temperature + WindDirection,
  data = unseen
)

saveRDS(updated_tree, file = 'dtree.rds')
