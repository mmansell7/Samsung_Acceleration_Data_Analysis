########## Samsung_Acceleration_Data_Analysis ##############

-------------------------------------------------------------
USAGE:
  To utilize the code in this repo, open RStudio and type the
    following command:

      source("run_analysis.R")
-------------------------------------------------------------



-------------------------------------------------------------
SCRIPTS
  run_analysis.R:
    This script loads data from the Samsung data set, located
    in "./UCI HAR Dataset", combines observations from the 
    test set and the training set, and cleans the data to 
    produce two outputs.
-------------------------------------------------------------

-------------------------------------------------------------
OUTPUTS
  alldata:
    This data.frame contains all data from the Samsung data
    set, with activities and variables descriptively
    labeled.

  summarized:
    This data.frame contains a tidy data set with the mean
    value of each variable for each unique combination of
    subjectid and activityid.
-------------------------------------------------------------

