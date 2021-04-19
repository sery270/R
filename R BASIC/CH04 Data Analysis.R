######################################
## CH04 Data Analysis: A Beginner
######################################

## Describing Data
######################################

#  head( 변수, n=숫자 )
head(gdp, n=10)

#  tail( 변수, n=숫자 )
tail(gdp, n=10)

# View( 변수 )
# ‘변수’(object): matrix, data frame, vector 등이 올 수 있다.
View(gdp)

# dim( 변수 )
# ‘변수’(object): matrix, data frame, vector 등이 올 수 있다.
# 행의 갯수, 열의 갯수
# dim을 행렬로 변환 가능 !
dim(gdp)

# str( 변수 )
# ‘변수’(object): matrix, data frame, vector 등이 올 수 있다.
# 변수의 유형, 관측치의 갯수, 변수들의 특성
str(gdp)

# summary( 변수 )
# ‘변수’(object): matrix, data frame, vector 등이 올 수 있다.
#  min, 1st quartile, median, mean, 3rd quartile, max
summary(gdp)
summary(gdp$y2018)


## How To Change the Names of Variables
######################################
install.packages("dplyr")
library(dplyr)

# rename( 데이터 프레임, 새로운 이름 = 원래 이름 )
x1 <- c(1,2,3)
x2 <- c(4,5,6)
my.df <- data.frame(x1,x2)
my.df 
my.df <- rename(my.df, y1=x1)
my.df 


## How To Construct New Variables
######################################

# <- 로 변수 assign
head(gdp)
gdp$avg <- (gdp$y2017+gdp$y2018)/2
# gdp에 새 변수 avg가 생김 
head(gdp)

# ifelse 로 변수 assign
# ifelse( 테스트할 조건문, true일 때의 값, false일 때의 값)
gdp$rich <- ifelse( gdp$avg >= 50000, "yes", "no")
View(gdp)

# gdp$rich의 분포 확인
table(gdp$rich)

# gdp$rich의 분포를 표로 확인
install.packages("ggplot2")
library(ggplot2)
qplot(gdp$rich)


