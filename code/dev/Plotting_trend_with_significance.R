
#calculating significant change in trend based on percentiles
source("code/source/global_variables.R")
source("code/source/functions.R")

dt<- readRDS("slope_with_significance_dt.rds")
dt[is.na(sig_positive_slope) & is.na(sig_negative_slope), 
   sig := "insig"][is.na(sig), sig := "sig"]

dt_final <-dt[, c("X", "Y", "variable","slope", "timestep", "sig")]
dt_final[ ,Trend:=sign(slope)]


source("code/source/global_variables.R")
source("code/source/functions.R")


ggplot() +
  geom_raster(data = dt_final[variable=="pdsi_mn"], aes(X, Y, fill = as.factor(Trend)))+
  geom_point(data = dt_final[variable=="pdsi_mn" &Trend>0 & sig=="sig"], aes(X, Y, color="darkblue"), size=0.1)+
  geom_point(data = dt_final[variable=="pdsi_mn" &Trend<0 & sig=="sig"], aes(X, Y,  color="darkred"),size=0.1)+
  scale_fill_manual(values = c("tomato", "steelblue"), 
                    labels = c("Trend (+)", "Trend (-)")) +
  scale_color_manual(values = c("darkblue", "darkred"), 
                     labels = c("Significant trend (+)","significant trend (-)")) +
  scale_x_continuous(breaks = seq(-20, 30, 10)) +
  scale_y_continuous(breaks = seq(30, 70, 10)) +
  facet_wrap(~timestep, nrow = 5, strip.position = "top")+
  labs(x = "Longitude", y = "Latitude") +
  guides(fill = guide_legend(title = "")) +
  guides(color = guide_legend(override.aes = list(size = 5), title = "")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_blank(),
        strip.text = element_text(size = 10, face = "bold"),
        axis.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10, angle = 0),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.1, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,10,0)))



ggplot() +
  geom_raster(data = dt_final[variable=="spei_mn"], aes(X, Y, fill = as.factor(Trend)))+
  geom_point(data = dt_final[variable=="spei_mn" &Trend>0 & sig=="sig"], aes(X, Y, color="darkblue"), size=0.1)+
  geom_point(data = dt_final[variable=="spei_mn" &Trend<0 & sig=="sig"], aes(X, Y,  color="darkred"),size=0.1)+
  scale_fill_manual(values = c("tomato", "steelblue"), 
                    labels = c("Trend (+)", "Trend (-)")) +
  scale_color_manual(values = c("darkblue", "darkred"), 
                     labels = c("Significant trend (+)","significant trend (-)")) +
  scale_x_continuous(breaks = seq(-20, 30, 10)) +
  scale_y_continuous(breaks = seq(30, 70, 10)) +
  facet_wrap(~timestep, nrow = 6, strip.position = "top")+
  labs(x = "Longitude", y = "Latitude") +
  guides(fill = guide_legend(title = "")) +
  guides(color = guide_legend(override.aes = list(size = 5), title = "")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_blank(),
        strip.text = element_text(size = 10, face = "bold"),
        axis.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10, angle = 0),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.1, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,10,0)))



ggplot() +
  geom_raster(data = dt_final[variable=="tas_mn"], aes(X, Y, fill = as.factor(Trend)))+
  geom_point(data = dt_final[variable=="tas_mn" &Trend>0 & sig=="sig"], aes(X, Y, color="darkblue"), size=0.1)+
  geom_point(data = dt_final[variable=="tas_mn" &Trend<0 & sig=="sig"], aes(X, Y,  color="darkred"),size=0.1)+
  scale_fill_manual(values = c("tomato", "steelblue"), 
                    labels = c("Trend (+)", "Trend (-)")) +
  scale_color_manual(values = c("darkblue", "darkred"), 
                     labels = c("Significant trend (+)","significant trend (-)")) +
  scale_x_continuous(breaks = seq(-20, 30, 10)) +
  scale_y_continuous(breaks = seq(30, 70, 10)) +
  facet_wrap(~timestep, nrow = 6, strip.position = "top")+
  labs(x = "Longitude", y = "Latitude") +
  guides(fill = guide_legend(title = "")) +
  guides(color = guide_legend(override.aes = list(size = 5), title = "")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_blank(),
        strip.text = element_text(size = 10, face = "bold"),
        axis.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10, angle = 0),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.1, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,10,0)))
