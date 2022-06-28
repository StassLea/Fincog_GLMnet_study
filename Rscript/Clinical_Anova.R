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
library(dplyr)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L

#load data set
setwd("C:/Users/stass/OneDrive/Desktop/5yearProject")
Clinical_Data <- read_excel("Datasets/Clinical_AnovaData.xlsx")

head(Clinical_Data)
str(Clinical_Data)
#Clinical_Data <- Clinical_Data[!(Clinical_Data$Time %in% "2"),]
Clinical_p <- Clinical_Data[!(Clinical_Data$Patient_Type %in% "H"),] 
  
  

#Begin annova assessment

###### tARCS ######
ggline(Clinical_Data, x = "Time", y = "tARCS", color = "Patient_Type",
       add = "mean_se", palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "tARCS", color = "Patient_Type",
       add = c("mean_se", "jitter"), palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "tARCS", color = "Patient_Type",
       add = c("mean_se", "violin"), palette = c("#00AFBB","#FF0000"), size = 1.3)

res <- t.test(tARCS ~ Time, data = Clinical_p, paired = TRUE)
res

##### DASS21 #####
ggline(Clinical_Data, x = "Time", y = "DASS21", color = "Patient_Type",
       add = "mean_se", palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "DASS21", color = "Patient_Type",
       add = c("mean_se", "jitter"), palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "DASS21", color = "Patient_Type",
       add = c("mean_se", "violin"), palette = c("#00AFBB","#FF0000"), size = 1.3)

res <- t.test(DASS21 ~ Time, data = Clinical_p, paired = TRUE)
res

##### EDSS #####

ggline(Clinical_p, x = "Time", y = "EDSS", color = "Patient_Type",
       add = "mean_se", palette = c("#FF0000"), size = 1.3)
ggline(Clinical_p, x = "Time", y = "EDSS", color = "Patient_Type",
       add = c("mean_se", "jitter"), palette = c("#FF0000"), size = 1.3)
ggline(Clinical_p, x = "Time", y = "EDSS", color = "Patient_Type",
       add = c("mean_se", "violin"), palette = c("#FF0000"), size = 1.3)

res <- t.test(EDSS ~ Time, data = Clinical_p, paired = TRUE)
res

##### MFIS #####
ggline(Clinical_Data, x = "Time", y = "MFIS", color = "Patient_Type",
       add = "mean_se", palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "MFIS", color = "Patient_Type",
       add = c("mean_se", "jitter"), palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "MFIS", color = "Patient_Type",
       add = c("mean_se", "violin"), palette = c("#00AFBB","#FF0000"), size = 1.3)

res <- t.test(MFIS ~ Time, data = Clinical_p, paired = TRUE)
res

##### SDMT #####
ggline(Clinical_Data, x = "Time", y = "SDMT", color = "Patient_Type",
       add = "mean_se", palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "SDMT", color = "Patient_Type",
       add = c("mean_se", "jitter"), palette = c("#00AFBB","#FF0000"), size = 1.3)
ggline(Clinical_Data, x = "Time", y = "SDMT", color = "Patient_Type",
       add = c("mean_se", "violin"), palette = c("#00AFBB","#FF0000"), size = 1.3)

res <- t.test(SDMT ~ Time, data = Clinical_p, paired = TRUE)
res

# Clear packages
p_unload(all)  # Remove all add-ons

