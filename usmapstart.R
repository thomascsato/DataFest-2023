setwd("C:\\Users\\15033\\OneDrive\\Desktop\\Data Fest")
library(tidyverse)
library(GGally)
library(skimr)
library(usmap)
library(sf)

clients <- read_csv("clients.csv")
view(clients)
questions <- read_csv("questions.csv")
view(questions)
QA <- read_csv("questionposts.csv")
view(QA)
attorney <-read_csv("attorneys.csv")
view(attorney)
attorneytime <- read_csv("attorneytimeentries.csv")
view(attorneytime)
categories <- read_csv("categories.csv")
view(categories)
statesites <- read_csv("statesites.csv")
view(statesites)
subcategories <- read_csv("subcategories.csv")
view(subcategories)

questions_states <- questions %>%
  count(StateAbbr) %>%
  arrange(desc(n))
questions_states_n <- questions %>%
  count(StateAbbr, Category) 
prop.categories <- left_join(questions_states_n, questions_states,
                             by = c("StateAbbr" = "StateAbbr")) %>%
  mutate(prop_category = n.x / n.y)

prop.categories = prop.categories %>%
  rename("state"="StateAbbr")

 pc1=prop.categories %>%
  filter(Category == "Family and Children")

  plot_usmap(data=pc1,values="prop_category",color="black")+
    ggtitle("Proportion of i Cases in each State")+
    scale_fill_continuous(low="yellow",high="red",name="Proportion of Cases")
    theme(legend.position = "right")

