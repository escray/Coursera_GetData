## question 1
library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github", 
                   key = "b4099f0acdb2dc575143",
                   secret = "3e87fecb9d84909c108468694bc83453e0ecb392")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache=FALSE)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

req$rate$limit
jtleek <- GET("https://api.github.com/users/jtleek/repos", gtoken)
jtleekContent <- content(jtleek)


for (i in 1: length(jtleekContent)) {
        if (jtleekContent[[i]]$name == "datasharing") {
                print(jtleekContent[[i]]$created_at)                
        }
}

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
jsonData$created_at[jsonData$name=="datasharing"]

## question 2

## question 3

## question 4
download.file("http://biostat.jhsph.edu/~jleek/contact.html", "jleek.html")
jleek <- readLines("jleek.html")
length(jleek)
nchar(jleek[[10]])
nchar(jleek[[20]])
nchar(jleek[[30]])
nchar(jleek[[100]])
## 45 31 7 25

## question 5
s <- read.fwf("getdata-wksst8110.for", skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
head(s)
sum(s[, 4])
## 32436.7