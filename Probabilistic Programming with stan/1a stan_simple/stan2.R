

N<- 100 
#generate fake data
Y <- rnorm(N, 1.6, 0.2) # N is sample size

hist(Y) # We get approx normal distribution data


#Compile model

library(rstan)

model <- stan_model('stan2.stan')

# pass data to stan and run model

# list in enlisted ac to the sequence of rstan file data block
fit <- sampling(model, list(N=N, Y=Y), iter=200, chains= 4)



# diagnose
print(fit) # it give summary statistics for each of our parameter


# Reading stan:
# 4 chains, each with iter=200; warmup=100, thin=1
#post warmup draws per chain = 100, total post-warm-up draws = 400
#

# Each of chain has 200 iterations
# Stan by default uses half the chain for warm up
#this means after the warm up we only get 100 samples
# meaning we get 400 total posterior samples

# thin : if we ru lot of iterations, we got lot of arameters and we then run into memory issues
# then we can thin our samples here

# NUTS: No U-turn Sampler is used



# Extract parameters and graph them

params <- extract(fit) # getting object of mu, sigma and lp (log probability withut a constant) each with 400 samples

# To see where samples value in comparison to true value

hist(params$mu) # graphing histogram of posterior samples, log prob parameter


hist(params$sigma) 


# Diagnostics with Rshiny

library(shinystan)

launch_shinystan(fit) # open a browser
















