library(tidyverse)

read_csv("cyclic_mechanism.csv") -> cyclic

cyclic %>%
  group_by(step) %>%
  summarise(total = sum(energy)) ->
  cyclic

read_csv("acyclic_mechanism.csv") -> acyclic

acyclic %>%
  group_by(step) %>%
  summarise(total = sum(energy)) ->
  acyclic

cyclic %>%
  spread(step, total) %>%
  transmute(cyclic_1 = cyclic_1 + benzoic_acid + n_isocyano_triphenylphosphorane,
            cyclic_1_intr_2 = cyclic_1_to_2_intr + benzoic_acid - cyclic_1,
            cyclic_1_to_2 = cyclic_1_to_2 + benzoic_acid - cyclic_1,
            cyclic_2 = cyclic_2 + benzoic_acid - cyclic_1,
            cyclic_2_intr_3 = cyclic_2_to_3_intr  - cyclic_1,
            cyclic_2_to_3 = cyclic_2_to_3 - cyclic_1,
            cyclic_3 = cyclic_3 - cyclic_1,
            cyclic_3_to_4 = cyclic_3_to_4 - cyclic_1,
            cyclic_4 = cyclic_4 - cyclic_1,
            cyclic_5 = cyclic_5 - cyclic_1,
            cyclic_5_to_6 = cyclic_5_to_6 - cyclic_1,
            cyclic_6 = cyclic_6 + triphenylphosphine_oxide - cyclic_1,
            cyclic_1 = 0.0) %>%
  mutate_all(list(~ . * 2625.5 / 4.184)) ->
  cyclic_mechanism

acyclic %>%
  spread(step, total) %>%
  transmute(acyclic_1 = acyclic_1 + benzoic_acid + n_isocyano_triphenylphosphorane,
            acyclic_1_intr_2 = acyclic_1_intr_2 + benzoic_acid - acyclic_1,
            acyclic_1_to_2 = acyclic_1_to_2 + benzoic_acid - acyclic_1,
            acyclic_2 = acyclic_2 + benzoic_acid - acyclic_1,
            acyclic_2_intr_3 = acyclic_2_intr_3  - acyclic_1,
            acyclic_2_to_3 = acyclic_2_to_3 - acyclic_1,
            acyclic_3 = acyclic_3 - acyclic_1,
            acyclic_3_to_4 = acyclic_3_to_4 - acyclic_1,
            acyclic_4 = acyclic_4 - acyclic_1,
            acyclic_5 = acyclic_5 - acyclic_1,
            acyclic_5_to_6 = acyclic_5_to_6 - acyclic_1,
            acyclic_6 = acyclic_6 + triphenylphosphine_oxide - acyclic_1,
            acyclic_1 = 0.0) %>%
  mutate_all(list(~ . * 2625.5 / 4.184)) ->
  acyclic_mechanism

print(cyclic_mechanism %>% gather)

cyclic_mechanism %>%
  gather %>%
  ggplot(aes(key, value)) +
  geom_point(shape = 15, size = 2) +
  geom_line(aes(group = 1)) +
  scale_x_discrete(labels=c("r", "ic1", "ts1", "im1", "inter", "ts2", "im2", "ts3", "im3", "rc", "ts4","p")) +
  scale_y_continuous(breaks=seq(-55, 5, 5), limits=c(-55, 5)) +
  labs(x = "state", y = "energy relative to products (kcal/mol)", title = "mechanism") +
  cowplot::theme_cowplot()

print(acyclic_mechanism %>% gather)

acyclic_mechanism %>%
  gather %>%
  ggplot(aes(key, value)) +
  geom_point(shape = 15, size = 2) +
  geom_line(aes(group = 1)) +
  scale_x_discrete(labels=c("r", "ic1", "ts1", "im1", "ic2", "ts2", "im2", "ts3", "im3", "rc", "ts4" ,"p")) +
  scale_y_continuous(breaks=seq(-60, 5, 5), limits=c(-60, 5)) +
  labs(x = "state", y = "energy relative to products (kcal/mol)", title = "mechanism") +
  cowplot::theme_cowplot()



