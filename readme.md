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


