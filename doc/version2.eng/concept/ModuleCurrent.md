# Current module

A module for which operations are performed. By default, this module loads from the file <code>.will.yml</code> of the current directory  from a pair of files <code>.im.will.yml</code> and <code>.ex.will.yml</code>.

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

In order to make the current module a module with the named `will-file`, execute the command `.with`.  Do not forget to specify the name of the corresponding `will-file`. For example, by executing
```
will .with second .build

```
the current module will be the module with the file `second.will.yml`.  

By implementation of `.each` command each module will be loaded in sequence. 
```
will .each . .build
```

This command will build each module in the current directory.

Named `will-file` is not possible to make the current without using the `.with` or `.each` commands.
