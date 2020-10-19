#'select_input_world_countries allows the user to select any desired country from a list of countries.
#'
#'select_input_world_countries function allows the user to select a country from the list select of countries.
#'The choices for this country are a unique list of countries available from the already existing package of COVID19.
#'You can download this package from the CRAN library and find out more about it
#'select_input_world_countries, function accepts and stores the country of user choice.
#'The user country can be stored in as a label in the selected_country_label, which is one of the argument of our function
#'The user also will have to pass covid_data which is already been store din the app.R for the second argument of this function
#'
#'@param selected_country_label defines a new label everytime this function runs and save it's value in the input_id of our select input function
#'@param covid_data, this requires the function to pass the covid_data, which will help the function recognize other select input default parameter
#'
#'
#'@export
select_input_world_countries <- function(selected_country_label, covid_data) {
  selectInput(inputId = selected_country_label ,
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



