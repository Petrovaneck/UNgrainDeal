# https://docs.google.com/spreadsheets/d/1vQD_V0AnKWLHzgF0CxQ3EhgpiYdLcbl4AyoP4znvSYI/edit?usp=sharing


# https://appsilon.com/connect-r-to-google-sheets-using-googlesheets4/#read

library(googlesheets4)
library(dplyr)
library(tidyverse)
library(reshape2)

df<- read_sheet("https://docs.google.com/spreadsheets/d/1vQD_V0AnKWLHzgF0CxQ3EhgpiYdLcbl4AyoP4znvSYI/edit?usp=sharing")

df

View(df)
colnames(df)

d1 <- df %>% select(., c('#' ,Country, Commodity, `Metric tons`, `Departure date`, `Inspection cleared`, `Development category`))

# reshape(d1, idvar = "#")
# 
# reshape(data = d1, idvar = 'Country', direction = 'wide')

colnames(d1) <- c('number', 'Country', 'Commodity', 'MetricTonnes', 'Departure', 'Inspection', 'DevCat')


class(d1)
attach(d1)

summary(d1)


t1 <- d1 %>% group_by(Country, Commodity) %>% 
  mutate(totalTonnes = sum(MetricTonnes)) 

t1 %>% select(c(Country, totalTonnes))



r1 <- d1 %>% group_by(Country) %>% 
  mutate(totalTon = sum(MetricTonnes))

r2 <- r1 %>% select(c(Country, totalTon)) %>% unique(.)


# chart showing the total grain exported to a country to date.
ggplot(r2) + 
  geom_col(aes(x = Country, y = totalTon)) +
  theme_classic() +
  theme(axis.text.x=element_text(angle=90,hjust=1, vjust = 0.5)) +
  labs(x = NULL, y = 'Metric tonnes',
       title = 'Metric tonnes of grain received from Ukraine since August 3',
       subtitle = 'UN Black Sea trade deal',
       caption = "Source: United Nations")


# now want to split the grain into categories.
# first trying it for Egypt:


p1 <- d1 %>% 
  group_by(Country, Commodity) %>% 
  mutate(totals = sum(MetricTonnes)) %>% 
  select(c(Country, Commodity, totals)) %>% 
  unique() 


# Chart showing the grain in categories

ggplot(p1) + 
  geom_col(aes(x = Country, y = totals, fill = Commodity))  +
  ggtitle("Grain exports received. UN trade deal.") +
  theme_classic() +
  theme(axis.text.x=element_text(angle=90,hjust=1, vjust = 0.5)) 

# head(p1)
# 
# ggplot(p1) +
#   geom_bar(aes(x = Country, y = totals), stat = 'identity') +
#   theme_classic() +
#   theme(axis.text.x=element_text(angle=90,hjust=1))

# 


ggplot(p1) + 
  geom_col(aes(x = Country, y = totals, fill = Commodity), 
           position = "fill",
           colour = 'black') +
  theme(axis.text.x=element_text(angle=90,hjust=1)) +
  ggtitle("Grain exports received. UN trade deal. Percentage share of grains received.") 


# ?palette


unique(p1$Commodity)


head(p1)

head(melt(p1, id.vars = c('Country')))






