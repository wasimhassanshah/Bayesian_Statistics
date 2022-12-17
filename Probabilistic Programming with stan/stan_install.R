


# Removing and Re-installing rstan

remove.packages(c("StanHeaders","rstan"))
# OR remove.packages(c("rstan", "StanHeaders"))
#Finally, do `install.packages(“rstan”). But all this is usually only necessary for Windows.
# OR

install.packages(c("StanHeaders","rstan"), type="source")

install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))

install.packages("StanHeaders", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))



#install.packages(c("Rcpp", "rstan"), type = "source")

 #Then verify that rstan is really gone via

system.file("libs", package = "rstan")
#If that returns something other than "", then you have to delete the rstan directory manually.


library(rstan)

#Verifying Installation
#To verify your installation, you can run the RStan example/test model:
example(stan_model, package = "rstan", run.dontrun = TRUE)


#The model should then compile and sample. You may also see the warning:

#Warning message:
# In system(paste(CXX, ARGS), ignore.stdout = TRUE, ignore.stderr = TRUE) :
#'C:/rtools40/usr/mingw_/bin/g++' not found
#his is safe to ignore and will be removed in the next RStan release.


# For this error: Error in stanc(file = file, model_code = model_code, model_name = model_name,  : 0
#Try:
install.packages("devtools")
devtools::install_github("stan-dev/rstan", ref = "develop",
                         subdir = "rstan/rstan")
install.packages("Rcpp")
install.packages("RcppParallel")

# Again install


# For this error: Error in stanc(file = file, model_code = model_code, model_name = model_name,  : 0
 
install.packages("devtools")
devtools::install_github("stan-dev/rstan", ref = "develop",
                         subdir = "rstan/rstan")
install.packages("Rcpp")




#Version check
packageVersion("rstan")
packageVersion("StanHeaders")


