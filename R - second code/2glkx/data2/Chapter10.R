%%  Chapter13 R����ʱ�����з���  %%

%%-- P1:�������ݵ�ץȡ��Quandl/quantmod/yahoo�� --%%  20200802

library(quantmod);library(TTR)

setSymbolLookup(SSEC=list(name="000001.SS",src="yahoo"))
getSymbols("SSEC",from="2010-07-01",to="2020-07-31")
head(SSEC)
tail(SSEC)

mydata=SSEC[,4];head(mydata) #�õ�close price
returns=diff(log(mydata))*100
head(returns)
returnMonth=monthlyReturn(SSEC)

write.csv(as.data.frame(mydata),file="mydata.csv")
write.csv(as.data.frame(SSEC),file="SSEC.csv")

%%-- P2����ȡ���ݡ����������ݷ�������ͼ --%% 

temp=read.csv("closingprice.csv")
price=as.timeSeries(as.matrix(temp[,2]),as.Date(temp[,1]))
colnames(price)="Clsep"
head(price)
returns=diff(log(price))   #�������������
summary(returns)
newreturns=na.omit(returns)  #ȥ��NAֵ
renames(newreturns)=returns

var(newreturns)
sqrt(var(newreturns))
skewness(newreturns)
kurtosis(newreturns)
attr(,"method")
normalTest(returns,method=c("jb"),na.rm=F)

%% ʱ�����л�ͼlibrary(xts)
temp=read.csv("SSECindex.csv",header=T)
head(temp,3)
y=temp[,5]
plot(y,type="l",col="blue",ylab="close",xlab="number",main="��֤��ָ���̼�")
grid()
dat=as.xts(temp[,-1],as.Date(temp[,1]))
plot(dat[,4],type="l",col="green",yax.loc="left",main="��֤��ָ���̼�")

Sys.setlocale(category="LC_ALL",locale="English_United States.1252")  # ��ϵͳʱ���趨ΪӢ��
plot(dat[,4],type="l",col="red",yax.loc="left",main="��֤��ָ���̼�",format.labels='%y-%m-%d')
abline(v="2015-06-12",lty=2,col="red")
abline(h=5166.35,v="2015-06-12",untf=F,lty=2,col="red")

#plot(dat[,4],type="l",col="red",yax.loc="left",main="��֤��ָ���̼�",
#     events=list(time=c("2015-06-12","2015-06-20"),label="��ߵ�"),
#     blocks=list(start.time="2015-06-12",end.time="2015-06-20",
#     col=c("lightblue1","lightgreen")),
#    format.labels='%y-%m-%d')
#yline=list(time="2015-06-12",col="blue")

par(mfrow=c(2,2),mar=c(4,4,2,2)+0.1,mgp=c(2.5,1,0))
plot(density(y),col="blue",main="���ܶ�ͼ")
qqnorm(y,pch=19,col="brown",main="Q-Qͼ")   #pchΪ��������
hist(y,pch=19,col="lightpink",main="ֱ��ͼ")
boxplot(y,col="green",main="����ͼ")
par(opar)

%%-- P3��ʱ������Ԥ����������ء�ƽ���ԡ������� --%% 

library(forescast)
library(tseries)
(.packages())    #�鿴�Ѽ��ص�package 

# ����ؼ���
acf(returns,main="ACF of SSEC returns")
pacf(returns,main="PACF of SSEC returns")
corr=acf(returns,lag=10);corr

# ƽ���ԣ���λ�����飬����ADF��PP��ZA��
library(urca)  #�ж���

adf.test(returns)   
pp.test(returns)

# ����������
Box.test(returns,type="Ljung-Box")  # H0:����Ϊ������


%%-- P4��ARIMAģ�� --%% 20200805

library(forescast)
library(MTS)
library(arima)     #R4.0.2������
estARIMA=auto.arima(returns,ic="aic")
names(estARIMA) #�鿴estARIMA�е�����



%%-- P5��GARCHģ�� --%% 

head(returns)
y=returns
t=nrow(y)

# ARCHЧӦ����
archTest(returns,lags=12) #��ԭʼreturns����ARCHЧӦ���飬Ĭ���ͺ���Ϊ10
archTest(fit.arima$resid,lags=20) #��ARIMA��Ϻ�Ĳв����ARCHЧӦ���飬���һ��

# fGarch���ı�׼GARCH����

library(fGarch)
distribution=c("std")  #ѧ��t�ֲ�
myfit=garchFit(formula=~arma(1,1)+garch(1,1),data=y,cond.dist=distribution)
summary(myfit)
plot(myfit,which=2)

par(mfrow=c(2,2))
plot(myfit,which=c(1,2,8,9))
par(mfrow=c(1,1))

# rugarch����GARCH����

library(rugarch)

meanSpec=list(armaOrder=c(1,1),include.mean=TRUE,archm=TRUE, archpow=1, arfima=FALSE, external.regressors = NULL)
               ## ��ֵ�����趨
varSpec=list(model="sGARCH",garchOrder = c(1,1),submodel = NULL, variance.targeting = FALSE, external.regressors = NULL) 
                          ## "sGARCH", "iGARCH", "eGARCH", "gjrGARCH", "apARCH"
distSpec=c("snorm") 
	                    ## �ֲ��趨 "norm", "snorm", "std", "sstd", "ged","sged", "nig", "jsu"
     
mySpec=ugarchspec(mean.model=meanSpec, variance.model=varSpec, distribution.model=distSpec)

estGARCH = ugarchfit(spec=mySpec, data = y)
estGARCH
summary(estGARCH) 
plot(estGARCH,which=3) #

SIG=sigma(estGARCH)

list()
ls()

# iClick����GARCH����
library(iClick)
meanEQ=list(AR=1,MA=1,Exo=NULL,autoFitArma=F,arfimaDiff=F,archM=F)
garchEQ=list(type="sGARCH",P=1,Q=1,exo=NULL)
iClick.GARCH(y,meanEQ,garchEQ,n.ahead=10)


#Ԥ�� fGarchģ�͵�Ԥ��

> myforecast=predict(myfit,n.ahead=50,mse="cond",plot=T,crit_val=2)
> head(myforecast)

save.image("Chapter13.RData")