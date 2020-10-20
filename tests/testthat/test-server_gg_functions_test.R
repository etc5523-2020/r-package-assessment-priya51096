covid_data <- COVID19::covid19()

min = as.POSIXct("2020-01-01","%Y-%m-%d")
max = as.POSIXct("2020-10-05","%Y-%m-%d")
value = c(as.POSIXct("2020-02-05"), as.POSIXct("2020-09-05"))

df <- tibble(
  trajectory = 1:2,
  country = "India")

df$trajectory <- dplyr::recode(df$trajectory,
                           "1" = as.Date("2020-02-05"),
                           "2" = as.Date("2020-09-05"))


tbase <- covid_data %>% dplyr::filter(administrative_area_level_1 == "India") %>%
  filter(date >= value[1] & date <= value[2]) %>%
  ggplot(aes(x = date)) + geom_line(aes(y = confirmed), color = "blue") +
  geom_line(aes(y = deaths), color = "red") +
  geom_line(aes(y = recovered), color = "green") +
  ggtitle("Overview of the COVID-19 Scenario") +
  xlab("Date") +
  ylab("Count of Confirmed/Recovered/Death Cases")+
  theme_ipsum()



gg_covid_line <- function(covid_data, input){
  p1 <-  covid_data %>% dplyr::filter(administrative_area_level_1 == input$country) %>%
    filter(date >= input$trajectory[1] & date <= input$trajectory[2]) %>%
    ggplot(aes(x = date)) + geom_line(aes(y = confirmed), color = "blue") +
    geom_line(aes(y = deaths), color = "red") +
    geom_line(aes(y = recovered), color = "green") +
    ggtitle("Overview of the COVID-19 Scenario") +
    xlab("Date") +
    ylab("Count of Confirmed/Recovered/Death Cases") +
    theme_ipsum()

  (p1)
}





test_that("Plot returns ggplot object",{
  p <- gg_covid_line(covid_data, input = df)
  expect_identical(p$labels$y, NULL)
})




