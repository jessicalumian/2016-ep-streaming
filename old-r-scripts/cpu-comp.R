## Comparing CPU streaming vs nonstreaming ##

# Load both logs, name columns specifying streaming or non, correct CPU

log.data.nonstream <- read.table("~/benchmarking/nonstreaming/log.out") 
colnames(log.data.nonstream) <- c("TIMEns", "CPUns","RAMns","DISKns","5","6","7","8")

log.data.stream <- read.table("~/benchmarking/streaming/raw-ouput/10-27-15/log.out") 
colnames(log.data.stream) <- c("TIMEs", "CPUs","RAMs","DISKs","5","6","7","8")

# Create plots, then have <plot>.x to force both plots to have same 
# x axis and force y axis to start at 0

cpuplot.stream <- ggplot(data=log.data.stream, aes_string(x="TIMEs", y="CPUs")) + 
  geom_line(color = "blue") + xlab("") + ylab("Streaming") +
  ggtitle("Eel Pond (1-3) CPU Load Streaming vs Nonstreaming") + theme(axis.text.x = 
                                                                         element_blank(), axis.text.y = element_text(size = 16, color = "black", 
                                                                                                                     face = "bold"), plot.title = element_text(face = "bold", size = 13.5))

# Create new plot to fix axis, then another 
# to annotate with text and shading

cpuplot.streamx <-  cpuplot.stream + xlim(0, 650)

cpuplot.streamax <- cpuplot.streamx + annotate("text", x = 60, y = 90, label = "QC") +
  annotate("rect", xmin = 44, xmax = 76, ymin = 0, ymax = 100,
           fill = "magenta", alpha = .2) +
  annotate("text", x = 260, y = 60, label = "diginorm") +
  annotate("rect", xmin = 200, xmax = 320, ymin = 0, ymax = 100,
           fill = "purple", alpha = .2) +
  annotate("text", x =  550, y = 30, label = "assembly") +
  annotate("rect", xmin = 320, xmax = 520, ymin = 0, ymax = 100,
           fill = "orange", alpha = .2) + expand_limits(y = 0)

cpuplot.nonstream <- ggplot(data=log.data.nonstream, aes_string(x="TIMEns", y="CPUns")) + 
  geom_line(color = "blue") + xlab("Time (seconds)") + ylab("Nonstreaming") +
  theme(axis.text.y = element_text(size = 16, color = "black", face = "bold"),
        axis.text.x = element_text(size = 16, color = "black", 
                                   face = "bold")) 

cpuplot.nonstreamx <- cpuplot.nonstream + xlim(0, 650)

cpuplot.nonstreamax <- cpuplot.nonstreamx + annotate("text", x = 60, y = 90, label = "QC") +
  annotate("rect", xmin = 44, xmax = 76, ymin = 0, ymax = 100,
           fill = "magenta", alpha = .2) +
  annotate("text", x = 370, y = 60, label = "diginorm") +
  annotate("rect", xmin = 260, xmax = 450, ymin = 0, ymax = 100,
           fill = "purple", alpha = .2) +
  annotate("text", x =  590, y = 30, label = "assembly") +
  annotate("rect", xmin = 450, xmax = 640, ymin = 0, ymax = 100,
           fill = "orange", alpha = .2) + expand_limits(y = 0)

# grid.arrange to stack graphs, textGrob for common y axis label

grid.arrange(cpuplot.streamax, cpuplot.nonstreamax,
             left = textGrob("CPU (100%)", rot = 90, vjust = 1, 
                             gp = gpar(fontface = "bold")))
