library(shiny)

df <- tibble(
  value = 1:2,
  country = "India")


test_that("test for ui functions",{
expect_s3_class(object = select_input_world_countries(selected_country_label = "input",
                                                        covid_data = df),
  class = "shiny.tag")
                             })
