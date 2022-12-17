
data {
  int<lower=0> N;
  real Y[N];  #Continuous uncostrained variable

}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real mu; #Continuous uncostrained variable
  real<lower=0> sigma; # sigma of normal distr. can never be negative so applying non negative constraint
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.

model {
 
  
  for(i in 1:N)
    Y[i] ~ normal(mu, sigma); # this statement here defined our likelihood
   #Y[i] is sampled from normal(mu, sigma)
   
  # Now coding up priors
  
  mu ~ normal(1.7, 0.3);
  sigma ~ cauchy(0, 1);
   
   
   
   
}

//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
