---
title: "Unit 5 HW"
author: "Rene Pineda"
date: "June 13, 2018"
output:
  html_document:
    keep_md: true
---

# Homework Unit 5

*Prepared by: Rene M. Pineda*

### 1.	Data Munging (30 points)
#### a.	First, import the .txt file into R so you can process it.  Keep in mind this is not a CSV file.  You might have to open the file to see what you’re dealing with.  Assign the resulting data frame to an object, df, that consists of three columns with human-readable column names for each.


```r
# Load the data
df <- read.table("yob2016.txt", header = TRUE, sep = ";")


# We will perform some data cleanaup
#The names in the data frame are not very explanatory. Change the names of the variables:
library(dplyr)
df <- rename(df, first_name = Emma, gender = "F", amount_of_children = X19414)
```

#### b.	Display the summary and structure of df

```r
summary(df)
```

```
##    first_name    gender    amount_of_children
##  Aalijah:    2   F:18757   Min.   :    5.0   
##  Aaliyan:    2   M:14111   1st Qu.:    7.0   
##  Aamari :    2             Median :   12.0   
##  Aarian :    2             Mean   :  110.1   
##  Aarin  :    2             3rd Qu.:   30.0   
##  Aaris  :    2             Max.   :19246.0   
##  (Other):32856
```

```r
str(df)
```

```
## 'data.frame':	32868 obs. of  3 variables:
##  $ first_name        : Factor w/ 30295 levels "Aaban","Aabha",..: 22546 3770 26409 12019 20596 6185 339 9298 11222 2066 ...
##  $ gender            : Factor w/ 2 levels "F","M": 1 1 1 1 1 1 1 1 1 1 ...
##  $ amount_of_children: int  19246 16237 16070 14722 14366 13030 11699 10926 10733 10702 ...
```

#### c.	Your client tells you that there is a problem with the raw file.  One name was entered twice and misspelled.  The client cannot remember which name it is; there are thousands he saw! But he did mention he accidentally put three y’s at the end of the name.  Write an R command to figure out which name it is and display it.

```r
#Write an expression to find the string "yyy"
grep("yyy", df$first_name, value = FALSE)
```

```
## [1] 211
```

```r
#The name is on row 211. We will display it:
df[211,]
```

```
##     first_name gender amount_of_children
## 211   Fionayyy      F               1547
```

#### d.	Upon finding the misspelled name, please remove this particular observation, as the client says it’s redundant.  Save the remaining dataset as an object: y2016 

```r
# Remove this observation. There are many ways to do it:
y2016 <- df[-211,]
```
### 2.	Data Merging (30 points): Utilize yob2015.txt for this question.  This file is similar to yob2016, but contains names, gender, and total children given that name for the year 2015.
#### a.	Like 1a, please import the .txt file into R.  Look at the file before you do.  You might have to change some options to import it properly.  Again, please give the dataframe human-readable column names.  Assign the dataframe to y2015.  

```r
y2015 <- read.table("yob2015.txt", header = TRUE, sep = ",")
names(y2015)
```

```
## [1] "Emma"   "F"      "X20415"
```

```r
names(y2015) <- c("first_name", "gender", "amount_of_children")
```

#### b.	Display the last ten rows in the dataframe.  Describe something you find interesting about these 10 rows.

```r
tail(y2015, 10)
```

```
##       first_name gender amount_of_children
## 33053       Ziyu      M                  5
## 33054       Zoel      M                  5
## 33055      Zohar      M                  5
## 33056     Zolton      M                  5
## 33057       Zyah      M                  5
## 33058     Zykell      M                  5
## 33059     Zyking      M                  5
## 33060      Zykir      M                  5
## 33061      Zyrus      M                  5
## 33062       Zyus      M                  5
```
I find interesting that all names start with Z, all are male names, and that every name in this list has exactly 5 ocurrences

#### c.	Merge y2016 and y2015 by your Name column; assign it to final.  The client only cares about names that have data for both 2016 and 2015; there should be no NA values in either of your amount of children rows after merging.

```r
#Merge the data sets by first name and gender
final <- merge(x = y2015, y = y2016, union("first_name", "gender"), all = FALSE)
str(final)
```

```
## 'data.frame':	26549 obs. of  4 variables:
##  $ first_name          : Factor w/ 30553 levels "Aaban","Aabha",..: 1 2 3 5 7 8 9 10 11 12 ...
##  $ gender              : Factor w/ 2 levels "F","M": 2 1 1 2 2 2 2 2 2 1 ...
##  $ amount_of_children.x: int  15 7 5 22 15 297 31 5 11 8 ...
##  $ amount_of_children.y: int  9 7 11 18 11 194 28 6 5 14 ...
```

```r
#Assign names to the data
names(final) <- c("Name", "gender", "amount_of_children.2015", "amount_of_children.2016")

#Check that there are no NAs (in two different ways)
anyNA(final)
```

```
## [1] FALSE
```

```r
sapply(final, function(y) sum(is.na(y)))
```

```
##                    Name                  gender amount_of_children.2015 
##                       0                       0                       0 
## amount_of_children.2016 
##                       0
```

```r
# Check for duplicates
sum(duplicated(final))
```

```
## [1] 0
```
### 3.	Data Summary (30 points): Utilize your data frame object final for this part.

#### a.	Create a new column called “Total” in final that adds the amount of children in 2015 and 2016 together.  In those two years combined, how many people were given popular names?

```r
# Create a new column for total children for both years
final$Total <- final$amount_of_children.2015 + final$amount_of_children.2016
```

#### b.	Sort the data by Total.  What are the top 10 most popular names?

```r
# Sort the dataframe by the "Total" column
final <- arrange(final, desc(Total))
head(final,10)
```

```
##        Name gender amount_of_children.2015 amount_of_children.2016 Total
## 1    Olivia      F                   19638                   19246 38884
## 2      Noah      M                   19594                   19015 38609
## 3      Liam      M                   18330                   18138 36468
## 4    Sophia      F                   17381                   16070 33451
## 5       Ava      F                   16340                   16237 32577
## 6     Mason      M                   16591                   15192 31783
## 7   William      M                   15863                   15668 31531
## 8     Jacob      M                   15914                   14416 30330
## 9  Isabella      F                   15574                   14722 30296
## 10    James      M                   14773                   14776 29549
```
The 10 most popular names are Olivia, Noah, Liam, Sophia, Ava, Mason, William, Jacob, Isabella and James

#### c.	The client is expecting a girl!  Omit boys and give the top 10 most popular girl’s names.

```r
# Order the dataframe by gender, then display the top 10 most popular girl's names
final <- arrange(final, gender, desc(Total))
head(final, 10)
```

```
##         Name gender amount_of_children.2015 amount_of_children.2016 Total
## 1     Olivia      F                   19638                   19246 38884
## 2     Sophia      F                   17381                   16070 33451
## 3        Ava      F                   16340                   16237 32577
## 4   Isabella      F                   15574                   14722 30296
## 5        Mia      F                   14871                   14366 29237
## 6  Charlotte      F                   11381                   13030 24411
## 7    Abigail      F                   12371                   11699 24070
## 8      Emily      F                   11766                   10926 22692
## 9     Harper      F                   10283                   10733 21016
## 10    Amelia      F                    9838                   10702 20540
```

#### d.	Write these top 10 girl names and their Totals to a CSV file.  Leave out the other columns entirely.

```r
#Write the csv File with the most popular girl names
Popularfemalenames <- head(final,10)[,c(1,5)]
write.csv(Popularfemalenames, "Popular Female Names.csv", row.names = FALSE)
```

