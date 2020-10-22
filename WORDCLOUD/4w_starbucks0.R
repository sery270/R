# sentiment analysis for Starbucks

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

# twitter key값 할당
api_key <- "djLOJHJSoS9gPeOJcZweZdIcy"
api_secret <- "9odoeJ4VceVNgY4Yukkom0I5fKmA6LczDENPVKSESmzMiolHIl"
access_token <- "264032128-rmG5dQxVLNYl6u0DTVa19nNiXEmAwjHON2xOYsfk"
access_token_secret <- "kAioQWvsXasUYhiFNCtikcIreY3CYpkpxWv0Sz78aHUqP"

# twitter와 연결
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

score.sentiment = function(sentences, pos.words, neg.words)
{
   # Parameters
   # sentences: vector of text to score
   # pos.words: vector of words of postive sentiment
   # neg.words: vector of words of negative sentiment  
   # create simple array of scores with laply

   scores = laply(sentences, 
   function(sentence, pos.words, neg.words)
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
    }, pos.words, neg.words)
# data frame with scores for each sentence
   scores.df = data.frame(text=sentences, score=scores)
   return(scores.df)
}

# import positive and negative words
pos.words = scan(file.choose(), what='character', comment.char=';')
neg.words = scan(file.choose(), what='character', comment.char=';')

# harvest some tweets
tweets = searchTwitter("starbucks", n=1000, lang="en")

class(tweets)
head(tweets)

# get the text
tweets_txt = sapply(tweets, function(x) x$getText())
write.csv(tweets_txt, "starbucksTweets.csv")

starbucks.score = score.sentiment(tweets_txt, pos.words, neg.words)

head(starbucks.score)
starbucks.score$score
table(starbucks.score$score)
mean(starbucks.score$score)

qplot(starbucks.score$score, geom="histogram", binwidth=0.3)
