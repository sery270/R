rm(list = ls()) 

#install.packages("wordcloud")
#install.packages("RColorBrewer")
#install.packages("KoNLP")  

pkg <- c("wordcloud", "RColorBrewer", "KoNLP")
new.pkg <- pkg[!(pkg %in% installed.packages())]
new.pkg
if (length(new.pkg)) {
  install.packages(new.pkg) 
}

library(wordcloud)
library(RColorBrewer)
library(KoNLP)

useSejongDic()

# cloud computing.txt 파일을 읽어서 data1 변수에 저장
data1 <- readLines(file.choose())

# data1에서 명사만 data2에 저장
data2 <- sapply(data1, extractNoun, USE.NAMES = F)

# 두 글자 이상 필터링을 위해 unlist 작업하여 저장
data3 <- unlist(data2)

wordcount <- table(data3) # 단어별 count
head(sort(wordcount, decreasing=TRUE), 10) # 빈도수 높은 Top10

pal2 <- brewer.pal(8, "Dark2") # 글자 색깔 지정

wordcloud(names(wordcount), freq = wordcount, scale = c(5,1), rot.per = 0.1, min.freq = 10, random.order = F, colors = pal2, family = "AppleGothic")

# 세종사전에 없는 단어 추가(mergeUserDic 함수를 대체)
buildDictionary(ext_dic = 'sejong', category_dic_nms = 'information and communication', user_dic = data.frame(term="클라우드", tag="ncn"), replace_usr_dic=F)
buildDictionary(ext_dic = 'sejong', category_dic_nms = 'information and communication', user_dic = data.frame(term="인터넷", tag="ncn"), replace_usr_dic=F)
buildDictionary(ext_dic = 'sejong', category_dic_nms = 'information and communication', user_dic = data.frame(term="아키텍처", tag="ncn"), replace_usr_dic=F)
buildDictionary(ext_dic = 'sejong', category_dic_nms = 'information and communication', user_dic = data.frame(term="아마존", tag="ncn"), replace_usr_dic=F)

# 세종사전에 없는 단어 추가(잘 사용되지 않아 곧 사라질 함수임)
#mergeUserDic(data.frame(c("클라우드"),c("ncn"))) 
#mergeUserDic(data.frame(c("인터넷"),c("ncn"))) 
#mergeUserDic(data.frame(c("아키텍처"),c("ncn"))) 
#mergeUserDic(data.frame(c("아마존"),c("ncn"))) 

data2 <- sapply(data1, extractNoun, USE.NAMES = F) # data1에서 명사만 data2에 저장
data3 <- unlist(data2) # 두 글자 이상 필터링을 위해 unlist 작업하여 저장

data3 <- gsub("\\d+", "", data3) # 숫자 제외 정규식
data3 <- gsub("[[:punct:]]", "", data3) # 심볼, 괄호, 특수문자 제외

data3 <- gsub("들이", "", data3) # 불필요 데이터 삭제
data3 <- gsub("이것", "", data3) # 불필요 데이터 삭제
data3 <- gsub("이상", "", data3) # 불필요 데이터 삭제
data3 <- gsub("하나", "", data3) # 불필요 데이터 삭제
data3 <- gsub("년대", "", data3) # 불필요 데이터 삭제
data3 <- gsub("어디", "", data3) # 불필요 데이터 삭제
data3 <- gsub("하기", "", data3) # 불필요 데이터 삭제
data3 <- gsub("때문", "", data3) # 불필요 데이터 삭제
data3 <- gsub("하게", "", data3) # 불필요 데이터 삭제

data3 <- Filter(function(x){nchar(x)>=2}, data3) # 두 글자 이상 단어만 저장

wordcount <- table(data3) # 단어별 count
head(sort(wordcount, decreasing=TRUE), 10)

pal2 <- brewer.pal(8, "Dark2") # 글자 색깔 지정

wordcloud(names(wordcount), freq = wordcount, scale = c(5,1), rot.per = 0.1, min.freq = 5, random.order = F, colors = pal2, family = "AppleGothic")

pal <- brewer.pal(9, "Blues")[5:9] # 글자 색깔 지정
set.seed(1234) # 난수 고정

wordcloud(names(wordcount), freq = wordcount, scale = c(5,0.2), rot.per = 0.1, min.freq = 3, random.order = F, colors = pal, family = "AppleGothic")

