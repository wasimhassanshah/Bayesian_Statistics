library(rstan)
# 8 school example
schools_dat <- list(J = 8, 
                    treatment = c(28.39,  7.94, -2.75,  6.82, -0.64,  0.63, 18.01, 12.16), # Response variable
                    standard_error = c(14.9, 10.2, 16.3, 11,  9.4, 11.4, 10.4, 17.6))
# treatment is Estimated Treatment effect on students after introducing new preparation programs
# standard_error is Standard error of effect estimate

# Simple Non Hierarchical Modelling

Model_A <- stan(file = 'schools_stan.stan',
            data = schools_dat,
            iter = 1000,
            warmup = 500)

# To check Model convergence
traceplot(Model_A)

#Non_Hierarchical Analysis of Model
print(Model_A)



# So it shows The Problem of Non_Hierarchical Models :
#It shows essentially the means of inference of the treatment effects are the same inference as we initially has in the data for each school
# So it is not doing any new inference at all
# So, there is need of doing Hierarchical Modelling


plot(Model_A) # To see credible interval of each parameter




# Hierarchical Modelling


Model_B <- stan(file = "8_schools_multi_level.stan",
                data = schools_dat,
                iter = 12000,
                control = list(stepsize=0.00001)
                )

print(Model_B)

# now means here shown are different from the original data ,
# And ar now good estimates

# Whereas we have some high Rhat 60, 70 ...
# So we need to increase number of iterations

# Now after inreasing iter from 1000 to 12000 and reducing step size
# we have Rhat is within range and model is converged then

print(Model_B)
