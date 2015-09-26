## Question 1
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(fileUrl, destfile="data/acs.cvs", method="curl")
acs <- read.csv("data/acs.cvs")
head(acs)
agricultureLogical <- acs$ACR == 3 & acs$AGS == 6
head(argricultureLocical)
which(agricultureLogical)
##  125  238  262

## Question 2

install.packages("jpeg")
library(jpeg)
link = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
img <- readJPEG(link, native=TRUE)

download.file(link, destfile="data/jeff.jpg", mode = "wb", method="curl")
img <- readJPEG("data/getdata_jeff.jpg", native=TRUE)

head(img)

quantile(img, probs = c(0.3, 0.8))
##       30%       80% 
## -15259150 -10575416 

## Question 3
fileurl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileurl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileurl1, "data/GDP.csv", method="curl")
download.file(fileurl2, "data/fedstats.csv", method="curl")

gdp <- read.csv("data/GDP.csv")
fedstats <- read.csv("data/fedstats.csv")
head(gdp)
head(fedstats)
names(gdp)
names(fedstats)

head(gdp$X, 6)

mergeData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
mergeData <- merge(gdp, fedstats, by.x="X", by.y="CountryCode", all=TRUE)
head(mergeData)
length(mergeData)
mergeData[13,]
dim(mergeData)
names(mergeData)
md <- select(mergeData, Short.Name, Gross.domestic.product.2012)
md <- rename(md, GDP = Gross.domestic.product.2012)

md <- mutate(md, rank = as.numeric(md$Gross.domestic.product.2012))

md <- select(mergeData, Short.Name, Gross.domestic.product.2012, Income.Group)
names(md) <- c("country", "gdp", "group")
md <- md[complete.cases(md$country),]
md <- md[complete.cases(md$gdp),]
md <- md[complete.cases(md$group),]
dim(md)
m.f <- filter(md, gdp!="")
m.f$rank <- as.numeric(as.character(m.f$gdp))
ma <- arrange(m.f, desc(rank))

## question 4

OECD <- subset(ma, group=="High income: OECD")
mean(OECD$rank)
nonOECD <- subset(ma, group=="High income: nonOECD")
mean(nonOECD$rank)

## question 5

ma2 <- mutate(ma, incomegroups = cut2(rank, g=5))
table(ma2$incomegroups)

