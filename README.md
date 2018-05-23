# JHU_cleaning_data
Course project for JHU Coursera Getting and cleaning data

This work is for the peer-graded assessment task for week 4 of the Coursera “Getting and Cleaning Data” course, run by Johns Hopkins University.

The script run_analysis performs the following steps:

- Loads data provided by the course website
- Merges two data sets and also merges the subject and response variables for each instance.
- Applies variable names from a separate text file
- Applies factor levels to the ‘activity’ variable from a separate text file
- Removes data that are not a mean or standard deviation by searching for ‘mean’ and ‘std’ in the variable names
- saves this as a data frame mn_std_data
- Averages each mean and standard deviation variable for all observations for a single individual (subject)
- Saves this as a separate data frame subj_av_data
