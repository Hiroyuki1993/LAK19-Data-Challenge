library(pscl)
library(MASS)

base.lm = lm(deduction ~ ., data = data)
summary(base.lm)
logLik(base.lm)

base.log = lm(log(deduction + 0.1) ~ ., data = data)
logLik(base.log)

base.poisson = glm(deduction ~., data = data, family = "poisson")
logLik(base.poisson)

base.nb = glm.nb(deduction ~., data = data)
logLik(base.nb)

zm = zeroinfl(deduction ~ . | ., data = data.selected, dist = "")
logLik(zm) 
