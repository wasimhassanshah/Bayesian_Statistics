
# Parametric Bayesian Inference

library(rstan)
data(women)
attach(women)

x <- women$weight # predictor

y <- women$height # predicted or response value

N <- nrow(women)

Model_Non_Bayesian <- glm( formula = y ~ x ,
     data = women) # it takes exact data

summary(Model_Non_Bayesian)

plot(x, y)

# Fitting in non Bayesian framework
abline(Model_Non_Bayesian,
       col = "red",
       lty = 1)

####################################################################################

# Bayesian Anaysis

# Define dataset that is gonna be an input to stan programming
# Then just fit our model probabilistically into stan
# The I should say take samples from the posterior in the parametric space

# stan will take narrowed, shaped and formed data
# data will be in format of list

data_stan <- list(x=x, 
                  y=y,
                   # y is response value or predicted value
                  N=N) # N is number of observation (15 women ) in our dataset

       
# Running stan model by putting the created stan model in file
Linear_Model <- stan(file='womensimple.stan',
                data= data_stan, chains = 4, iter=1000, warmup=500) # warmup should behalf of number of iterations as rule of thumb

 class(Linear_Model)
#If model doesn't converge, then we have to just go back
# to tune our model by changing number of iterations and step size in the parameter space
# or to change adapt_delta close to one in control argument
# control = list(adapt_delta= 0.85)



quadratic_Model <- stan(file = "womenquadratic.stan",
                        data = data_stan,
                        iter = 7000,
                        control = list(stepsize = 0.0001)) # removing warmup sample argment we put control argument



# Model will search deepest gradient in the parameter space
#Then chains run in parallel to converge to one spot in the model

# If model is not converged each chain is not superimposed into the other traceplot to view 4 plots of 4 parameters and 4 chains for each
# the we see for each chain we have different estimate for our parameter of interest for gamma, alpha and beta
# traceplot to see after step size reduction wheter model converged or not
traceplot(quadratic_Model,
          inc_warmup= FALSE)

# Convergence
# For improving the model Convergence of chains is important
#Two methods to achieve Convegence, parameter tuning
# 1, Increase the number of iterations: 2000 to 4000 and so on
#2, To reduce the step size of our model
# leapforg and stepsize, these two parameters are decided during warmup
# smaller the step size , the more time model will take
# control = list(stepsize = 0.0001) is the argument for step size



library(shinystan)
launch_shinystan(quadratic_Model)


print(quadratic_Model)
# Rhat to measure the convergence should be around 1 and 1.01, it means model is converged



# Replicating the data set



quadratic_Model_rep <- stan(file = "women_quadratic_rep.stan",
                        data = data_stan,
                        iter = 9000,
                        control = list(stepsize = 0.00001)) # removing warmup sample argment we put control argument

# to check for convergence, traceplot which require an object which is stan fit

traceplot(quadratic_Model_rep)

#  Rhat is another measure for convergence optimal number is 1.01

print(quadratic_Model_rep)

# Matrix with number of draws only for the replicatied observations that we had
y_rep <- as.matrix(quadratic_Model_rep,
                   pars= "y_rep")


# Bayesplot

library(bayesplot)



dim(y_rep) #checking for y_rep dimensions


#ppc = posterior predictive check
ppc_dens_overlay(y,
                 yrep = y_rep[1:100, ]) # printing only 100 rows out of 18000 rows to avoid computation expense

# it shows that in quadratic models the replicated data light blue lines are very close mimicking the dark line real data 

#You see that the model which is replicated is very better than the model that we created on the previous model where we have, I should say,
#the perimeter, which it was modeled as a linear model. Now, with the quadratic model, we see that the replicated data, 
#which is essentially that the brighter blue. Is essentially much closer to the real bad policies that initially trained our model,
#which is going to be at the globe, which is more darker, you see that the replicated ones in a very improved way.
##It's mimicking the behavior and the pattern with the real data and the real observation produced, I should say, to create the model
#that we just trained our data. And you see that then as a result, you see that with picking the model as a quadratic one.
#We got a substantial improvements in the way that the model can replicate its own original datasets that it got trained with. 
#And now and just the good thing is that we just learned how to do this by using the probabilistic language instead.
#Then as a result, you know, got some kind of you brush your skills in a way that you're able to create a model with the memory
#by adding a block, which is called generated quantities, and in order to replicate the data. And then you can visualize it 
#by using the best package, which is a good way to visualize the best estimates and the inferences that you have for your models.
#
#
#

# Convergence Diagnostics for each parameter
#Two things
# One is Trace plot to see convergence
# Two through R statistics Rhat
class(Linear_Model) #stanfit class


#the posterior, which is essentially it extracts the inference from the posterior density that we have about the parameters that we are interested to find and make an inference. And the best estimate about that
# through extract function we put our stan model posteriors in an object
posterior <- extract(Linear_Model) # put stanfit class model


#posterior contains alpha, beta, sigma and lp

posterior$alpha #essentially they are your estimate from each sample, that standard algorithm fuq from the posterior
                 #distribution to make the best estimate for the Alpha.
 
# alpha essentialy is slope : u = a(weight) + b 


length(posterior$alpha)
par(mfrow=c(1,3)) # To see 3 plots in one window
plot(posterior$alpha, type="l", main="Alpha") # type="l" coverting dot plots to lines
#plots shows alpha is converged
plot(posterior$beta, type="l", main="Beta") 
plot(posterior$sigma, type="l", main="Sigma") 



# Non Convergence

Model_Bad <- stan(file = 'women.stan',
                  data = data_stan,
                  iter = 50,
                  warmup = 25
                  )


posterior_Bad <- extract(Model_Bad )


par(mfrow = c(1,3)) # 1 pgae with 3 floors

plot(posterior_Bad$alpha,
     main = "Alpha", type="l")



plot(posterior_Bad$beta,
     main = "Beta",  type="l")


plot(posterior_Bad$sigma,
     main = "Sigma",  type="l")

# it shows with small number of iterations we have divergence
#And we cannot move forward to just run through that analysis because we cannot just, let's say, have a best estimate for the parameters. We cannot have, for example, insurance for the problem that we have. And we cannot just to any say prediction for the unobserved observation that we just are interested to see their response value, then we have to stop there.

#Then we have to just do some kind of crime. The tuning, the parameters that we are just going to do normally just goes we just increasing the number of iterations or the number of steps,

# 18 :- Traceplot methods for the convergence diagnosis diagnostics of parameters

# Markov Chain Traceplot

traceplot(Linear_Model,
          pars = ("alpha"),  # can plot ("alpha", "beta", "sigma)
          inc_warmup = FALSE) # if inc_warmup = TRUE then we also get warmup lines in plot

posterior$alpha #Also, remember, we have to take the mean of these alpha inferences that we had in order to just make the best estimates.



# Shinystan : shinystan method for the interactive convergence diagnostics

library(shinystan)
class(Linear_Model)

launch_shinystan(Linear_Model) #object is stanfit object


# 21. Posterior Predictive Check (PPC) in Action
 # argument y is true exact values of my observation
# yrep can be found from posterior.predict

y <- women$height
# y_rep is a block we generated inside womensimple.stan, so converting it in matrix

y_rep <- as.matrix(L ,
          pars = "y_rep")

class(y_rep)
dim(y_rep) 

y_rep[1:3, ]

#ppc_dens_overlay is function from bayesplot to  Compare the empirical distribution of the data y to the distributions of simulated/replicated data yrep from the posterior predictive distribution.

ppc_dens_overlay(y,
                 yrep = y_rep[1:100,] )

# We have y_rep simulated data deviated from y original data
# TO fix replicated data (y_rep) deviation
#  I should say, to define a method, non-linear method, and we defined a quadratic functions in order to fix 


# 22. Plot the Fit both Bayesian and Non_Bayesian

Linear_Model # to see means of alpha, beta and sigma

summary(Linear_Model)

par(mfrow = c(1,2))
plot(x,y)

# NOn Bayesian plot
abline(Model_Non_Bayesian,
       col = "red",
       lty = 1,
       main = "Non_Bayesian Fit")


# Bayesian plot just for some estimates
abline(mean(posterior$alpha), mean(posterior$beta),
       col="blue")


#Visualize the uncertainty we need to plot for every estimate for a and b
plot(x,y)


for(i in 1:500){#As above Linear Model has 1000 iterations and 500 for warmup , remaining 500 for simulated data
abline(mean(posterior$alpha[i]), mean(posterior$beta[i]),
       col="grey", lty = 1)
} 


# Now we have 500 lines

# of these 15 American woman's height and weight. You see that they become that thick in terms of, I should say, the color is going to be the gray, then it means that any way that you can think of that you are in the area which is shown by the color as the gray.
#It shows that you are in the region, that it could have been one of the feet and one of the models in that probabilistic model that you had from the Bayesian of the American woman's,


# Now taking mean of it

abline(mean(posterior$alpha), mean(posterior$beta),
       col="blue")
#blue line, which I have shown that here. But the other regions which is in line, it is that any other lines? It could have been one of the fits in our model. If it's still in that line, then it's it. That's how we just interpret that. I should say that gray area in the model that you just created in the Bayesian statistics using standard probabilistic language.

#And so I should say the uncertainty and the fact that we show that we are not certain that it's going to be the best fit of a model. Any lines in that gray area can be a best fit of our model then. And that's why we see that you have some uncertainty. We are not certain. We do not know if the blue light is going to be the right and the best one there, because the blue line is the mean one. It could have been any other. And that's why you talk about the uncertainty and that's how you just visualise it.







#############################################################################







