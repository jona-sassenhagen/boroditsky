library("lme4")

# (männl: -1)

# run model on all adjectives

# note: real gender used, so sex alone, no interaction term, should be optimal

# out_all = ['subj,word,assoc_i,sex_port,sex_ger,sex,language,rating']
sourcefile<-paste("./preproc/boroditsky_all.csv",sep=",")
dat<-read.table(sourcefile,sep=",",header=TRUE)

dat$subj <- as.factor(dat$subj)
dat$language <- as.factor(dat$language)
dat$word <- as.factor(dat$word)
dat$sex_port <- as.factor(dat$sex_port)
dat$sex_ger <- as.factor(dat$sex_ger)
dat$sex <- as.factor(dat$sex)
dat$assoc_i <- as.factor(dat$assoc_i)



modl1 <- lmer(rating ~ sex + language +  (1|assoc_i/word/language) + (1|assoc_i/subj/language) , data = dat)

modl2 <- lmer(rating ~ language +  (1|assoc_i/word/language) + (1|assoc_i/subj/language) , data = dat)

summary(modl1)
summary(modl2)

anova(modl1, modl2, test = "F")

# xyplot(rating ~ sex|language + subj + word, data = dat)