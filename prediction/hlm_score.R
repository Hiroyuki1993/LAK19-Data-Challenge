library(rstan)
library(ggmcmc)

data.stan = list(
  N = nrow(scores),
  L = 15,
  U = 3,
  y = scores$score,
  LID = as.integer(factor(scores$dataset)),
  L2U = as.integer(factor(unique(scores[, c('dataset', 'univ')])$univ))
)

fit = stan(file = "hlm_score.stan", data = data.stan, seed = 42, chains = 4, warmup = 500, iter = 2000, thin = 1)
fit
ggmcmc(ggs(fit), file='plots/fit-ggmcmc.pdf', plot=c('density'))

samples = extract(fit)
au = samples$au
au = data.frame(au)
colnames(au) = c('AU', 'KU', 'KyoU')
au.tidy = au %>% gather('AU', 'KU', 'KyoU', key = 'univ', value = 'sample')
au.tidy %>% ggplot(aes(x = sample, fill = univ)) + geom_density(alpha = 0.5) + xlab('score') + theme_gray(base_size = 18)
