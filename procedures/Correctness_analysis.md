# Experiment data, correctness adjustment

## Correctness

### Case 1: The automatic test prints SUCCESS

Then the task is considered to be correct.  

### Case 2: The automatic test fails.
Then we have to analyse the answer.

#### Case 2.1: Ammolite

In the expected answer a participant:
1. Explains that the faulty "Adèle" student has a marker `+ ` (with the trailing space).
2. Explains why it causes a problem, i.e., where/how the marker is compared?
3. Give a possible solution.

If the provided answer only satisfies:
- (1) and (3), check (3), if the solution is correct then we consider the answer to be correct.
- (1) and (2), check (2), if correct, then we consider the answer to be correct.
- (1), check the automatic test, if it is in success, the answer is correct.

Otherwise, the participant's answer is incorrect.

#### Case 2.2: Lights Out

In the expected answer a participant:
1. Explains that the `onColor` and `offColor` of the faulty light are the same.
2. Explains that `SwitchButtonMorph >> position or getCorner or setCorner` are responsible for the bug.
3. Explains a fix involving a deletion / comment of the methods of (2).

If the provided answer only satisfies:
- (1) and (3), or (3) alone, check the methods deleted/commented; if correct, then consider the answer correct.
- (1) and (2), check (2), if correct, then we consider the answer to be correct.
- (1), check the automatic test, if it is in success, the answer is correct.

Otherwise, the participant's answer is incorrect.

## Validity

### Case 1: Automatic detection

The non-validity of the task is determined automatically if the participant does not use the tool.

### Case 2: Out of time

The participant cut off the experiment because of lacking time.  
In this case look at the answer to determine of far the participant went through the task.

**We expect to see at least an explanation of the symptoms and a correct hypothesis to consider the task valid.**
The decisions will be put in comments attached to the metadata of the participation.
