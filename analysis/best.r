library("BEST")

# note: larger differences between groups indicate larger gender congruence effects

sourcefile<-paste("./preproc/ger_out.csv",sep=",")
ger<-as.numeric(read.table(sourcefile,sep=","))

sourcefile<-paste("./preproc/por_out.csv",sep=",")
por<-as.numeric(read.table(sourcefile,sep=","))

BESTout <- BESTmcmc( -1*por, ger )

postscript("filename.eps")
plotAll(BESTout, credMass=0.8, ROPEm=c(-0.1,0.1), ROPEeff=c(-0.2,0.2), compValm=5)
dev.off()

summary(BESTout, credMass=0.8, ROPEm=c(-0.1,0.1), ROPEsd=c(-0.15,0.15), ROPEeff=c(-0.2,0.2))

