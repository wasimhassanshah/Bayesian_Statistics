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


// Now for our outcome variable (Responese variable)
//just create the same block, which is called the generated quantities. But right now here we do not have it for the replication value of the observation. Now we just want to talk about the predicted values of our response. 
//Which is binary outcome

// And now by having these tree formation, we are just going to come here and see if that person is what is the chance, what are the odds that that person is going to be diagnosed with diabetes or not? That's going to be very fascinating because that's we took all these steps in order to get to this stage to see that if we can, just after fitting your model to the datasets that we had, if you are able to use datasets and the same model that we developed in order to see what's going to happen into the future. And that's that's why it's going to be very interesting.

generated quantities{
  //This outcome_hat is some tkind of predicted value unlike the outcome in the model or data block
  // Now we are looking at the probabilities (continuous probability distribution) of being diabetic or not, so it is real number
  real Outcome_hat; // Predictated outcome
  //we have the model. Fitted and trained on the data without splitting that into the train and the test, now you are going to draw one number, I should say, and one observation, which you haven't seen that in the model to see that what's going to be the outcome as a prediction.
  
  //When you just defined it, I should say, the distribution as the generated quantities block. Then the names become different, but the nature is the same. bernoulli
  //inv_logitis same as bernoulli_logi
 // Put values inside parenthesis to see prediction, example: Pregnancies=2,Glucose=99, BMI= 27.6
 
  Outcome_hat <- inv_logit(b_0 + b_pregnancies*(2) + b_Glucose*(99) + b_BMI*(27.6));
  
}







