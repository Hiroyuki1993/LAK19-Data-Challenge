events.KyoU1 = read_csv("./data/KyoU/Course_509a6f75849b_EventStream.csv")
events.KU1 = read_csv("./data/KU/Course_24a65f29b6_EventStream.csv")

formatData = function(df, dataset){
  df.tidy = df %>% select(userid, operationname) %>% gather(operationname, key = "action", value = "cnt")
  df.structured = as.data.frame.matrix(table(df.tidy %>% select(-action)))
  df.structured = df.structured  %>% mutate(userid = rownames(df.structured))
  df.structured %>% select(userid, CLOSE, NEXT, OPEN, PAGE_JUMP, PREV, SEARCH) %>%
    mutate(dataset = dataset)
}

events.KyoU1 = formatData(events.KyoU1, "KyoU1")
events.KU1 = formatData(events.KU1, "KU1")

events = events.KU1 %>% bind_rows(events.KyoU1)
data = events %>% inner_join(scores, by = c("userid", "dataset"))
