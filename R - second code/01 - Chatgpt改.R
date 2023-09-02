# 创建正态分布曲线并绘制到同一图形中

# 参数设置
x_range <- c(-5, 5)
y_range <- c(0, 0.8)

# 第一条曲线 - 均值为0，标准差为1，红色虚线
curve(dnorm(x, 0, 1), xlim = x_range, ylim = y_range, col = 'red', lwd = 2, lty = 3)

# 第二条曲线 - 均值为0，标准差为2，绿色实线
curve(dnorm(x, 0, 2), add = TRUE, col = 'green', lwd = 2, lty = 1)

# 第三条曲线 - 均值为0，标准差为0.5，黑色点线
curve(dnorm(x, 0, 0.5), add = TRUE, col = 'black', lwd = 2, lty = 4)

# 添加标题
title("View of Normal Distributions")