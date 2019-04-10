data {
  int N;
  vector<lower=0>[N] X;
  int<lower=0, upper=100> y[N];
}

parameters {
  real a;
  real b;
  //real<lower=0> sigma;
}

transformed parameters {
  vector<lower=0, upper=1>[N] theta = inv_logit(a + b*X);
  vector<lower=0>[N] lambda = exp(a + b*X);
  //vector[N] mu = a + b*X;
}

model {
  for (i in 1:N){
    if (y[i]==0){
      target += log_sum_exp(bernoulli_lpmf(1 | theta),
                            bernoulli_lpmf(0 | theta)
                            + poisson_lpmf(y[i] | lambda[i]));
    } else {
      target += bernoulli_lpmf(1| theta[i]) + poisson_lpmf(y[i]| lambda[i]);
    }
    target += normal_lpdf(lambda[i] | 20, 10);
  }
}

generated quantities {
  vector[N] y_sim;
  for(i in 1:N){
    if(bernoulli_rng(theta[i])==0){
      y_sim[i] = 0;
    } else {
      y_sim[i] = poisson_rng(lambda[i]);
    }
  }
}