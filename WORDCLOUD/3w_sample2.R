# 다양한 색으로 단어를 출력해 보기

wordcloud(word, frequency, random.order=F, random.color=F, colors=rainbow(length(word)))

# 다양한 단어 색 출력을 위한 팔레트 패키지의 활용
#install.packages("RColorBrewer")
library(RColorBrewer)      
pal2 <- brewer.pal(8,"Dark2")

word <- c("인천광역시", "강화군", "옹진군")
frequency <- c(651, 85, 61)

wordcloud(word, frequency, colors=pal2)
