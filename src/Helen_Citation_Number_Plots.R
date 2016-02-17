install.packages("data.table")        
library(data.table)                   

citationData <- read.csv("/Users/helenliu/Documents/Patent Capstone/Motorola_Patent_Citations-master/data/Patents_Citing_Motorola_1114.csv", header = TRUE, stringsAsFactors = FALSE)
citationData = citationData[-c(1)]
counts=table(citationData$Motorola_Patents_Being_Cited)

t = as.data.frame(counts)
names(t)[1] = 'patentID'
names(t)[2] = 'freq'

avgcited <- mean(t$freq,na.rm = FALSE)
standarddeviation <- sd(t$freq, na.rm = FALSE)
quantile(t$freq, c(.25, .50, .75, .80, .85, .90, .95)) 
-quantile(-t$freq, c(.05)) 

t1 <- t[t$freq > 50,]
t2 <- t1[order(-t1$freq), ]

par(mar = rep(2, 4))
barplot(t2$freq,main="No. of Citation per Patent(Cited freq>50)",xlab="Patent ID", col=c("darkblue"),legend = rownames(t2$patentID))
boxplot(t$freq,data=t$freq, main="No. of Citation per Patent", ylab="No Patents Blocked",col=c("gold"))
qqnorm(t$freq, main = "Normal Q-Q Plot", xlab = "Theoretical Quantiles",ylab = "Sample Quantiles", plot.it = TRUE, datax = FALSE)


