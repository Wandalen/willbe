# Declaring local submodules

This tutorial shows how to declare a local module for an external project.

## Module structure

```
.
├── local_modules
|   |──semantic-ui             # external project files
|   └──semantic-ui.will.yml    # local module config
└── .will.yml                  # main module config
```

## Local module

In this tutorial, we will use Semantic-UI as external project.

### Project files

1. Create a directory for the local modules with the name `local_modules`, and a project directory `local_modules/semantic-ui`.
2. Prepare the project files, in our case we will use files from [Semantic-UI](https://github.com/Semantic-Org/Semantic-UI-CSS).

### Preparing will file for the local module

Create a config file inside the `local_modules` directory, with name `semantic-ui.will.yml`:

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

> Command should be executed from the root directory of the main module

Run `will .each local_modules .export`:
```
Exporting export
   + Write out file to .../local_modules/semantic-ui.out.will.yml
  Exported export with 175 files in 0.175s
```
During the export process, willbe generates a `local_modules/semantic-ui.out.will.yml` file that contains information needed to import the module.

## Importing

Create a config file for the main module, with the name `.will.yml`:

```yaml

about :

  name : main
  version : 0.0.1
  description : 'Imports semantic-ui'

submodule :

  encore.common : ./local_modules/semantic-ui
```

`submodule` - declares list of [submodules](../Submodules.md), which can be local or remote.

For local submodules, declaration looks like:

    module_name : local_modules_dir/module_name

> local_modules_dir must contain module_name.out.will.yml file to import the module

## Checking results

Run `will .submodules.list` and check that the `semantic-ui` module is imported:

```
Request ".submodules.list"
 . Read : .../.will.yml
 . Read : .../local_modules/semantic-ui.out.will.yml
submodule::semantic-ui
  path : ./local_modules/semantic-ui
  isDownloaded : 1
  Exported builds : [ 'export' ]
```

In the next tutorials, we will learn how to use the imported module in a build process.

#
[Back to content](../README.md)
