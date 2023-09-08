# 输入数据
x <- c(99.3, 98.7, 100.5, 101.2, 98.3, 99.7, 99.5, 102.1, 100.5)

# 执行 t-检验
t_test_result <- t.test(x)

# 输出 t-检验结果
t_test_result

# 输出置信区间
confidence_interval <- t_test_result$conf.int
confidence_interval
