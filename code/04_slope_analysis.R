source("code/source/global_variables.R")
source("code/source/functions.R")

# Read data

PHYDA <- readRDS(paste0(PATH_OUTFILES, "PHYDA_pdsi_spei_tas_dt_1000_2000_yearly_0.25_degree.rds"))
PHYDA$year <- year(PHYDA$time)
PHYDA$time=NULL

#subsetting variables
pdsi_dt<-PHYDA[variable=="pdsi_mn"]
spei_dt<-PHYDA[variable=="spei_mn"]
tas_dt<-PHYDA[variable=="tas_mn"]

year_interval <- seq(min(pdsi_dt$year), max(pdsi_dt$year)+30, by=30)
pdsi_dt$timestep <- NA
pdsi_dt$timestep=as.character(pdsi_dt$timestep)

#adding time window (e.g 1000-1030) to the variable pdsi 

for (i in 1:length(year_interval)) {
  pdsi_dt[year<=year_interval[i] & year>=year_interval[i-1], timestep:= paste0(year_interval[i-1], sep="-",year_interval[i])]
}

#calculating slope 

pdsi_dt_slopes <- pdsi_dt[, {
  linear_model <- lm(value ~ year); coef(linear_model)[2]
}, by = .(X, Y, timestep)]
setnames(pdsi_dt_slopes, "V1", "slope")




#adding time window (e.g 1000-1030) to the variable spei 

for (i in 1:length(year_interval)) {
  spei_dt[year<=year_interval[i] & year>=year_interval[i-1], timestep:= paste0(year_interval[i-1], sep="-",year_interval[i])]
}

#calculating slope 

spei_dt_slopes <- spei_dt[, {
  linear_model <- lm(value ~ year); coef(linear_model)[2]
}, by = .(X, Y, timestep)]
setnames(spei_dt_slopes, "V1", "slope")



#adding time window (e.g 1000-1030) to the variable tas 

for (i in 1:length(year_interval)) {
  tas_dt[year<=year_interval[i] & year>=year_interval[i-1], timestep:= paste0(year_interval[i-1], sep="-",year_interval[i])]
}

#calculating slope 

tas_dt_slopes <- tas_dt[, {
  linear_model <- lm(value ~ year); coef(linear_model)[2]
}, by = .(X, Y, timestep)]
setnames(tas_dt_slopes, "V1", "slope")

pdsi_dt_slopes$variable<-"pdsi_mn"
spei_dt_slopes$variable<-"spei_mn"
tas_dt_slopes$variable<- "tas_mn"

slope_dt<-rbind(pdsi_dt_slopes, spei_dt_slopes, tas_dt_slopes)
saveRDS(slope_dt, "slope_pdsi_spei_tas_1000-2000.rds")
