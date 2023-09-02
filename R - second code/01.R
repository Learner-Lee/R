curve(dnorm(x,0,1),xlim=c(-5,5),ylim=c(0,0.8),col=('red'),lwd = 2 , lty = 3)
curve(dnorm(x,0,2),add=T,col=('green'),lwd = 2 , lty = 1)
curve(dnorm(x,0,0.5),add=T,col=('black'),lwd = 2 , lty = 4)
title("view")
