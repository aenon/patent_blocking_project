setwd("/Users/marie-camilleachard/Documents/4. Capstone/")

M_ids_count=read.csv(file = "4. Results in csv/Count_motorola_blocking_patents.csv", header = FALSE, col.names=c("Patent number","Count"))
M_ids=read.csv(file = "4. Results in csv/Motorola_blocking_patents.csv", header= TRUE)

M_ids_count$Order[1]=1
M_ids_count$Cumulative[1]=M_ids_count$Count[1]

for (i in 2:nrow(M_ids_count)){
  M_ids_count$Order[i]=i
  M_ids_count$Cumulative[i]=M_ids_count$Count[i]+M_ids_count$Cumulative[i-1]
}

# Graph to represent the number of apps each Motorola patent blocked
barplot(M_ids_count$Count, names.arg=M_ids_count$Order , main="Nb of apps blocked per patent", xlab="Motorola patents")

# Graph to represent the cumulative distribution
plot( M_ids_count$Order, M_ids_count$Cumulative, pch='.', xlab = 'Number of Motorola patents', ylab = 'Number of apps blocked', main = 'Empirical Cumluative Distribution')

##### M_ids_count.ecdf = ecdf(M_ids_count$Order)
##### plot(M_ids_count.ecdf, xlab = 'Motorola patents', ylab = '', main = 'Empirical Cumluative Distribution\nApps blocked by Motorola patents',pch=".")

# Boxplot graph
boxplot(M_ids_count$Count, main= "Boxplot representation\n Nb of apps blocked per Motorola patent", col="gold", pch=".")




