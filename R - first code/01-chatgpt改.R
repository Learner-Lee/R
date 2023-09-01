# 载入所需的库
library(RODBC)

# 定义 Excel 文件路径
excel_file <- "F:/R/class01/R - first code/2glkx/data2/al5-1.xls"

# 连接 Excel 文件
z <- odbcConnectExcel2007(excel_file)

# 从 Excel 中读取数据到数据框 sq
sq <- sqlFetch(z, "Sheet1")

# 关闭连接
odbcClose(z)

# 打印读取的数据
print(sq)

# 绘制直方图的通用参数
hist_params <- list(
  main = "电力消费情况",
  xlab = "电力消费情况",
  ylab = "频数"
)

# 设置绘图布局为2x2
par(mfrow = c(2, 2))

# 绘制不同设置的直方图
hist(sq$DLXF, ...)
hist(sq$DLXF, main = "电力消费情况", ...)
hist(sq$DLXF, main = "电力消费情况", xlim = c(0, 4000), ..., ylim = c(0, 15))
hist(sq$DLXF, main = "电力消费情况", xlim = c(min(sq$DLXF), max(sq$DLXF)), ylim = c(0, 15), ...)