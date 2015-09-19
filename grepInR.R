word <- c('abcnobody@stat.berkeley.edu', 'text with no email', 'first me@mything.com alsoyou@yourspace.com')
pattern <- '[-A-Za-z0-9_.%]+@[-A-Za-z0-9_.%]+\\.[A-Za-z]+'
grep(pattern, word)
gregout = gregexpr(pattern, word)

substring(word[1], gregout[[1]], gregout[[1]] + attr(gregout[[1]], 'match.length') - 1)
## error
## substring(word[1], gregout[[1]], gregout[1] + attr(gregout[1], 'match.length') - 1 )

getexpr <- function(s, g) {
        substring(s, g, g + attr(g, 'match.length') - 1)
}

getexpr(word[[2]], gregout[[2]])
getexpr(word[[3]], gregout[[3]])

emails = mapply(getexpr, word, gregout)

names(emails) = NULL
emails

unlist(emails)

emails = emails[emails != '']
emails = subset(emails, emails != '')

emails = mapply(getexpr, word, gregout)
names(emails) = NULL
sapply(emails, length)

sapply(emails, function(e) {
        if (nchar(e[1]) > 0) {
                length(e)
        }
        else {
                0
        }
})

htmls = c('This is an image: <IMG SRC="img/rxb.gif">', 
          '<a href="something.html">click here</a>');
grep('<.*>', htmls)

matches = mapply(getexpr, htmls, gregexpr('<.*>', htmls))
names(matches) = NULL
matches

matches = mapply(getexpr, htmls, gregexpr('<[^>]*>', htmls))
names(matches) = NULL
matches

matches = mapply(getexpr, htmls, gregexpr('<.*?>', htmls))
names(matches) = NULL
matches

link = '<a href="http://www.stat.berkeley.edu">UC Berkeley Stat Dept Home Page</a><br />'
gregout = gregexpr('href *= *["\']?([^"\'>]+)["\']?', link, ignore.case = TRUE)

thematch = mapply(getexpr, link, gregout)
answer = gsub('href *= *["\']?([^"\'>]+)["\']?', '\\1', thematch, ignore.case = TRUE)


names(answer) = NULL
answer

link = '<a href="http://www.stat.berkeley.edu">UC Berkeley Stat Dept Home Page</a><br />'
gregout = gregexpr('href *= *["\']?([^"\'>]+)["\'][>]?([^<]+)', link, ignore.case = TRUE)
thematch = mapply(getexpr, link, gregout)
answer = gsub('href *= *["\']?([^"\'>]+)["\']?', '\\2', thematch, ignore.case = TRUE)
names(answer) = NULL
answer

x = readLines('http://www.stat.berkeley.edu/~s133/schedule.html')
baseurl = 'http://www.stat.berkeley.edu/~s133'
linkpat = '^.*<td> *<a href=["\'](.*)["\']>.*$'
x = readLines('http://www.stat.berkeley.edu/~s133/schedule.html')
y = grep(linkpat, x, value=TRUE)
paste(baseurl, sub(linkpat, '\\1', y), sep='/')

url <- "http://calbears.cstv.com/sports/m-basebl/sched/cal-m-basebl-sched.html"
url <- "http://www.calbears.com/SportSelect.dbml?&DB_OEM_ID=30100&SPID=126525&SPSID=749481"
thepage <- readLines(url)

grep('Opponent / Event', thepage)
grep('<td class="opponent">[\n]\\W*(\\w+)[\n]\\W*</td>', thepage)
grep('<td class="opponent">([\\W\\w]*)</td>', thepage)

mypattern = '<td class="opponent">([^<]*)</td>'
datalines = grep(mypattern, thepage[536:length(thepage)], value=TRUE)

x = readLines('http://www.imdb.com/chart/')
grep('Rank', x)

goodlines = '<a href="/title[^>]*>(.*)</a>.*$|^ *\\S'
goodlines = '<a href=\\"/name[^>]*>(.*)</a>'
goodlines = '<a href=\\"/name[^>]'
try = grep(goodlines, x, value=TRUE)
try[1:10]

download.file('http://finance.yahoo.com/q?s=aapl&x=0&y=0', 'quote.html')
x = readLines('quote.html')

grep('Open:', x)
nchar(x[195])
gregexpr('Open:', x[195])
sub <- substring(x[195], 587, 650)
gsub('^.*Open:</th><td class=\"yfnc_tabledata1\">([^<]*)</td>.*$', '\\1', x[195])

getquote = function(sym) {
        baseurl = 'http://finance.yahoo.com/q?s='
        myurl = paste(baseurl, sym, '&x=0&y=0', sep='')
        x = readLines(myurl)
        q = gsub('^.*Open:</th><td class=\"yfnc_tabledata1\">([^<]*)</td>.*$', '\\1', grep('Open:', x, value=TRUE))
        as.numeric(q)
}

gethistory = function(symbol) {
        data = read.csv(paste('http://ichart.finance.yahoo.com/table.csv?s=', symbol, sep=''))
        data$Date <- as.Date(data$Date)
        data
}
aapl <- gethistory('aapl')

plot(aapl$Date, aapl$Open, main='Closing price for AAPL', type='l')

plothistory <- function(symbol, what) {
        match.arg(what, c('Date', 'Open', 'High', 'Low', 'Close', 'Adj.Close'))
        data = gethistory(symbol)
        plot(data$Date, data[, what], main = paste(what, 'price for ', symbol), type = 'l')
}

plothistory('aapl','High')

z <- readLines('https://www.google.com/search?q=introduction+to+r')
lenght(z)
nchar(z)
grep('href=', z)

hrefpat = 'href *= *"([^"]*)"'
getexpr = function(s, g) {
        substring(s, g, g+attr(g, 'match.length') - 1)
}
gg = gregexpr(hrefpat, z[[1]])
res = mapply(getexpr, z[[1]], gg)
res = sub(hrefpat, '\\1', res)
res[1:10]

refs = res[grep('^https?:', res)]
refs = refs[-grep('google.com/', refs)]
refs[1:3]

refs = refs[-grep('cache:', refs)]
length(refs)

z = readLines('https://www.google.com/search?q=introduction+to+r&start=10')
hrefpat = 'href *= *"([^"]*)"'
getexpr = function(s, g) {
        substring(s, g, g+attr(g, 'match.length')-1)
}
gg = gregexpr(hrefpat, z[[5]])
res = mapply(getexpr, z[[5]], gg)

##Sys.setLocale('LC_ALL', 'C')

res = sub(hrefpat, '\\1', res)
refs = res[grep('^https?:', res)]
refs = refs[-grep('google.com/', refs)]
refs = refs[-grep('cache:', refs)]
length(refs)

googlerefs = function(term, pg=0) {
        getexpr = function(s, g) {
                substring(s, g, g+attr(g, 'match.length')-1)
        }
        qurl = paste('https://www.google.com/search?q=', term, sep='')
        if (pg > 0) {
                qurl = past(qurl, '&start=', pg * 10, sep='')
        }
        qurl = gsub('  ', '+', qurl)
        z = readLines(qurl)
        hrefpat = 'href *= *"([^"]*)"'
        wh = grep(hrefpat, z)[2]
        gg = gregexpr(hrefpat, z[[wh]])
        res = mapply(getexpr, z[[wh]], gg)
        refs = res[grep('^https?:', res)]
        refs = refs[-grep('goolge.com/|cache:', refs)]
        names(refs) = NULL
        refs[!is.na(refs)]
}

links = sapply(0:9, function(pg) {googlerefs("introduction to r", pg)})
links = unlist(links)
head(links)