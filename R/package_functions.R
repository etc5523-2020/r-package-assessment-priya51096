library(shiny)

launchApp <- function() {
  appDir <- system.file("inst", "app")
  if (appDir == "") {
    stop("Could not find directory")
  }

  shiny::runApp(appDir)
}
