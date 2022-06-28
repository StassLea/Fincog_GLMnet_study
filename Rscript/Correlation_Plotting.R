# INSTALL AND LOAD PACKAGES ################################
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")

# Installs pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

library(readxl)
library(tidyverse)
library(ggpubr)
library(rstatix)
library(corrplot)
library(Hmisc)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L

#load data set
setwd("C:/Users/stass/OneDrive/Desktop/5yearProject")
Fincog_Data <- read_excel("Datasets/Fincog_Data_CLEAN.xlsx")

Fincog_Data <- Fincog_Data[c(-1)]

# corrolation matrix
Fincog_Corr <- cor(Fincog_Data, use = "complete.obs")
Corr_data <- rcorr(as.matrix(Fincog_Data))              #for p-value data
corrplot(Fincog_Corr, tl.cex = 0.5)



# Clear packages
p_unload(all)  # Remove all add-ons