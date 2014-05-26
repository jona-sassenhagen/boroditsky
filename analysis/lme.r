library("lme4")

setwd("~/Dropbox/manuscripts/boroditsky/analysis")

# (männl: -1)

# run model on all adjectives

# note: real gender used, so sex alone, no interaction term, should be optimal

# out_all = ['subj,word,assoc_i,sex_port,sex_ger,sex,language,rating']
sourcefile<-paste("../preproc/boroditsky_all.csv",sep=",")
dat<-read.table(sourcefile,sep=",",header=TRUE)

dat$subj <- as.factor(dat$subj)
dat$language <- as.factor(dat$language)
dat$word <- as.factor(dat$word)
dat$sex_port <- as.factor(dat$sex_port)
dat$sex_ger <- as.factor(dat$sex_ger)
dat$sex <- as.factor(dat$sex)
dat$assoc_i <- as.factor(dat$assoc_i)
dat$rater_i <- as.factor(dat$rater_i)



modl1 <- lmer(rating ~ sex + language +  (1|assoc_i/word/language) + (1|rater_i) + (1|assoc_i/subj/language) , data = dat, family=binomial)

modl2 <- lmer(rating ~ language + (1|rater_i)  + (1|assoc_i/word/language) + (1|assoc_i/subj/language) , data = dat, family=binomial)

summary(modl1)
summary(modl2)

anova(modl1, modl2, test = "F")

# xyplot(rating ~ sex|language + subj + word, data = dat)


modl1 <- lmer(rating ~ sex_ger:language + (1|rater_i) + (1|word/language) + (1|subj/language) , data = dat)




modl3 <- lmer(rating ~ sex + language + (1|rater_i) + (1|word) + (1|subj) , data = dat)

modl4 <- lmer(rating ~ language +  (1|word) + (1|subj) , data = dat)

summary(modl3)
summary(modl4)

anova(modl1, modl3, test = "F")
anova(modl2, modl4, test = "F")
