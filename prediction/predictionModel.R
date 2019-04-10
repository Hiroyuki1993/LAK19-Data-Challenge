parameters = extract(fit)
a_post = parameters$a
b_post = parameters$b
sigma = parameters$sigma

pred_model = function(x){
  lin_comb = sample(a_post, size = length(x)) + x*sample(b_post, size = length(x))
  rnorm(length(x), lin_comb, sample(sigma, size = length(x)))
}

pred_model = function(x){
  lin_comb = mean(a_post) + x*mean(b_post)
  rlnorm(length(x), log(lin_comb), mean(sigma))
}

prediction = pred_model(data$NEXT)

mean((prediction - data$deduction)^2)

