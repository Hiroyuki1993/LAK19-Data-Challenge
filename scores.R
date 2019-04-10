library(tidyverse)

scores.KyoU1 = read_csv("./data/KyoU/Course_509a6f75849b_QuizScore.csv") %>% mutate(dataset = "KyoU1")
scores.KyoU2 = read_csv("./data/KyoU/Course_7f89cc14862c_QuizScore.csv") %>% mutate(dataset = "KyoU2")
scores.AU1 = read_csv("./data/AU/Course_1_QuizScore.csv", col_types = list(col_character(), col_integer())) %>% mutate(dataset = "AU1")
scores.AU2 = read_csv("./data/AU/Course_2_QuizScore.csv", col_types = list(col_character(), col_integer())) %>% mutate(dataset = "AU2")
scores.AU3 = read_csv("./data/AU/Course_3_QuizScore.csv", col_types = list(col_character(), col_integer())) %>% mutate(dataset = "AU3")
scores.KU1 = read_csv("./data/KU/Course_24a65f29b6_QuizScore.csv") %>% mutate(dataset = "KU1")
scores.KU2 = read_csv("./data/KU/Course_34451e8c77_QuizScore.csv") %>% mutate(dataset = "KU2")
scores.KU3 = read_csv("./data/KU/Course_39a67f80f4_QuizScore.csv") %>% mutate(dataset = "KU3")
scores.KU4 = read_csv("./data/KU/Course_60ab104927_QuizScore.csv") %>% mutate(dataset = "KU4")
scores.KU5 = read_csv("./data/KU/Course_65bb6224af_QuizScore.csv") %>% mutate(dataset = "KU5")
scores.KU6 = read_csv("./data/KU/Course_6b1900c56c_QuizScore.csv") %>% mutate(dataset = "KU6")
scores.KU7 = read_csv("./data/KU/Course_792efa2c1b_QuizScore.csv") %>% mutate(dataset = "KU7")
scores.KU8 = read_csv("./data/KU/Course_86066cba6d_QuizScore.csv") %>% mutate(dataset = "KU8")
scores.KU9 = read_csv("./data/KU/Course_9a683161f5_QuizScore.csv") %>% mutate(dataset = "KU9")
scores.KU10 = read_csv("./data/KU/Course_dbed6c966a_QuizScore.csv") %>% mutate(dataset = "KU10")

scores = scores.AU1 %>%
  bind_rows(scores.AU2, scores.AU3, scores.KU1, scores.KU2, scores.KU3,
            scores.KU4, scores.KU5, scores.KU6, scores.KU7, scores.KU8,
            scores.KU9, scores.KU10, scores.KyoU1, scores.KyoU2)

scores %>% ggplot(aes(score)) + geom_histogram() + facet_wrap(~dataset, ncol = 5)

scores = scores %>% mutate(univ = substr(dataset, 1, 2))
