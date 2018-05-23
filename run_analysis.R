# load packages
library(devtools)
library(dplyr)

rm(list=ls())
# Get data
setwd("/Users/esteebie/Documents/DATA/Courses/4. JHU/3. Getting and Cleaning data/Course project - wearable computing")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Merge train and test data
X_all <- rbind(X_train,X_test)
y_all <- rbind(y_train,y_test)
subj_all <- rbind(subj_train,subj_test)

# Get variable names and trim variable numbers and space from start of each
vars_vec <- readLines("./UCI HAR Dataset/features.txt")
vars_vec <- sub("^[0-9]* ","",vars_vec)

# Unused but keep for future use
# vars_vec <- strsplit(vars_vec,"^[0-9 ]") - splits string too many times - one for each numerical
# second_element <- function(x){x[2]} - unused function
# vars_vec <- sapply(vars_vec,second_element) - unused call to function - sub() does it in one go
#vars_vec <- trimws(vars_vec) - no need to trim white space as now have it in one go with sub()

# Insert variable names into dataframe
colnames(X_all) <- vars_vec

# Put Y variables into data frame and convert to factor variable with appropriate labels

# Get aactivity names
activities_vec <- readLines("./UCI HAR Dataset/activity_labels.txt")
activities_vec <- sub("^[0-9]* ","",activities_vec)

# Create full data frame
all_data <- cbind(subj_all,X_all,y_all)
colnames(all_data)[1] <- "subject"
colnames(all_data)[563] <- "activity"

# Convert to factor
all_data$activity <- factor(all_data$activity,levels=c(1,2,3,4,5,6),labels=activities_vec,ordered=FALSE)

# Get column numbers of mean and standard deviation variables into a vector - include activity y variable
idx_mn <- grep("[Mm]ean",colnames(all_data))
idx_std <- grep("[Ss]td",colnames(all_data))
idx <- sort(c(1,idx_mn,idx_std,563))

# Create new data frame with subset of data (86 variables) - satisfies points 1-4
mn_std_data <- all_data[,idx]

# Create second data set with averages per subject
table(mn_std_data$subject)

# New data frame will have 30 rows - one for each subject
subj_av_data <- mn_std_data[,1:87] %>%
  group_by(subject) %>%
  summarise_all(funs(mean(.,na.rm=TRUE)))

