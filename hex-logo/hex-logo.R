library(tidyverse)
library(hexSticker)
library(magick)
library(png)
library(sp)
library(grid)
library(here)
library(showtext)


## Loading Google fonts (http://www.google.com/fonts)
font_add_google("News Cycle", "news")
## Automatically use showtext to render text for future devices
showtext_auto()


l <- 1
hex <- tibble(
  x = 1.35 * l * c(-sqrt(3) / 2, 0, rep(sqrt(3) / 2, 2), 0, rep(-sqrt(3) / 2, 2)),
  y = 1.35 * l * c(0.5, 1, 0.5, -0.5, -1, -0.5, 0.5)
)

theme_hex <- theme_void() + theme_transparent() +
  theme(axis.ticks.length = unit(0, "mm"))

img <- readPNG("hex-logo/cosmo.png")
g <- rasterGrob(img, interpolate=TRUE)

# Create empty hexagon
logo <- ggplot() +
  geom_polygon(data = hex, aes(x, y), color = "#002e5d", fill = "white",
    size = 2) +
  annotate(geom = "text", label = "cosmodown", x = 0, y = -0.55,
    family = "news", color = "#002e5d", fontface = "bold", size = 6) +
  annotation_custom(g, xmin = -1.1, xmax = 1.1, ymin = -0.5, ymax = 0.9) +
  coord_equal(xlim = range(hex$x), ylim = range(hex$y)) +
  scale_x_continuous(expand = c(0.04, 0)) +
  scale_y_continuous(expand = c(0.04, 0)) +
  theme_hex

png("man/figures/cosmodown.png", width = 181, height = 210, bg = "transparent")
print(logo)
dev.off()

logo_large <- ggplot() +
  geom_polygon(data = hex, aes(x, y), color = "#002e5d", fill = "white",
    size = 10) +
  annotate(geom = "text", label = "cosmodown", x = 0, y = -0.55,
    family = "news", color = "#002e5d", fontface = "bold", size = 30) +
  annotation_custom(g, xmin = -1.1, xmax = 1.1, ymin = -0.5, ymax = 0.9) +
  coord_equal(xlim = range(hex$x), ylim = range(hex$y)) +
  scale_x_continuous(expand = c(0.04, 0)) +
  scale_y_continuous(expand = c(0.04, 0)) +
  theme_hex

png("man/figures/cosmodown-large.png", width = 905, height = 1050, bg = "transparent")
print(logo_large)
dev.off()


img <- image_read(here("man", "figures", "cosmodown-large.png")) %>%
  image_trim()

image_blank(32, 32, "hotpink") %>%
  image_composite(image_scale(img, "x32"), offset = "+2+0") %>%
  image_transparent("hotpink", fuzz = 15) %>%
  image_write(here("inst", "examples", "figures", "favicon.png"))

