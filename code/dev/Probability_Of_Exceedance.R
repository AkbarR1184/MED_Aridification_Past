source("code/source/functions.R")
source("code/source/global_variables.R")
#load the data 
slope_30year<-readRDS("~/shared/data_projects/med_datasets/1000_2000_data/slope_pdsi_spei_tas_1010-2000.rds")
pdsi_slope<-slope_30year[variable=="pdsi_mn"]
spei_slope<-slope_30year[variable=="spei_mn"]
tas_slope<-slope_30year[variable=="tas_mn"]


#Probability of Exceedance code for PDSI

column <- c(names(pdsi_slope), "Probability of Exceedance")
pdsi_prob_dt <- as.data.table(matrix(ncol = length(column), nrow = 0))
names(pdsi_prob_dt) <- column
start_year_vec <- unique(pdsi_slope[, timestep])
for(start_year_itr in start_year_vec){
  pdsi_slope_dummie_positive <- pdsi_slope[slope >= 0 & timestep == start_year_itr,]
  l_pos_slope <- length(pdsi_slope_dummie_positive[,slope])
  pdsi_slope_dummie_positive[ ,"Probability of Exceedance":= 1 -  rank(slope)/l_pos_slope]
  
  pdsi_slope_dummie_negative <- pdsi_slope[slope < 0 & timestep == start_year_itr,]
  l_neg_slope <- length(pdsi_slope_dummie_negative[,slope])
  pdsi_slope_dummie_negative[ ,"Probability of Exceedance":= 1 -  rank(slope)/l_neg_slope]
  
  pdsi_slope_dummie <- rbind(pdsi_slope_dummie_positive, pdsi_slope_dummie_negative)
  
  pdsi_prob_dt <- rbind(pdsi_prob_dt, pdsi_slope_dummie)
}

#Probability of Exceedance code for SPEI

column <- c(names(spei_slope), "Probability of Exceedance")
spei_prob_dt <- as.data.table(matrix(ncol = length(column), nrow = 0))
names(spei_prob_dt) <- column
start_year_vec <- unique(spei_slope[, timestep])
for(start_year_itr in start_year_vec){
  spei_slope_dummie_positive <- spei_slope[slope >= 0 & timestep == start_year_itr,]
  l_pos_slope <- length(spei_slope_dummie_positive[,slope])
  spei_slope_dummie_positive[ ,"Probability of Exceedance":= 1 -  rank(slope)/l_pos_slope]
  
  spei_slope_dummie_negative <- spei_slope[slope < 0 & timestep == start_year_itr,]
  l_neg_slope <- length(spei_slope_dummie_negative[,slope])
  spei_slope_dummie_negative[ ,"Probability of Exceedance":= 1 -  rank(slope)/l_neg_slope]
  
  spei_slope_dummie <- rbind(spei_slope_dummie_positive, spei_slope_dummie_negative)
  
  spei_prob_dt <- rbind(spei_prob_dt, spei_slope_dummie)
}

#Probability of Exceedance code for tas

column <- c(names(tas_slope), "Probability of Exceedance")
tas_prob_dt <- as.data.table(matrix(ncol = length(column), nrow = 0))
names(tas_prob_dt) <- column
start_year_vec <- unique(tas_slope[, timestep])
for(start_year_itr in start_year_vec){
  tas_slope_dummie_positive <- tas_slope[slope >= 0 & timestep == start_year_itr,]
  l_pos_slope <- length(tas_slope_dummie_positive[,slope])
  tas_slope_dummie_positive[ ,"Probability of Exceedance":= 1 -  rank(slope)/l_pos_slope]
  
  tas_slope_dummie_negative <- tas_slope[slope < 0 & timestep == start_year_itr,]
  l_neg_slope <- length(tas_slope_dummie_negative[,slope])
  tas_slope_dummie_negative[ ,"Probability of Exceedance":= 1 -  rank(slope)/l_neg_slope]
  
  tas_slope_dummie <- rbind(tas_slope_dummie_positive, tas_slope_dummie_negative)
  
  tas_prob_dt <- rbind(tas_prob_dt, tas_slope_dummie)
}
#creating single data table with probability of exceedance for all three variable

Probability_Of_Exceedance_dt<-rbind(pdsi_prob_dt, spei_prob_dt, tas_prob_dt)

#saving the data

saveRDS(Probability_Of_Exceedance_dt,paste0(PATH_OUTFILES, "Probability_Of_Exceedance_dt.rds"))
