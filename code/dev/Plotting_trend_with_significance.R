
#calculating significant change in trend based on percentiles
source("code/source/global_variables.R")
source("code/source/functions.R")

dt<- readRDS("slope_with_significance_dt.rds")
dt <- dt[!(timestep =="1990-2020"), ]
dt[is.na(sig_positive_slope) & is.na(sig_negative_slope), 
   sig := "insig"][is.na(sig), sig := "sig"]

dt_final <-dt[, c("X", "Y", "variable","slope", "timestep", "sig")]
dt_final[ ,Trend:=sign(slope)]

p_01<- ggplot() +
  geom_raster(data = dt_final[variable=="pdsi_mn"], aes(X, Y, fill = as.factor(Trend)), alpha = 0.5)+
  geom_point(data = dt_final[variable=="pdsi_mn" &Trend>0 & sig=="sig"], aes(X, Y, color="darkblue"), size=0.5)+
  geom_point(data = dt_final[variable=="pdsi_mn" &Trend<0 & sig=="sig"], aes(X, Y,  color="darkred"),size=0.5)+
  scale_fill_manual(values = c("tomato", "steelblue"), 
                    labels = c("Trend (-)", "Trend (+)"), guide = guide_legend(alpha = 0)) +
  scale_color_manual(values = c("darkblue", "darkred"), 
                     labels = c("Significant trend (+)","significant trend (-)")) +
  borders(colour = 'black', size = 0.2) +
  coord_cartesian(xlim = c(-5,40), ylim = c(30, 45), expand = FALSE) +
  scale_x_continuous(labels = ~ paste0(.x, "°")) +
  scale_y_continuous(labels = ~ paste0(.x, "°")) +
  facet_wrap(~timestep, ncol  = 5, strip.position = "top")+
  guides(fill = guide_legend(title = "", override.aes = list(alpha = 0.5, size = 5))) +
  guides(color = guide_legend(override.aes = list(size = 5), title = "")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_rect(fill = "white", size = 0.5),
        strip.text = element_text(size = 14, face = "bold"),
        axis.title = element_blank(),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14, angle = 0),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.5, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,1,0)))
ggsave("PDSI_TREND.png", height = 2*7, width = 5*5, units = "cm", dpi = 1000)

ggsave("pdsi_trend")

p_02<- ggplot() +
  geom_raster(data = dt_final[variable=="spei_mn"], aes(X, Y, fill = as.factor(Trend)), alpha = 0.5)+
  geom_point(data = dt_final[variable=="spei_mn" &Trend>0 & sig=="sig"], aes(X, Y, color="darkblue"), size=0.5)+
  geom_point(data = dt_final[variable=="spei_mn" &Trend<0 & sig=="sig"], aes(X, Y,  color="darkred"),size=0.5)+
  scale_fill_manual(values = c("tomato", "steelblue"), 
                    labels = c("Trend (-)", "Trend (+)"), guide = guide_legend(alpha = 0)) +
  scale_color_manual(values = c("darkblue", "darkred"), 
                     labels = c("Significant trend (+)","significant trend (-)")) +
  borders(colour = 'black', size = 0.2) +
  coord_cartesian(xlim = c(-5,40), ylim = c(30, 45), expand = FALSE) +
  scale_x_continuous(labels = ~ paste0(.x, "°")) +
  scale_y_continuous(labels = ~ paste0(.x, "°")) +
  facet_wrap(~timestep, ncol  = 5, strip.position = "top")+
  guides(fill = guide_legend(title = "", override.aes = list(alpha = 0.5, size = 5))) +
  guides(color = guide_legend(override.aes = list(size = 5), title = "")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_rect(fill = "white", size = 0.5),
        strip.text = element_text(size = 14, face = "bold"),
        axis.title = element_blank(),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14, angle = 0),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.5, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,1,0)))
ggsave("SPEI_TREND.png", height = 2*7, width = 5*5, units = "cm", dpi = 1000)


p_03<- ggplot() +
  geom_raster(data = dt_final[variable=="tas_mn"], aes(X, Y, fill = as.factor(Trend)), alpha = 0.5)+
  geom_point(data = dt_final[variable=="tas_mn" &Trend>0 & sig=="sig"], aes(X, Y, color="darkblue"), size=0.5)+
  geom_point(data = dt_final[variable=="tas_mn" &Trend<0 & sig=="sig"], aes(X, Y,  color="darkred"),size=0.5)+
  scale_fill_manual(values = c("tomato", "steelblue"), 
                    labels = c("Trend (-)", "Trend (+)"), guide = guide_legend(alpha = 0)) +
  scale_color_manual(values = c("darkblue", "darkred"), 
                     labels = c("Significant trend (+)","significant trend (-)")) +
  borders(colour = 'black', size = 0.2) +
  coord_cartesian(xlim = c(-5,40), ylim = c(30, 45), expand = FALSE) +
  scale_x_continuous(labels = ~ paste0(.x, "°")) +
  scale_y_continuous(labels = ~ paste0(.x, "°")) +
  facet_wrap(~timestep, ncol  = 5, strip.position = "top")+
  guides(fill = guide_legend(title = "", override.aes = list(alpha = 0.5, size = 5))) +
  guides(color = guide_legend(override.aes = list(size = 5), title = "")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_rect(fill = "white", size = 0.5),
        strip.text = element_text(size = 14, face = "bold"),
        axis.title = element_blank(),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 14, angle = 0),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.5, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,1,0)))
ggsave("Temperature_TREND.png", height = 2*7, width = 5*5, units = "cm", dpi = 1000)