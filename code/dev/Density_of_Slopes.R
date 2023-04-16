
library(viridis)

# Generate a color palette with 33 colors using the "viridis" color map
my_colors <- viridis(33)

# Display the color palette
plot(1:33, col = my_colors, pch = 16, cex = 3)

#plot density 
ggplot(slope_dt, aes(slope, fill = timestep)) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = my_colors) +
  scale_alpha_manual(values = c(0, rep(0.5, 33))) +
  facet_wrap(~variable, scales = "free", 
             labeller = labeller(Variable = c(pdsi_mn = "PDSI", 
                                              spei_mn = "SPEI", 
                                              tas_mn = "Temperature (Centigrade)"))) +
  theme_bw() +
  theme(
    strip.background = element_rect(fill = NA), 
    strip.text = element_text(size = 10, face = "bold"))
  