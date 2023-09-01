# 链接R语言中的RODBC库，该库提供了数据库连接和操作的功能。
library(RODBC)

# 使用ODBC连接方法，将代码中的Excel文件路径 ("F:/R/class01/2glkx/data2/al5-1.xls") 
# 连接到R中，并将连接对象存储在变量 z 中。
z<-odbcConnectExcel2007("F:/R/class01/R - first code/2glkx/data2/al5-1.xls")

# 使用连接对象 z 和指定的工作表名 "Sheet1"，
# 从Excel文件中读取数据，并将数据存储在变量 sq 中。
sq<-sqlFetch(z,"Sheet1")

# 关闭与Excel文件的数据库连接，释放资源
close(z)

# 打印输出
sq

# 绘制关于 sq$DLXF 列的直方图。
# sq$DLXF 表示数据框 sq 中的名为 "DLXF" 的列，
# 这个代码会绘制这一列数据的直方图。
hist(sq$DLXF)

# 这行代码与上一行类似，但添加了一个标题 "电力消费情况" 到绘制的直方图上。
hist(sq$DLXF,main="电力消费情况")

# 这一行代码对绘制直方图的参数进行了更多的设定。
# xlim 参数设置x轴的范围，xlab 和 ylab 参数设置x轴和y轴的标签。
hist(sq$DLXF,main="电力消费情况",xlim=c(0,4000),ylim=c(0,15),xlab="电力消费情况",ylab="频数")

# 这行代码使用了数据中的最小值和最大值来设置x轴的范围，并设定y轴范围为0到15。
hist(sq$DLXF,main="电力消费情况",xlim=c(min(sq$DLXF),max(sq$DLXF)),ylim=c(0,15))
