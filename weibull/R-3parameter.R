thres <- 60
x <- rweibull(200, 3, 1) + thres

EPS = sqrt(.Machine$double.eps) # "epsilon" for very small numbers

llik.weibull <- function(shape, scale, thres, x)
{ 
  sum(dweibull(x - thres, shape, scale, log=T))
}

thetahat.weibull <- function(x)
{ 
  if(any(x <= 0)) stop("x values must be positive")

  toptim <- function(theta) -llik.weibull(theta[1], theta[2], theta[3], x)

  mu = mean(log(x))
  sigma2 = var(log(x))
  shape.guess = 1.2 / sqrt(sigma2)
  scale.guess = exp(mu + (0.572 / shape.guess))
  thres.guess = 1

  res = nlminb(c(shape.guess, scale.guess, thres.guess), toptim, lower=EPS)

  c(shape=res$par[1], scale=res$par[2], thres=res$par[3])
}

thetahat.weibull(x)
    shape     scale     thres 
 3.325556  1.021171 59.975470
