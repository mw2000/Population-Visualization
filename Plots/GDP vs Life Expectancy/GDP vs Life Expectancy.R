library(ggplot2)
library(dplyr)
library(plotly)

# Set plotly config
Sys.setenv("plotly_username"="thatonenerdy")
Sys.setenv("plotly_api_key"="1b4rzj9N1gNS8DKN5jaX")

# Rad in the CSV files
hdi <- read.csv('hdi.csv')
population <- read.csv('population.csv')

# Refining the Data
population <- subset(population, select = c(Country.Name, X2015))
names(population) <- c("Country", "X2015")
data <- merge(hdi, population)
colnames(data)[colnames(data)=="X2015"] <- "Population"

# Creating the plot
p <- data %>%
  mutate(Population=round(Population/1000000,2)) %>%
  
  arrange(desc(Population)) %>%
  mutate(Country = factor(Country, Country)) %>%
  
  mutate(text = paste("Country: ", Country)) %>%
  
  ggplot( aes(x=Economy..GDP.per.Capita., y=Health..Life.Expectancy., size = Population, color = Region, text=text)) +
  geom_point(alpha=0.7) +
  scale_size(range = c(1.4, 19), name="Population") +
  theme(legend.position="top")

# turn ggplot interactive with plotly
pp <- ggplotly(p, tooltip="text")
pp

