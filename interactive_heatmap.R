# NOT RUN {
## Only run examples in interactive R sessions
if (interactive()) {
  
  library("shiny")
  library("shinyWidgets")
  
  
  #creating title page (emily)
  ui <- fluidPage(
    tags$h2("US MAP"),
    br(),
    dropdown(
      #Sub title
      tags$h3("Interactive US Map of Various Datasets"),
      
      #Making dropdown bar to select the preffered map (emily)
      pickerInput(inputId = 'xcol2',
                  label = 'DataSet',
                  choices = names(filler)[2:7],
                  options = list(`style` = "btn-info")),

      
      
      #Animation to fade between selected graphs (emily)
      style = "unite", icon = icon("gear"),
      status = "danger", width = "300px",
      animate = animateOptions(
        enter = animations$fading_entrances$fadeInLeftBig,
        exit = animations$fading_exits$fadeOutRightBig
      )
    ),
    #Plots the graph
    plotOutput(outputId = 'plot2')
  )
  
  server <- function(input, output, session) {
    
    #reactive value that changes based on input selected (james)
    selectedData2 <- reactive({
      filler[, input$xcol2]
    })
    
    output$plot2 <- renderPlot({
     #plot for map that adjusts based on input selected (James)
      plot_usmap(data=filler, values = input$xcol2, color = "black") + 
        scale_fill_continuous(name = input$xcol2, label = scales::comma) + 
        theme(legend.position = "right")
    })
    
  }
  
  shinyApp(ui = ui, server = server)
  
}
# }