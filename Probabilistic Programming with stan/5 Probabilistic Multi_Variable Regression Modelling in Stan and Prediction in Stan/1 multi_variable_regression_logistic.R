# 24. Multi_Variable_Logistic_Regression


#Person has diabetes or not model
# Our response variable is outcome

#Load the dataset

data("C:/Users/HP/Documents/PimaIndianDiabetes")

data <- read.csv("PimaIndianDiabetes.csv")

#structure of data

str(data)

sum(is.na(data))

# Feature Selection

# Select some variables
# Generalized Linear Models, glm
linear_model <- glm(formula = Outcome ~.,
    data = data) # ~. means include every single feature we have


linear_model

summary(linear_model) # features with stars in  Pr(>|t|) are significant features

# Our Model after selecting significant features to diagnose whether person has diabetes or not (Outcome 0 or 1)

#outcome = b0 + b1(pregnancy) + b2(Glucose) + b3(BMI)

#Which is our model from where we just move on to the stan, the whole purpose that we have is that we are just going to make the best estimates for all these intercepts.
#  you're just going to write some codes into the tiny environment in order to find a probabilistic estimates for these slots that we have here byone, which represents the slope for the number of the pregnancy, B two, which represents the number of the,
# the level of the glucose after two hours of having the food and also B three, which refers to the slope of the BMI index datasets.




# Data
class(data)
#However, in order to just have the data for your stan model, it has to be off the format of the list and it has to be defined in a way that it is about.

# Model: outcome = b0 + b1(pregnancy) + b2(Glucose) + b3(BMI)


# Now we have several predictors in our model


data_stan <-list(N = nrow(data), # N is number of observations in dataset
                 Outcome = data$Outcome,  # Binary response variable 1: have diabetes,0: have no diabetes
                 Pregnancies = data$Pregnancies, # Variable# 1
                 Glucose = data$Glucose, # Variable# 2
                 BMI = data$BMI # # Variable# 3
                 
                 )
class(data_stan)

View(data_stan)

library(rstan)

#Model Diabetes is the posterior distribution

Model_Diabetes <- stan(file = "diabetes.stan",
                       data - data_stan,
                       iter = 1000,
                       warmup = 500) # the warm ups, which is going to be at least half of the number of iterations which it gives the opportunity for the algorithm to just find the best gradient in the parameter space.



# Check for the MCMC Model Convergence ( Two Methods)

# And now that's the time to check that. If our search in the parameter space in parallel with four chains have just converged into one area in the parameter space, if that's going to be so, then we can just extract reliably the estimates that we're looking for, for our model that we have for the diabetes datasets now


library(shinystan)

# launch_shinystan_demo() #large shiny stack demo. And it teaches you how to interpret different results, how to get, for example, step size. What does it mean if you, for example, take this step size smaller in your algorithm and your search grid? And also it shows that, for example, if the model has converged, what do you expect to see on that
#browser which is opened


#Model_Diabetes has function stanfit
class(Model_Diabetes)

# Method1 : shinystan 
launch_shinystan(Model_Diabetes) #put stan fit in parenthesis

# Note:  Stop shiny stan from console by clicking red dot before doing anything in R



#Method2: traceplot

traceplot(Model_Diabetes,
          inc_warmup= FALSE) # excluding warmup iterationf from plots


#32. Posterior Extraction of the Best estimates
# Extract the estimates of the parameters that we are interested in


Model_Diabetes # To see summary statistics of the model



#We are just going to do some kind of predictions based on the estimates that we were able to extract
# from the posterior distribution.

#You see that in order to find the best estimates in the posterior distribution we are drawing, I should say, two thousand times. And for each trial we have an estimate for each of those four coefficients of the interest for B0, B1,B2 and B3

#That you can expect that you have the values which it's going to be two thousand times the value for one of the estimates that you're looking for. Then you have to just mean to have, as should say, the average of those two thousand times that in order to get the best estimates.


#the thing that you're interested in now at this stage is the mean value for the intercepts and this look for the number of the pregnancy, the level of the glucose and the index of the body mass.

#And also the other thing that we are interested to get from this model, it's essentially a kind of a posterior that you are just going to use the extract function.

#Posterior from extract function

# Extract samples from a fitted Stan model
#you are just going to extract from the posterior distribution.

posterior <- extract(Model_Diabetes,
        inc_warmup = FALSE)
 
head(posterior) 

#Plotting posterior of each parameter

plot(posterior$b_0,
     type="l") # It shows convergence of this parameter

plot(Model_Diabetes)
#I'm just going to plot the function itself, which it was essentially the model. Diabetics, in order to show the credibility intervals of the model that had this kind of zoom on that model, and you see that for the estimates that we have, it shows that, for example, we have the inner interval, which is the 50 percent of the credibility, . And I should say, you see that also the outer interval, which is going to be 95 percent of the interval.
# Then you see that, for example, for the estimates of the intercepts for the B0, the value is varied in how much is a credible interval.




# 7, 33: Prediction and Forecasting in Stan


pred_Model_Diabetes <- stan(file = "pred_diabetes.stan",
     data = data_stan,
     iter = 1000,
     chains = 4)

#when you're talking about the splitting of the data into training deficits and the test data sets, you will see that that data stand that you're creating as a list for the data model for the standard model. It also includes some additions for the test data. But because we didn't do that just with the data totally on the training sets, now introduce that unseen observation. We do not need to change the structure of the data which we created

# Looking for prediction

class(pred_Model_Diabetes)

# Converting pred_Model_Diabetes as.matrix bcz apply function need it to be matrix
quants <- apply(as.matrix(pred_Model_Diabetes),
      MARGIN = 2,
      FUN = quantile,#quantile() :The generic function quantile produces sample quantiles corresponding to the given probabilities. The smallest observation corresponds to a probability of 0 and the largest to a probability of 1.
      probs = (1:100)/100
      
      )

#Predicted percentage of being diabetic in quants matrix for each observation

#You can see that the objects which you have created not only for each probability it defines. A quants for each coefficients and also it has actually seen estimates for the outcome corresponding for that probablity.



