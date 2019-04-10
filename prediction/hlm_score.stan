data {
  int N;
  int L;
  int U;
  int<lower=1, upper=L> LID[N];
  int<lower=1, upper=U> L2U[L];
  real<lower=0, upper=100> y[N];
}

parameters {
  real a0;
  real au[U];
  real al[L];
  real sigma_y;
  real sigma_u;
  real sigma_l;
}

model {
  for (u in 1:U) {
    au[u] ~ normal(a0, sigma_u);
  }
  for (l in 1:L) {
    al[l] ~ normal(au[L2U[l]], sigma_l);
  }
  for (n in 1:N) {
    y[n] ~ normal(al[LID[n]], sigma_y);
  }
}
