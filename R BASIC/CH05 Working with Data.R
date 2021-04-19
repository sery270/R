######################################
## CH05 Working with Data
######################################
law <- read.csv("law.csv", stringsAsFactors=F)
library(dplyr)
View(law)

## Filter and Select
######################################

# filter( 데이터 프레임, 조건문 )
filter(law, law$gdp>1)
filter(law, rule_of_law >= 1 & control_of_corruption >= 1)

#  grouping
group1 <- filter(law, law$rule_of_law < -1)
group2 <- filter(law, law$rule_of_law >=-1 &  law$rule_of_law  < 0)
group3 <- filter(law, law$rule_of_law >=0 &  law$rule_of_law  < 1)
group4 <- filter(law, law$rule_of_law >=1)

group <- data.frame(nrow(group1),nrow(group2),nrow(group3),nrow(group4))
View(group)

# grouping and mean
mean(group1$gdp)


# select( 데이터 프레임, 변수1, 변수2, 변수3, ...)
# 선택한 변수만 보여줌
select(law, gdp)

# select( 데이터 프레임, ???변수1, ???변수2, ???변수3, ...)
# 선택한 변수만 빼고 보여줌
my_law <- select(law, -law$rule_of_law, law$control_of_corruption, -law$education)
View(my_law)


## Sorting
######################################

## Filter and Select
######################################

