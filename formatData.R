library(tidyverse)

events = read_csv("./data/KyoU/Course_509a6f75849b_EventStream.csv")
scores = read_csv("./data/KyoU/Course_509a6f75849b_QuizScore.csv")

scores %>% ggplot(aes(score)) + geom_histogram()
events.tidy = events %>% select(userid, operationname) %>% gather(operationname, key = "action", value = "cnt")
events.structured = as.data.frame.matrix(table(events.tidy %>% select(-action))) %>% mutate(userid = rownames(events.structured))
data = events.structured %>% left_join(scores, by = "userid") %>% select(-userid)
cor(data)
