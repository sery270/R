# sentiment analysis for a sample sentence

rm(list = ls())             

pkg <- c("twitteR", "plyr", "stringr", "ggplot2")
new.pkg <- pkg[!(pkg %in% installed.packages())]
new.pkg
if (length(new.pkg)) {
  install.packages(new.pkg) 
}

library(twitteR)
library(plyr)
library(stringr)
library(ggplot2)

FUN=function(sentence, pos.words, neg.words)
   {
      # remove punctuation
      sentence = gsub("[[:punct:]]", "", sentence)
      # remove control characters
      sentence = gsub("[[:cntrl:]]", "", sentence)
      # remove digits?
      sentence = gsub('\\d+', '', sentence)

      # define error handling function when trying tolower
      tryTolower = function(x)
      {
         # create missing value
         y = NA
         # tryCatch error
         try_error = tryCatch(tolower(x), error=function(e) e)
         # if not an error
         if (!inherits(try_error, "error"))
          y = tolower(x)
         # result
         return(y)
      }

      # use tryTolower with sapply 
      sentence = sapply(sentence, tryTolower)
      # split sentence into words with str_split (stringr package)
      word.list = str_split(sentence, "\\s+")
      words = unlist(word.list)

      # compare words to the dictionaries of positive & negative terms
      pos.matches = match(words, pos.words)
      neg.matches = match(words, neg.words)

      # get the position of the matched term or NA
      # we just want a TRUE/FALSE
      pos.matches = !is.na(pos.matches)
      neg.matches = !is.na(neg.matches)

      # final score
      score = sum(pos.matches) - sum(neg.matches)
      return(score)
    }

score.sentiment = function(sentences, pos.words, neg.words)
{
   # Parameters
   # sentences: vector of text to score
   # pos.words: vector of words of postive sentiment
   # neg.words: vector of words of negative sentiment  
   # create simple array of scores with laply

   scores = laply(sentences, FUN, pos.words, neg.words)

   # data frame with scores for each sentence
   scores.df = data.frame(text=sentences, score=scores)
   return(scores.df)
}

pos.words = scan(file.choose(), what='character', comment.char=';')
neg.words = scan(file.choose(), what='character', comment.char=';')

sample = c("You're awesome and I love you",
"I hate and hate and hate. So angry. Die!",
"Impressed and amazed: you are peerless in your achievement of unparalleled mediocrity",
"Oh how I love being ignored",
"Absolutely adore it when my bus is late.")

result = score.sentiment(sample, pos.words, neg.words)
result

qplot(result$score, geom="histogram", binwidth=0.3)
