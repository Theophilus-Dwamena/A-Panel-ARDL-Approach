###Packages
library(readr)
library(ggplot2)
library(corrplot)
library(gridExtra)
library(plm)

###Import Data
indicators <- read_csv("GitHub/A-Panel-ARDL-Approach/indicators.csv")

###Declare data as panel
paneldata <- pdata.frame(indicators, index = c("Country", "Time"))

### Correlation Analysis
# Calculate correlation matrix
cor_matrix <- cor(paneldata[, c("lGDPC", "lCO2", "lFP", "lAVA", "lPGR")], 
                  use = "complete.obs")
# Plot correlation matrix
corrplot(cor_matrix, method = "color", 
         col = colorRampPalette(c("red", "white", "blue"))(200), 
         addCoef.col = "black", tl.col = "black", tl.srt = 50, 
         title = "Correlation Matrix for Indicator (Variables)", 
         mar = c(0, 0, 1, 0))

ggplot(indicators, aes(x = Time, y = lGDPC, color = Country)) +
  geom_point() +
  geom_line() +  # Add lines to connect points for better visualization
  labs(
    title = "Country Specific GDP Growth over Time", 
    x = "Year", 
    y = "Log GDP"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 15),
    legend.title = element_text(size = 15),
    legend.text = element_text(size = 11),
    legend.position = "right"  # Keep the legend readable
  )

### Indicators vs GDP Growth
plots_indicators <- lapply(c("lCO2", "lFP", "lAVA", "lPGR"), function(x) {
  ggplot(paneldata, aes_string(x = x, y = "lGDPC")) +
    geom_point(colour = 'red') + ggtitle(paste0(x, " Vs GDP")) +
    xlab(x) + ylab("GDP")
})
do.call(grid.arrange, c(plots_indicators, ncol = 2))

library(gplots)
### Heterogeneity
# Across Countries
plotmeans(lGDPC ~ Country, main = "Heterogeineity across countries", 
          data = paneldata)
# Across Years
plotmeans(lGDPC ~ Time, main = "Heterogeineity across years", data = paneldata)

