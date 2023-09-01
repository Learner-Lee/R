labs <- c('s1','s1','s1','s1','s1','s1','s1','s1')
mydata <- cbind(c(2017,400,5013,308),c(2018,400,5013,308),c(2019,400,5013,308),c(2010,400,5013,308),c(2011,400,5013,308),c(2012,400,5013,308),c(2013,400,5013,308),c(2014,400,5013,308),)
barplot(mydata,col = c('steelblue',"mediumturquoise","hotpink"),width=1,space=1,border=NA,
        lenfend.text = c("n1","n1","n1","n1"),
        args.legend = list(x="topright"))
abline(h=0)
text(x = seq(1.5,25.5,by=2),y = -300 ,srt = 45 ,adj = 1 ,labels = labs,xpd=TRUE)