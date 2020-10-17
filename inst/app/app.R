library(shiny)
library(shinythemes)
library(readr)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(COVID19)
library(leaflet)
library(htmltools)
library(hrbrthemes)

covid_data <- COVID19::covid19()

covid_data <- covid_data %>% mutate(`Month Number` = month(date)) %>%
  mutate(`Months Names` = case_when(
    `Month Number` == "1" ~ "Jan",
    `Month Number` == "2" ~ "Feb",
    `Month Number` == "3" ~ "Mar",
    `Month Number` == "4" ~ "Apr",
    `Month Number` == "5" ~ "May",
    `Month Number` == "6" ~ "Jun",
    `Month Number` == "7" ~ "July",
    `Month Number` == "8" ~ "Aug",
    `Month Number` == "9" ~ "Sept",
    `Month Number` == "10" ~ "Oct",
    `Month Number` == "11" ~ "Nov",
    `Month Number` == "12" ~ "Dec"))

covid_data_map <- covid_data %>% select(latitude, longitude, administrative_area_level_1) %>% distinct()


owid_covid_data <- read_csv("Data/owid-covid-data.csv")
swe_con <- read_csv("Data/time_series_confimed-confirmed.csv")
swe_deaths <- read_csv("Data/time_series_deaths-deaths.csv")
aus_state <- read_csv("Data/COVID_AU_state.csv")

owid_covid_data <- owid_covid_data %>% mutate(month = month(date),
                                              week = month(date)) %>%
                  group_by(location, month) %>%
  select(location, month, total_cases, total_deaths)


aus_state <- aus_state %>% mutate(month = month(date))

aus_state_mon <- aus_state %>%  group_by(state,month) %>%
  summarise(Hospitalized = max(hosp, na.rm = TRUE),
            ICU = max(icu, na.rm = TRUE),
            Ventilator = max(vent, na.rm = TRUE),
            Recovered = max(recovered, na.rm = TRUE))

swe_con <- swe_con %>% dplyr::select("Region",
                                     "Display_Name",
                                     "Lat",
                                     "Long" ,
                                     "Region_Total",
                                     "Region_Deaths")


ui <- navbarPage(title = "COVID Traversing",
                 theme = shinytheme("cerulean"),

                 tabPanel(title = "Globeview of COVID-19",
                          img(src = "sym.png", height = 145, width = 1800, align = "center"),
                          fluidRow(
                            br(),
                            p("Worldwide, COVID-19 cases are rising unsurpassed, exceeding the daily numbers.
                              One thing that is apparent is that adjusting to change is inevitable, and we all know that change is unavoidable.
                              In the last few months, thanks to COVID-19, we have experienced an exceptional change in our way of life and the same applies to this entire globe.
                              Let's look at the state of this pandemic all over the world. Before we investigate futher, seek medical help if you develop any of the symptoms mentioned in the image above,
                              even if you encounter mild symptoms that are being examined today, get tested and help stop this virus from spreading indeed spread more happiness around us.",


                              style="text-align:justify;font-size:18px;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                            br(),

                            p("Lets have a detailed, look at the COVID-19 scenario, this page allows the user to pick the country of the desired choice and we are given a visual about the pattern of the reported cases,
                              the recovered cases and unfortunately the death cases in the selected country according to the user's choice. In addition, we have also supported this, with a world map where COVID-19 cases have been found,
                              the user can click on the labelled country of his / her choice with the help of the hover feature over the map, and the graph showing the COVID-19 trend of different type of cases is modified dynamically as per the user's choice.
                              The date range, allows the user to find what when which country, suffered the most and leasts, as well as infer more about other interesting facts. Scroll down further and enjoy working with map and graph together. HOPE YOU HAVE FUN",
                              style="text-align:justify;font-size:18px;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                            width=12),
                 sidebarLayout(

                   sidebarPanel(
                   selectInput(inputId = "country",
                                label = "Select country",
                                selected = "Italy",
                                choices = unique(covid_data$administrative_area_level_1)),
                   sliderInput(inputId = "trajectory",
                               label = "Date Range:",
                               min = as.POSIXct("2020-01-01","%Y-%m-%d"),
                               max = as.POSIXct("2020-10-05","%Y-%m-%d"),
                               value = c(as.POSIXct("2020-02-05"), as.POSIXct("2020-09-05")),
                               timeFormat="%Y-%m-%d", step = 1)

                  ),


                 mainPanel(
                   plotlyOutput("Plot1"),
                   fluidRow(
                     br(),
                     p("The graph above shows, the trend line of the confirmed cases(blue line), the recovered cases(green line), the death cases(red line).
                       The hover function, also the user to see the exact date, as well as the precise count of the total number of confirmed, recovered and fatal cases.",
                       style="text-align:justify;font-size:18px;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                     br(),

                     p("The map below are the locations across the globe where instances of COVID-19 have been discovered.
                       The hover feature also allows the user to see the labelled countries and the user can see the graph of the selected country by clicking on one of them.",
                       style="text-align:justify;font-size:18px;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                     br(),
                     width=12),
                   leafletOutput("mymap")

                   ))),


                  tabPanel(title = "Australia's States",
                  img(src = "aushelp.png", height = 360, width = 1759, align = "center"),
                  fluidRow(
                   br(),
                   p("Australia is one of the most amazing places to have rightly battled the pandemic, a jewel in all countries and one of the most prosperous countries in the world.
                      Kudos to all of Australia's State and its people that have been so patient and fought the pandemic in the right way.
                      There is a little more interactivity that you will find on this page. The user may pick the one of the regions of Australia for more information of Monthly COVID-19 positive cases from the various states of Australia.
                      It just doesn't end here, on clicking the one of the months, from the graphs which gives us overview of positive cases over the months of time, you will further get details about the maximum people that were recovered,
                      that were hospitalized, were on ventilator & people kept in the ICU for the corresponding month clicked by the user. Scroll Down and Enjoy Exploring the Statistics of Confirmed cases in the various Regions of Australia",
                      style="text-align:justify;font-size:18px;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                    br(),
                    width=12),
                 sidebarLayout(
                   sidebarPanel(
                     selectInput(inputId = "region",
                                 label = "Select Region",
                                 selected = "Victoria",
                                 choices = unique(aus_state$state))

                   ),
                   mainPanel(
                     plotlyOutput("Plot2"),
                     fluidRow(
                       br(),
                       p("CLICK ON THE BAR PLOT OF ONE OF THE MONTHS FOR FUTHER DETAILS OF THE POSTIVE CASES OF THAT CLICKED MONTH",
                         style="text-align:justify;font-size:18px;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                       br(),
                       width=12),
                     #verbatimTextOutput("info"),
                     plotlyOutput("Plot3"),
                     fluidRow(
                       br(),
                       p("The graph, above showcases the the maximum people that recovered, that were hospitalized, were on ventilator & people kept in the ICU
                         for the month clicked by the user. Hovering over the points of this graph, will allow the user,
                         to show what was the maximum cases for each category as mentioned previously",
                         style="text-align:justify;font-size:18px;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                       br(),
                       width=12),
                   ))),

                 tabPanel(title = "WorldWide Statistics",
                 img(src = "abc.jpg", height = 270, width = 1800, align = "center"),
                 fluidRow(
                  br(),
                   p("Statistical knowledge allows you to use the right approaches to interpret and to present the findings effectively.
                     The COVID-19 monthly statistics allow us to see each month 's progress.
                     The following table helps the user to pick the desired country of preference and offers data on the average reported incidents, deaths and recovered incidents.
                     This table helps users to consider each country's development. Choose your place & find out more. DO HAVE FUN",
                     style="text-align:justify;font-size:18px;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                   br(),
                   width=12),
                 sidebarLayout(
                   sidebarPanel(
                     selectInput(inputId = "state",
                                 label = "Select Country",
                                 selected = "Italy",
                                 choices = unique(covid_data$administrative_area_level_1)),

                   ),
                   mainPanel(
                     DT::dataTableOutput("mytable1")
                     ))),

                 tabPanel(title = "References",
                          fluidRow(
                          includeMarkdown("include.md"))),


                 tabPanel(title = "About",
                          HTML('<center><img src="about.jpg" width="400"></center>'),
                          br(),
                          HTML('<center><img src="pic.jpeg" width="400"></center>'),
                           fluidRow(
                            br(),
                            p("A Little Introduction about Ms. Priya Ravindra Dingorkar",
                            style="text-align:center;font-size:18px;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                            br(),
                            p("Hey Reader,

Many Thanks for your interest in my Shiny App,
I am someone who believes in God, Goals, Growing
I am developing my Management and Analytic skills in Creative problem solving, Business Data analysis, Business Data interpretation, Data management and Effective Decision Making.
If you have enjoyed using my application, let me know.
If you have any suggestion, please a click and drop a message at the mentioned link below
“The Goal is to turn Data into Information, and Information into Insight.” – Carly Fiorina",
                            style="text-align:justify;font-size:18px;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                            br(),
                            width=12),
                            wellPanel(
                            helpText(   a("Click Here and Contact Me:)",     href="https://www.linkedin.com/in/priya-dingorkar/")
                            )
                          ),
                          fluidRow(
                            br(),
                            p("Purpose of this Shiny Application",
                              style="text-align:center;font-size:18px;color:black;background-color:papayawhip;padding:15px;border-radius:10px"),
                            br(),
                            p("This application is an assessment which represents 20% of my final grade of ETC5523.
                              In this Application we have discovered and seen the Overview of COVID-19 across the globe over time.
                              We have looked in detail about the country of our residency - Australia and learned more about its states.
                              We have also seen the Statistics of different cases over time across ht e globe.
                              We have learned how to make an shiny app in detail and for this we extend our gratitude to Respected Dr Emi Tanaka
                              & Respected Tutor Mitchell O’Hara-Wild. Thank for this awesome and creative thigng you have taught.",
                              style="text-align:justify;font-size:18px;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                            br(),
                            width=12),
                          )
                 )


server <- function(input, output, session) {

  output$Plot1 <- renderPlotly({

    DatesMerge<-input$DatesMerge
    options(scipen = 999)

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

  })

  output$mymap <- renderLeaflet({

    leaflet(covid_data_map) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addCircleMarkers(~longitude, ~latitude,
                       radius = 6,
                       label = ~htmlEscape(covid_data_map$administrative_area_level_1)
      )
  })

  observeEvent(input$mymap_marker_click,{

    click <- input$mymap_marker_click
    print(click)

    click_data <- covid_data_map %>%
      filter((latitude %in% click$lat) &
               (longitude %in% click$lng))


    updateSelectInput(session,
                      "country" ,
                      label = "Select Country",
                      choices = unique(covid_data$administrative_area_level_1),
                      selected = click_data$administrative_area_level_1)


  })

  output$Plot2 <- renderPlotly({


    p2 <-  aus_state %>% dplyr::filter(state == input$region) %>%
      ggplot(aes(x = month)) +
      geom_col(aes(y = positives), color = "orange", fill = "orange")  +
      ggtitle("Monthly Overview of the Positive Cases in the States of Australia") + xlab("Months") +
      ylab("Count of Positive Cases") +
    theme_ipsum()

    ggplotly(p2)


})

  #output$info <- renderPrint({
  #event_data("plotly_click")
  #})

  output$Plot3 <- renderPlotly({
    d <- event_data("plotly_click")
    if (is.null(d)) return(NULL)
    p3 <- aus_state_mon %>%
      filter(state == input$region) %>%
      filter(month %in% d$x) %>%
      ggplot(aes(x = month)) +
      geom_point(aes(y = Recovered), width = 0.3, color = "orange", size = 1.8) +
      geom_point(aes(y = ICU), width = 0.3, color = "darkblue", size = 1.8) +
      geom_point(aes(y = Ventilator), width = 0.3, color = "red", size = 1.8 ) +
      geom_point(aes(y = Hospitalized), width = 0.3, color = "darkgreen", size = 1.8 ) +
      ggtitle("Max Count of Recovered, Hospitizalised, ICU & Ventilator as per the Clicked Month") + xlab("Clicked Month") +
      ylab("Details of the Positive Cases, as per the Month Clicked") +
      theme_ipsum()

   ggplotly(p3)

  })

  output$mytable1 <- DT::renderDataTable({


    DT::datatable(covid_data %>%
                  dplyr::filter(administrative_area_level_1 == input$state) %>%
                  group_by(`Month Number`,`Months Names`) %>%
                  summarise(`Montly Average Cases` = round(mean(confirmed, na.rm = TRUE)),
                  `Monthly Average Deaths` = round(mean(deaths, na.rm = TRUE)),
                  `Monthly Average Recovered` = round(mean(recovered, na.rm = TRUE))))

  })

}



shinyApp(ui = ui, server = server)
