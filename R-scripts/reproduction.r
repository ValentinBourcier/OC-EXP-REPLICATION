setwd(".")
library(effectsize)

source("R-scripts/utils.R")


raw_data <- read.csv("data/data.csv")
columns <- names(raw_data)
controls <- raw_data[, 2:18]
treatements <- raw_data[, 19:35]
experiment_feedback <- raw_data[, 36:51]
demographic_data <- raw_data[, 52:59]

valid_controls <- controls[controls$control.task.validity == "true",]

ammolite_controls <- valid_controls[valid_controls$control.task.name == "Ammolite", ] 
lightsout_controls <- valid_controls[valid_controls$control.task.name == "Lights Out", ]

valid_treatments <- treatements[treatements$treatment.task.validity == "true", ]
ammolite_treatments <- valid_treatments[valid_treatments$treatment.task.name == "Ammolite", ] 
lightsout_treatments <- valid_treatments[valid_treatments$treatment.task.name == "Lights Out", ]

ammolite_stats <- stats_task("Ammolite", ammolite_controls, ammolite_treatments)
lightsout_stats <- stats_task("Lights Out", lightsout_controls, lightsout_treatments)

col <- ammolite_treatments$tt.task.easiness
table <- as.data.frame(table(col))
print(table)

h <- hist(table$Freq, plot = FALSE)

plot(h, xaxt = "n", xlab = "Easiness", ylab = "Counts", main = "", col=rgb(1,0,0,0.5))
axis(1, table$col, labels = table$col, tick = FALSE)

d <- aggregate(table$Freq, by=list(table$col), FUN=sum)
#d <- d[order(d$x, decreasing = T),]
t <- d$x
names(t) <- d$spray

barplot(t, las = 1, space = 0, col = "pink", xlab = "Easiness", ylab = "Count")

#Create data
#set.seed(1)
#Ixos=rnorm(4000 , 120 , 30)     
#Primadur=rnorm(4000 , 200 , 30) 
 
# First distribution
#hist(Ixos, breaks=30, xlim=c(0,300), col=rgb(1,0,0,0.5), xlab="height", 
     #ylab="nbr of plants", main="distribution of height of 2 durum wheat varieties" )

# Second with add=T to plot on top
#hist(Primadur, breaks=30, xlim=c(0,300), col=rgb(0,0,1,0.5), add=T)

# Add legend
#legend("topright", legend=c("Ixos","Primadur"), col=c(rgb(1,0,0,0.5), 
     #rgb(0,0,1,0.5)), pt.cex=2, pch=15 )


#print(sessionInfo())