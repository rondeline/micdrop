#libraries
library(dplyr)
library(tidyverse)
library(here)
library(stats)
library(readr)
library(purrr)
library(stringr)

# ------- Run everything below!
# Modify these paths and information accordingly
root <- "/Users/deniznarikan/Documents/GitHub/chaos/analysis/scripts/"
kid_number <- "188"
segment_num <- "10"

# ------- No touching!
# You don't have to modify anything below
root <- paste(root, kid_number, "/", sep="")
input_path <- paste(root, "durationchaos_", kid_number, "_", segment_num, ".csv", sep="")
output_path <- paste(root, "compare_files/", "BT0", kid_number, "_", segment_num, ".csv", sep="")

#Read in data
data <- read_csv(input_path, col_names = FALSE) #CHANGE P_ID

#separate cell into columns
codes <- data %>%
  separate(col = X1,
           into = c("code", "start", "stop", "duration"),
           sep = "\\s") #Separate values into 4 columns by spaces

codes$duration <- as.numeric(codes$duration) #change duration to numeric

#label as percentage (two) then participant number (172)
BT0153_4 <- codes %>% #CHANGE P_ID 
  group_by(code) %>% 
  summarise(total_duration = sum(duration)) %>%  #Get durations for each category
  mutate(total = sum(total_duration),
         proportion = total_duration/total)

#convert df to csv file
write.csv(BT0153_4, output_path, row.names = FALSE) #CHANGE P_ID 

#compare two files
#add both csv files to compare_files before continuing. Make sure no other files are stored there.

#name both files
both_files <- list.files(paste(root, "compare_files", sep=""),
                         full.names = T,
                         pattern = "*.csv") %>%
  set_names() %>% 
  map_df(~read_csv(.,
                   col_names = TRUE,
                   col_types = cols(.default = "c")),
         .id = "participant")

both_files$participant <- str_extract(both_files$participant, "BT\\d+")

both_files <- both_files %>% 
  group_by(code) %>% 
  mutate(proportion = as.numeric(proportion),
         difference = abs(proportion - first(proportion)))

#View output
View(both_files)

# Save proportions to BTXXX_bootstrap_previous%_current%. Ex. BT0172_bootstrap_2_4
BT0153_bootstrap_2_4 <- both_files

#Save output to participant's folder as BTXXX_bootstrap_previous%_current%. Ex. BT0172_bootstrap_2_4.
prev_segment_num <- as.character(as.numeric(segment_num) - 2)
write.csv(BT0153_bootstrap_2_4, paste(root, "move_to_pps_folder/", "BT0153_bootstrap_", prev_segment_num, "_", segment_num, ".csv", sep="")) #CHANGE P_ID

#write.csv(BT0153_bootstrap_2_4, here("../participants", "BT0153", "BT0153_bootstrap_2_4.csv")) #CHANGE P_ID
