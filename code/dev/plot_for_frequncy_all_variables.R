library(ggplot2)
library(cowplot)

# create the plots
pdsi_plot <- ggplot(data = pdsi_trend_changes, aes(X, Y)) +
  geom_tile(aes(fill = `Frequency (%)`, color = `Frequency (%)`)) +
  scale_fill_gradient2(low = "#00204C", midpoint = 50, mid = "gray", high = "#FFA500") +
  scale_color_gradient2(low = "#00204C", midpoint = 50, mid = "gray", high = "#FFA500") +
  scale_x_continuous(breaks = seq(-20, 30, 10), name = "Longitude") +
  scale_y_continuous(breaks = seq(30, 70, 10), name = "Latitude") +
  ggtitle("PDSI")

spei_plot <- ggplot(data = spei_trend_changes, aes(X, Y)) +
  geom_tile(aes(fill = `Frequency (%)`, color = `Frequency (%)`)) +
  scale_fill_gradient2(low = "#00204C", midpoint = 50, mid = "gray", high = "#FFA500") +
  scale_color_gradient2(low = "#00204C", midpoint = 50, mid = "gray", high = "#FFA500") +
  scale_x_continuous(breaks = seq(-20, 30, 10), name = "Longitude") +
  scale_y_continuous(breaks = seq(30, 70, 10), name = "Latitude") +
  ggtitle("SPEI")

temp_plot <- ggplot(data = tas_trend_changes, aes(X, Y)) +
  geom_tile(aes(fill = `Frequency (%)`, color = `Frequency (%)`)) +
  scale_fill_gradient2(low = "#00204C", midpoint = 50, mid = "gray", high = "#FFA500") +
  scale_color_gradient2(low = "#00204C", midpoint = 50, mid = "gray", high = "#FFA500") +
  scale_x_continuous(breaks = seq(-20, 30, 10), name = "Longitude") +
  scale_y_continuous(breaks = seq(30, 70, 10), name = "Latitude") +
  ggtitle("Temperature")

# arrange the plots in a single panel with three rows
plot_grid(plotlist = list(pdsi_plot, spei_plot, temp_plot),
          ncol = 1, nrow = 3, align = "vh", axis = "tb",
          labels = c("A", "B", "C"),
          label_size = 16)


# create a custom theme with white background
my_theme <- theme_bw() + theme(plot.background = element_rect(fill = "white"))

# update the plots with the custom theme
pdsi_plot + my_theme
spei_plot + my_theme
temp_plot + my_theme

# arrange the updated plots in a single panel with three rows
plot_grid(plotlist = list(pdsi_plot + my_theme, spei_plot + my_theme, temp_plot + my_theme),
          ncol = 1, nrow = 3, align = "vh", axis = "tb",
          labels = c("A", "B", "C"),
          label_size = 16)



ggsave(paste0(PATH_OUTFILES,"Frequency_plots.png"), 
       width = 12, height = 8)

