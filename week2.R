ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;");
dbDisconnect(ucscDb);

hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19);
length(allTables);
dbDisconnect(hg19);

dbListFields(hg19, "affyU133Plus2");
dbGetQuery(hg19, "select count(*) from affyU133Plus2");

affyData <- dbReadTable(hg19, "affyU133Plus2");
head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3");
affyMis <- fetch(query); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)

dbDisconnect(hg19)

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa");
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")


A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A");
B = array(seq(0.1, 2.0, by=0.1), dim=c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B");
h5ls("example.h5");

df = data.frame(1L:5L, seq(0, 1, length.out=5), c("ab", "cde", "fghi", "a", "s"), stringAsFactors=FALSE);
h5write(df, "example.h5", "df")
h5ls("example.h5")

readA = h5read("example.h5", "foo/A");
readB = h5read("example.h5", "foo/foobaa/B");
readf = h5read("example.h5", "df");
readA

h5write(c(12, 13, 14), "example.h5", "foo/A", index=list(1:3, 1))
h5read("example.h5", "foo/A");

con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en");
htmlCode = readLines(con)
close(con)
htmlCode

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)
xpathSApply(html, "//td[@class='gsc_a_c']", xmlValue)

library(httr)
html2 <- GET(url)
content2 <- content(html2, as="text")
parsedHTML <- htmlParse(content2, asText=TRUE)
xpathSApply(parsedHTML, "//title", xmlValue)

pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2
names(pg2)

google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path="search")

baidu = handle("http://baidu.com");
pg1 = GET(handle=baidu, path="/")
pg2 = GET(handle=baidu, path="search")

myapp = oauth_app("douban", key="0d081a08586ae88a27184e190940b99e", secret="10f8e21c8dadb798")
sig = sign_oauth1.0(myapp)
homeTL = GET("http://api.douban.com/v2/movie/subject/1764796", sig)