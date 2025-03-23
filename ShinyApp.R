# Define UI

ui <- fluidPage(
  titlePanel("Sports Injury Prediction App"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("player_age", "Player Age", value = 25, min = 10, max = 50),
      numericInput("player_weight", "Player Weight (kg)", value = 70, min = 40, max = 120),
      numericInput("player_height", "Player Height (cm)", value = 180, min = 140, max = 220),
      numericInput("training_intensity", "Training Intensity (1-10)", value = 5, min = 1, max = 10),
      numericInput("recovery_time", "Recovery Time (days)", value = 2, min = 1, max = 7),
      numericInput("previous_injuries", "Previous Injuries (0 = No, 1 = Yes)", value = 0, min = 0, max = 1),
      actionButton("predict_button", "Predict Injury Likelihood")
    ),
    
    mainPanel(
      h3("Prediction Result"),
      textOutput("prediction_output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Load the trained model
  model <- readRDS("injury_prediction_model.rds")
  
  # Observe the predict button click
  observeEvent(input$predict_button, {
    # Create a data frame from user input
    new_data <- data.frame(
      Player_Age = input$player_age,
      Player_Weight = input$player_weight,
      Player_Height = input$player_height,
      Training_Intensity = input$training_intensity,
      Recovery_Time = input$recovery_time,
      Previous_Injuries = input$previous_injuries
    )
    
    # Make a prediction
    prediction <- predict(model, newdata = new_data, type = "prob")
    
    # Display the prediction
    output$prediction_output <- renderText({
      paste("Probability of Injury: ", round(prediction$`1`, 2))
    })
  })
}
# Run the application


rsconnect::setAccountInfo(name='kidigapeet',
                          token='D00A1F27B656B6CADDDCE61EA9203CB6',
                          secret='34SyZ9cRPclM3JKcsTST3cGHXQJ8EWwr+PjHhKBr')
library(rsconnect)
library(rsconnect)

rsconnect::deployApp("C:/Users/kidig/OneDrive/Desktop/r packages")
