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
DTI_Data <- read_excel("Datasets/DTI_data_5.xlsx")
DTI_Data <- DTI[!(DTI$Time %in% 2),]
DTI_MS <- DTI_Data[!(DTI_Data$Patient %in% "H"),] 
DTI_H <- DTI_Data[(DTI_Data$Patient %in% "H"),] 

#VISUALISATION
############## LESION
ggline(DTI_MS, x = "Time", y = "MDLesion", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "#E7B800"), size = 1)
ggline(DTI_MS, x = "Time", y = "MDLesion", color = "Patient",
       add = "mean_se", palette = c("#00AFBB"), size = 1)
res <- t.test(MDLesion ~ Time, data = DTI_MS, paired = TRUE)
res

ggline(DTI_MS, x = "Time", y = "ADLesion", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "#E7B800"), size = 1)
ggline(DTI_MS, x = "Time", y = "ADLesion", color = "Patient",
       add = "mean_se", palette = c("#00AFBB"), size = 1)


res <- t.test(ADLesion ~ Time, data = DTI_MS, paired = TRUE)
res

ggline(DTI_MS, x = "Time", y = "FALesion", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "#E7B800"), size = 1)
ggline(DTI_MS, x = "Time", y = "FALesion", color = "Patient",
       add = "mean_se", palette = c("#00AFBB"), size = 1)
res <- t.test(FALesion ~ Time, data = DTI_MS, paired = TRUE)
res

ggline(DTI_MS, x = "Time", y = "RDLesion", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "#E7B800"), size = 1)
ggline(DTI_MS, x = "Time", y = "RDLesion", color = "Patient",
       add = "mean_se", palette = c("#00AFBB"), size = 1)
res <- t.test(RDLesion ~ Time, data = DTI_MS, paired = TRUE)
res

############## NAWM
ggline(DTI_Data, x = "Time", y = "MDNAWM", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "green","#E7B800"), size = 1)
ggline(DTI_Data, x = "Time", y = "MDNAWM", color = "Patient",
       add = "mean_se", palette = c( "green", "#00AFBB"), size = 1)
res <- t.test(MDNAWM ~ Time, data = DTI_MS, paired = TRUE)
res
res <- t.test(MDNAWM ~ Time, data = DTI_H, paired = TRUE)
res

ggline(DTI_Data, x = "Time", y = "ADNAWM", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "green","#E7B800"), size = 1)
ggline(DTI_Data, x = "Time", y = "ADNAWM", color = "Patient",
       add = "mean_se", palette = c( "green", "#00AFBB"), size = 1)
res <- t.test(ADNAWM ~ Time, data = DTI_MS, paired = TRUE)
res
res <- t.test(ADNAWM ~ Time, data = DTI_H, paired = TRUE)
res

ggline(DTI_Data, x = "Time", y = "FANAWM", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "green","#E7B800"), size = 1)
ggline(DTI_Data, x = "Time", y = "FANAWM", color = "Patient",
       add = "mean_se", palette = c( "green", "#00AFBB"), size = 1)
res <- t.test(FANAWM ~ Time, data = DTI_MS, paired = TRUE)
res
res <- t.test(FANAWM ~ Time, data = DTI_H, paired = TRUE)
res

ggline(DTI_Data, x = "Time", y = "RDNAWM", color = "Treatment",
       add = "mean_se", palette = c("#00AFBB","#FF0000", "green","#E7B800"), size = 1)
ggline(DTI_Data, x = "Time", y = "RDNAWM", color = "Patient",
       add = "mean_se", palette = c( "green", "#00AFBB"), size = 1)
res <- t.test(RDNAWM ~ Time, data = DTI_MS, paired = TRUE)
res
res <- t.test(RDNAWM ~ Time, data = DTI_H, paired = TRUE)
res

# Clear packages
p_unload(all)  # Remove all add-ons
