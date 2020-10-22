##
# p.12
#
## str_split(string, pattern) : 문자열을 pattern 기준으로 분리

sample = c("You're awesome and I love you",
           "I hate and hate and hate. So angry. Die!")
str_split(sample, "\\s+") # 문장을 단어로 분리(space 기준으로)
## [[1]] 
## [1] "You're"  "awesome" "and"     "I"       "love"    "you" 
## 
## [[2]] 
## [1] "I"      "hate"   "and"    "hate"   "and"    "hate."  "So"     "angry." "Die!"

#
## match(x, table) : x 를 table 과 매칭해서 매칭 여부를 알려줌

match_point <- match(c("hate","love","like"), c("late","hate","angry","die","like","want"))
match_point
## [1]  2 NA  5
## 왼쪽 벡터에서의 hate, like 는 오른 쪽 벡터의 2,5번째에 있다. love는 없다. 

#
## !is.na( ) : NA 인지 아닌지 판단하는 함수

match_point <- !is.na(match_point)
match_point
## [1]  TRUE FALSE  TRUE

#
## sum( ) : logical TRUE 는 1, FALSE 는 0

sum(match_point)
## [1] 2

##
# p.14
#
## scan(file, what=‘character’) : 파일을 읽기 위한 함수

scan('positive-words.txt', what='character', comment.char=';')
## what='character' - 문자 데이터인 경우 
## comment.char=';' - ; 는 주석처리
## Read 2007 items
## [1] "a+"                   "abound"               "abounds"             
## [4] "abundance"            "abundant"             "accessable"          
## [7] "accessible"           "acclaim"              "acclaimed"  
##
# p.15
#
## data.frame(vector1, vector2, … , vectorn) # n개의 벡터로 구성되는 데이터 오브젝트

name <- c("kim", "lee", "park", "choi")
exercise <- c(1,2,0,3)

data.frame(name, exercise)
##    name exercise
## 1   kim        1
## 2   lee        2
## 3  park        0
## 4  choi        3
