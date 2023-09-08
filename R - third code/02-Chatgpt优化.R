# 计算均值的置信区间
conf <- function(x, sigma, alpha) {
  n <- length(x)  # 观测数量
  mean <- mean(x)  # 均值
  
  # 计算置信区间的半宽度
  half_width <- sigma * qnorm(1 - alpha / 2) / sqrt(n)
  
  # 计算置信区间的下限和上限
  lower_bound <- mean - half_width
  upper_bound <- mean + half_width
  
  # 返回置信区间
  c(lower_bound, upper_bound)
}

# 输入数据和参数
x <- c(14.6, 15.1, 14.9, 14.8, 15.2, 15.1)
sigma <- sqrt(0.6)

# 计算并打印置信区间
conf(x, sigma, 0.05)