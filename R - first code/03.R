library(RODBC)
z<-odbcConnectExcel2007("C:/Users/PZ_EDU/Desktop/2glkx/data2/al5-3.xls")
sq<-sqlFetch(z,"Sheet1")
sq
d<-data.frame(y1=sq$total,y2=sq$new)
matplot(d,type = 'l')
matplot(d,type = 'l',main="人口",ylim = c(0,220))
close(z)