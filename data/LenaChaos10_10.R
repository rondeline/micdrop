
#First, you'll need to download the libraries using install.packages(xlsx)

library(xlsx) #to allow us load excel sheet
library(varhandle) #to allow us handle factors
library(psych) # allow us generate summary statistics
library(doBy)
require(XLConnect)
library(XLConnect)
library(readxl)
library(tidyverse)
#library(here)
#library(quarto)

# set view data frame to up to 1000 columns
rstudioapi::writeRStudioPreference("data_viewer_max_columns", 1000L)

# here you read the ADEX output; change the name of the Adex file
#data <- read_csv(here("BT0176", "BT0153_15May2017.csv"))

root <- "/Users/deniznarikan/Documents/GitHub/chaos/lena/participants/BT0209"
name <- "BT0209_02Sep2018.csv"

filename <- paste(root, "/", name, sep="")
data <-  read_csv(filename)

#to pull out time stamps for conversational blocks 

CB <- subset(data,Block_Type!="Pause")
dimres <- subset(CB, 
                subset = !duplicated(CB[c("Block_Number", "Block_Type")]),
                 select = c("Elapsed_Time", "Block_Duration", "Block_Number","Block_Type"))

#colMax <- function(data) sapply(data, max, na.rm = TRUE)

A <- max(data$Block_Number, na.rm = TRUE) - 1

sink(
  paste(root, "/", "BT0122_12m_7Feb2018_cb.txt", sep=""),
  split=FALSE, append = FALSE)


for(i in 1:A) {
  # i-th element of `u1` squared into `i`-th position of `usq`
  print(paste("intervals [",2*i-1,"]: xmin = ",dimres$Elapsed_Time[i],
              "xmax = ",dimres$Elapsed_Time[i] + dimres$Block_Duration[i],
              "text =",sprintf("X_%04g",dimres$Block_Number[i])))
  
  print(paste("intervals [",2*i,"]: xmin = ",dimres$Elapsed_Time[i]+dimres$Block_Duration[i],
              "xmax = ", dimres$Elapsed_Time[i+1], "text =",dimres$Block_Type[20000]))


}

sink()

#This didn't do anything 
  #print(paste("intervals [",i,"]: xmin = ", dimres$Elapsed_Time[i], "xmax = ",dimres$Elapsed_Time[i] + dimres$Block_Duration[i], "text =",dimres$Block_Number[i],dimres$Block_Type[i]))
  

# For OLN segments
sink(
  paste(root, "/", "BT0122_12m_7Feb2018.txt", sep=""),
  split=FALSE,append = FALSE)

OLN <- subset(data, Speaker_ID =="OLN")

B <- nrow(OLN) - 1

for(i in 1:B) {
  print(paste("intervals [",2*i-1,"]: xmin = ",OLN$Elapsed_Time[i],
              "xmax = ",OLN$Elapsed_Time[i]+OLN$Segment_Duration[i],
              "text =",sprintf("X_%04g",OLN$Index[i]),OLN$Speaker_ID[i]))
  
  print(paste("intervals [",2*i,"]: xmin = ",OLN$Elapsed_Time[i]+OLN$Segment_Duration[i],
              "xmax = ", OLN$Elapsed_Time[i+1], "text =",dimres$Block_Type[20000]))
}

sink()

#get last xmax

last_max <- data$Segment_Duration[nrow(data)]

last_max

