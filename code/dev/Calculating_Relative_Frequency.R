#read data 
source("code/source/functions.R")
source("code/source/global_variables.R")
#reading the data and subsetting for frequency plot

slope_30year<-readRDS("slope_pdsi_spei_tas_1000-2000.rds")
slope_30year[,TrendSign:= sign(slope)]
slope_30year <- slope_30year[slope_30year$timestep != "1990-2020", ]

pdsi_slope_30_year<-slope_30year[variable=="pdsi_mn"]
spei_slope_30_year<-slope_30year[variable=="spei_mn"]
tas_slope_30_year<-slope_30year[variable=="tas_mn"]

#calculating frequency of trend change during 34 time intervals

pdsi_trend_changes <- pdsi_slope_30_year[, .("Frequency (%)" = sum(diff(TrendSign) != 0) / 33 * 100), by = .(X, Y)]
spei_trend_changes <- spei_slope_30_year[, .("Frequency (%)" = sum(diff(TrendSign) != 0) / 33 * 100), by = .(X, Y)]
tas_trend_changes <- tas_slope_30_year[, .("Frequency (%)" = sum(diff(TrendSign) != 0) / 33 * 100), by = .(X, Y)]

#creating trend change data table for all variables
tas_trend_changes$variable<- "tas_mn"
pdsi_trend_changes$variable<- "pdsi_mn"
spei_trend_changes$variable<-"spei_mn"

trendchange_dt<- rbind(pdsi_trend_changes, spei_trend_changes, tas_trend_changes)
saveRDS(trendchange_dt, "trendchange.rds")

#plotting the frequecny maps


ggplot() +
  geom_raster(data = trendchange_dt , aes(x = X, y = Y, fill = `Frequency (%)`)) +
  scale_fill_gradientn(colours =c('#3F52E3', '#F6F6F6','#F12D2D')) +
  borders(colour = 'black', size = 0.8) +
  coord_cartesian(xlim = c(-10,40), ylim = c(30, 45), expand = FALSE) +
  labs(fill = "Relative Frequency (%)", title = "Frequency Maps", x = "Longitude", y = "Latitude") +
  scale_x_continuous(labels = ~ paste0(.x, "°")) +
  scale_y_continuous(labels = ~ paste0(.x, "°")) +
  facet_wrap(~variable, nrow = 3, labeller = labeller(variable = c("pdsi_mn" = "PDSI", "spei_mn" = "SPEI", "tas_mn" = "Temperature"))) +
  theme(panel.background = element_rect(fill = NA), panel.ontop = TRUE,
        axis.ticks.length = unit(0, "cm"),
        panel.grid.major = element_line(colour = "gray60"),
        panel.border = element_rect(size = 1, fill = NA),
        panel.spacing =unit(0.5, "cm"), 
        axis.title = element_blank(),
        axis.text = element_text(size = 24),
        plot.title = element_text(size = 24, hjust = 0.5),
        legend.text = element_text(size = 20),
        legend.key.width  = unit(4, "cm"),
        legend.key.height = unit(1, "cm"),
        legend.title = element_text(size = 20),
        legend.position = 'bottom',
        strip.background = element_rect(fill = NA), 
        strip.text = element_text(size = 24, face = "bold"))

ggsave("Frequncy_maps.png", dpi = 600, height = 3*15, width = 50, units = "cm")

