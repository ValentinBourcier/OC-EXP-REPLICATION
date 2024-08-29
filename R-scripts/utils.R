# Columns accesses
agree_disagree_col_names <- c("task.easiness", "task.length", "debugger.enjoy", "debugger.efficient", "debugger.intuitive", "debugger.easiness", "debugger.learn")
yes_no_col_names = c("bug.found")
help_col_names = c("debugger.help")
post_experiment_agree_disagree_col_names = colnames(experiment_feedback)

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
            rbind(agree_disagree_count, count_choices(control[[ct_col_name]], ct_col_name, agree_disagree_labels))
        agree_disagree_count <- 
            rbind(agree_disagree_count, count_choices(treatment[[tt_col_name]], tt_col_name, agree_disagree_labels))
    }

    yes_no_count <- c()
    for (name in yes_no_col_names) {
        ct_col_name <- paste("ct", name, sep=".")
        tt_col_name <- paste("tt", name, sep=".")
        yes_no_count <- 
            rbind(yes_no_count, count_choices(control[[ct_col_name]], ct_col_name, yes_no_labels))
        yes_no_count <- 
            rbind(yes_no_count, count_choices(treatment[[tt_col_name]], tt_col_name, yes_no_labels))
    }   

    help_count <- c("Choices", help_col_names)
    help_count <- c()
    for (name in help_col_names) {
        ct_col_name <- paste("ct", name, sep=".")
        tt_col_name <- paste("tt", name, sep=".")
        help_count <- 
            rbind(help_count, count_choices(control[[ct_col_name]], ct_col_name, help_labels))
        help_count <- 
            rbind(help_count, count_choices(treatment[[tt_col_name]], tt_col_name, help_labels))
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
        agree_disagree_count <- rbind(agree_disagree_count, count_choices(col, name, agree_disagree_labels))  
    }
    return(agree_disagree_count)
}
 
count_choices <- function(col, col_name, choices) {
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

write_demographics <- function(data){
    for (name in colnames(data[,1:6])) {
        filename <- paste(paste("./data/extracted-data/", name, sep=''), ".csv",  sep='')
        table <- table(data[[name]])
        write.csv(table,filename)
    }

    agree_disagree_count <- c()
    for (name in colnames(data[,7:8])) {
        col <- data[[name]]
        agree_disagree_count <- rbind(agree_disagree_count, count_choices(col, name, agree_disagree_labels))  
    }
    write.csv(agree_disagree_count,"./data/extracted-data/familiarity.csv")


}



