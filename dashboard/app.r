library(dplyr)
library(ggplot2)
library(shiny)
library(survival)
library(survminer)
library(shinycssloaders)

# Original COVID data
data <- read.csv("C:/Users/siddh/Downloads/COVID19_line_list_data_Industry Assignment 1.csv")
data$age[is.na(data$age)] <- mean(data$age, na.rm = TRUE)
data$gender[is.na(data$gender)] <- "Unknown"
data$reporting_date <- as.Date(data$reporting_date)
data$death <- ifelse(data$death == 1, 1, 0)
data$age_group <- cut(data$age, breaks = c(0, 20, 40, 60, 80, Inf), 
                      labels = c("0-20", "21-40", "41-60", "61-80", "80+"))

age_analysis <- data %>%
  group_by(age_group) %>%
  summarise(death_rate = mean(death == 1, na.rm = TRUE))
gender_analysis <- data %>%
  group_by(gender) %>%
  summarise(death_rate = mean(death == 1, na.rm = TRUE))

# Dummy data for Cox regression
set.seed(42)
dummy_data <- data.frame(
  time = sample(1:100, 50, replace = TRUE),  # survival times in days
  death = sample(c(0, 1), 50, replace = TRUE),  # death indicator (0 = censored, 1 = event)
  age = sample(20:80, 50, replace = TRUE),  # random ages
  gender = sample(c("Male", "Female"), 50, replace = TRUE)  # random gender
)
cox_model <- coxph(Surv(time, death) ~ age + gender, data = dummy_data)

# Define UI
ui <- fluidPage(
  titlePanel("COVID-19 Data Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("ageInput", "Select Age Range:", min = 0, max = 100, value = c(0, 100)),
      selectInput("genderInput", "Select Gender:", choices = unique(data$gender), selected = "Male"),
      actionButton("refresh", "Refresh Data")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Data Overview", dataTableOutput("dataTable") %>% withSpinner()),
        
        # Age Group Analysis
        tabPanel("Age Group Analysis", 
                 plotOutput("agePlot") %>% withSpinner(),
                 plotOutput("agePieChart") %>% withSpinner(),
                 plotOutput("ageDensityPlot") %>% withSpinner(),
                 plotOutput("ageHistPlot") %>% withSpinner()),
        
        # Gender Analysis
        tabPanel("Gender Analysis", 
                 plotOutput("genderPlot") %>% withSpinner(),
                 plotOutput("genderPieChart") %>% withSpinner(),
                 plotOutput("genderBarPlot") %>% withSpinner(),
                 plotOutput("genderBoxPlot") %>% withSpinner(),
                 plotOutput("genderViolinPlot") %>% withSpinner()),
        
        # Cox Regression Analysis
        tabPanel("Cox Regression Analysis", 
                 verbatimTextOutput("coxOutput"),
                 plotOutput("coxSurvPlot") %>% withSpinner(),
                 plotOutput("coxHazardPlot") %>% withSpinner(),
                 plotOutput("coxResidualPlot") %>% withSpinner())
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Reactive filtered data based on age and gender inputs
  filtered_data <- reactive({
    req(input$ageInput)
    data %>% 
      filter(age >= input$ageInput[1], age <= input$ageInput[2], gender == input$genderInput)
  })
  
  # Data Table
  output$dataTable <- renderDataTable({
    filtered_data()
  })
  
  # Age Group Analysis Plots
  output$agePlot <- renderPlot({
    ggplot(age_analysis, aes(x = age_group, y = death_rate)) +
      geom_bar(stat = "identity", fill = "blue") +
      labs(title = "Death Rate by Age Group", x = "Age Group", y = "Death Rate") +
      theme_minimal()
  })
  
  output$agePieChart <- renderPlot({
    ggplot(age_analysis, aes(x = "", y = death_rate, fill = age_group)) +
      geom_bar(stat = "identity") +
      coord_polar("y") +
      labs(title = "Death Rate Distribution by Age Group") +
      theme_void() +
      theme(legend.position = "right")
  })
  
  output$ageDensityPlot <- renderPlot({
    ggplot(data, aes(x = age, fill = gender)) +
      geom_density(alpha = 0.5) +
      labs(title = "Age Density by Gender", x = "Age", y = "Density") +
      theme_minimal()
  })
  
  output$ageHistPlot <- renderPlot({
    ggplot(data, aes(x = age, fill = gender)) +
      geom_histogram(bins = 30, alpha = 0.5, position = "identity") +
      labs(title = "Age Distribution by Gender", x = "Age", y = "Count") +
      theme_minimal()
  })
  
  # Gender Analysis Plots
  output$genderPlot <- renderPlot({
    ggplot(gender_analysis, aes(x = gender, y = death_rate)) +
      geom_bar(stat = "identity", fill = "red") +
      labs(title = "Death Rate by Gender", x = "Gender", y = "Death Rate") +
      theme_minimal()
  })
  
  output$genderPieChart <- renderPlot({
    ggplot(gender_analysis, aes(x = "", y = death_rate, fill = gender)) +
      geom_bar(stat = "identity") +
      coord_polar("y") +
      labs(title = "Death Rate Distribution by Gender") +
      theme_void() +
      theme(legend.position = "right")
  })
  
  output$genderBarPlot <- renderPlot({
    ggplot(data, aes(x = gender)) +
      geom_bar(fill = "darkgreen") +
      labs(title = "Total Cases by Gender", x = "Gender", y = "Count") +
      theme_minimal()
  })
  
  output$genderBoxPlot <- renderPlot({
    ggplot(data, aes(x = gender, y = age, fill = gender)) +
      geom_boxplot() +
      labs(title = "Age Distribution by Gender", x = "Gender", y = "Age") +
      theme_minimal()
  })
  
  output$genderViolinPlot <- renderPlot({
    ggplot(data, aes(x = gender, y = age, fill = gender)) +
      geom_violin() +
      labs(title = "Age Distribution by Gender (Violin Plot)", x = "Gender", y = "Age") +
      theme_minimal()
  })
  
  # Cox Regression Analysis Outputs
  output$coxOutput <- renderPrint({
    summary(cox_model)
  })
  
  # Kaplan-Meier survival plot for gender-based analysis
  output$coxSurvPlot <- renderPlot({
    # Fit a survival model by gender
    surv_fit <- survfit(Surv(time, death) ~ gender, data = dummy_data)
    ggsurvplot(surv_fit, data = dummy_data, conf.int = TRUE, ggtheme = theme_minimal(),
               title = "Gender-Based Kaplan-Meier Survival Curve", 
               palette = c("blue", "pink"))
  })
  
  # Hazard Ratios by Gender
  output$coxHazardPlot <- renderPlot({
    # Fit Cox regression model by gender
    cox_model_gender <- coxph(Surv(time, death) ~ gender, data = dummy_data)
    coef_data <- data.frame(
      covariate = names(coef(cox_model_gender)),
      estimate = exp(coef(cox_model_gender)),
      lower = exp(coef(cox_model_gender) - 1.96 * sqrt(diag(vcov(cox_model_gender)))),
      upper = exp(coef(cox_model_gender) + 1.96 * sqrt(diag(vcov(cox_model_gender))))
    )
    ggplot(coef_data, aes(x = covariate, y = estimate, ymin = lower, ymax = upper)) +
      geom_pointrange() +
      labs(title = "Hazard Ratios by Gender", x = "Covariate", y = "Hazard Ratio") +
      theme_minimal()
  })
  
  # Residual Plot (Gender-Based)
  output$coxResidualPlot <- renderPlot({
    # Schoenfeld residuals by gender
    cox_model_gender <- coxph(Surv(time, death) ~ gender, data = dummy_data)
    cox.zph_test <- cox.zph(cox_model_gender)
    plot(cox.zph_test, resid = TRUE, se = TRUE)
    title("Gender-Based Schoenfeld Residuals")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
