# Load the data
df <- read.table("yob2016.txt", header = TRUE, sep = ";")
summary(df)
str(df)

# We will perform some data cleanaup
#The names in the data frame are not very explanatory. Change the names of the variables:
library(dplyr)
df <- rename(df, first_name = Emma, gender = "F", amount_of_children = X19414)
str(df)



#Write an expression to find the string "yyy"
grep("yyy", df$first_name, value = FALSE)

#The name is on row 211. We will display it:
df[211,]

# Remove this observation. There are many ways to do it:
y2016 <- df[-211,]

y2015 <- read.table("yob2015.txt", header = TRUE, sep = ",")
names(y2015)
names(y2015) <- c("first_name", "gender", "amount_of_children")

#Display the last 10 names
tail(y2015, 10)

#I find interesting that all names start with Z, one of the least popular initials, and that every name in this list has exactly 5 ocurrences

#Merge the data sets by first name and gender
final <- merge(x = y2015, y = y2016, union("first_name", "gender"), all = FALSE)
str(final)
#Assign names to the data
names(final) <- c("Name", "gender", "amount_of_children.2015", "amount_of_children.2016")

#Check that there are no NAs (in two different ways)
anyNA(final)
sapply(final, function(y) sum(is.na(y)))

# Check for duplicates
sum(duplicated(final))

# Create a new column for total children for both years
final$Total <- final$amount_of_children.2015 + final$amount_of_children.2016

# Sort the dataframe by the "Total" column
final <- arrange(final, desc(Total))
head(final, 10)

# The 10 most popular names are Olivia, Noah, Liam, Sophia, Ava, Mason, William, Jacob, Isabella and James
final <- arrange(final, gender, desc(Total))
head(final, 10)

#Write the csv File with the most popular girl names
Popularfemalenames <- head(final,10)[,c(1,5)]
write.csv(Popularfemalenames, "Popular Female Names.csv", row.names = FALSE, col.names = TRUE)

