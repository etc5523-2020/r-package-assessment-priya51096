% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/server_gg_functions.R
\name{gg_covid_line}
\alias{gg_covid_line}
\title{gg_covid_line functions creates a graphs that shows us the recovered/confirmed/deaths cases for the selected country and selected date range by the user}
\usage{
gg_covid_line(covid_data, input)
}
\arguments{
\item{covid_data}{is the required argument of this function, to help the function recognize the data and further work on it as per the function}

\item{input}{allows the user to read the data for filtering/matching as per the function in order to produce the graph}
}
\description{
gg_covid_line function helps us for the creation of line graphs of the covid confirmed, recovered and death cases for covid_data
ggplot2 and geom_line, are the dependencies of this functions, we has also set a theme for the graphs which allows the  uniformity, throughout our app.
We further add this function in the ggplotly function to enhances the user interactivity of our graph.
}
