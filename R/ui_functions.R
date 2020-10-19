#'This is on eof the funct for my app
#'
#'
#'
#'ONe of the select input
#'
#'
#'@export
select_input_world_countries <- function(A, covid_data) {
  selectInput(inputId = A,
              label = "Select Country" ,
              selected = "Italy" ,
              choices = unique(covid_data$administrative_area_level_1))
}


#'This is on eof the funct for my app
#'
#'
#'
#'ONe of the select input trajectory
#'
#'
#'@export
select_input_austate <- function(B, aus_state){
   selectInput(inputId = B,
            label = "Select Region",
            selected = "Victoria",
            choices = unique(aus_state$state))
}

#'This is on eof the funct for my app
#'
#'
#'
#'ONe of the select input trajectory
#'
#'
#'@export
date_slider_input <- function(C){
  sliderInput(inputId = C ,
            label = "Date Range:",
            min = as.POSIXct("2020-01-01","%Y-%m-%d"),
            max = as.POSIXct("2020-10-05","%Y-%m-%d"),
            value = c(as.POSIXct("2020-02-05"), as.POSIXct("2020-09-05")),
            timeFormat="%Y-%m-%d", step = 1)
}



