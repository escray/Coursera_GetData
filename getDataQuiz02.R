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