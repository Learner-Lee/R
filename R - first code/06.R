library(RODBC)
z<-odbcConnectExcel2007("C:/Users/PZ_EDU/Desktop/2glkx/data2/al5-6.xls")
sq<-sqlFetch(z,"Sheet1")
sq

pie(sq$CANYIN,sq$FANGCHAN,sq$ZHIZAO)

colors <- c("white","grey20","grey45")

rna_labels <- round((sq$CANYIN/sum(sq$CANYIN)) * 100 ,1)
rna_labels <- paste(rna_labels,"%",sep="")

pie(sq$CANYIN,main="Total",col = colors,labels = rna_labels,cex=0.8)

close(z)