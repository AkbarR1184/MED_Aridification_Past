#calculating significant change in trend based on percentiles
source("code/source/global_variables.R")
source("code/source/functions.R")

# Read slope data

PHYDA <- readRDS(paste0(PATH_OUTFILES, "slope_pdsi_spei_tas.rds"))
PHYDA[,Interval:=paste0(StartYear,"-", EndYear)]
PHYDA[,c("StartYear", "EndYear")]=NULL
pdsi_slope<-PHYDA[Variable=="pdsi_mn"]
spei_slope<-PHYDA[Variable=="spei_mn"]
tas_slope<-PHYDA[Variable=="tas_mn"]

#calculating p10 and p90 for the PDSI

pdsi_slope[, c("Positive_Trend_P20", "Positive_Trend_P80", "Negative_Trend_P20", "Negative_Trend_P80") :=
                         .(quantile(Slope[Slope>=0], 0.2, na.rm = TRUE),
                           quantile(Slope[Slope>=0], 0.8, na.rm = TRUE),
                           quantile(Slope[Slope<0], 0.2, na.rm = TRUE),
                           quantile(Slope[Slope<0], 0.8, na.rm = TRUE)), by = Interval]

#setting threshold for the significant upward/downward change based on percentiles

pdsi_slope[, c("sig_positive_slope", "sig_negative_slope") :=
                         .(ifelse(Slope > Positive_Trend_P80 , "significant Upward change", NA),
                           ifelse(Slope <  Negative_Trend_P20 , "significant Downward change", NA))]


#calculating p10 and p90 for the SPEI

spei_slope[, c("Positive_Trend_P20", "Positive_Trend_P80", "Negative_Trend_P20", "Negative_Trend_P80") :=
             .(quantile(Slope[Slope>=0], 0.2, na.rm = TRUE),
               quantile(Slope[Slope>=0], 0.8, na.rm = TRUE),
               quantile(Slope[Slope<0], 0.2, na.rm = TRUE),
               quantile(Slope[Slope<0], 0.8, na.rm = TRUE)), by = Interval]

#setting threshold for the significant upward/downward change based on percentiles

spei_slope[, c("sig_positive_slope", "sig_negative_slope") :=
             .(ifelse(Slope > Positive_Trend_P80 , "significant Upward change", NA),
               ifelse(Slope <  Negative_Trend_P20 , "significant Downward change", NA))]


#calculating p10 and p90 for the tas

tas_slope[, c("Positive_Trend_P20", "Positive_Trend_P80", "Negative_Trend_P20", "Negative_Trend_P80") :=
             .(quantile(Slope[Slope>=0], 0.2, na.rm = TRUE),
               quantile(Slope[Slope>=0], 0.8, na.rm = TRUE),
               quantile(Slope[Slope<0], 0.2, na.rm = TRUE),
               quantile(Slope[Slope<0], 0.8, na.rm = TRUE)), by = Interval]

#setting threshold for the significant upward/downward change based on percentiles

tas_slope[, c("sig_positive_slope", "sig_negative_slope") :=
             .(ifelse(Slope > Positive_Trend_P80 , "significant Upward change", NA),
               ifelse(Slope <  Negative_Trend_P20 , "significant Downward change", NA))]



slope_with_significance_dt<- rbind(pdsi_slope, spei_slope, tas_slope)
saveRDS(slope_with_significance_dt, "slope_with_significance_dt.rds")
