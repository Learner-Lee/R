# 参数设置
x_range <- c(-5, 5)
y_range <- c(0, 0.8)
mean1 <- 0
stddev1 <- 1
mean2 <- 0
stddev2 <- 2
mean3 <- 0
stddev3 <- 0.5
color1 <- 'red'
color2 <- 'green'
color3 <- 'black'

# 第一条曲线
curve(dnorm(x, mean1, stddev1), xlim = x_range, ylim = y_range, col = color1, lwd = 2, lty = 3)

# 第二条曲线
curve(dnorm(x, mean2, stddev2), add = TRUE, col = color2, lwd = 2, lty = 1)

# 第三条曲线
curve(dnorm(x, mean3, stddev3), add = TRUE, col = color3, lwd = 2, lty = 4)

# 添加标题
title("View of Normal Distributions")