source("code/source/functions.R")
source("code/source/global_variables.R")
slope_30year<-readRDS("~/shared/data_projects/med_datasets/1000_2000_data/slope_pdsi_spei_tas.rds")

#Probability of Exceedance code

column <- c(names(slope_30year), "prob")
prob_dt <- as.data.table(matrix(ncol = length(column), nrow = 0))
names(prob_dt) <- column
start_year_vec <- unique(slope_30year[, StartYear])
for(start_year_itr in start_year_vec){
  slope_30year_dummie_positive <- slope_30year[Slope >= 0 & StartYear == start_year_itr,]
  l_pos_slope <- length(slope_30year_dummie_positive[,Slope])
  slope_30year_dummie_positive[ ,prob:= 1 -  rank(Slope)/l_pos_slope, by=Variable]
  
  slope_30year_dummie_negative <- slope_30year[Slope < 0 & StartYear == start_year_itr,]
  l_neg_slope <- length(slope_30year_dummie_negative[,Slope])
  slope_30year_dummie_negative[ ,prob:= 1 -  rank(Slope)/l_neg_slope, by=Variable]
  
  slope_30year_dummie <- rbind(slope_30year_dummie_positive, slope_30year_dummie_negative)
  
  prob_dt <- rbind(prob_dt, slope_30year_dummie)
}