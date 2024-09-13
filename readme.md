# Replication package - Empirically Evaluating the Impact of Object-Centric Breakpoints on the Debugging of Object-Oriented Programs 

This repository provides the necessary materials to replicate the empirical experiment analysis presented in the paper "Empirically Evaluating the Impact of Object-Centric Breakpoints on the Debugging of Object-Oriented Programs".
It includes instructions, data, and artifacts to enable reproduction of the analysis. 
Additionally, the repository contains PDF files with diagrams of the extracted data whose numbers were reported in the paper. 
The files are primarily in Markdown format, we recommend reading them with a Markdown renderer. 
For those who prefer a more traditional format, PDF versions are also available.

In the following, we present the structure of this repository and how to interpret the results.

## Design

Within the "design" directory, you will find the components of the experiment definition and the procedures used to transform and interpret the collected data.
The directory is structured as follows:  

**Design**
- **Procedures** - Directory containing the description of the procedures used to filter out non-valid participation and transform the data
  - [Correctness_analysis.md](./Design/Procedures/Correctness_analysis.md) - Explains the protocol to decide if a participant successfully completed each task.   
  - [Time_computation_analysis.md](./Design/Procedures/Time_computation_analysis.md) - Explains the protocol to interpret and adjust the interruption time on each task.
- **Questionnaires** - Directory containing all the questionnaires as they were presented to the participants
  - [Demographic_questions.md](./Design/Questionnaires/Demographic_questions.md)
  - [Experiment_feedback.md](./Design/Questionnaires/Experiment_feedback.md)
  - [Post-task_questions.md](./Design/Questionnaires/Post-task_questions.md)
- **Tasks** - Directory contains the description of each task composing the experiment and present one solution to debug Ammolite and Lights Out. 
  - **Description**
    - [Ammolite.md](./Design/Tasks/Description/Ammolite.md)
    - [LightsOut.md](./Design/Tasks/Description/LightsOut.md)
    - [Tutorial.md](./Design/Tasks/Description/Tutorial.md)
    - [Warmup.md](./Design/Tasks/Description/Warmup.md)
  - **Solution**
    - [Ammolite.md](Design/Tasks/Solution/Ammolite.md)
    - [LightsOut.md](Design/Tasks/Solution/LightsOut.md)

## R-scripts

The "R-scripts" directory contains the scripts to reproduce the results of our experiment.
To run the scripts, you must have [R](https://www.r-project.org/) installed on your system. 

The scripts require a few libraries to be installed on your system, "effectsize", "ggplot2", "Hmisc" and "lobstr".
If you don't have them installed, you can uncomment the following lines at the top of the file: [./R-scripts/reproduction.r](./R-scripts/reproduction.r).

```R
#install.packages("effectsize")
#install.packages("ggplot2")
#install.packages("Hmisc")
#install.packages("lobstr")
```

To launch the script, you must execute the following command at the root-directory of this replication package.

```sh
> Rscript R-scripts/reproduction.r
```

## Data

The data directory contains the extracted data generated by the R-scripts.
The directory is structured as follows: 

```plain
.
├── Feedback - Additionnal feedbacks on the perception of the tasks
│   ├── about-treatment-difficulty.md
│   ├── ammolite-control-then-lightsout-treatment.md
│   ├── grey-feedback.md
│   └── lightsout-control-then-ammolite-treatment.md
├── data.csv - Contains the extraction of all questions and answers
└── extracted-data
    ├── controls - The statistical tests results for the comparison of both tasks under the control condition                                           
    │   ├── Controls-full-statistics.txt
    │   ├── control-actions-distribution.pdf
    │   └── control-times-distribution.pdf
    ├── demographics - Contains the repartition of the participants per-task depending on the different demographic factors. Please refer to questions-data-mapping.csv for more details about the demographic questions each file refers to. 
    │   ├── Ammolite-education.csv
    │   ├── Ammolite-frequency.csv
    │   ├── Ammolite-jobs.csv
    │   ├── Ammolite-pharo-frequency.csv
    │   ├── Ammolite-pharo.csv
    │   ├── Ammolite-prog.csv
    │   ├── LightsOut-education.csv
    │   ├── LightsOut-frequency.csv
    │   ├── LightsOut-jobs.csv
    │   ├── LightsOut-pharo-frequency.csv
    │   ├── LightsOut-pharo.csv
    │   ├── LightsOut-prog.csv
    │   ├── code.frequency.csv
    │   ├── education.csv
    │   ├── familiarity.csv
    │   ├── job.position.csv
    │   ├── pharo.exp.csv
    │   ├── pharo.frequency.csv
    │   ├── program.exp.csv
    │   ├── total-jobs.csv
    │   └── total-xp.csv
    ├── experiment-feedback
    │   └── experiment-feedback.csv - Contains the answers given by participants to the post-experiment questions. The results are presented by number/frequency of apparition of the different possible answers.
    ├── post-task-feedback - Contains the answers given by participants to the post-task questionnaires. The results are presented by number/frequency of apparition of the different possible answers, after the control task and the treatment task.
    │   ├── ammolite-agree-disagree.csv
    │   ├── ammolite-help.csv
    │   ├── ammolite-yes-no.csv
    │   ├── lightsout-agree-disagree.csv
    │   ├── lightsout-help.csv
    │   └── lightsout-yes-no.csv
    ├── questions-data-mapping.csv - Maps the name of each CSV file with the questions asked after each tasks and at the end of the experiment
    └── statistics - Contains the results of the statical tests (normality, significance) performed on Ammolite and Lights Out 
    │   ├── Ammolite-full-statistics.txt - Control-Treatment comparison for the Ammolite task
    │   ├── LightsOut-full-statistics.txt - Control-Treatment comparison for the Lights Out task
    │   ├── Ammolite-demographics-statistics.txt - Control-Treatment demographics for the Ammolite task (only chi-squared p-values)
    │   └── Ammolite-full-statistics.txt - Control-Treatment demographics for the Lights Out task (only chi-squared p-values)
    └── tools-usage - Contains the tools usage frequency per task and the statistical tests checking for a difference in tools usage between control and treatment (with the Benjamini-Hochberg procedure for limiting the false discovery rate).
        ├── BenjaminiH-procedure-for-tools-usage-Ammolite.pdf
        ├── BenjaminiH-procedure-for-tools-usage-LightsOut.pdf
        ├── BenjaminiH-procedure-for-tools-usage.xlsx
        └── detailed-tools-usage.csv
```