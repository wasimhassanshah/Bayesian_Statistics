data {
   int N; // Number of the observations
   vector[N] x;  // x (predictor: weight) is a vector as we have numbe of observations equal to N
   vector[N] y; // the response variable
}

// height = a(weight) + b
// height~ N(u, s) // writing height as normal ditribution with mean u and sigma s 
// u and s are parameters that define the normal distribution of height
// u = a(weight) + b // a is slope and b is intercept
// putting parameter based on above model that is why it is called Bayesian parametric analysis
// We have to find the best estimates of slope (a) and intercept (b) from our model
// to find inference (best estimates) through sampling from posterior distribution within paramteric space

parameters{
 real alpha; // The parameter for the slope 
 real beta; // The parameter for intercept
 real<lower=0> sigma; //standard deviation (SD) // sigma has to be positive so we put constraint, lower bound = 0
 }

//  Likelihood is the way it designs how data are being generated in our model

model{
  // height~ N(u, s)
  // u = a(weight) + b 
  // In hierarchical models, multilevel models, that even these parameters that point here the slope and intercept 
  // they can be defined further down along the hierarchy to be defined by another distribution that distribution has its own parameters that we call the hyperparameters
  
  //  u = a(weight) + b ; weight = x, b = beta, height =y, putting u value in height~ N(u, s) 
  y~normal(alpha*x + beta, sigma); // likelihood of the model
  }