
#used libraries
library(ncdf4) 
library(raster) 
library(rgdal) 
library(ggplot2) 
library(stringr)
library(ggplot2) 
library(data.table)
library(RColorBrewer)
library(sf)
PATH_INFILES <- "~/shared/data/paleo/PHYDA" # Path for the input files 
PATH_OUTFILES <- "~/shared/data_projects/med_datasets/1000_2000_data/" # Path for the cropped files 
PERIOD_START <- as.Date("1000-04-01")
PERIOD_END <- as.Date("2000-04-01")
study_area <- extent(-10.25, 40.25, 29.75, 45.25) # Extent for Mediterranean region
