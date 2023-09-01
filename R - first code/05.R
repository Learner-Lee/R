library(RODBC)
z<-odbcConnectExcel2007("C:/Users/PZ_EDU/Desktop/2glkx/data2/al5-5.xls")
sq<-sqlFetch(z,"Sheet1")
sq
boxplot(sq$SCFE)
boxplot(sq$SCFE~sq$Center,data2=sq)
close(z)