rm(list = ls()) 

# 김영삼 대통령 연설문의 단어에 대한 워드 클라우드 만들기

install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("KoNLP")  # cran 패키지 목록에서 제외되어 직접 설치 안됨

# java, rJava 설치
install.packages("multilinguer")

# 의존성 패키지 설치
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")

# github 버전 설치
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"),force = TRUE)

# 아래 패키지 중에 설치안된 패키지를 확인하여 있으면 설치
pkg <- c("wordcloud", "RColorBrewer", "KoNLP")
new.pkg <- pkg[!(pkg %in% installed.packages())]
new.pkg
if (length(new.pkg)) {
  install.packages(new.pkg) 
}

library(wordcloud)
library(RColorBrewer)
library(KoNLP)

useSejongDic() # 한글 세종사전 로딩

pal2 <- brewer.pal(8,"Dark2")   

text <- readLines(file.choose()) # speech.txt 선택
head(text)

noun <- sapply(text, extractNoun, USE.NAMES=F)
head(noun)

noun2 <- unlist(noun) 
noun2

word_count <- table(noun2) 
word_count  

head(sort(word_count, decreasing=TRUE), 10) # 단어 빈도수 많은 순으로 10개 표시

wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2, family="AppleGothic")

# 단어 추가/삭제 및 두 글자 이상 단어의 빈도만 출력하기
mergeUserDic(data.frame(c("정치"), c("ncn"))) # "정치" 단어 추가
noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun) 

noun2 <- gsub("여러분", "", noun2) # "여러분" 삭제
noun2 <- gsub("우리", "", noun2) # "우리" 삭제
noun2 <- gsub("오늘", "", noun2) # "오늘" 삭제

noun2 <- Filter(function(x){nchar(x) >= 2}, noun2) # 두 글자 이상 단어만 추출

word_count <- table(noun2) # 단어 빈도수 count
#x11()
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2,family="AppleGothic")

# 출력 결과의 이미지 저장(x11()로 별도 창에 출력한 경우에만 가능)
#savePlot('speech.png', type='png')  

# 김대중 대통령 연설문의 단어에 대한 워드 클라우드 만들기
# speech2.txt 선택
noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun) 
word_count <- table(noun2) 
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2,family="AppleGothic")

noun2 <- gsub("오늘", "", noun2)
noun2 <- gsub("여러분", "", noun2)
noun2 <- gsub("우리", "", noun2)

noun2 <- Filter(function(x){nchar(x) >= 2}, noun2)

word_count <- table(noun2)
#x11()
wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2,family="AppleGothic")

# 출력 결과의 이미지 저장(x11()로 별도 창에 출력한 경우에만 가능)
savePlot('speech2.png', type='png')
# The same with 'Save as Image' menu in Export

