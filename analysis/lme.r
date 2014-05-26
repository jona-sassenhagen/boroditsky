library(lme4)
library(effects)

setwd(normalizePath("."))

# (männl: 0)

# run model on all adjectives

# note: real gender used, so sex alone, no interaction term, should be optimal

# out_all = ['subj,word,assoc_i,sex_port,sex_ger,sex,language,rating']
dat <- read.csv(normalizePath("../preproc/boroditsky_all.csv")
                ,header=TRUE
                ,colClasses="factor")


basic <- glmer(rating ~ sex * language + (1|rater_i) + (1|word/language) +  (1|subj), data = dat, family=binomial)
basic.probit <- glmer(rating ~ sex * language + (1|rater_i) + (1|word/language) +  (1|subj), data = dat, family=binomial(link="probit"))


plot(allEffects(germansex <- glmer(rating ~ sex_ger * language + (1|rater_i) + (1|word/language) +  (1|subj), data = dat, family=binomial)))

summary(modl1)

