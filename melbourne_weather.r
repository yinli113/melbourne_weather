

# Load required libraries
library(readxl)
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)
library(broom)

# Load data
melbourne <- read_excel("melbourne.xlsx")

# Clean column names
names(melbourne) <- make.names(names(melbourne))

# Convert Date column to Date type
melbourne$Date <- as.Date(melbourne$Date)

# Extract components of Date
mel_date <- melbourne %>%
  mutate(year = factor(year(Date)),
         month = factor(month(Date)),
         date = factor(day(Date)),
         day = factor(weekdays(Date)))

# Convert character columns to numeric
melbourne_numeric <- melbourne %>%
  mutate(across(where(is.character), as.numeric))

# Convert wind direction columns to factor
melbourne_factors <- melbourne %>%
  select(starts_with("Direction")) %>%
  mutate_all(as.factor)

# Combine numeric and factor columns
melbourne_combined <- bind_cols(mel_date, melbourne_numeric, melbourne_factors)

# Remove columns with any NA values
melbourne_cleaned <- melbourne_combined %>% 
  select_if(~sum(is.na(.)) == 0)

# Compute skewness
skewness_values <- map_dbl(melbourne_cleaned %>% 
                             select(starts_with("Temperature"), 
                                    ends_with("humidity"),
                                    starts_with("Evaporation")), 
                           skewness, na.rm = TRUE)

# Log transform variables with high skewness
high_skewness_indices <- which(skewness_values > 0.5)
melbourne_cleaned[, high_skewness_indices] <- log(melbourne_cleaned[, high_skewness_indices] + 1)

# Plot histograms
hist_plots <- map(names(melbourne_cleaned), ~{
  ggplot(melbourne_cleaned, aes_string(x = .)) + 
    geom_histogram() +
    labs(title = .)
})

# Boxplots
boxplot_plots <- map(names(melbourne_cleaned)[grepl("Evaporation", names(melbourne_cleaned))], ~{
  ggplot(melbourne_cleaned, aes_string(x = "month", y = .)) + 
    geom_boxplot() +
    labs(y = .)
})

# Simple linear models
linear_models <- map(names(melbourne_cleaned)[grepl("Evaporation", names(melbourne_cleaned))], ~{
  lm(as.formula(paste0(.x, " ~ month")), data = melbourne_cleaned)
})

# Summary of linear models
model_summaries <- map(linear_models, broom::tidy)

# Confidence intervals for predictor variables
ci_mintemp <- broom::confint(linear_models[[2]], "mintemp")
ci_hum9 <- broom::confint(linear_models[[3]], "hum9")

# Predictions
new_data <- expand.grid(month = as.factor(1:12), mintemp = 12.3, hum9 = 66.82)
predictions <- map(linear_models, ~predict(.x, newdata = new_data, interval = "confidence"))

# Exponentiate predictions
exp_predictions <- map(predictions, ~exp(.x) - 1)

# Print results
print(skewness_values)
print(hist_plots)
print(boxplot_plots)
print(model_summaries)
print(ci_mintemp)
print(ci_hum9)
print(exp_predictions)
