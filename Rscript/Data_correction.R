# File:   ImportingData.R
# Course: R: An Introduction (with RStudio)

# INSTALL AND LOAD PACKAGES ################################
if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")
library(ggplot2)
library(datasets)  # Load base packages manually

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L

# Installs pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# import package to read excel
library(readxl)

#load data set
setwd("C:/Users/stass/OneDrive/Desktop/5yearProject")
Fincog_Data <- read_excel("DataSets/Fincog_Data.xlsx")
View(Fincog_Data)
     
#multiple import 
tARC <- Fincog_Data$d_tARC
DASS21 <- Fincog_Data$d_DASS21
MFIS <- Fincog_Data$d_MFIS
EDSS <- Fincog_Data$d_EDSS
SDMT <- Fincog_Data$d_SDMT 

#plot datae
hist(tARC, breaks=10, freq=F)
lines(density(tARC))
hist(DASS21, breaks=10, freq=F)
lines(density(DASS21))
hist(MFIS, breaks=10, freq=F)
lines(density(MFIS))
hist(EDSS, breaks=20, freq=F)
lines(density(EDSS))
hist(SDMT, breaks=10, freq=F)
lines(density(SDMT))

#plot outliers
boxplot(tARC,DASS21,MFIS,EDSS,SDMT,
        main = "OUTPUT Data Outliers",
        xlab = "Score",
        names = c("tARC","DASS21","MFIS","EDSS","SDMT"),
        las = 2,
        col = "orange",
        border = "brown",
        horizontal = TRUE,
        notch = TRUE)

###LOADING CLEAN DATA FOR COMPARISION
Fincog_Data <- read_excel("Datasets/Fincog_Data_CLEAN.xlsx")
View(Fincog_Data)

#multiple import 
tARC <- Fincog_Data$d_tARC
DASS21 <- Fincog_Data$d_DASS21
MFIS <- Fincog_Data$d_MFIS
EDSS <- Fincog_Data$d_EDSS
SDMT <- Fincog_Data$d_SDMT 

#plot datae
hist(tARC, breaks=10, freq=F)
lines(density(tARC))
hist(DASS21, breaks=10, freq=F)
lines(density(DASS21))
hist(MFIS, breaks=10, freq=F)
lines(density(MFIS))
hist(EDSS, breaks=20, freq=F)
lines(density(EDSS))
hist(SDMT, breaks=10, freq=F)
lines(density(SDMT))

#plot outliers
boxplot(tARC,DASS21,MFIS,EDSS,SDMT,
        main = "OUTPUT Data Outliers",
        xlab = "Score",
        names = c("tARC","DASS21","MFIS","EDSS","SDMT"),
        las = 2,
        col = "orange",
        border = "brown",
        horizontal = TRUE,
        notch = TRUE)

# Clear packages
p_unload(all)  # Remove all add-ons

