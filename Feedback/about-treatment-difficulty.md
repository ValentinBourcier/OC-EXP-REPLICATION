

## In general

```
While i understood the concept I found the first example with lightOn not to be an obvious one for object centric debugging - I wanted to set a conditional breakpoint for setting the colour attribute to grey for all instances - and this isn't available as an option (I don't understand why? Given I didn't know which insance was likey to go wrong, it wasn't obvious where set an object centric breakpoint, so I wanted to set a write condition on color - I think this is an obvious omission. Writing now - I guess I could have inspected all 4 corners and set a write breakpoint for all 4 instances but that seems wasteful. In essence, I didn't find it a compelling example? I also find it deeply annoying that in the Pharo debugger you can't add new breakpoints while debugging - why? (not an object centric issue though). I also found that object centric breakpoints don't always seem to work if you set one on an instance and then press restart in the debugger? The persons example with the do loop - when I got a test failure I set an OC breakpoint, pressed restart on the test (in the debugger) and it didn't work. I had to set a breakpoint before the do loop (and coldn't do that in the debugger - although realised I could have restarted and stepped up to the point I needed and then set an OC breakpoiint - but it seems like a bug?
```

```
I probably missedfilled the first form, because it didn't scroll as expected, my appologies.
Cliffnotes are that it was tedious to find without OCDdebugger.
I had to find a discriminating factor, to be able to basically do OCD debugging.
```

```
I'm now coding in Pharo for around 1 year, so I'm still learning what some methods do and what's Pharo's behaviour in different situations, so I believe this may have impacted my performance negatively in the experiment. Besides that, I understood how the features you suggested work, even though I feel my lack of knowledge in Pharo in general made me had trouble applying your feature to solve real problems.
```



## With Lights Out task as treatment



## With Ammolite task as treatment


```
I had issues triggering the object-centric debugging breakpoints. While they seemed to work in the tutorial, I could only trigger sometimes in the warmup and led to an error message in the ammolite example. However, I enjoyed the process and would like to use objcdg more!! 
``` 
```
I'm not the sure the tasks (including the last one) really highlight the features of OCD.
```

```
- I did put breakoints on state read/access and it froze the system
- I feel that finding objects of interest uses very traditional "put break, inspect", Could there be more ways? 
```

```
I had one crash when performing steps in the LightsOut task.

My image freezed when putting object-centric breakpoints (read or state-access) on the `marker` instance variable of `AMStudent`. 
```

