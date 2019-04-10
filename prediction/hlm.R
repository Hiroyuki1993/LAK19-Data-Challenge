library(rstan)

data.stan = list(
  N = nrow(data),
  y = data$deduction,
  X = data$PREV
)

fit = stan(file = "hlm.stan", data = data.stan, seed = 42, chains = 3)
fit

samples = extract(fit)
y_sim = samples$y_sim
y_sim = y_sim[nrow(y_sim),]
hist(data$deduction, breaks = 15)
hist(y_sim, breaks = 15)

RMSE(y_sim, data$deduction)

ggmcmc(ggs(fit), file='fit-ggmcmc.pdf', plot=c('density'))
