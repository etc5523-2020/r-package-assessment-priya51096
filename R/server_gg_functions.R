#'gg function
#'
#'gg function for the line graphs of the covid confirmed, recovered and death cases
#'
#'@export
gg_covid_line <- function(covid_data, input){
  p1 <-  covid_data %>% dplyr::filter(administrative_area_level_1 == input$country) %>%
    filter(date >= input$trajectory[1] & date <= input$trajectory[2]) %>%
    ggplot(aes(x = date)) + geom_line(aes(y = confirmed), color = "blue") +
    geom_line(aes(y = deaths), color = "red") +
    geom_line(aes(y = recovered), color = "green") +
    ggtitle("Overview of the COVID-19 Scenario") +
    xlab("Date") +
    ylab("Count of Confirmed/Recovered/Death Cases")+
    theme_ipsum()

  ggplotly(p1)
}

#'gg function
#'
#'gg function for the line graphs of the covid confirmed, recovered and death cases
#'
#'@export
gg_covid_barplot <- function(aus_state, input){
p2 <-  aus_state %>% dplyr::filter(state == input$region) %>%
  ggplot(aes(x = month)) +
  geom_col(aes(y = positives), color = "orange", fill = "orange")  +
  ggtitle("Monthly Overview of the Positive Cases in the States of Australia") + xlab("Months") +
  ylab("Count of Positive Cases") +
  theme_ipsum()

ggplotly(p2)
}
