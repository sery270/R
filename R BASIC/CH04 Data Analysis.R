######################################
## CH03 getting started with R: data frame
######################################

# data.frame create
econ <- c(1,2,3,4,5)
biz <- c(1,2,3,4,5)
midterm <- data.frame(econ, biz)
midterm
midterm$econ
midterm$biz
mean(midterm$econ)
mean(midterm$biz)


# xlsx upload : returnÀÌ data frame
install.packages("readxl")
library(readxl)
getwd()
dir()
gdp <- read_excel("gdp.xlsx") 
gdp

# csv upload : returnÀÌ data frame
gdp2 <- read.csv("gdp.csv", stringsAsFactors=F)
gdp2