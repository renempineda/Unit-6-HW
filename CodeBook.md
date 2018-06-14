---
title: "Homework Unit 6 CodeBook"
author: "Rene M. Pineda"
date: "June 13, 2018"
output:
  html_document:
    keep_md: yes
---

## Project Description
Research the most popular names for baby girls in order to help a client who is expecting a baby

## Data Description

###Collection of the raw data
I downloaded two databases of names for babies in the US, for 2016 and 2017. The filenames in the repository are:

yob2016.txt A dataframe with 32868 obs. of  3 variables
yob2015.txt A dataframe with 26549 obs. of 3 variables

### Description of the variables

first_name: children's first name
gender: Male (M) or Female (F) 
amount_of_children: integer with the total amount of children that received that name during the year

###Notes on the original (raw) data 
yob2016.txt is a colon (;) separated file
yob2015.txt is a comma (,) separated file

### Notes on data cleaning
I removed one repeated observation from the 2016 dataset

### Notes on data merging
I merged based on the first_name variable. Due to the fact that one name can be assigned both to male and female, the merging also took this into account

## Description of objects:
**df**: dataframe with the 2016 dataset
**y2016**: dataframe with the 2016 dataset, with the removed observation
**y2015**: dataframe with the 2015 dataset
**final**: dataframe with the merged 2015 and 2016 datasets, one additional column for the sum of children in both years
**Popular Female Names.csv**: CSV file with the top 10 girl names, and sum of children in both years
