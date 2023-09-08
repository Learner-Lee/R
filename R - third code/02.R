conf <- function(x, sigma, alpha){
  n <- length(x)
  mean <- mean(x)
  
  result <- c(
    mean - sigma * qnorm(1 - alpha / 2) / sqrt(n),
    mean + sigma * qnorm(1 - alpha / 2) / sqrt(n)
  )
  
  result
}

x <- c(14.6,15.1,14.9,14.8,15.2,15.1)
sigma <- sqrt(0.6)

conf(x, sigma, 0.05)