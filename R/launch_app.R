#'Launching the app with a function
#'
#'
#'This app launches the shiny app directly
#'
#'
#'
#'
#'
#'@export
launch_app <- function() {
  appDir <- system.file("app","app.R", package = "prikage")
  if (appDir == "") {
    stop("Could not find directory")
  }
  shiny::runApp(appDir)
}

"launch_app"

