library(RODBC)
z<-odbcConnectExcel2007("C:/Users/PZ_EDU/Desktop/2glkx/data2/al5-7.xls")
sq<-sqlFetch(z,"Sheet1")
sq
barplot(sq$sum)
axis(side = 1)
barplot(sq$sum,main = "人数情况",ylim = c(0,7000))
axis(side = 1)
close(z)