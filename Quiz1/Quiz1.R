## Question 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "ss06hid.csv", method="curl")
data <- read.csv("ss06hid.csv")
head(data)
nrow(data)

dt <- data[complete.cases(data$VAL), ]
nrow(dt)

nrow(dt[dt$VAL >= 24, ])

## Question 2

## Question 3

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="gov_NGAP.xlsx", method="curl")
dateDownloaded <- date()
library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23

dat <- read.xlsx("gov_NGAP.xlsx", sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)
sum(dat$Zip*dat$Ext, na.rm=TRUE)

## Question 4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile="restaurants.xml", method="curl")
library(XML)
doc <- xmlTreeParse("restaurants.xml", useInternal=TRUE)
rootNode <- xmlRoot(doc)
res <- xpathSApply(doc, "//row//row//zipcode", xmlValue)
length(res[res=="21231"])

## Question 5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="pid.csv", method="curl")
DT <- fread("pid.csv")

system.time(mean(DT$pwgtp15, by=DT$SEX))

system.time(mean(DT[DT$SEX==1, ]$pwgtp15))
system.time(mean(DT[DT$SEX==2, ]$pwgtp15))

system.time(sapply(split(DT$pwgtp15, DT$SEX), mean))

system.time(tapply(DT$pwgtp15, DT$SEX, mean))

system.time(DT[, mean(pwgtp15), by=SEX])

system.time(rowMeans(DT)[DT$SEX==1]);
system.time(rowMeans(DT)[DT$SEX==2]);