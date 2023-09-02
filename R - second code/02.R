curve(dlnorm(x),xlim = c(-0.2,5),ylim=c(0,1.0),lwd=2)
curve(dlnorm(x,0,3/2),add=T,col='blue',lwd = 2,lty=2)
curve(dlnorm(x,0,1/2),add=T,col='orange',lwd = 2,lty=3)
title("view")