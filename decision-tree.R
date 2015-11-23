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

# Build the data frame, this would come from db/csv
#captures <- data.frame(
#  temp = c(21, 22, 21, 22, 12, 0),
#  ap = c(1000, 1001, 1010, 1010, 1009, 1009),
#  location = c("NNN", "SNY", "SNN", "SNN", "SNN", "SNN")
#)

# Read data from CSV
captures = read.csv('train.csv')

print(captures)

# Set a random seed
set.seed(1)

# Build a decision tree model
tree <- rpart(Label ~ AirPressure + Temperature + WindDirection, data = captures, method = "class")

# A dataframe containing unseen observations
unseen <- data.frame(Temperature = c(temp), AirPressure = c(ap), WindDirection = c(wd))

# Predict the label of the unseen observation
pred = predict(tree, unseen, type="class")

print(pred[1])
