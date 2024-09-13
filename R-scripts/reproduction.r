options(repos = list(CRAN="http://cran.rstudio.com"))

#install.packages("effectsize")
#install.packages("ggplot2")
#install.packages("Hmisc")
#install.packages("lobstr")

library(effectsize)
library(Hmisc)
library(lobstr)
options(warn=-1)
setwd(".")

raw_data <- read.csv("data/data.csv")
columns <- names(raw_data)
controls <- raw_data[, 2:18]
treatements <- raw_data[, 19:35]
experiment_feedback <- raw_data[, 36:51]
demographic_data <- raw_data[, 52:59]

source("R-scripts/utils.R")

valid_controls <- controls[controls$control.task.validity == "true",]
ammolite_controls <- valid_controls[valid_controls$control.task.name == "Ammolite", ] 
lightsout_controls <- valid_controls[valid_controls$control.task.name == "Lights Out", ]

valid_treatments <- treatements[treatements$treatment.task.validity == "true", ]
ammolite_treatments <- valid_treatments[valid_treatments$treatment.task.name == "Ammolite", ] 
lightsout_treatments <- valid_treatments[valid_treatments$treatment.task.name == "Lights Out", ]

ammolite_stats <- stats_task("Ammolite", ammolite_controls, ammolite_treatments)
lightsout_stats <- stats_task("Lights Out", lightsout_controls, lightsout_treatments)
capture.output(tree(ammolite_stats), file = "./data/extracted-data/statistics/Ammolite-full-statistics.txt")
capture.output(tree(lightsout_stats), file = "./data/extracted-data/statistics/LightsOut-full-statistics.txt")

ammolite_post_task_survey_results <- 
    post_task_surveys_count("Ammolite", ammolite_controls, ammolite_treatments)
lightsout_post_task_survey_results <- 
    post_task_surveys_count("Lights Out", lightsout_controls, lightsout_treatments)

post_experiment_survey_results <- post_experiment_surveys_count(experiment_feedback)

per_task_demographics_analysis <- per_task_demographics_count(raw_data)

write.csv(ammolite_post_task_survey_results$agree_disagree_results, 
    "./data/extracted-data/post-task-feedback/ammolite-agree-disagree.csv")
write.csv(lightsout_post_task_survey_results$agree_disagree_results, 
    "./data/extracted-data/post-task-feedback/lightsout-agree-disagree.csv")

write.csv(ammolite_post_task_survey_results$yes_no_results, 
    "./data/extracted-data/post-task-feedback/ammolite-yes-no.csv")
write.csv(lightsout_post_task_survey_results$yes_no_results, 
    "./data/extracted-data/post-task-feedback/lightsout-yes-no.csv")

write.csv(ammolite_post_task_survey_results$help_results, 
    "./data/extracted-data/post-task-feedback/ammolite-help.csv")
write.csv(lightsout_post_task_survey_results$help_results, 
    "./data/extracted-data/post-task-feedback/lightsout-help.csv")

write.csv(post_experiment_survey_results, 
    "./data/extracted-data/experiment-feedback/experiment-feedback.csv")

write_demographics(demographic_data, "./data/extracted-data/demographics/")



# Control comparison
controls_stats <- stats_task_control(ammolite_controls, lightsout_controls)
capture.output(tree(controls_stats), file = "./data/extracted-data/controls/Controls-full-statistics.txt")

 export_control_distributions(
    ammolite_controls$control.task.time.in.seconds/60, 
    lightsout_controls$control.task.time.in.seconds/60,
    ammolite_controls$control.task.actions,
    lightsout_controls$control.task.actions)


# Tool usage
detailed_tool_usage <- read.csv("data/detailed-tools-usage.csv", sep=";")
tools_columns <- names(detailed_tool_usage)
ammolite_tools_controls <- detailed_tool_usage[detailed_tool_usage$Ammolite_Condition=="control",]
ammolite_tools_treatment <- detailed_tool_usage[detailed_tool_usage$Ammolite_Condition=="treatment",]

print("###Ammolite tool usage")
print("Avg debugger time in % of total time debugging")
print("Control=")
print(mean((ammolite_tools_controls$Ammolite_Debugger.time + ammolite_tools_controls$Ammolite_Inspector.time)/ammolite_tools_controls$total,na.rm = TRUE))
print("Treatment=")
print(mean((ammolite_tools_treatment$Ammolite_Debugger.time + ammolite_tools_treatment$Ammolite_Inspector.time)/ammolite_tools_treatment$total,na.rm = TRUE))

print("Avg code navigation time in % of total time debugging")
print("Control=")
print(mean((ammolite_tools_controls$Ammolite_Browser.time + ammolite_tools_controls$Ammolite_Implementors.time + ammolite_tools_controls$Ammolite_Senders.time + ammolite_tools_controls$Ammolite_References.time)/ammolite_tools_controls$total,na.rm = TRUE))
print("Treatment=")
print(mean((ammolite_tools_treatment$Ammolite_Browser.time + ammolite_tools_treatment$Ammolite_Implementors.time + ammolite_tools_treatment$Ammolite_Senders.time + ammolite_tools_treatment$Ammolite_References.time)/ammolite_tools_treatment$total,na.rm = TRUE))


Lights_Out_tools_controls <- detailed_tool_usage[detailed_tool_usage$Lights_Out_Condition=="control",]
Lights_Out_tools_treatment <- detailed_tool_usage[detailed_tool_usage$Lights_Out_Condition=="treatment",]

print("###Lights Out tool usage")
print("Avg debugger time in % of total time debugging")
print("Control=")
print(mean((Lights_Out_tools_controls$Lights_Out_Debugger.time + Lights_Out_tools_controls$Lights_Out_Inspector.time)/Lights_Out_tools_controls$total,na.rm = TRUE))
print("Treatment=")
print(mean((Lights_Out_tools_treatment$Lights_Out_Debugger.time + Lights_Out_tools_treatment$Lights_Out_Inspector.time)/Lights_Out_tools_treatment$total,na.rm = TRUE))

print("Avg code navigation time in % of total time debugging")
print("Control=")
print(mean((Lights_Out_tools_controls$Lights_Out_Browser.time + Lights_Out_tools_controls$Lights_Out_Implementors.time + Lights_Out_tools_controls$Lights_Out_Senders.time + Lights_Out_tools_controls$Lights_Out_References.time)/Lights_Out_tools_controls$total,na.rm = TRUE))
print("Treatment=")
print(mean((Lights_Out_tools_treatment$Lights_Out_Browser.time + Lights_Out_tools_treatment$Lights_Out_Implementors.time + Lights_Out_tools_treatment$Lights_Out_Senders.time + Lights_Out_tools_treatment$Lights_Out_References.time)/Lights_Out_tools_treatment$total,na.rm = TRUE))

