data {
   int N; // Number of the observations
   vector[N] x;  // x (predictor: weight) is a vector as we have numbe of observations (rows) equal to N
   vector[N] y; // the response variable, the women's height
}

// height = a(weight) + b
// height~ N(u, s) // writing height as normal ditribution with mean u and sigma s 
// u and s are parameters that define the normal distribution of height
// u = a(weight) + b // a is slope and b is intercept
// putting parameter based on above model that is why it is called Bayesian parametric analysis
// We have to find the best estimates of slope (a) and intercept (b) from our model
// to find inference (best estimates) through sampling from posterior distribution within paramteric space


# for transsforming parameter weight(x) to weight^2 (x^2)
# Transformation for Quadratic models u= b0+b1(x)+b2(x)^2 , now mean is represented by these quadrativ equation
transformed data{
  // x_sq will be a vector
  vector[N] x_sq; // The transformed data as the squared of the weight
  
  // when we multiply two vectors in order to show that each component of each vetor multiply with each other only we put space+ dot(.) before *
  x_sq <- x .*x; // The formula for the transformation
}

parameters{
 real alpha; // The parameter for the slope b1
 real beta; // The parameter for intercept b
 real gamma; // The parameter (b2) for the weight squared (x^2)
 real<lower=0> sigma; //standard deviation (SD) // sigma has to be positive so we put constraint, lower bound = 0
 } 

//  Likelihood is the way it designs how data are being generated in our model

model{
  // height~ N(u, s)
  // u = a(weight) + b 
  // In hierarchical models, multilevel models, that even these parameters that point here the slope and intercept 
  // they can be defined further down along the hierarchy to be defined by another distribution that distribution has its own parameters that we call the hyperparameters
  
  //  u = a(weight) + b ; weight = x, b = beta, height =y, putting u value in height~ N(u, s) 
  y ~ normal(alpha*x + gamma*x_sq+beta, sigma); // likelihood of the model
  //u= b0+b1(x)+b2(x)^2
  
  
  
  }