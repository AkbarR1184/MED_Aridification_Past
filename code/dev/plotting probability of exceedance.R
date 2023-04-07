#load data for plotting probability of exceedance

prob<-readRDS("Probability_Of_Exceedance_dt.rds")
prob[,Interval:=paste0(StartYear,"-", EndYear)]
prob[,c("StartYear", "EndYear")]=NULL


#Plotting probability of exceedance for PDSI

ggplot() +
  geom_point(data = prob[Slope<0 & Variable=="pdsi_mn"], aes(X, Y, color = `Probability of Exceedance`), size=0.25)+ 
  geom_tile(data = prob[Slope>0 & Variable=="pdsi_mn"], aes(X, Y, fill = `Probability of Exceedance`))+
  scale_color_gradientn(colors = c("#33a02c", "#fb9a99", "#e31a1c"), 
                        na.value = "#cccccc", name="Probability of Exceedance (Trend-)", guide=guide_colorbar(title.position = "right"))+
  scale_fill_gradientn(colors = c("#a6cee3", "#1f78b4"), na.value = "#cccccc", name="Probability of Exceedance (Trend+)", guide=guide_colorbar(title.position = "right"))+
  scale_x_continuous(breaks = seq(-20, 30, 10)) +
  scale_y_continuous(breaks = seq(30, 70, 10)) +
  facet_wrap(~Interval, nrow = 6, strip.position = "top")+
  labs(x = "Longitude", y = "Latitude") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_blank(),
        strip.text = element_text(size = 10, face = "bold"),
        axis.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10, angle = 90),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.1, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,10,0)))


ggsave("pdsi_probability_of_exceedance.png", width = 12, height = 8)

#Plotting probability of exceedance for SPEI

ggplot() +
  geom_point(data = prob[Slope<0 & Variable=="spei_mn"], aes(X, Y, color = `Probability of Exceedance`), size=0.25)+ 
  geom_tile(data = prob[Slope>0 & Variable=="spei_mn"], aes(X, Y, fill = `Probability of Exceedance`))+
  scale_color_gradientn(colors = c("#33a02c", "#fb9a99", "#e31a1c"), 
                        na.value = "#cccccc", name="Probability of Exceedance (Trend-)", guide=guide_colorbar(title.position = "right"))+
  scale_fill_gradientn(colors = c("#a6cee3", "#1f78b4"), na.value = "#cccccc", name="Probability of Exceedance (Trend+)", guide=guide_colorbar(title.position = "right"))+
  scale_x_continuous(breaks = seq(-20, 30, 10)) +
  scale_y_continuous(breaks = seq(30, 70, 10)) +
  facet_wrap(~Interval, nrow = 6, strip.position = "top")+
  labs(x = "Longitude", y = "Latitude") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_blank(),
        strip.text = element_text(size = 10, face = "bold"),
        axis.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10, angle = 90),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.1, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,10,0)))

ggsave("spei_probability_of_exceedance.png", width = 12, height = 8)


#Plotting probability of exceedance for tas

ggplot() +
  geom_point(data = prob[Slope<0 & Variable=="tas_mn"], aes(X, Y, color = `Probability of Exceedance`), size=0.25)+ 
  geom_tile(data = prob[Slope>0 & Variable=="tas_mn"], aes(X, Y, fill = `Probability of Exceedance`))+
  scale_color_gradientn(colors = c("#33a02c", "#fb9a99", "#e31a1c"), 
                        na.value = "#cccccc", name="Probability of Exceedance (Trend-)", guide=guide_colorbar(title.position = "right"))+
  scale_fill_gradientn(colors = c("#a6cee3", "#1f78b4"), na.value = "#cccccc", name="Probability of Exceedance (Trend+)", guide=guide_colorbar(title.position = "right"))+
  scale_x_continuous(breaks = seq(-20, 30, 10)) +
  scale_y_continuous(breaks = seq(30, 70, 10)) +
  facet_wrap(~Interval, nrow = 6, strip.position = "top")+
  labs(x = "Longitude", y = "Latitude") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        axis.ticks = element_line(),
        strip.background = element_blank(),
        strip.text = element_text(size = 10, face = "bold"),
        axis.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10, angle = 90),
        legend.key.size = unit(1.2, "lines"),
        legend.box.spacing = unit(0.2, "lines"),
        legend.background = element_rect(fill = "transparent"),
        panel.spacing = unit(0.1, "lines"),
        panel.border = element_rect(fill = NA, color = "black"),
        strip.placement = "outside",
        strip.text.x = element_text(size = 10, margin = margin(0,0,10,0)))


ggsave("tas_probability_of_exceedance.png", width = 12, height = 8)
