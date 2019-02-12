# Declaring a split module
This tutorial shows how the will configuration can be splitted into two will files.

## Module structure
We are going to split our configuration file in two: an export and an import will files.

```
.
├── fileToExport
├── .ex.will.yml
├── .im.will.yml
```
___

## Creating the export configuration

In a past tutorial, we saw how to export a module, review: [Exporting the module](Exporting.md).

In this case, we are going to re-use that will config file, naming it `.ex.will.yml`.

### Preparing the file for export:

In this case we will export a single file, let´s create a `fileToExport` in the root directory.

### Writing the export configuration:

The final version of the `.ex.will.yml` file would be:

<details>
  <summary><u>Click to expand!</u></summary>

```yaml
about :

  name : multi-config ex
  description : "Multi-config module - export"
  version : 0.0.0

path :
  out : '.'
  fileToExport : './fileToExport'

step  :
  export.single :
      inherit : export
      tar : 0
      export : path::fileToExport

build :
  export :
      criterion :
          default : 1
          export : 1
      steps :
          - export.single
```
</details>


## Creating the import build configuration

In a past tutorial, we saw how to create a build configuration that runs npm to install dependencies, review: [Creating a build configuration](FirstBuild.md).

In this case, we are going to re-use that will config file, naming it `.im.will.yml`. Moreover, we will modify it a bit, so it performs a simple shell command:

Instead of installing the npm dependencies, it will output some text in the console. No additional files need to be prepared in this case.

### Writing the import build configuration:

In this tutorial, we want to show that sections defined in the opposite will configuration file are available everywhere.

In this particular case, sections defined in our `.ex.will` file will also be available for the `.im.will file` ( and the other way around ). Therefore, there is no need to duplicate sections
like the `about` section.

The final version of the `.im.will.yml` file would be:

<details>
  <summary><u>Click to expand!</u></summary>

```yaml

submodule:

step :

  echo :
    currentPath : '.'
    shell : echo .im.will.yml executed

build :

  debug:
    criterion :
      default : 1
    steps :
      - echo
```
</details>

## Testing the build configurations:

  Let´s see now the outputs when executing our will files:

### To export the module, run:

> Command should be executed from the root directory of the module.

```
will .export
```
Output:
```
Request ".export"
 . Read : /D/work/willbe/.im.will.yml
 . Read : /D/work/willbe/.ex.will.yml

  Exporting export
   + Write out file to ...doc/tutorial/modules/multi-config/multi-config ex.out.will.yml
  Exported export with 1 files in 0.149s
```
During the export process, willbe generates an ex.out.will.yml file that contains information needed to import the module.

.im.will.yml is read but not executed.

### To launch the current ( default ) build configuration, run:

> Command should be executed from the root directory of the module.

```
will .build
```

Output:

```
Request ".build"
 . Read : /D/work/willbe/.im.will.yml
 . Read : /D/work/willbe/.ex.will.yml

  Building debug
 > echo .im.will.yml executed
.im.will.yml executed
  Built debug in 0.125s
```

We can see that the shell command is read and executed.

In this tutorial, we have divided our will file into two files, and executed one at a time.

#
[Back to content](../README.md)
