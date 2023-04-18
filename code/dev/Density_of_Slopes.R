
library(viridis)

# Generate a color palette with 33 colors using the "viridis" color map
my_colors <- viridis(33)

# Display the color palette
plot(1:33, col = my_colors, pch = 16, cex = 3)

source("code/source/global_variables.R")
source("code/source/functions.R")
slope_dt<- readRDS("slope_pdsi_spei_tas_1000-2000.rds")
slope_dt <- slope_dt[!(timestep =="1990-2020"), ]
#plot density 
ggplot(slope_dt, aes(slope, fill = timestep)) +
  geom_density(alpha = 0.5) +
  labs(x= "Slope", y="Density")+
  scale_fill_viridis(discrete = TRUE)+
  scale_alpha_manual(values = c(0, rep(0.5, 33))) +
  facet_wrap(~variable, scales = "free", 
             labeller = labeller(variable = c("pdsi_mn" = "PDSI", 
                                              "spei_mn" = "SPEI", 
                                              "tas_mn" = "Temperature"))) +
  theme_bw() +
  theme(
    strip.background = element_rect(fill = NA), 
    strip.text = element_text(size = 16, face = "bold"), 
    axis.title = element_text(size = 16), 
    axis.text = element_text(size = 14, color = "black"))


ggsave("density_test.png",width = 2*8, height = 8 ,dpi = 1000)

  