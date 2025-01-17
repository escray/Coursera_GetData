set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5), ];
X$var2[c(1, 3)] = NA;
X[, 1]
X[, "var1"]
X[1:2, "var2"]

X[(X$var1 <= 3 & X$var3 > 11), ]
X[(X$var1 <= 3 | X$var3 > 15), ]

X[which(X$var2 > 8), ]

sort(X$var1)
sort(X$var1, decreasing=TRUE)
sort(X$var2, na.last=TRUE)

X[order(X$var1), ]
X[order(X$var1, X$var3), ]

library(plyr)
arrange(X, var1)
arrange(X, desc(var1))

X$var4 <- rnorm(5)
X
Y <- cbind(X, rnorm(5))
Y

if (!file.exists("../data")){
        dir.create("../data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="data/restaurants.csv", method="curl")
restData <- read.csv("data/restaurants.csv")

head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))
table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict, restData$zipCode)

sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"), ]

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF)

warpbreaks$replicate <- rep(1:9, len=54)
xt = xtabs(breaks ~ ., data=warpbreaks)
xt
ftable(xt)

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")

s1 <- seq(1, 10, by=2);
s1
s2 <- seq(1, 10, length=3);
s2
x <- c(1, 3, 8, 25, 100); 
seq(along=x)

names(restData)
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
names(restData)

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData)

yesno <- sample(c("yes", "no"), size=10, replace=TRUE)
yesno
yesnofac <- factor(yesno, levels=c("yes", "no"))
yesnofac
relevel(yesnofac, ref="yes")
as.numeric(yesnofac)

library(Hmisc)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4))
table(restData2$zipGroups)

library(reshape2)
head(mtcars)

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp"))
head(carMelt, n=3)
tail(carMelt, n=3)

cylData <- dcast(carMelt, cyl ~ variable); cylData
cylData <- dcast(carMelt, cyl ~ variable, mean); cylData

head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

spIns = split(InsectSprays$count, InsectSprays$spray); spIns

sprCount = lapply(spIns, sum); sprCount

unlist(sprCount)
sapply(spIns, sum)

ddply(InsectSprays, .(spray), summarise, sum=sum(count))

spraySums <- ddply(InsectSprays, .(spray), summarise, sum=ave(count, FUN=sum))
dim(spraySums)
head(spraySums)

library(dplyr)
options(width = 105)

chicago <- readRDS("chicago.rds")

setwd("/Users/escray/Study/SourceCode/GetData")
chicago <- readRDS("data/chicago.rds")
dim(chicago)
str(chicago)
names(chicago)

head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))

i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

chicago <- arrange(chicago, date)
head(chicago)
tail(chicago)

chicago <- arrange(chicago, desc(date))
head(chicago)
tail(chicago)

chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))

chicago <- mutate(chicago, tempcat = factor(1*(tmpd>80), labels=c("cold", "hot")))
head(chicago)
hotcold <- group_by(chicago, tempcat)
head(hotcold)

summarize(hotcold, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summary(years, pm25 = mean(pm25, na.rm=TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tme))


if (!file.exists("./data")) { dir.create("./data") }
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="./data/reviews.csv", method="curl")
download.file(fileUrl2, destfile="./data/solutions.csv", method="curl")
reviews = read.csv("./data/reviews.csv");
solutions = read.csv("./data/solutions.csv");
head(reviews, 2)
head(solutions, 2)

names(reviews)
names(solutions)

mergeData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
head(mergeData)

intersect(names(solutions), names(reviews))
mergeData2 <- merge(reviews, solutions, all = TRUE)
head(mergeData2)

library(plyr)
df1 = data.frame(id=sample(1:10), x = rnorm(10))
df2 = data.frame(id=sample(1:10), y = rnorm(10))
arrange(join(df1, df2), id)

df1 = data.frame(id=sample(1:10), x = rnorm(10))
df2 = data.frame(id=sample(1:10), y = rnorm(10))
df3 = data.frame(id=sample(1:10), z = rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)



data(mtcars)
mtcars

narrow <- mtcars[, c("cyl", "gear", "vs", "mpg")]
narrow

library(reshape2)
wide1 <- tidied <- dcast(narrow, cyl + gear ~ vs, max)
wide1

wide2 <- tidied <- dcast(narrow, cyl + vs ~ gear, max)
wide2

wide3 <- tidied <- dcast(narrow, gear + vs ~ cyl, max)
wide3

notverywide <- aggregate(mpg ~ gear + vs + cyl, data = narrow, max)
notverywide

untidy <- with(narrow, tapply(mpg, list(cyl, vs, gear), max))
untidy