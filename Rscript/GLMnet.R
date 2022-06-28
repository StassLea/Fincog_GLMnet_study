# INSTALL AND LOAD PACKAGES ################################
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")

# Installs pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

##################################################3
library(readxl) 
library(tidyverse)
library(ggpubr)
library(rstatix)
library(caret)
library(glmnet)
library(mlbench)
library(psych) 

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L

#load data set ##############################################
setwd("C:/Users/stass/OneDrive/Desktop/5yearProject")           # working directory CHANGE
Fincog_Data <- read_excel("Datasets/Fincog_Imp.xlsx")           # DATA SET
Fincog_Data <- as.data.frame(Fincog_Data[c(-1)])              
str(Fincog_Data)

# select y-response variable
# 76-d_tARCS, 77-d_S.MEM, 78-d_Fluence, 79-d_Visuo, 80-d_S.lang,
# 81-d_Atten, 82-d_DASS21, 83-d_Stress, 84-d_Anxiety, 85-d_depression
# 86-d_MFIS, 87-d_EDSS, 88-d_SDMT, 89-d_cog_fat

data <- Fincog_Data[c(1:75,76)]
names(data)[length(data)] <- "y_res"


# Custom Control Parameters
custom <- trainControl(method = "repeatedcv",
                       number = 10,
                       repeats = 5,
                       verboseIter = T)

# Ridge Regression
set.seed(1222)
ridge <- train(y_res ~ .,
               data,
               method = 'glmnet',
               tuneGrid = expand.grid(alpha = 0,
                                      lambda = seq(1 ,200, length=100)),
               trControl = custom)


# Plot Results
plot(ridge)
ridge
plot(ridge$finalModel, xvar = "lambda", label = T)
plot(ridge$finalModel, xvar = 'dev', label=T)
plot(varImp(ridge, scale=T))


# Lasso Regression
set.seed(1222)
lasso <- train(y_res ~ .,
               data,
               method = 'glmnet',
               tuneGrid = expand.grid(alpha = 1,
               lambda = seq(0.0001, 1.5, length=30)),
               trControl = custom)

# Plot Results
plot(lasso)
lasso
plot(lasso$finalModel, xvar = 'lambda', label=T)
plot(lasso$finalModel, xvar = 'dev', label=T)
plot(varImp(lasso, scale=T))

# Elastic Net Regression
set.seed(1222)
en <- train(y_res ~ .,
            data,
            method = 'glmnet',
            tuneGrid = expand.grid(alpha = seq(0,1, length=10),
                                   lambda = seq(0.0001, 1.5, length=30)),
            trControl = custom)

# Plot Results
plot(en)
en
plot(en$finalModel, xvar = 'lambda', label=T)
plot(en$finalModel, xvar = 'dev', label=T)
plot(varImp(en))
     


# Compare Models
model_list <- list(Ridge = ridge, Lasso = lasso, ElasticNet = en)
res <- resamples(model_list)
summary(res)

# Best Model
ridge$bestTune
best <- ridge$finalModel
coef(best, s = ridge$bestTune$lambda)