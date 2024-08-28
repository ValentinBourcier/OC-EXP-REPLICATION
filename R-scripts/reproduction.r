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

