#'Launch the shiny app from this function
#'
#'The launch_app() function checks for the app.R file in the directory inst/app.
#'This function looks for the particular path and stores it appDir variable.
#'We have also defined a if condition which helps the user by hinting the use, if the placement of his app.R file is been correctly stored.
#'If the user does not place the app.R in the correct directory(inst/app) they will receive a message regarding the incorrect directory.
#'
#'@export
launch_app <- function(){
  appDir <- system.file("app","app.R", package = "prikage")
  if (appDir == "") {
    stop("Could not find directory")
  }
  shiny::runApp(appDir)
}


