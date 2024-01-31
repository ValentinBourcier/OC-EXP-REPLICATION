# Warmup task 1

This task is a warmup to practice the **halt on call** breakpoint.

The test `OCDPersonRegistryTest>>#testRegisterPersons` is failing. 
Try to understand why by using the **halt on call** breakpoint.

Remember that object-centric operations complements standard debugging tools.
The purpose of this task is not to restrict you to use only the **halt on call** breakpoint, but to use it when you feel necessary to complement standard debugging tools.

It is possible that you understand why the test fails without using the debugging tools.
If so, and for training purpose, try to use the object-centric tools to observe what you understood.

For example, from reading the source code you understand that a variable is set to nil into an object and that is the source of the problem. Then, try to use the object-centric tools to observe the precise moment in the debugger where that variable is put to nil.

# Warmup task 2

This task is a warmup to practice the **halt on state access** breakpoint.

The test `OCDPersonRegistryTest>>#testPersonsAge` is failing. 
Try to understand why by using the **halt on state access** breakpoint.

Remember that object-centric operations complements standard debugging tools.
The purpose of this task is not to restrict you to use only the **halt on state access** breakpoint, but to use it when you feel necessary to complement standard debugging tools.

It is possible that you understand why the test fails without using the debugging tools.
If so, and for training purpose, try to use the object-centric tools to observe what you understood.

For example, from reading the source code you understand that a variable is set to nil into an object and that is the source of the problem.
Then, try to use the object-centric tools to observe the precise moment in the debugger where that variable is put to nil.
