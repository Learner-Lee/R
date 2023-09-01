%%  Chapter13 R语言时间序列分析  %%

%%-- P1:金融数据的抓取，Quandl/quantmod/yahoo等 --%%  20200802

library(quantmod);library(TTR)

setSymbolLookup(SSEC=list(name="000001.SS",src="yahoo"))
getSymbols("SSEC",from="2010-07-01",to="2020-07-31")
head(SSEC)
tail(SSEC)

mydata=SSEC[,4];head(mydata) #得到close price
returns=diff(log(mydata))*100
head(returns)
returnMonth=monthlyReturn(SSEC)

write.csv(as.data.frame(mydata),file="mydata.csv")
write.csv(as.data.frame(SSEC),file="SSEC.csv")

%%-- P2：读取数据、基本的数据分析、画图 --%% 

temp=read.csv("closingprice.csv")
price=as.timeSeries(as.matrix(temp[,2]),as.Date(temp[,1]))
colnames(price)="Clsep"
head(price)
returns=diff(log(price))   #计算对数收益率
summary(returns)
newreturns=na.omit(returns)  #去掉NA值
renames(newreturns)=returns

var(newreturns)
sqrt(var(newreturns))
skewness(newreturns)
kurtosis(newreturns)
attr(,"method")
normalTest(returns,method=c("jb"),na.rm=F)

%% 时间序列绘图library(xts)
temp=read.csv("SSECindex.csv",header=T)
head(temp,3)
y=temp[,5]
plot(y,type="l",col="blue",ylab="close",xlab="number",main="上证综指收盘价")
grid()
dat=as.xts(temp[,-1],as.Date(temp[,1]))
plot(dat[,4],type="l",col="green",yax.loc="left",main="上证综指收盘价")

Sys.setlocale(category="LC_ALL",locale="English_United States.1252")  # 将系统时间设定为英文
plot(dat[,4],type="l",col="red",yax.loc="left",main="上证综指收盘价",format.labels='%y-%m-%d')
abline(v="2015-06-12",lty=2,col="red")
abline(h=5166.35,v="2015-06-12",untf=F,lty=2,col="red")

#plot(dat[,4],type="l",col="red",yax.loc="left",main="上证综指收盘价",
#     events=list(time=c("2015-06-12","2015-06-20"),label="最高点"),
#     blocks=list(start.time="2015-06-12",end.time="2015-06-20",
#     col=c("lightblue1","lightgreen")),
#    format.labels='%y-%m-%d')
#yline=list(time="2015-06-12",col="blue")

par(mfrow=c(2,2),mar=c(4,4,2,2)+0.1,mgp=c(2.5,1,0))
plot(density(y),col="blue",main="核密度图")
qqnorm(y,pch=19,col="brown",main="Q-Q图")   #pch为线条类型
hist(y,pch=19,col="lightpink",main="直方图")
boxplot(y,col="green",main="箱型图")
par(opar)

%%-- P3：时间序列预处理：自相关、平稳性、白噪声 --%% 

library(forescast)
library(tseries)
(.packages())    #查看已加载的package 

# 自相关检验
acf(returns,main="ACF of SSEC returns")
pacf(returns,main="PACF of SSEC returns")
corr=acf(returns,lag=10);corr

# 平稳性：单位根检验，包括ADF、PP、ZA等
library(urca)  #有多种

adf.test(returns)   
pp.test(returns)

# 白噪声检验
Box.test(returns,type="Ljung-Box")  # H0:样本为白噪声


%%-- P4：ARIMA模型 --%% 20200805

library(forescast)
library(MTS)
library(arima)     #R4.0.2不可用
estARIMA=auto.arima(returns,ic="aic")
names(estARIMA) #查看estARIMA中的内容



%%-- P5：GARCH模型 --%% 

head(returns)
y=returns
t=nrow(y)

# ARCH效应检验
archTest(returns,lags=12) #对原始returns进行ARCH效应检验，默认滞后期为10
archTest(fit.arima$resid,lags=20) #对ARIMA拟合后的残差进行ARCH效应检验，结果一样

# fGarch包的标准GARCH估计

library(fGarch)
distribution=c("std")  #学生t分布
myfit=garchFit(formula=~arma(1,1)+garch(1,1),data=y,cond.dist=distribution)
summary(myfit)
plot(myfit,which=2)

par(mfrow=c(2,2))
plot(myfit,which=c(1,2,8,9))
par(mfrow=c(1,1))

# rugarch包的GARCH估计

library(rugarch)

meanSpec=list(armaOrder=c(1,1),include.mean=TRUE,archm=TRUE, archpow=1, arfima=FALSE, external.regressors = NULL)
               ## 均值方程设定
varSpec=list(model="sGARCH",garchOrder = c(1,1),submodel = NULL, variance.targeting = FALSE, external.regressors = NULL) 
                          ## "sGARCH", "iGARCH", "eGARCH", "gjrGARCH", "apARCH"
distSpec=c("snorm") 
	                    ## 分布设定 "norm", "snorm", "std", "sstd", "ged","sged", "nig", "jsu"
     
mySpec=ugarchspec(mean.model=meanSpec, variance.model=varSpec, distribution.model=distSpec)

estGARCH = ugarchfit(spec=mySpec, data = y)
estGARCH
summary(estGARCH) 
plot(estGARCH,which=3) #

SIG=sigma(estGARCH)

list()
ls()

# iClick包的GARCH估计
library(iClick)
meanEQ=list(AR=1,MA=1,Exo=NULL,autoFitArma=F,arfimaDiff=F,archM=F)
garchEQ=list(type="sGARCH",P=1,Q=1,exo=NULL)
iClick.GARCH(y,meanEQ,garchEQ,n.ahead=10)


#预测 fGarch模型的预测

> myforecast=predict(myfit,n.ahead=50,mse="cond",plot=T,crit_val=2)
> head(myforecast)

save.image("Chapter13.RData")
