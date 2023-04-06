#calculating significant change in trend based on percentiles

pdsi_slope_prob_30year[, c("Positive_Trend_P10", "Positive_Trend_P90", "Negative_Trend_P10", "Negative_Trend_P90") :=
                         .(quantile(Slope[Trend == "Positive"], 0.1, na.rm = TRUE),
                           quantile(Slope[Trend == "Positive"], 0.9, na.rm = TRUE),
                           quantile(Slope[Trend == "Negative"], 0.1, na.rm = TRUE),
                           quantile(Slope[Trend == "Negative"], 0.9, na.rm = TRUE)), by = StartYear]

#setting threshold for the significant upward/downward change based on percentiles

pdsi_slope_prob_30year[, c("sig_positive_slope", "sig_negative_slope") :=
                         .(ifelse(Slope > Positive_Trend_P90 , "significant Upward change", NA),
                           ifelse(Slope <  Negative_Trend_P10 , "significant Downward change", NA))]


# subsetting data for plotting change in trend 
