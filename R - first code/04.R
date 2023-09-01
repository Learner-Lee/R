library(RODBC)
z<-odbcConnectExcel2007("C:/Users/PZ_EDU/Desktop/2glkx/data2/al5-4.xls")
sq<-sqlFetch(z,"Sheet1")
sq
plot(sq$year,sq$number,type="b")
plot(sq$year,sq$number,type="b",main = "上市",xlim = c(1998,2013),ylim = c(800,2500))
plot(sq$year,sq$number,type="b",pch = 18)
close(z)