library(tidyverse)

data = scores %>% inner_join(events, by = c("userid", "dataset"))
data
write.csv(data, file = "data.csv", row.names = F)
