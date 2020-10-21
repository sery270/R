rm(list = ls())

# 지역별 순이동 인구수에 따른 워드 클라우드(sample)

install.packages("wordcloud")
library(wordcloud)

word <- c("인천광역시", "강화군", "옹진군")
frequency <- c(651, 85, 61)

#x11() # 별도의 창에 나타내고자 할 경우
wordcloud(word, frequency, colors = "blue", family="AppleGothic")

