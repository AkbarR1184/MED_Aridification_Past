library(ncdf4) 
library(raster) 
library(rgdal) 
library(ggplot2) 
library(stringr)
library(ggplot2) 
library(data.table)
library(RColorBrewer)
library(sf)

PATH_OUTFILES <- "~/shared/data_projects/med_datasets/1000_2000_data" # patch for the Aridification for the past millennium 
STUDY_PERIOD_START <- as.Date("1000-04-01")
STUDY_PERIOD_END <- as.Date("2000-04-01")
STUDY_AREA <- extent(-10.25, 40.25, 29.75, 45.25) # Extent for Mediterranean region
