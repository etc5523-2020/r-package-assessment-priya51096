#'@title select_input_world_countries allows the user to select any desired country from a list of countries.
#'
#'@description select_input_world_countries function allows the user to select a country from the list select of countries.
#'The choices for this country are a unique list of countries available from the already existing package of COVID19.
#'You can download this package from the CRAN library and find out more about it
#'select_input_world_countries, function accepts and stores the country of user choice.
#'The user country can be stored in as a label in the selected_country_label, which is one of the argument of our function
#'The user also will have to pass covid_data which is already been stored in the app.R for the second argument of this function
#'
#'@param selected_country_label defines a new label everytime this function runs and save it's value in the input_id of our select input function
#'@param covid_data, this requires the function to pass the covid_data, which will help the function recognize other select input default parameters, in this case choices
#'
#'@export
select_input_world_countries <- function(selected_country_label, covid_data) {
  selectInput(inputId = selected_country_label,
              label = "Select Country" ,
              selected = "Italy" ,
              choices = unique(covid_data$administrative_area_level_1))
}


#'@title select_input_austate allows the user to select one of the states of Australia.
#'
#'@description select_input_austate function allows the user to choose from a list of all the Australia's state
#'The data used for this function is a external data for a github repository. (Available in the data folder of this application)
#'select_input_ausstate function, accepts and stores the state of Australia as per user's choice.
#'The user's selected state can be stored in as a label in the selected_state_label, which is one of the argument of our function
#'The user also will have to pass aus_state which is already been stored in the app.R for the second argument of this function
#'
#'
#'@param selected_state_label defines a new label everytime this function runs and save it's value in the input_id of our select input function
#'@param aus_data, this requires the function to pass the aus_data, which will help the function recognize other select input default parameter, for the choices
#'
#'
#'
#'@export
select_input_austate <- function(selected_state_label, aus_state){
   selectInput(inputId =selected_state_label,
            label = "Select Region",
            selected = "Victoria",
            choices = unique(aus_state$state))
}

#'@title date_slider_input allows the user to set the the date range from which the user want to produces the graphs for that selected range of date
#'
#'@description date_slider_input functions, allows the user to select the desired data range.
#'the selected date range is further used by our shiny app to plot the the confirmed/recovered/death cases against the selected date range by the user.
#'This selected date range acts like our x axis in the shiny app.
#'The user's selected date range can be stored in as a label in the selected_date_range, which is an argument of our function
#'
#'
#'@param selected_date_range stores the user's selected date range in this label.
#'
#'@export
date_slider_input <- function(selected_date_range){
  sliderInput(inputId = selected_date_range ,
            label = "Date Range:",
            min = as.POSIXct("2020-01-01","%Y-%m-%d"),
            max = as.POSIXct("2020-10-05","%Y-%m-%d"),
            value = c(as.POSIXct("2020-02-05"), as.POSIXct("2020-09-05")),
            timeFormat="%Y-%m-%d", step = 1)
}



