source("./RMSE.R")

fit.lm = lm(deduction ~ PREV, data = data)
RMSE(predict(fit.lm), data$deduction)
