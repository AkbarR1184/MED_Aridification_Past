#read data 
source("code/source/functions.R")
source("code/source/global_variables.R")
slope_30year<-readRDS("~/shared/data_projects/med_datasets/1000_2000_data/slope_pdsi_spei_tas.rds")
pdsi_slope_30_year<-slope_30year[Variable=="pdsi_mn"]
pdsi_slope_30_year[,Interval:=paste0(StartYear, sep="-", EndYear)]
pdsi_slope_30_year[,TrendSign:= sign(Slope)]

#calculating frequency of trend change during 34 time intervals
pdsi_trend_changes <- pdsi_slope_30_year[, .(frequency = sum(diff(TrendSign) != 0) / 34 * 100), by = .(X, Y)]
names(pdsi_trend_changes)= c("X","Y", "Frequency of Trend Changes")
#plotting the frequecny map
ggplot(data = pdsi_trend_changes, aes(X, Y)) +
  geom_tile(aes(fill = `Frequency of Trend Changes`, color=`Frequency of Trend Changes`)) +
  scale_fill_gradient2(low = "blue",midpoint = 50,mid = "gray",   high = "red",limit=c(30, 70)) +
  scale_color_gradient2(low = "blue",midpoint =  50,mid = "gray",   high = "red",limit=c(30, 70)) +
  scale_x_continuous(breaks = seq(-20, 30, 10), name = "Longitude") +
  scale_y_continuous(breaks = seq(30, 70, 10), name = "Latitude") +
  theme(panel.background = element_rect(fill = NA), panel.ontop = TRUE,
        axis.ticks.length = unit(0, "cm"),
        panel.grid.major = element_line(colour = "gray60"),
        axis.title = element_text(size = 16), 
        legend.text = element_text(size = 12), 
        legend.title = element_text(size = 16))

