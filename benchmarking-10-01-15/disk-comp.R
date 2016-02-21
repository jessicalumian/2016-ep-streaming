install.packages("ggplot2")
library("ggplot2")

install.packages("gridExtra")
library("gridExtra")


## Comparing DISK streaming vs nonstreaming ##

# Load both logs, name columns specifying streaming or non, correct disk

log.data.nonstream <- read.table("~/benchmarking/nonstreaming/log.out") 
colnames(log.data.nonstream) <- c("TIMEns", "CPUns","RAMns","DISKns","5","6","7","8")
log.data.nonstream$DISKns <- log.data.nonstream$DISKns/1e2

log.data.stream <- read.table("~/benchmarking/streaming/raw-ouput/10-27-15/log.out") 
colnames(log.data.stream) <- c("TIMEs", "CPUs","RAMs","DISKs","5","6","7","8")
log.data.stream$DISKs <- log.data.stream$DISKs/1e2

# Create plots, then have <plot>.x to force both plots to have same 
# x axis and force y axis to start at 0

diskplot.stream <- ggplot(data=log.data.stream, aes_string(x="TIMEs", y="DISKs")) + 
  geom_line(color = "green") + xlab("") + ylab("Streaming") +
  ggtitle("Eel Pond (1-3) Disk Streaming vs Nonstreaming") + theme(axis.text.x = 
                                                                     element_blank(), axis.text.y = element_text(size = 16, color = "black", 
                                                                                                                 face = "bold"), plot.title = element_text(face = "bold", size = 13.5))

diskplot.streamx <-  diskplot.stream + xlim(0, 650) + expand_limits(y = 0)

diskplot.nonstream <- ggplot(data=log.data.nonstream, aes_string(x="TIMEns", y="DISKns")) + 
  geom_line(color = "green") + xlab("Time (seconds)") + ylab("Nonstreaming") +
  theme(axis.text.y = element_text(size = 16, color = "black", face = "bold"),
        axis.text.x = element_text(size = 16, color = "black", 
                                   face = "bold"))

diskplot.nonstreamx <- diskplot.nonstream + xlim(0, 650) + expand_limits(y = 0)

# grid.arrange to stack graphs, textGrob for common y axis label

grid.arrange(diskplot.streamx, diskplot.nonstreamx,
             left = textGrob("Disk (kTPS)", rot = 90, vjust = 1, 
                             gp = gpar(fontface = "bold")))

