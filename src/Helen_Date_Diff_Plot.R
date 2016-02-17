dateData <- read.csv("/Users/helenliu/Documents/Patent Capstone/Motorola_Patent_Citations-master/data/Patents_Citing_Motorola_1114.csv", header = TRUE, stringsAsFactors = FALSE)
dateData = dateData[-c(1:2)]

dateData$diff_in_days<- difftime(dateData$Date_Citing_Patent ,dateData$Date_Motorola_Patent , units = c("days"))

avgtime <- mean(dateData$diff_in_days,na.rm = FALSE)

dateData1 <- dateData[dateData$diff_in_days > 4000,]
dateData2 <- dateData1[order(-dateData1$diff_in_days), ]

par(mar = rep(2, 4))
barplot(dateData2$diff_in_days,main="Date Difference (Date Diff>4000)",xlab="Patent ID", col=c("darkblue"))

