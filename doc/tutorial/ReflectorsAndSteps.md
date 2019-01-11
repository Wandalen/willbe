# Creating reflectors and steps
This tutorial shows how to copy a file using reflectors and steps.

## Module structure

```
.
├── fileToReflect
├── .will.yml
```

## Creating our build configuration

### Preparing the will file:

In the first build tutorial, we created a basic build configuration to run our first step ( a shell command ).
Our current goal is to modify it to use a new step: to perform a predefined operation ( reflect a file ).

#### Create a base will config for the module:

``` yaml
about :

  name : 'copying'
  description : 'Reflect a file'
  version : 0.0.0

path :

  proto : './proto'
  in : '.'
  out : 'out'
  out.debug : './out.debug'

```

The section `path` defines paths that are used in the current module:

`proto` - path to the file that will be copied.

`out.debug` - path where the file will be copied.

#### Add the new component to use in the will config - the predefined operation:

`reflector` - describes the predefined operation of reflecting a file: We will work with the simplest operation that a reflector can perform, copy a file.

```yaml
reflector :

  reflect.proto :
    inherit : predefined.*
    criterion :
      debug : 1
    filePath :
      path::proto : path::out.debug
```

`criterion` - defines criteria which help to select the necessary configuration, sage of criterions will be described later.

`path::proto` - path to the file that will be copied.

`path::out.debug` - path where the file will be copied.


#### Add a build step:

This step executes the predefined operation: `reflect`.

```yaml
step :

  reflect.proto :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.proto
    criterion :
      debug : 1
```

`reflect.proto` - name of the step.

`reflector` - command to execute.

#### Add a build configuration:

```yaml
build :

  debug :
    criterion :
      default : 1
      debug : 1
    steps :
      - step::reflect.proto
```

`debug` - name of the configuration.

`criterion` - defines criteria which help to select the necessary configuration, sage of criterions will be described later.

`steps` - list of steps to execute in the current build configuration.

### Preparing the file to reflect:

To finally test this functionality, we need to create a sample file to reflect. Then, we have to include its path in the `path.proto` field.


## Testing the build configuration:

The final version of the `.will.yml` file would be:

<details>
  <summary><u>Click to expand!</u></summary>

```yaml

about :

  name : 'copying'
  description : 'Reflect a file'
  version : 0.0.0

path :

  proto : './proto'
  in : '.'
  out : 'out'
  out.debug : './out.debug'

reflector :
  reflect.proto :
    inherit : predefined.*
    criterion :
      debug : 1
    filePath :
      path::proto : path::out.debug

step :

  reflect.proto :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.proto
    criterion :
      debug : 1

build :

  debug :
    criterion :
      default : 1
      debug : 1
    steps :
      - step::reflect.proto

```
</details>

#### To launch the current ( default ) build configuration, run:

> Command should be executed from the root directory of the module.

```
will .build
```

The file referenced in the `path.proto` field will be copied:

```
  Building debug
    + Reflect 1 files to /C/./modules/copying/out.debug in 0.053s

  Built debug in 0.118s
```



#
[Back to content](../README.md)
