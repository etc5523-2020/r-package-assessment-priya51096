#'@title gg_covid_line functions creates a graphs that shows us the recovered/confirmed/deaths cases for the selected country and selected date range by the user
#'
#'@description gg_covid_line function helps us for the creation of line graphs of the covid confirmed, recovered and death cases for covid_data
#'ggplot2 and geom_line, are the dependencies of this functions, we has also set a theme for the graphs which allows the  uniformity, throughout our app.
#'We further add this function in the ggplotly function to enhances the user interactivity of our graph.
#'
#'@param covid_data is the required argument of this function, to help the function recognize the data and further work on it as per the function
#'@param input allows the user to read the data for filtering/matching as per the function in order to produce the graph
#'
#'@import dplyr
#'@import ggplot2
#'@import hrbrthemes
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

#'@title gg_covid_barplot functions creates a bar chart that shows us the covid- 19 positive case for the user selected state of Australia
#'
#'@description gg_covid_barplot function helps us for the creation of bar charts of the covid confirmed cases for one of the Australia's selected state
#'ggplot2 and geom_line, are the dependencies of this functions, we has also set a theme for the graphs which allows the  uniformity, throughout our app.
#'We further add this function in the ggplotly function to enhances the user interactivity of our graph.'
#'
#'@param aus_state is the required argument of this function, to help the function recognize the data and further work on it as per the function
#'@param input allows the user to read the data for filtering/matching as per the function in order to produce the graph
#'
#'@import dplyr
#'@import ggplot2
#'@import hrbrthemes
#'
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
