library(ggplot2)
library(gridExtra)

pdf("plots.pdf", onefile = TRUE)
cuts <- unique(diamonds$cut)
for(i in 1:length(cuts)){
  dat <- subset(diamonds, cut==cuts[i])
  top.plot <- ggplot(dat, aes(price,table)) + geom_point()
  bottom.plot <- ggplot(dat, aes(price,depth)) + geom_point()
  top2.plot <- ggplot(dat, aes(price,table)) + geom_point()
  bottom2.plot <- ggplot(dat, aes(price,depth)) + geom_point()
  grid.arrange(top.plot, bottom.plot, top2.plot, bottom2.plot)
}
dev.off()
