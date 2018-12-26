# Declaring local submodules

This tutorial shows how declare local module for a external project.

## Module structure

```
.
├── local_modules
|   |──semantic-ui             # external project files
|   └──semantic-ui.will.yml    # local module config
└── .will.yml                  # main module config
```

## Local module

In this tutorial we will use  as external project.

### Project files

1. Create directory for local modules with name `local_modules` and project directory `local_modules/semantic-ui`.
2. Prepare project files, in out case it will be files from [Semantic-UI](https://github.com/Semantic-Org/Semantic-UI-CSS).

### Preparing will file for local module

Create config file inside of `local_modules` directory with name `semantic-ui.will.yml`:

```yaml

about :

  name : semantic-ui
  version : 2.0.7

path :

  out : '.'
  export : '.'

step  :
  export.semantic :
      inherit : export
      tar : 0
      export : path::export

build :
  export :
      criterion :
          default : 1
          export : 1
      steps :
          - export.semantic
```

## Exporting

> Command should be executed from root directory of main module

Run `will .each local_modules .export`:
```
Exporting export
   + Write out file to .../local_modules/semantic-ui.out.will.yml
  Exported export with 175 files in 0.175s
```
During export process willbe generates `local_modules/semantic-ui.out.will.yml` file that contains information needed to import the module.

## Importing

Create config file for main module with name `.will.yml`:

```yaml

about :

  name : main
  version : 0.0.1
  description : 'Imports semantic-ui'

submodule :

  encore.common : ./local_modules/semantic-ui
```

`submodule` - declares list of [submodules](../Submodules.md), which can be local or remote.

For local submodules declaration looks like:

    module_name : local_modules_dir/module_name

> local_modules_dir must contain module_name.out.will.yml file to import the module

## Checking results

Run `will .submodules.list` check that `semantic-ui` module is imported:

```
Request ".submodules.list"
 . Read : .../.will.yml
 . Read : .../local_modules/semantic-ui.out.will.yml
submodule::semantic-ui
  path : ./local_modules/semantic-ui
  isDownloaded : 1
  Exported builds : [ 'export' ]
```

In next tutorials we will learn how to use imported module in build process.

#
[Back to content](../README.md)





