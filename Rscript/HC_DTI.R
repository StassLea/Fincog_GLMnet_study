# INSTALL AND LOAD PACKAGES ################################
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")

# Installs pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

library(ggplot2)
library(datasets)
library(readxl)
library(tidyverse)
library(ggpubr)
library(rstatix)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L

#load data set
setwd("C:/Users/stass/OneDrive/Desktop/5yearProject")
DTI_HC <- read_excel("Datasets/DTI_HC.xlsx")
DTI_3 <- DTI_HC[!(DTI_HC$Metric %in% "FANAWM"),]
DTI_1 <- DTI_HC[(DTI_HC$Metric %in% "FANAWM"),]

ggline(DTI_3, x = "Time", y = "Value", color = "Metric",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "green","#E7B800"), size = 1)
ggline(DTI_1, x = "Time", y = "Value", color = "Metric",
       add = "mean_se", palette = c("#E7B800"), size = 1)

res <- t.test(Value ~ Time, data = DTI_HC, paired = TRUE)
res
