# Exporting the module

This tutorial shows how to create a module and export it.

Export is a special kind of build configuration that generates an *.out.will file.
This file is used by other modules in the import process. *.out.will contains information about the module, and includes a list of the files that module exports.

## Module structure

```
.
├── fileToExport
├── .will.yml
```
___

## Creating an export configuration

### Preparing the file for export:

In this case we will export a single file, let´s create a `fileToExport` in the root directory.

### Writing the export configuration:

1. Create a base will config for the module:

``` yaml
about :
    name : third
    description : "Third module"
    version : 0.0.1

path :
  out : '.'
  fileToExport : './fileToExport'

```

The section `path` defines paths that are used in the current module:

`out` - path to the directory where the out file will be generated.

`fileToExport` - custom path, leads to the exported file.

2. Add an export step and a build configuration:

Export step:

``` yaml
step  :
    export.single :
        inherit : export
        tar : 0
        export : './fileToExport'
```
`inherit` - inherits predefined scenario.

`tar` - archives exported files ( 1 - enables archivation / 0 - disables archivation ).

`export` - path to file or directory to export.

Export configuration:

``` yaml
build :
    export :
        criterion :
            default : 1
            export : 1
        steps :
            - export.single
```

The configuration named `export` has two new criterions: `default : 1` and `export : 1`
This means that it is a default export ( build ) configuration.

## Exporting

> Command should be executed from the root directory of the module.

Exporting the module:

```
will .export
```
Output:
```
 Exporting export
   + Write out file to ...doc/tutorial/modules/third/third.out.will.yml
  Exported export with 1 files in 0.073s
```
During the export process, willbe generates an *.out.will.yml file that contains information needed to import the module.

#
[Back to content](../README.md)
