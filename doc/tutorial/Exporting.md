# Building: Exporting the module

This tutorial shows how to create a module and export it.

Export is a special kind of build configuration that generates *.out.will file.
This file is used by other modules in import process. *.out.will contains information about module and includes list of files that module exports.

More about [modules](Module.md) and [will files](Will-files.md).

## Module structure

```
.
├── fileToExport
├── .will.yml
```
___

## Creating export configuration

### Preparing file for export:

In this case we will export a single file, lets create `fileToExport` in the root directory.

### Writing export configuration:

Adding section `about`:

``` yaml
about :
    name : third
    description : "Third module"
    version : 0.0.1
```
In [previous tutorial](FirstBuild.md) we already created simple build configuration by adding `step` and `build` sections.

Lets add new export step:

``` yaml
step  :
    export.single :
        inherit : export
        tar : 0
        export : path::export
```

     ``` yaml
    build :
        export :
            criterion :
                default : 1
                export : 1
            steps :
                - export.single
    ```

    - path -
    - step -
    - build -

  - Lets execute some will commands to check that everything works fine.
    All commands should be executed from the root directory of the module.
    - Getting info about the module:
        ```
        will .about.list
        ```
    - Exporting the module:
        ```
        will .export
        ```
      During export process willbe generates *.out.will.yml file that contains information that is needed to import current module.

Sample of the module can be found in ./doc/Tutorials/modules/single






