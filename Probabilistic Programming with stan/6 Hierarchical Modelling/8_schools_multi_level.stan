data {
  int<lower=0> N;         // number of schools 
  vector[N] treatment;     // estimated treatment effects, The response variable
  vector[N] standard_error; // standard error of effect estimates 
}

//Hyper_parameters 

parameters{
    real mu[N]; // the parameter that defines the likelihood
 // Adding additional parameter of Hyper_parameter
 // hyperparameters
    real alpha[N]; // The hyper_parameter as the mean of the hyper model
    real<lower=0> beta[N]; // The hyper_parameter as the s.d of the hyper model
}



 //Hyper_Models in STAN
model{
  // parent model and hyper model
  
  //To compute value for mu of parent model we need to put hyper-model above the parent model
  
  
    // defining another likelihood called generated likelihood or hyper parametr
   // it is parameter of the parameter in the model comes with two different parameters (alpha and beta) of its own
   
   mu ~ normal(alpha, beta); // The Hyper Model
  
  //Continuing with same logic, defining alpha for another model
  //alpha ~ normal() //parameters of hyper-parameters or it can be called as the parameter of the parameter of the parametr

  
   // Parent Model
   treatment ~ normal(mu, standard_error); // The Model as likelihood
 
}