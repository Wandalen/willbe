# Current module

A module with respect to which the operations are performed. By default, this module loads from the file <code>.will.yml</code> of the current directory or from a pair of files <code>.im.will.yml</code> and <code>.ex.will.yml</code>.

```
.
├── proto
│     ├── files
│     │     ├── one.will.yml
│    ...    ├── two.will.yml
│          ...
├── .will.yml  
├── all.will.yml
├── second.will.yml
└── super.will.yml
 ```

  In order to make the current module the module with the named `willfile`, please execute the command `.with`. Do not forget to specify the name of the corresponding `willfile`. For instance by the implementation
  ```
  will .with second .build
  ```
  the current module will be the module with the file `second.will.yml.`.

   By implementation of `.each` each module will be loaded in sequence.
   ```
   will .each . .build`.
   ```
  This command will build each module in the current directory.

  Named `willfile` is not possible to make the current `willfile` without using the `.with` or `.each` commands.
