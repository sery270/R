##
# p.11
## display.brewer.all( ) : 유형별 palette의 이름과 색의 종류을 보여줌

display.brewer.all( )

##
# p.20
## grep(pattern, text) : text에서 일치되는 pattern의 원소를 찾음

name <- c("kim", "lee", "park", "choi")
exercise <- c(1,2,0,3)
PT <- data.frame(name, exercise)
PT
##name  exercise
##1   kim        1
##2   lee        2
##3  park        0
##4  choi        3

x <- grep("m$", PT$name) # name이 m으로 끝나는 원소를 찾음
x
## [1] 1

PT2 <- PT[-c(x),] # name이 m으로 끝나는 데이터를 제외
PT2
##names exercise
##2   lee        2
##3  park        0
##4  choi        3

PT3 <- PT2[PT2$exercise > 0,] # exercise 값이 0 보다 큰 데이터만 가져옴 
PT3
##name exercise
##2  lee        2
##4 choi        3

##
# p.28
## extractNoun(text) : KoNLP package 내의 함수로 세종 사전 기준으로 문장의 명사를 추출함

useSejongDic() 
## Backup was just finished! 
## 87007 words were added to dic_user.txt. 

x <- c("홍길동 曰 : 동해물과 백두산이 마르고 닳도록", "하느님이 보우하사 우리나라 만세~!") 
extractNoun(x) 
## [[1]]
## [1] "홍길동"   "曰"       "동해"     "물"       "백두산이" "닳도"     "록"      
##
## [[2]]
## [1] "하느님이" "보우"     "하사"     "우리나라" "만"       "세"

## extractNoun()은 사용자가 원하는 단어도 추가 할 수 있음

mergeUserDic(data.frame(c("백두산","하느님"), "ncn")) 
## 2 words were added to dic_user.txt.

extractNoun(x) 
## [[1]]
## [1] "홍길동" "曰"     "동해"   "물"     "백두산" "닳도"   "록"    
##
## [[2]]
## [1] "하느님"   "보우"     "하사"     "우리나라" "만"       "세"

## 사전에 단어를 추가하기 전과 비교했을 때, "백두산이" 는 "백두산"으로 추출되었고, "하느님이"도 "하느님" 으로 추출됨

##
# p.29
## sapply(x, function(x)) : x에 대해 함수 function(x)를 수행한 결과값을 리턴함

## 예제에 사용될 list 형태인 오브젝트 y를 생성함

y <- list(a = 1:10, b = rep(5,5)) 
y 
## $a 
## [1] 1 2 3 4 5 6 7 8 9 10 
## 
## $b 
## [1] 5 5 5 5 5

## 생성한 오브젝트 y를 사용하여 sapply()함수에 대해 알아보자. 

y2 <- sapply(y, function(x) sum(x)) 
y2 
##  a  b 
## 55 25 

##
# p.31
## unlist(x) : List 형태인 x 오브젝트를 unlist하면 벡터 형태로 변환함

l_ex <- list(LETTERS[1:5],"두번째") 
l_ex 
## [[1]] 
## [1] "A" "B" "C" "D" "E" 
## 
## [[2]] 
## [1] "두번째" 

unlist(l_ex) 
## [1] "A" "B" "C" "D" "E" "두번째" 

## table(x) : x 오브젝트의 각 원소별로 건수를 반환함

x <- c(rep(1:3, length=17))
x 
## [1] 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2
       
table(x)
## x
## 1 2 3 
## 6 6 5 

##
# p.33
## gsub(pattern, replacement, x) : 문자열에서 패턴을 검색하여 지정된 문자열로 대체하는 함수

x <- "R Tutorial"
gsub("ut","ot",x)
## [1] "R Totorial"

x <- "line 4322: He is now 25 years old, and weights 130lbs"
gsub("\\d+","---",x)
## [1] "line ---: He is now --- years old, and weights ---lbs"

## nchar(x) : 단어의 글자수를 count하는 함수

nouns <- c("한글", "텍스트", "명사", "만", "추출", "하기")
nchar(nouns)
## [1] 2 3 2 1 2 2
nchar(nouns)>=2
## [1]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE

## Filter(f, x) : 함수 f에 대해 True값인 x의 원소를 리턴하는 함수

Filter(function(x){nchar(x)>=2},nouns)
## [1] "한글"   "텍스트" "명사"   "추출"   "하기"
