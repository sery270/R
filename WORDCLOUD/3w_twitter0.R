rm(list = ls()) 

# 패키지 설치
#install.packages("twitteR")
#install.packages("KoNLP")
#install.packages("wordcloud")
#install.packages("ROAuth") # 외부에서 트위터에 접근하기 위해 필요한 패키지 설치

# 아래 패키지 중에 설치안된 패키지를 확인하여 있으면 설치
pkg <- c("wordcloud", "RColorBrewer", "KoNLP", "twitteR", "ROAuth")
new.pkg <- pkg[!(pkg %in% installed.packages())]
new.pkg
if (length(new.pkg)) {
  install.packages(new.pkg) 
}

library(twitteR)
library(KoNLP)
library(wordcloud)
library(ROAuth)
library(RCurl)
library(RColorBrewer)

useSejongDic()

# twitter key값 할당
api_key <- "djLOJHJSoS9gPeOJcZweZdIcy"
api_secret <- "9odoeJ4VceVNgY4Yukkom0I5fKmA6LczDENPVKSESmzMiolHIl"
access_token <- "264032128-rmG5dQxVLNYl6u0DTVa19nNiXEmAwjHON2xOYsfk"
access_token_secret <- "kAioQWvsXasUYhiFNCtikcIreY3CYpkpxWv0Sz78aHUqP"

# twitter와 연결
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

# 키워드를 한글로 처리
  keyword <- enc2utf8("세란여주")

# 내용 검색
tweets <- searchTwitter(keyword, n=1000) # n의 건수 크기에 따라 시간소요
#tweets <- searchTwitter(keyword, n=1000, since='2017-01-01') # 검색기간 지정
head(tweets)

# Text 가져오기
tweets_txt = sapply(tweets, function(x) x$getText())
head(tweets_txt)

# RT된 것들 제외 너무 정확성 떨어짐 (내가 추가함 ㅋ)
tmp <-  grep("^RT",tweets_txt) 
tweets_txt <- tweets_txt[-tmp]

# 문자 분리(명사추출)
result.nouns <- sapply(tweets_txt, extractNoun, USE.NAMES = F)
result.wordsvec <- unlist(result.nouns, use.names = FALSE)

# 불필요한 문자 제거
result.wordsvec <- gsub("[[:punct:]]", "", result.wordsvec)
result.wordsvec <- gsub("[[:digit:]]", "", result.wordsvec)
result.wordsvec <- gsub("[[:space:]]", "", result.wordsvec)
result.wordsvec <- gsub("[[:cntrl:]]", "", result.wordsvec)
result.wordsvec <- gsub("http[[:alnum:]]*", "", result.wordsvec)
result.wordsvec <- gsub("RT", "", result.wordsvec)

# 단어의 글자 수가 2이상인 단어만 필터링
result.wordsvec <- Filter(function(x){nchar(x) >= 2 & nchar(x) <= 6 }, result.wordsvec)

# 단어별 카운팅
twitter.count <- table(result.wordsvec)
twitter_data <- head(sort(twitter.count, decreasing = TRUE), 50)
head(twitter_data)

# 색 설정
pal2 <- brewer.pal(8, "Dark2")

# 폰트 등록
#windowsFonts(malgun=windowsFont("맑은 고딕"))
#windowsFonts() # 등록된 폰트 리스트 출력

# 워드 클라우드 그리기
#x11()
wordcloud(names(twitter_data),
          freq = twitter_data,
          scale = c(4,1),
          min.freq = 1,
          random.order = F,
          rot.per = 0,
          colors = pal2,
          family = "AppleGothic")

