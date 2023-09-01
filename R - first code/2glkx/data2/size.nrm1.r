two.sample.ci<-function(x,y,conf.level=0.95,sigma1,sigma2){
options(digits=4)
m=length(x);n=length(y)
xbar=mean(x)-mean(y)
alpha=1-conf.level
zstar=qnorm(1-alpha/2)*(sigma1/m+ sigma2/n)^(1/2)
xbar+c(-zstar,+zstar)
}
