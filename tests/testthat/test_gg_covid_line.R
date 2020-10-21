library(dplyr)
library(ggplot2)
library(hrbrthemes)
library(plotly)

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


test_that("test for gg_covid_line",{
          expect_s3_class(object = gg_covid_line(covid_data = covid_data, input = df),
                class = c("plotly", "htmlwidget"))
})
