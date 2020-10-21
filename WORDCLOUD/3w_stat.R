rm(list = ls())

library(wordcloud)
library(RColorBrewer)
pal2 <- brewer.pal(8, "Dark2")

# 다운로드한 시군구별 이동자수.csv 파일 읽어오기(headline 1줄은 읽어오기 생략)
data <- read.csv(file.choose(), header = T, skip=1)
head(data)

data2 <- data[data$행정구역.시군구.별!="전국",] # "전국" 데이터 제외

x <- grep("구$", data2$행정구역.시군구.별) # "구"로 끝나는 데이터 검색
data3 <- data2[-c(x),] # "구"로 끝나는 데이터 제외
head(data3)

data4 <- data3[data3$순이동..명. > 0, ] # 순이동명 값이 0보다 큰 데이터만 가져오기

word <- data4$행정구역.시군구.별
frequency <- data4$순이동..명.

wordcloud(word, frequency, colors = pal2)
