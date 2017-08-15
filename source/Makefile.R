###############################################################################
### Title:        MSDS6303 Case Study 2 Makefile
### Team:         Chayson Comfort, Phillip Edwards, George Sturrock
### Description:  This R script will execute the discrete code chunks created 
###               to answer Case Study 2 questions 2 and 3.
###############################################################################

# Load Libraries
source("CS2Libraries.R")
print("Libraries Loaded")

#############
# Question 2
#############

#Load Data
source("CS2Q2Load.R")
print("Question 2 data loaded")

#Analysis
source("CS2Q2Analysis.R", print.eval = TRUE)
print("Question 2 Analysis Complete")

###############
# Question 3
###############

# Load data for Question 3
source("CS2Q3Load.R")
print("Question 3 Data Loaded")

###############
# Question 3.i 
###############

source("CS2Q3i.R", print.eval = TRUE)
print("Question 3.i Cleansing and Analysis Complete")

################
# Question 3.ii
################

source("CS2Q3ii.R", print.eval = TRUE)
print("Question 3.ii Cleansing and Analysis Complete")

#################
# Question 3.iii
#################

source("CS2Q3iii.R", print.eval = TRUE)
print("Question 3.iii Cleansing and Analysis Complete")