library("BEST")
library("ggplot2")
library("lme4")
library("BayesFactor")
library("doMC")


# (männl: -1)


sourcefile<-paste("~/Dropbox/manuscripts/boroditsky/boroditsky.csv",sep=",")
dat<-read.table(sourcefile,sep=",",header=TRUE)

dat$subj <- as.factor(dat$subj)
dat$language <- as.factor(dat$language)
dat$word <- as.factor(dat$word)


modl <- lm(rating ~ sex + language + sex*language,data = dat)
summary(modl)



modl1 <- lmer(rating ~ sex + language + (1|subj) + (1|word/language) ,data = dat)
summary(modl1)

modl2 <- lmer(rating ~ language + sex:language + (1|subj) + (1|word/language) ,data = dat)
summary(modl2)

anova(modl1, modl2, test = "F")


# out_all = ['subj,word,assoc_i,sex_port,sex_ger,sex,language,rating']


sourcefile<-paste("~/Dropbox/manuscripts/boroditsky/boroditsky_all.csv",sep=",")
dat<-read.table(sourcefile,sep=",",header=TRUE)

dat$subj <- as.factor(dat$subj)
dat$language <- as.factor(dat$language)
dat$word <- as.factor(dat$word)
dat$sex_port <- as.factor(dat$sex_port)
dat$sex_ger <- as.factor(dat$sex_ger)
dat$sex <- as.factor(dat$sex)
dat$assoic_i <- as.factor(dat$assoc_i)



modl2 <- lmer(rating ~ sex + language + (1|assoc_i) + (1|subj/language) + (1|word/language) , data = dat)



modl2 <- lmer(rating ~ sex_port + language + (1|assoc_i/word) + (1|subj/language) + (1|word/language) , data = dat)


modl2 <- lmer(rating ~ sex + language + (1|assoc_i/word) + (1|subj/language) + (1|word/language) , data = dat)



modl3 <- lmer(rating ~ sex*language + (1|assoc_i) + (1|subj/language) + (1|word/language) , data = dat)
modl4 <- lmer(rating ~ sex:language + (1|assoc_i) + language + (1|subj/language) + (1|word/language) , data = dat)

summary(modl2)
summary(modl3)
summary(modl4)

anova(modl2, modl4, test = "F")
anova(modl2, modl3, test = "F")
anova(modl4, modl3, test = "F")







sourcefile<-paste("~/Dropbox/manuscripts/boroditsky/ger_out.csv",sep=",")
ger<-as.numeric(read.table(sourcefile,sep=","))

sourcefile<-paste("~/Dropbox/manuscripts/boroditsky/por_out.csv",sep=",")
por<-as.numeric(read.table(sourcefile,sep=","))


#setwd("~/Dropbox/manuscripts/boroditsky/best")
#source("~/Dropbox/manuscripts/boroditsky/best/BEST.R")

#mcmcChain = BESTmcmc( -1*por, ger )
#BESTplot( -1*por , ger, mcmcChain , compValm=15 , ROPEeff=c(-0.1,0.1) , pairsPlot=FALSE )




# anovaBF(rating ~ sex + language + sex*language + word + subj, data = dat, whichRandom = c("word","subj","language"),        progress=TRUE)      
        
# anovaBF(rating ~ sex + language, data = dat, progress=TRUE,multicore=TRUE)


modl2 <- lmer(rating ~ sex + language + (1|subj/language) + (1|word/language) , data = dat)
modl3 <- lmer(rating ~ sex*language + (1|subj/language) + (1|word/language) , data = dat)
modl4 <- lmer(rating ~ sex:language + language + (1|subj/language) + (1|word/language) , data = dat)

summary(modl2)
summary(modl3)
summary(modl4)

anova(modl2, modl4, test = "F")
anova(modl2, modl3, test = "F")
anova(modl4, modl3, test = "F")


modl2 <- glmer(rating ~ language + sex:language + (1|subj) + (1|word/language) ,data = dat)
summary(modl2)

modl2 <- glmer(rating ~ language + sex:language + sex/language + (1|subj) + (1|word/language) ,data = dat)



xyplot(extro ~ open + social + agree | school, data = lmm.data, 
                 auto.key = list(x = .85, y = .035, corner = c(0, 0)), 
       layout = c(3, 2), main = "Extroversion by School") 

xyplot(rating ~ sex|language + subj + word, data = dat)