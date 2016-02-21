install.packages("ggplot2")
library("ggplot2")

install.packages("gridExtra")
library("gridExtra")

install.packages("gtable")
library("gtable")

## CPU Comp on one graph ##

# Load both logs, name columns specifying streaming or non, correct CPU

log.data.nonstream <- read.table("~/benchmarking/nonstreaming/log.out") 
colnames(log.data.nonstream) <- c("TIMEns", "CPUns","RAMns","DISKns","5","6","7","8")

log.data.stream <- read.table("~/benchmarking/streaming/raw-ouput/10-27-15/log.out") 
colnames(log.data.stream) <- c("TIMEs", "CPUs","RAMs","DISKs","5","6","7","8")

# Create plots, then have <plot>.x to force both plots to have same 
# x axis and force y axis to start at 0

plot(log.data.nonstream$TIMEns, log.data.nonstream$CPUns,
                    type = "l")
par(mar=c(4, 4, 4, 2) + 0.3)
lines(log.data.stream$TIMEs, log.data.stream$CPUs,
      xlab = "", ylab = "", col = "red",
      main = "Streaming vs Nonstreaming CPU Comparison")
axis(side = 3, col = "red", labels = TRUE, at = axTicks(3))
title(main = "Streaming vs Nonstreaming CPU Comparison")

?plot