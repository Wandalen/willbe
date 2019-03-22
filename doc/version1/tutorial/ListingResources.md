# Listing resources of a module
This tutorial shows how to get resources of a module.

## Module structure

```
.
├── .will.yml
```

## Will file:

<details>
  <summary><u>Click to expand!</u></summary>

```yaml

about :

  name : listing
  description : "Module for listing"
  version : 0.0.1

path :

  in : 'in'
  out : 'out'
  export : 'proto'

step :

  export.proto :
      inherit : export
      tar : 0
      export : path::export

build :

  export :
      criterion :
          default : 1
          export : 1
      steps :
          - export.proto

```
</details>


## Listing resources:

> Commands should be executed from the root directory of the module.

#### List of available commands:

```
will .help
```

<details>
  <summary><u>Output</u></summary>

```
  .help - Get help.
  .set - Set a command.
  .list - List information about the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List available reflectors.
  .steps.list - List available steps.
  .builds.list - List available builds.
  .exports.list - List available exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.
  .submodules.download - Download each submodule, if such was not downloaded yet.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.
  .clean - Clean current module: delete generated artifacts, temp files and downloaded submodules.
  .clean.what - Find out which files will be deleted by the clean command.
  .build - Build the current module with the specified criterion.
  .export - Export the selected module with specified criterion. Save output to output file and archive.
  .with - Use "with" to select a module.
  .each - Use "each" to iterate over each module in a directory.
```
</details>

#### List information about the current module

```
will .list
```

<details>
  <summary><u>Output</u></summary>

```
About
  name : 'listing'
  description : 'Module for listing'
  version : '0.0.1'
  enabled : 1

Paths
  in : 'in'
  out : 'out'
  export : 'proto'

step::export.proto
  opts :
    tar : 0
    export : path::export
  inherit :
    export

build::export
  criterion :
    default : 1
    export : 1
  steps :
    export.proto
```
</details>

#### List resource of specific kind

List available paths:

```
will .paths.list
```
<details>
  <summary><u>Output</u></summary>

```
Paths
  in : 'in'
  out : 'out'
  export : 'proto'
```
</details>


List available steps:

```
will .steps.list
```
<details>
  <summary><u>Output</u></summary>

```
step::export.proto
  opts :
    tar : 0
    export : path::export
  inherit :
    export
```
</details>




[Back to content](../README.md)
