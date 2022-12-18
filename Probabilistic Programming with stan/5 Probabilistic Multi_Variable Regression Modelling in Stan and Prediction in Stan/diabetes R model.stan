data{
  int<lower =1> N; //The number of observations
  int<lower=0,upper=1> Outcome[N]; // THe binary outcome, Length of the vector is same as N number of observations;     //Follow the order of stan_data object of R file
  vector[N] Pregnancies; //variable 1
  vector[N] Glucose;   //variable 2
  vector[N] BMI;    //variable 3
}




parameters{
  // Model: outcome = b0 + b1(pregnancy) + b2(Glucose) + b3(BMI)
 //b0 to b3 are parameters
 //you saw previously that when we talked about the height, we took the height as a normally distributed , I should say, to the mean,
 // and measured for dispersion. And we took the mean as a formula, but it was a linear functions of the weight. Having that linear function, we defined the slope and intercept there.
 //It's going to be different here. We are just going to have  a binomial distribution. When we just go to the model, 
 // we have the success and we have the Failer then. Now it's like that case in the binary cases.
  //That's going to be binary, then that's going to be represented not as a normal distribution, but as a Bernoulli distribution, because internally distribution, you have a number of the trials. Then you're going to assign, for example, to each one the probability for the success and the probability for the failure.
  
  //Defining parameters
  
  real b_0; //the intercept
  real b_pregnancies; // The slope for the "Pregnancies""
  real b_Glucose; // slope for "Glucose" level
  real b_BMI; //THe slope for BMI
  
  
  
  
}


model{
  // priors
  // For each slope/ coefficient we will define the priors
  // We are Just defining weakly informative flat priors, because we havn't any investigation on data
   //b_0 ~ N(0,10)
  
  //likelihood
  
    // Model: outcome = b0 + b1(pregnancy) + b2(Glucose) + b3(BMI)
   //The parameters that we are interested to find the best estimates for them by the methods of the sampling is going to be one for the intercepts and also the slope for the number of the pregnancy, the slope for the level of the glucose, and also the slope for the index of the body mass.
  Outcome ~ bernoulli_logit(b_0 + b_pregnancies*(Pregnancies) + b_Glucose*(Glucose) + b_BMI*(BMI));
  }









