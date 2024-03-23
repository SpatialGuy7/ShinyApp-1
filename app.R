# Load required libraries
library(shiny)
library(leaflet)
library(jsonlite)

# Define UI
ui <- fluidPage(
  titlePanel("Simple Leaflet Shiny Map with GeoJSON"),
  leafletOutput("map")
)

# Define server logic
server <- function(input, output) {

  # Function to read GeoJSON data
  geojson_data <- reactive({
    # Load GeoJSON data from URL
    url <- "https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json"
    jsonlite::fromJSON(url)
  })

  # Render leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 30, zoom = 2) # Set initial view
  })

  # Add GeoJSON layer to the map
  observe({
    leafletProxy("map", data = geojson_data()) %>%
      addGeoJSON(color = "blue", weight = 1, fillOpacity = 0.2)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
