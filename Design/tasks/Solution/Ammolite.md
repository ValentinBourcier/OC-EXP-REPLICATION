# A method to track the root cause of the Ammolite bug, using object-centric breakpoints

The description of the Ammolite bug can be found here: [../Description/Ammolite.md](../Description/Ammolite.md)

## Bug characteristics

The bug has the following characteristics:
- It is a real bug of Ammolite which itself is a real application (used by teachers to create well-balanced groups of students),
- although not the same scenario, it conforms to Ressia'12 example `Live Object Interaction` where an object is incorrectly displayed on the application (here, with a missing marker).
 
## Debugging method using object-centric debugging

### Observing the bug

The bug can be observed when trying to generate groups of students using the `Generate` button.
One of the student, the last one named "Adèle" has no marker displayed in the group table while it is correctly displayed in the list: 

![Symptom of the bug](./Assets/Ammolite/ammolite-groups-bug.png)

### Investigating with standard tools


### Tracking the root cause with the object-centric debugger
