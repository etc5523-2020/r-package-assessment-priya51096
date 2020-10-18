mySliderInput <- function(A) {
  selectInput(inputId = A,
              label = "Select Country" ,
              selected = "Italy" ,
              choices = unique(covid_data$administrative_area_level_1))
}

