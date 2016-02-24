# Install ggplot
install.packages("ggplot2")
library("ggplot2")

install.packages("gridExtra")
library("gridExtra")

## EEL POND WITHOUT STREAMING, ANNOTATED ##

# Load space-separated data, rename columns, view

log.data <- read.table("~/benchmarking/nonstreaming/log.out") 
colnames(log.data) <- c("TIME", "CPU","RAM","DISK","5","6","7","8")
#head(log.data)

# Divide RAM column to get from bytes to MB, view

log.data$RAM <- log.data$RAM/1e6
log.data$DISK <- log.data$DISK/1e2
#head(log.data)

# Plot each graph (cpu, ram, disk) separately,
# add annotations by redefining with <name>a, 
# then use grid.arrange to stack <name>a graphs

cpuplot <- ggplot(data=log.data, aes_string(x="TIME", y="CPU")) + 
  geom_line(color = "blue") + xlab("") + ylab("CPU load (100%)") +
  ggtitle("Eel Pond (1-3) Without Streaming 10-23-15") + theme(axis.text.x = 
                                                                 element_blank(), axis.text.y = element_text(size = 13.5, color = "black", 
                                                                                                             face = "bold"), plot.title = element_text(face = "bold", size = 16))

cpuplota <- cpuplot + annotate("text", x = 60, y = 90, label = "QC") +
  annotate("rect", xmin = 40, xmax = 80, ymin = 0, ymax = 100,
           fill = "magenta", alpha = .2) +
  annotate("text", x = 300, y = 60, label = "diginorm") +
  annotate("rect", xmin = 170, xmax = 450, ymin = 0, ymax = 100,
           fill = "purple", alpha = .2) +
  annotate("text", x =  580, y = 30, label = "assembly") +
  annotate("rect", xmin = 450, xmax = 640, ymin = 0, ymax = 100,
           fill = "orange", alpha = .2) + expand_limits(y = 0)

ramplot <- ggplot(data=log.data, aes_string(x="TIME", y="RAM")) + 
  geom_line(color = "red") + xlab("") + ylab("RAM (GB)") +
  theme(axis.text.x = element_blank(), axis.text.y = element_text(
    size = 13.5, color = "black", face = "bold"))

ramplota <- ramplot  +
  annotate("rect", xmin = 40, xmax = 80, ymin = 0, ymax = 15,
           fill = "magenta", alpha = .2) +
  annotate("rect", xmin = 170, xmax = 450, ymin = 0, ymax = 15,
           fill = "purple", alpha = .2) +
  annotate("rect", xmin = 450, xmax = 640, ymin = 0, ymax = 15,
           fill = "orange", alpha = .2) + expand_limits(y = 0)

diskplot <- ggplot(data=log.data, aes_string(x="TIME", y="DISK")) + 
  geom_line(color = "green") + xlab("Time (seconds)") + ylab("Disk (kTPS)") +
  theme(axis.text.x = element_text(size = 16, color = "black", 
                                   face = "bold"), axis.text.y = element_text(size = 13.5, 
                                                                              color = "black", face = "bold"))

diskplota <- diskplot + 
  annotate("rect", xmin = 40, xmax = 80, ymin = 0, ymax = 20,
           fill = "magenta", alpha = .2) +
  annotate("rect", xmin = 170, xmax = 450, ymin = 0, ymax = 20,
           fill = "purple", alpha = .2) +
  annotate("rect", xmin = 450, xmax = 640, ymin = 0, ymax = 20,
           fill = "orange", alpha = .2) + expand_limits(y = 0)

#grid.arrange(cpuplot,ramplot,diskplot)
grid.arrange(cpuplota,ramplota,diskplota)

