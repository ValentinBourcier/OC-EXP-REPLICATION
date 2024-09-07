# Columns accesses
agree_disagree_col_names <- c("task.easiness", "task.length", "debugger.enjoy", "debugger.efficient", "debugger.intuitive", "debugger.easiness", "debugger.learn")
yes_no_col_names = c("bug.found")
help_col_names = c("debugger.help")
post_experiment_agree_disagree_col_names = colnames(experiment_feedback)

# Demographics labels
education <- c("High School but did not graduate", "High School graduate or GED", "Some college or 2-year degree", "Bachelor in CS (Computer Science)", "Bachelor in STEM (Science, Technology, Engineering and Mathematics)", "Bachelor in a different area than CS or STEM", "Master in CS", "Master in STEM", "Master in a different area than CS or STEM", "PhD or higher academic title in CS", "PhD or higher academic title in STEM", "PhD or higher academic title in a different area than CS or STEM")
jobs <- c("Student", "Part-Time Dev", "Full-Time Dev", "Unemployed", "Self-Employed")
programming_xp <-  c("< 1", "1-2 years", "3-5 years", "6-10 years", "More than 10")
code_freq <- c("At least once per day", "At least once per week", "At least once per month", "At least once per year")

# Likert labels
agree_disagree_labels <- c("Strongly Disagree", "Disagree","Nor disagree or agree", "Agree", "Strongly Agree")
yes_no_labels <- c("Yes", "No")
help_labels <- c("Not at all", "Slightly", "Moderately", "Normally", "Extremely")


# Vovk-Sellke maximum p-ratio (https://shiny.psy.lmu.de/felix/vs-mpr/)
# https://www.stat.purdue.edu/research/technical-reports/docs/tr17-01.pdf
vs_mpr <- function (pvalue) {
    return(1 / (exp(1) * pvalue * log(1/pvalue)))
}

cv <- function(column) {
    return (sd(column) / mean(column))
}

stats_task <- function (task_name, controls, treatments) {

    time_control_col <- controls$control.task.time.in.seconds/60
    time_treatment_col <- treatments$treatment.task.time.in.seconds/60
    stats_time <- stats(time_control_col, time_treatment_col)

    actions_control_col <- controls$control.task.actions
    actions_treatment_col <- treatments$treatment.task.actions
    stats_actions <- stats(actions_control_col, actions_treatment_col)

    correctness_control_col <- controls$control.task.correctness
    correctness_treatment_col <- treatments$treatment.task.correctness
    stats_correctness <- contingency(correctness_control_col, correctness_treatment_col)
  
    results <- list(
            name = task_name,
            time = stats_time,
            actions = stats_actions,
            correctness = stats_correctness)

    return(results)
}

stats <- function (controls, treatments) {
    test_result <- wilcox.test(controls, treatments, paired = FALSE)
    results <- list(
            shapiro = list(control = shapiro.test(controls), treatment = shapiro.test(treatments)),
            p_value = test_result$p.value,
            N = list(control = length(controls) , treatment = length(treatments)),
            mean = list(control = mean(controls) , treatment = mean(treatments)),
            CV = list(control = cv(controls), treatment = cv(treatments)),
            vs_mpr = vs_mpr(test_result$p.value),
            rrb = rank_biserial(controls, treatments, paired = FALSE))
    return(results)
}

contingency <- function (controls, treatments) {
    tag_column = c(rep('Control', length(controls)), rep('Treatment', length(treatments)))
    value_column = c(controls, treatments)
    table <- table(tag_column, value_column)
    #Pearson's Chi-squared test with Yates' continuity correction
    chi_squared_result <- chisq.test(table)
    return(chisq.test(table))
}

post_task_surveys_count <- function(task_name, control, treatment) {
    agree_disagree_count <- c()
    for (name in agree_disagree_col_names) {
        ct_col_name <- paste("ct", name, sep=".")
        tt_col_name <- paste("tt", name, sep=".") 
        agree_disagree_count <- 
            rbind(agree_disagree_count, count_choices_freq(control[[ct_col_name]], ct_col_name, agree_disagree_labels))
        agree_disagree_count <- 
            rbind(agree_disagree_count, count_choices_freq(treatment[[tt_col_name]], tt_col_name, agree_disagree_labels))
    }

    yes_no_count <- c()
    for (name in yes_no_col_names) {
        ct_col_name <- paste("ct", name, sep=".")
        tt_col_name <- paste("tt", name, sep=".")
        yes_no_count <- 
            rbind(yes_no_count, count_choices_freq(control[[ct_col_name]], ct_col_name, yes_no_labels))
        yes_no_count <- 
            rbind(yes_no_count, count_choices_freq(treatment[[tt_col_name]], tt_col_name, yes_no_labels))
    }   

    help_count <- c("Choices", help_col_names)
    help_count <- c()
    for (name in help_col_names) {
        ct_col_name <- paste("ct", name, sep=".")
        tt_col_name <- paste("tt", name, sep=".")
        help_count <- 
            rbind(help_count, count_choices_freq(control[[ct_col_name]], ct_col_name, help_labels))
        help_count <- 
            rbind(help_count, count_choices_freq(treatment[[tt_col_name]], tt_col_name, help_labels))
    }

    return(list(
        name=task_name,
        agree_disagree_results=agree_disagree_count,
        yes_no_results=yes_no_count,
        help_results=help_count))
}

post_experiment_surveys_count <- function(data) {
    agree_disagree_count <- c()
    for (name in post_experiment_agree_disagree_col_names) {
        col <- data[[name]]
        agree_disagree_count <- rbind(agree_disagree_count, count_choices_freq(col, name, agree_disagree_labels))  
    }
    return(agree_disagree_count)
}
 
count_choices_freq <- function(col, col_name, choices) {
    table <- table(col)
    total <- 0
    for (choice in choices) {
        count <- table[choice]
        if (is.na(count)) {count <- 0}
        total <- sum(total, count)
    }

    col_values <- c(col_name, total)
    for (choice in choices) {
        count <- table[choice]
        if(is.na(count)) {
           percentage <- 0 
        }
        else {
            percentage <- round(count / total * 100, 3)
        } 
        col_values <- c(col_values, percentage)
    }
    return(col_values)
}

count_choices <- function(col, col_name, choices) {
    table <- table(col)
    col_values <- c(col_name)
    for (choice in choices) {
        count <- table[choice]
        if(is.na(count)) {
           col_values <- c(col_values, 0)
        }
        else {
            col_values <- c(col_values, count)
        } 
    }
    return(col_values)
}

write_demographics <- function(data, filepath){
    for (name in colnames(data[,1:6])) {
        filename <- paste(paste(filepath, name, sep=''), ".csv",  sep='')
        table <- table(data[[name]])
        write.csv(table,filename)
    }

    agree_disagree_count <- c()
    for (name in colnames(data[,7:8])) {
        col <- data[[name]]
        agree_disagree_count <- rbind(agree_disagree_count, count_choices_freq(col, name, agree_disagree_labels))  
    }
    write.csv(agree_disagree_count,"./data/extracted-data/familiarity.csv")

}

per_task_demographics_count <- function(data) {

    valid_ct <- data[data$control.task.validity == "true",]
    ammolite_ct <- valid_ct[valid_ct$control.task.name == "Ammolite", ]     
    lightsout_ct <- valid_ct[valid_ct$control.task.name == "Lights Out", ]

    valid_tt <- data[data$treatment.task.validity == "true", ]
    ammolite_tt <- valid_tt[valid_tt$treatment.task.name == "Ammolite", ] 
    lightsout_tt <- valid_tt[valid_tt$treatment.task.name == "Lights Out", ]

    ammolite_ct_demographics <- 
        cbind(ammolite_ct$education, ammolite_ct$job.position, ammolite_ct$program.exp, ammolite_ct$pharo.exp, ammolite_ct$pharo.frequency, ammolite_ct$code.frequency)
    ammolite_tt_demographics <- 
        cbind(ammolite_tt$education, ammolite_tt$job.position, ammolite_tt$program.exp, ammolite_tt$pharo.exp, ammolite_tt$pharo.frequency, ammolite_tt$code.frequency)
   
    task_demographics_count("Ammolite", ammolite_ct, ammolite_tt)
    task_demographics_count("LightsOut", lightsout_ct, lightsout_tt)
   

    #pxp_mapping <- c("< 1" = 1, "1-2 years" = 2, "3-5 years" = 3, "6-10 years" = 4, "More than 10" = 5)
    #pxp_ctrl <- data.frame(values =ammolite_ct_demographics[,4])
    #pxp_ctrl$values <- pxp_mapping[pxp_ctrl$values]
    #pxp_ctrl <- pxp_ctrl[!is.na(pxp_ctrl), ]
    #print(pxp_ctrl)

    #pxp_tt <- data.frame(values = ammolite_tt_demographics[,4])
    #pxp_tt$values <- pxp_mapping[pxp_tt$values]
    #pxp_tt <- pxp_tt[!is.na(pxp_tt), ]
    #print(pxp_tt)

    #print(wilcox.test(pxp_ctrl, pxp_tt, alternative="two.sided"))

    total_jobs <- count_choices(data$job.position, "Total Jobs", jobs)
    write.csv(total_jobs, "./data/extracted-data/total-jobs.csv")
    total_xp <- count_choices(data$program.exp, "Total XP", programming_xp)
    write.csv(total_xp, "./data/extracted-data/total-xp.csv")
}

task_demographics_count <- function(task_name, ct_data, tt_data) {

    ct_demographics <- 
        cbind(ct_data$education, ct_data$job.position, ct_data$program.exp, ct_data$pharo.exp, ct_data$pharo.frequency, ct_data$code.frequency)
    tt_demographics <- 
        cbind(tt_data$education, tt_data$job.position, tt_data$program.exp, tt_data$pharo.exp, tt_data$pharo.frequency, tt_data$code.frequency)

    education <- 
        cbind(count_choices(ct_demographics[,1], "Control", education), 
              count_choices(tt_demographics[,1], "Treatment", education))
  
    prog_xp <- 
        cbind(count_choices(ct_demographics[,3], "Control", programming_xp), 
              count_choices(tt_demographics[,3], "Treatment", programming_xp))

    pharo_xp <- 
        cbind(count_choices(ct_demographics[,4], "Control", programming_xp), 
              count_choices(tt_demographics[,4], "Treatment", programming_xp))

    job <- 
        cbind(count_choices(ct_demographics[,2], "Control", jobs), 
              count_choices(tt_demographics[,2], "Treatment", jobs))

    pharo_freq <- 
        cbind(count_choices(ct_demographics[,5], "Control", code_freq), 
              count_choices(tt_demographics[,5], "Treatment", code_freq))

    freq <- 
        cbind(count_choices(ct_demographics[,6], "Control", code_freq), 
              count_choices(tt_demographics[,6], "Treatment", code_freq))

    data_path <- paste("./data/extracted-data/", task_name, sep="")
    write.csv(education, paste(data_path, "education.csv", sep="-"))
    write.csv(prog_xp, paste(data_path, "prog.csv", sep="-"))
    write.csv(pharo_xp, paste(data_path, "pharo.csv", sep="-"))
    write.csv(job, paste(data_path, "jobs.csv", sep="-"))
    write.csv(pharo_freq, paste(data_path, "pharo-frequency.csv", sep="-")) 
    write.csv(freq, paste(data_path, "frequency.csv", sep="-"))

}

export_control_distributions <- function(name, control_ammolite, control_lightsout) {

    data <- rbind(cbind(Condition='Ammolite', control_ammolite), cbind(Condition='LightsOut', control_lightsout))
    #Òcolnames(data) <- c("Condition", name)
    df<- data.frame(cond=data[,1], time=data[,2])
    print(df)
    library(ggplot2)
    #print(ggplot(df, aes(x=time, fill=cond)) + geom_density(alpha=.3))

    # Data
set.seed(5)
x <- df$time
group <- df$cond

print(group)

cols <- c("#F76D5E", "#FFFFBF", "#72D8FF")

# Basic density plot in ggplot2
print(ggplot(df, aes(x = df$time, fill = df$cond)) +
  geom_density(alpha = 0.5) + 
  scale_fill_manual(values = cols) )
 


}



