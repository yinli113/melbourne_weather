
Predicting Evaporation Rate at Melbourne's Reservoirs

Executive Summary
In response to recent climate changes affecting Melbourne, Melbourne Water Corporation (MWC) needs reliable
estimates of evaporation rates at their reservoirs. Exceeding 10mm of evaporation at Cardinia Reservoir prompts
emergency measures to ensure continuous water supply, including water transfer from Silvan Reservoir. 
To predict potential high evaporation days, we developed a multilinear regression model incorporating two 
continuous and one categorical variable. Four assumption tests were performed to validate the model's reliability.

Key findings indicate three significant factors influencing evaporation: month, minimum temperature, 
and 9 am relative humidity. Higher minimum temperatures correlate with increased evaporation,
while humidity shows the opposite effect. Summer months (October to March) exhibit higher evaporation rates, 
while June and July remain relatively low. Future emergency measures should consider meteorological forecasts, 
especially during high-evaporation months.

Methods
Part 1: Bivariate Summary
Analyzing potential influences on daily evaporation:
Month (Categorical)
Day of the week (Categorical)
Maximum temperature (Numerical)
Minimum temperature (Numerical)
Relative humidity at 9 am (Numerical)
Data preprocessing:
Recoding Month and Day of the week as factors
Checking symmetry using skewness and histograms
Simplifying column names and summarizing statistics
Exploring relationships between:
Categorical variables vs. Evaporation
Continuous variables vs. Evaporation

Part 2: Model Section
Building a linear model to predict daily evaporation:
Including all potential predictors
Considering an interaction term between month and humidity
Model construction process:
Fitting a model with all predictors
Iteratively removing non-significant predictors based on p-values
Updating the model until only significant predictors remain
Utilizing shortcut functions like factor() for categorical variables.


Conclusion
The developed model provides MWC with a reliable tool for predicting evaporation rates,
crucial for proactive water management strategies. By considering key meteorological factors, 
the model aids in identifying potential high-evaporation days, enabling timely implementation
of emergency measures to ensure water supply stability. Ongoing monitoring and refinement of 
the model will enhance its accuracy and utility in addressing evolving climate challenges.




