#read data 
source("code/source/functions.R")
source("code/source/global_variables.R")
#reading the data and subsetting for frequency plot

slope_30year<-readRDS("~/shared/data_projects/med_datasets/1000_2000_data/slope_pdsi_spei_tas.rds")
slope_30year[,Interval:=paste0(StartYear, sep="-", EndYear)]
slope_30year[,TrendSign:= sign(Slope)]
slope_30year[,c("StartYear", "EndYear")]=NULL
pdsi_slope_30_year<-slope_30year[Variable=="pdsi_mn"]
spei_slope_30_year<-slope_30year[Variable=="spei_mn"]
tas_slope_30_year<-slope_30year[Variable=="tas_mn"]

#calculating frequency of trend change during 34 time intervals

pdsi_trend_changes <- pdsi_slope_30_year[, .("Frequency (%)" = sum(diff(TrendSign) != 0) / 34 * 100), by = .(X, Y)]
spei_trend_changes <- spei_slope_30_year[, .("Frequency (%)" = sum(diff(TrendSign) != 0) / 34 * 100), by = .(X, Y)]
tas_trend_changes <- tas_slope_30_year[, .("Frequency (%)" = sum(diff(TrendSign) != 0) / 34 * 100), by = .(X, Y)]

#plotting the frequecny maps

ggplot(data = pdsi_trend_changes, aes(X, Y)) +
  geom_tile(aes(fill =`Frequency (%)`, color=`Frequency (%)`)) +
  scale_fill_gradient2(low = "blue",midpoint = 50,mid = "gray",   high = "red") +
  scale_color_gradient2(low = "blue",midpoint =  50,mid = "gray",   high = "red") +
  scale_x_continuous(breaks = seq(-20, 30, 10), name = "Longitude") +
  scale_y_continuous(breaks = seq(30, 70, 10), name = "Latitude") +
  theme(panel.background = element_rect(fill = NA), panel.ontop = TRUE,
        axis.ticks.length = unit(0, "cm"),
        panel.grid.major = element_line(colour = "gray60"),
        axis.title = element_text(size = 16), 
        legend.text = element_text(size = 12), 
        legend.title = element_text(size = 16))

ggsave(paste0(PATH_OUTFILES,"pdsi_frequncy_of_trend_change.png"), 
       width = 12, height = 8)


ggplot(data = spei_trend_changes, aes(X, Y)) +
  geom_tile(aes(fill =`Frequency (%)`, color=`Frequency (%)`)) +
  scale_fill_gradient2(low = "blue",midpoint = 50,mid = "gray",   high = "red") +
  scale_color_gradient2(low = "blue",midpoint =  50,mid = "gray",   high = "red") +
  scale_x_continuous(breaks = seq(-20, 30, 10), name = "Longitude") +
  scale_y_continuous(breaks = seq(30, 70, 10), name = "Latitude") +
  theme(panel.background = element_rect(fill = NA), panel.ontop = TRUE,
        axis.ticks.length = unit(0, "cm"),
        panel.grid.major = element_line(colour = "gray60"),
        axis.title = element_text(size = 16), 
        legend.text = element_text(size = 12), 
        legend.title = element_text(size = 16))

ggsave(paste0(PATH_OUTFILES,"spei_frequncy_of_trend_change.png"), 
       width = 12, height = 8)


ggplot(data = tas_trend_changes, aes(X, Y)) +
  geom_tile(aes(fill =`Frequency (%)`, color=`Frequency (%)`)) +
  scale_fill_gradient2(low = "blue",midpoint = 50,mid = "gray",   high = "red") +
  scale_color_gradient2(low = "blue",midpoint =  50,mid = "gray",   high = "red") +
  scale_x_continuous(breaks = seq(-20, 30, 10), name = "Longitude") +
  scale_y_continuous(breaks = seq(30, 70, 10), name = "Latitude") +
  theme(panel.background = element_rect(fill = NA), panel.ontop = TRUE,
        axis.ticks.length = unit(0, "cm"),
        panel.grid.major = element_line(colour = "gray60"),
        axis.title = element_text(size = 16), 
        legend.text = element_text(size = 12), 
        legend.title = element_text(size = 16))

ggsave(paste0(PATH_OUTFILES,"tas_frequncy_of_trend_change.png"), 
       width = 12, height = 8)
