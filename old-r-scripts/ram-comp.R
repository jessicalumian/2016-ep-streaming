## Comparing RAM streaming vs nonstreaming ##

# Load both logs, name columns specifying streaming or non, correct RAM

log.data.nonstream <- read.table("~/benchmarking/nonstreaming/log.out") 
colnames(log.data.nonstream) <- c("TIMEns", "CPUns","RAMns","DISKns","5","6","7","8")
log.data.nonstream$RAMns <- log.data.nonstream$RAMns/1e6

log.data.stream <- read.table("~/benchmarking/streaming/raw-ouput/10-27-15/log.out") 
colnames(log.data.stream) <- c("TIMEs", "CPUs","RAMs","DISKs","5","6","7","8")
log.data.stream$RAMs <- log.data.stream$RAMs/1e6

# Create plots, then have <plot>.x to force both plots to have same 
# x axis and force y axis to start at 0

ramplot.stream <- ggplot(data=log.data.stream, aes_string(x="TIMEs", y="RAMs")) + 
  geom_line(color = "red") + xlab("") + ylab("Streaming RAM") +
  ggtitle("Eel Pond (1-3) RAM Streaming vs Nonstreaming") + theme(axis.text.x = 
                                                                    element_blank(), axis.text.y = element_text(size = 16, color = "black", 
                                                                                                                face = "bold"), plot.title = element_text(face = "bold", size = 13.5))

# Create new plot to fix axis, then another 
# to annotate with text and shading

ramplot.streamx <-  ramplot.stream + xlim(0, 650) + ylim(0, 13)

ramplot.streamax <- ramplot.streamx + annotate("text", x = 50, y = 7, label = "QC") +
  annotate("rect", xmin = 44, xmax = 76, ymin = 0, ymax = 13,
           fill = "magenta", alpha = .2) +
  annotate("text", x = 260, y = 60, label = "diginorm") +
  annotate("rect", xmin = 200, xmax = 320, ymin = 0, ymax = 13,
           fill = "purple", alpha = .2) +
  annotate("text", x =  450, y = 30, label = "assembly") +
  annotate("rect", xmin = 320, xmax = 520, ymin = 0, ymax = 13,
           fill = "orange", alpha = .2) + expand_limits(y = 0)

ramplot.nonstream <- ggplot(data=log.data.nonstream, aes_string(x="TIMEns", y="RAMns")) + 
  geom_line(color = "red") + xlab("Time (seconds)") + ylab("Nonstreaming") +
  theme(axis.text.y = element_text(size = 16, color = "black", face = "bold"),
        axis.text.x = element_text(size = 16, color = "black", 
                                   face = "bold")) 

# Create new plot to fix axis, then another 
# to annotate with text and shading

ramplot.nonstreamx <- ramplot.nonstream + xlim(0, 650) + ylim(0, 13)

ramplot.nonstreamax <- ramplot.nonstreamx + annotate("text", x = 60, y = 7, label = "QC") +
  annotate("rect", xmin = 44, xmax = 76, ymin = 0, ymax = 13,
           fill = "magenta", alpha = .2) +
  annotate("text", x = 370, y = 7, label = "diginorm") +
  annotate("rect", xmin = 260, xmax = 450, ymin = 0, ymax = 13,
           fill = "purple", alpha = .2) +
  annotate("text", x =  590, y = 7, label = "assembly") +
  annotate("rect", xmin = 450, xmax = 640, ymin = 0, ymax = 13,
           fill = "orange", alpha = .2) + expand_limits(y = 0)

# grid.arrange to stack graphs, textGrob for common y axis label

grid.arrange(ramplot.streamax, ramplot.nonstreamax,
             left = textGrob("RAM (GB)", rot = 90, vjust = 1, 
                             gp = gpar(fontface = "bold")))

