getcontent <- function(s, g) {
        substring(s, g, g+attr(g, 'match.length') - 1)
}

url <- "http://movie.douban.com/top250?format=text"

web <- readLines(url, encoding="UTF-8")

## name <- web[grep('<tdheaders="m_name">', web) + 1]
name <- web[grep('<span class="title">', web) + 1]
gregrout <- gregexpr('>\\w+', name)

movie.names = 0;

for (i in 1:250) {
        movie.names <- getcontent(name, gregout[])
}

movie.names <- sub('>', '', movie.names )

year <- web[grep('<spanclass="year">', web)]

movie.year <- substr(year, 36, 39)

score <- web[grep('<tdheaders="m_rating_score">', web) + 1]

movie.rating <- sub('*', '', rating)

movie <- data.frame(names=movie.names, year=as.numeric(movie.year), 
                    score=as.numeric(movie.score), rate=as.numeric(movie.rating))

library(ggplot2)
p <- ggplot(data=movie, aes(x=year, y=score))
p + geom_point(aes(size=rate), color='lightskyblue4', position="jitter", alpha=0.8)
 + geom_point(aes(x=1997, y=8.9), colour='red', size=4)