### Reading and subsetting the data for the specified region and period

source('code/source/global_variables.R')
source('code/source/functions.R')

fname_PHYDA <- list.files(path = PATH_INFILES, full.names = T, pattern = "*.nc") 

## Read data
pdsi_mn <- brick(fname_PHYDA[1])
spei_mn <- brick(fname_PHYDA[2])
tas_mn <-brick(fname_PHYDA[3])

## Subset data over study area and period
pdsi_mn_PHYDA_MED <- crop_space_time(pdsi_mn, PERIOD_START, PERIOD_END, study_area) #function stored in functions.R
spei_mn_PHYDA_MED <- crop_space_time(spei_mn, PERIOD_START, PERIOD_END, study_area) #function stored in functions.R
tas_mn_PHYDA_MED <- crop_space_time(tas_mn, PERIOD_START, PERIOD_END, study_area) #function stored in functions.R


## Remove global data
rm(pdsi_mn); rm(spei_mn)
rm(tas_mn)
gc()

## Quick validation
plot(pdsi_mn_PHYDA_MED[[1:12]])
plot(spei_mn_PHYDA_MED[[1:12]])
plot(tas_mn_PHYDA_MED[[1:12]])

## Save data for further use
writeRaster(pdsi_mn_PHYDA_MED, paste0(PATH_OUTFILES, "pdsi_mn_PHYDA_MED.nc"),
            overwrite = TRUE,
            format = "CDF",
            varname = "PDSI",
            varunit = "Standardized units of relative dry and wet",
            longname = "PDSI (land only) (reconstruction mean)",
            xname = "lon",
            yname = "lat"
)

writeRaster(spei_mn_PHYDA_MED, paste0(PATH_OUTFILES, "spei_mn_PHYDA_MED.nc"),
            overwrite = TRUE,
            format = "CDF",
            varname = "spei_mn",
            varunit = "Standardized units of relative dry and wet",
            longname = "SPEI 12 months (land only) (reconstruction mean)",
            xname = "lon",
            yname = "lat"
)

writeRaster(tas_mn_PHYDA_MED, paste0(PATH_OUTFILES, "tas_mn_PHYDA_MED.nc"),
            overwrite = TRUE,
            format = "CDF",
            varname = "tas_mn",
            varunit = "degC",
            longname = "2 m temperature (reconstruction mean)",
            xname = "lon",
            yname = "lat"
)



