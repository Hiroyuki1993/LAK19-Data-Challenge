library(tidyverse)
library(ggmcmc)

events.KyoU1 = read_csv("./data/KyoU/Course_509a6f75849b_EventStream.csv")
events.KU1 = read_csv("./data/KU/Course_24a65f29b6_EventStream.csv")
events.KU1 %>% bind_rows(events.KyoU1)

scores = read_csv("./data/KyoU/Course_509a6f75849b_QuizScore.csv")

scores %>% ggplot(aes(score)) + geom_histogram()
events.tidy = events %>% select(userid, operationname) %>% gather(operationname, key = "action", value = "cnt")
events.structured = as.data.frame.matrix(table(events.tidy %>% select(-action)))
events.structured = events.structured  %>% mutate(userid = rownames(events.structured))
data = events.structured %>% left_join(scores, by = "userid") %>% select(-userid)
cor(data)
data = data %>% mutate(deduction = 100 - score) %>% select(-score)
data %>% ggplot(aes(log(deduction + 0.1))) + geom_histogram()
data.selected = data %>% select(CLOSE, NEXT, OPEN, PAGE_JUMP, PREV, SEARCH, deduction)
