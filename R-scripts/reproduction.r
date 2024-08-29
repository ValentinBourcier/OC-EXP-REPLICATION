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

ammolite_post_task_survey_results <- 
    post_task_surveys_count("Ammolite", ammolite_controls, ammolite_treatments)
lightsout_post_task_survey_results <- 
    post_task_surveys_count("Lights Out", lightsout_controls, lightsout_treatments)

post_experiment_survey_results <- post_experiment_surveys_count(experiment_feedback)

write.csv(ammolite_post_task_survey_results$agree_disagree_results, "./data/extracted-data/ammolite-agree-disagree.csv")
write.csv(lightsout_post_task_survey_results$agree_disagree_results, "./data/extracted-data/lightsout-agree-disagree.csv")

write.csv(ammolite_post_task_survey_results$yes_no_results, "./data/extracted-data/ammolite-yes-no.csv")
write.csv(lightsout_post_task_survey_results$yes_no_results, "./data/extracted-data/lightsout-yes-no.csv")

write.csv(ammolite_post_task_survey_results$help_results, "./data/extracted-data/ammolite-help.csv")
write.csv(lightsout_post_task_survey_results$help_results, "./data/extracted-data/lightsout-help.csv")

write.csv(post_experiment_survey_results, "./data/extracted-data/experiment-feedback.csv")
