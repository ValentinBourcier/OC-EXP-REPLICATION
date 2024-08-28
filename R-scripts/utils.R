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
 
