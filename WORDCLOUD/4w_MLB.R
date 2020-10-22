# sentiment analysis for MBL

rm(list=ls())

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
api_key <- "본인의 twitter API Key값"
api_secret <- "본인의 twitter API Secret값"
access_token <- "본인의 twitter Access Token값"
access_token_secret <- "본인의 twitter Access Token Secret값"

# twitter와 연결
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

score.sentiment = function(sentences, pos.words, neg.words)
{
   
 scores = laply(sentences, function(sentence, pos.words, neg.words) {
        sentence = gsub('[[:punct:]]', '', sentence)
        sentence = gsub('[[:cntrl:]]', '', sentence)
        sentence = gsub('\\d+', '', sentence)
        sentence = tolower(sentence)
        word.list = str_split(sentence, '\\s+')
        words = unlist(word.list)
        pos.matches = match(words, pos.words)
        neg.matches = match(words, neg.words)
        pos.matches = !is.na(pos.matches)
        neg.matches = !is.na(neg.matches)
        score = sum(pos.matches) - sum(neg.matches)
        return(score)
    }, pos.words, neg.words)
    scores.df = data.frame(score=scores, text=sentences)
    return(scores.df)
}

# import positive and negative words
pos.words = scan('positive-words.txt', what='character', comment.char=';')
neg.words = scan('negative-words.txt', what='character', comment.char=';')

# harvest some tweets
orioles.tweets <- searchTwitter('#orioles', n=500, lang="en")
yankees.tweets <- searchTwitter('#yankees', n=500, lang="en")
bluejays.tweets <- searchTwitter('#bluejays', n=500, lang="en")
rays.tweets <- searchTwitter('#rays', n=500, lang="en")
redsox.tweets <- searchTwitter('#redsox', n=500, lang="en")

# get the text
orioles.text = sapply(orioles.tweets, function(t) t$getText())
yankees.text = sapply(yankees.tweets, function(t) t$getText())
bluejays.text = sapply(bluejays.tweets, function(t) t$getText())
rays.text = sapply(rays.tweets, function(t) t$getText())
redsox.text = sapply(redsox.tweets, function(t) t$getText())

orioles.scores <- score.sentiment(orioles.text, pos.words, neg.words)
yankees.scores <- score.sentiment(yankees.text, pos.words, neg.words)
bluejays.scores <- score.sentiment(bluejays.text, pos.words, neg.words)
rays.scores <- score.sentiment(rays.text, pos.words, neg.words)
redsox.scores <- score.sentiment(redsox.text, pos.words, neg.words)

orioles.scores$team = 'Orioles'
yankees.scores$team = 'Yankees'
bluejays.scores$team = 'Blue Jays'
rays.scores$team = 'Rays'
redsox.scores$team = 'Red Sox'

table(orioles.scores$score)
mean(orioles.scores$score)
table(yankees.scores$score)
mean(yankees.scores$score)
table(bluejays.scores$score)
mean(bluejays.scores$score)
table(rays.scores$score)
mean(rays.scores$score)
table(redsox.scores$score)
mean(redsox.scores$score)

aleast.scores = rbind(orioles.scores, yankees.scores, bluejays.scores, rays.scores, redsox.scores)
    
ggplot(data=aleast.scores, aes(x=score, group=team)) +
  geom_histogram(aes(fill=team), binwidth=1) + 
  facet_grid(team~.) + # vertical
#  facet_grid(.~team) + # horizontal
  theme_bw() +
  labs(title="Barplot - AL East's Sentiment Scores")

x11()
ggplot(data=aleast.scores, aes(x=team, y=score, group=team)) +
  geom_boxplot(aes(fill=team)) +
  geom_jitter() +
  labs(title="Boxplot - AL East's Sentiment Scores")
