library(tidyverse)

events.KyoU1 = read_csv("./data/KyoU/Course_509a6f75849b_EventStream.csv") %>% mutate(dataset = "KyoU1")
events.KyoU2 = read_csv("./data/KyoU/Course_7f89cc14862c_EventStream.csv") %>% mutate(dataset = "KyoU2")
events.AU1 = read_csv("./data/AU/Course_1_EventStream.csv") %>% filter(!is.na(userid)) %>% mutate(dataset = "AU1")
events.AU2 = read_csv("./data/AU/Course_2_EventStream.csv") %>% filter(!is.na(userid)) %>% mutate(dataset = "AU2")
events.AU3 = read_csv("./data/AU/Course_3_EventStream.csv") %>% filter(!is.na(userid)) %>% mutate(dataset = "AU3")
events.KU1 = read_csv("./data/KU/Course_24a65f29b6_EventStream.csv") %>% mutate(dataset = "KU1")
events.KU2 = read_csv("./data/KU/Course_34451e8c77_EventStream.csv") %>% mutate(dataset = "KU2")
events.KU3 = read_csv("./data/KU/Course_39a67f80f4_EventStream.csv") %>% mutate(dataset = "KU3")
events.KU4 = read_csv("./data/KU/Course_60ab104927_EventStream.csv") %>% mutate(dataset = "KU4")
events.KU5 = read_csv("./data/KU/Course_65bb6224af_EventStream.csv") %>% mutate(dataset = "KU5")
events.KU6 = read_csv("./data/KU/Course_6b1900c56c_EventStream.csv") %>% mutate(dataset = "KU6")
events.KU7 = read_csv("./data/KU/Course_792efa2c1b_EventStream.csv") %>% mutate(dataset = "KU7")
events.KU8 = read_csv("./data/KU/Course_86066cba6d_EventStream.csv") %>% mutate(dataset = "KU8")
events.KU9 = read_csv("./data/KU/Course_9a683161f5_EventStream.csv") %>% mutate(dataset = "KU9")
events.KU10 = read_csv("./data/KU/Course_dbed6c966a_EventStream.csv") %>% mutate(dataset = "KU10")

formatData = function(df){
  dataset = df$dataset[[1]]
  df.tidy = df %>% select(userid, operationname) %>% gather(operationname, key = "action", value = "cnt")
  df.structured = as.data.frame.matrix(table(df.tidy %>% select(-action)))
  df.structured = df.structured  %>% mutate(userid = rownames(df.structured))
  df.structured %>% select(userid, CLOSE, NEXT, OPEN, PAGE_JUMP, PREV, SEARCH) %>%
    mutate(dataset = dataset)
}

events.KyoU1 = formatData(events.KyoU1)
events.KyoU2 = formatData(events.KyoU2)
events.KU1 = formatData(events.KU1)
events.KU2 = formatData(events.KU2)
events.KU3 = formatData(events.KU3)
events.KU4 = formatData(events.KU4)
events.KU5 = formatData(events.KU5)
events.KU6 = formatData(events.KU6)
events.KU7 = formatData(events.KU7)
events.KU8 = formatData(events.KU8)
events.KU9 = formatData(events.KU9)
events.KU10 = formatData(events.KU10)
events.AU1 = formatData(events.AU1)
events.AU2 = formatData(events.AU2)
events.AU3 = formatData(events.AU3)

events = events.AU1 %>%
  bind_rows(events.AU2, events.AU3, events.KU1, events.KU2, events.KU3,
            events.KU4, events.KU5, events.KU6, events.KU7, events.KU8,
            events.KU9, events.KU10, events.KyoU1, events.KyoU2)
