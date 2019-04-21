# Current module

A module with respect to which operations are performed. By default the module is loaded from file <code>.will.yml</code> of the current directory.

In other words, it is `will-file`, in relation to which the commands in the command shell of the system are executed.


#### Example   

```
 .
 ├── proto
 │     ├── files
 │     │     ├── one.will.yml
 │    ...    ├── two.will.yml
 │          ...
 ├── .will.yml  
 ├── all.will.yml
 ├── release.will.yml
 └── super.will.yml

 ```

 To make the current module, the module named `will-file`, executes the command `.with` with the name specification of the corresponding `will-file`. For instance by implementation  `will .with second .build` the current module will be the module with file `second.will.yml`.  

 By implementation of `.each` each module will be loaded in sequence. `will .each . .build`.

 This command will build each module in the current directory.

 Named `will-file` is not possible to make current without using the `.with` or `.each` commands.
