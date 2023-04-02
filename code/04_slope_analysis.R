#slope analysis for pdsi_mn& spei_mn& tas_mn

source("code/source/global_variables.R")
source("code/source/functions.R")

# Read data

data <- readRDS(paste0(PATH_OUTFILES, "PHYDA_pdsi_spei_tas_dt_1000_2000_yearly_0.25_degree.rds"))

data$year <- substr(data$time, 1, 4)
data$time<-NULL

# Set rolling window size and start and end years
window_size <- 30
start_year <- 1000
end_year <- 2000

# creating and empty data table to store slopes
slopes <- data.table(X=numeric(), Y=numeric(), Variable=character(), StartYear=numeric(), EndYear=numeric(), Slope=numeric())

# Loop over all unique (x, y, variable) 

unique_locs_vars <- unique(data[, .(X, Y, variable)])
for (i in 1:nrow(unique_locs_vars)) {
  
  # Get current location and variable
  current_location_variable <- unique_locs_vars[i, ]
  
  # Filter data for current location and variable and time window
  mask <- data[X == current_location_variable$X & Y == current_location_variable$Y & variable == current_location_variable$variable]
  
  for (j in seq(start_year, end_year, by=window_size)) {
    
    # Calculate start and end years for current time window
    start_time <- j
    end_time <- min(j + window_size - 1, end_year)
    
    # Filter data for current time window
    current_data <- mask[year >= start_time & year <= end_time]
    
    # Fit a linear regression model
    if (nrow(current_data) > 1) {
      model <- lm(value ~ year, data=current_data)
      
      # Extract the slope and store in the slopes data table
      slopes <- rbindlist(list(slopes, data.table(X=current_location_variable$X, Y=current_location_variable$Y, Variable=current_location_variable$variable, StartYear=start_time, EndYear=end_time, Slope=coef(model)[2])))
    }
  }
}


# save slopes data table
saveRDS(slopes, paste0(PATH_OUTFILES, "slope_pdsi_spei_tas.rds"))