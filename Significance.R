library(knitr)
library(rtracklayer)
library(Rsamtools)
library(grid)
library(GenomicAlignments)
library(ggplot2)
library(GGally)
library(edgeR)
library(stringr)
library(EDASeq)
library(dplyr)
library(matrixStats)
library(gridExtra)
library(reshape2)
library(scales)

load("All_wasp.rda")

#Boxplot-Orig.png
#ggparcoord(countTable, columns=1:ncol(countTable), alphaLines=0, boxplot=TRUE, scale="globalminmax") + coord_flip() + scale_y_log10()

myVec = c("DR", "DU", "F", "NR", "NU")
myCol = c(which(colnames(countTable) == grep('DR', colnames(countTable), value=TRUE)), which(colnames(countTable) == grep('DU', colnames(countTable), value=TRUE)))
#scatmat(countTable, columns=1:3, alpha = 0.01) + ggtitle("")

listcond = rep(c("DR","DU","F","NR","NU"),each= 6)
# create DGEList object
d = DGEList(counts=countTable, group=listcond)
# estimate normalization factors
d = calcNormFactors(d)

# MDS plot
plotMDS(d, labels=colnames(countTable), col = c("darkgreen","blue")[factor(listcond)])

# estimate tagwise dispersion
d = estimateCommonDisp(d)
d = estimateTagwiseDisp(d)

#mean-variance of tagwise dispersion
plotMeanVar(d, show.tagwise.vars=TRUE, NBline=TRUE)

#plotBCV
plotBCV(d)

DUDUR = exactTest(d, pair=c("DU","DR"))
