// saved as schools.stan
data {
  int<lower=0> N;         // number of schools 
  vector[N] treatment;     // estimated treatment effects, The response variable
  vector[N] standard_error; // standard error of effect estimates 
}
parameters {
  real mu;                // population mean of treatment effect
  #real<lower=0> tau;      // standard deviation in treatment effects
  #vector[N] eta;          // unscaled deviation from mu by school
}

//transformed parameters {
//  vector[N] theta = mu + tau * eta;        // school treatment effects
//}


model {
 // target += normal_lpdf(eta | 0, 1);       // prior log-density
  //target += normal_lpdf(y | theta, sigma); // log-likelihood
  
  
  treatment ~ normal(mu,standard_error);
  
}

