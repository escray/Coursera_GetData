## Advice for Week 3 Quiz 3 Question 3-4
## https://class.coursera.org/getdata-032/forum/thread?thread_id=97
library(downloader)
download("https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/appleorange.csv", destfile="data/appleorange.csv")
download("https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/stability.csv", destfile="data/stability.csv")
ao <- read.csv("data/appleorange.csv")
str(ao)
aoraw <- read.csv("data/appleorange.csv", stringsAsFactors = FALSE, header = FALSE)
head(aoraw, 10)
tail(aoraw, 10)
str(aoraw)

aodata <- aoraw[3:700, ]
names(aodata) <- c("country", "countrynumber", "products", "productnumber", "tonnes", "year")
aodata$countrynumber <- as.integer(aodata$countrynumber)

fslines <- which(aodata$country == "Food supply quantity (tonnes) (tonnes)")
aodata <- oadata[(-1*fslines), ]


aodata$tonnes <- gsub("\xca", "", aodata$tonnes)
aodata$tonnes <- gsub(", tonnes \\(\\)", "", aodata$tonnes)
aodata$tonnes <- as.numeric(aodata$tonnes)

aodata$year <- 2009

## the horrible way
cleanao1 <- aodata[aodata$productnumber == 2617, ]
cleanao1$oranges <- aodata$tonnes[aodata$productnumber == 2611]
cleanao1 <- cleanao1[, c(1, 2, 5, 7)]
names(cleanao1)[names(cleanao1) == "tonnes"] <- "apples"

## It is OK to merge data with itself

apples <- aodata[aodata$productnumber == 2617, c(1, 2, 5)]
names(apples)[3] <- "apples"
oranges <- aodata[aodata$productnumber == 2611, c(2, 5)]
names(oranges)[2] <- "oranges"
cleanao2 <- merge(apples, oranges, by="countrynumber", all=TRUE)
head(cleanao2)

## reshape2 make shifting around data easy

library(reshape2)
cleanao3 <- dcast(aodata[, c(1:3, 5)], formula = country + countrynumber~products, value.var="tonnes")
names(cleanao3)[3:4] <- c("apples", "oranges")
head(cleanao3)

cleanao2[!(complete.cases(cleanao2)), ]
cleanao3[!(complete.cases(cleanao3)), ]

table(aodata$country)[table(aodata$country) == 1]