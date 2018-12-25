# Exporting the module

This tutorial shows how to create a module and export it.

Export is a special kind of build configuration that generates *.out.will file.
This file is used by other modules in import process. *.out.will contains information about module and includes list of files that module exports.

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

1. Create base will config for the module:

``` yaml
about :
    name : third
    description : "Third module"
    version : 0.0.1

path :
  out : '.'
  fileToExport : './fileToExport'

```

Section `path` defines paths that are used in current module:

`out` - path to directory where out file will be generated.
`fileToExport` - custom path, leads to exported file.

2. Add export step and build configuration:

Export step:

``` yaml
step  :
    export.single :
        inherit : export
        tar : 0
        export : './fileToExport'
```
`inherit` - inherits predefined scenario.
`tar` - archives exported files.
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

Configuraion named `export` has new criterions `default : 1` and `export : 1` which means that its a default export( build ) configuration.

## Exporting

> Command should be executed from root directory of the module.

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
During export process willbe generates *.out.will.yml file that contains information needed to import the module.

#
[Back to content](../README.md)





