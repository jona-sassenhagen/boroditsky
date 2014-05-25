library("BayesFactor")

# run model on means per word and subject

# note: all values set to german gender,
# so an interaction between sex * language indicates gram. gender congruence

sourcefile<-paste("./boroditsky.csv",sep=",")
dat<-read.table(sourcefile,sep=",",header=TRUE)

dat$subj <- as.factor(dat$subj)
dat$language <- as.factor(dat$language)
dat$word <- as.factor(dat$word)
dat$sex <- as.factor(dat$sex)

        
anovaBF(rating ~ sex*language, data = dat,  whichRandom = c("word","subj"),  progress=TRUE,multicore=TRUE)

