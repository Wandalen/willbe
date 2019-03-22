# Using Criterion
This tutorial shows how to use critera to modify the behaviour of a build process.

## Module structure

```
.
├── fileToReflectA
├── fileToReflectB
├── .will.yml
```

## Creating our build configuration

### Preparing the will file:

In this tutorial we are going to create two reflectors with a criterion, in order to show how the criterion value modifies the
behaviour of the routine.

#### Create a base will config for the module:

Our objective will be to copy one or two files, depending on the criterion value. Therefore, we need to set paths
for each file:

<details>
  <summary><u>Click to expand!</u></summary>

``` yaml
about :

  name : 'criteria'
  description : 'Use of criteria'
  version : 0.0.0

path :

  proto : './fileA'
  protoTwo : './fileB'
  in : '.'
  out : 'out'
  out.debug :
    path : './out.debugA'
    criterion :
      debug : 1
  out.debugTwo :
    path : './out.debugB'
    criterion :
      debug : 1

```
</details>

The section `path` defines paths that are used in the current module:

`proto` and `protoTwo` - paths to the files that will be copied.

`out.debug` and `out.debugTwo` - paths where the files will be copied.

#### Add the reflectors:

We will call our criterion: `copyAll`. Where, if it equals 0, only one file will be copied, and if it equals 1 both files
will be copied. Let´s create now the two reflectors:

  - the first one copies only one file, and the criterion `copyAll` is equal to 0.

  - the second one copies two files, and the criterion `copyAll` is equal to 1.

<details>
  <summary><u>Click to expand!</u></summary>

```yaml
reflector :

  reflect.proto :
    inherit : predefined.*
    criterion :
      copyAll : 0
    filePath :
      path::proto : path::out.debug

  reflect.protoTwo :
    inherit : predefined.*
    criterion :
      copyAll : 1
    filePath :
      path::protoTwo : path::out.debugTwo
      path::proto : path::out.debug
```
</details>

`criterion` - defines the criterion `copyAll`.

`path::proto` and `path::protoTwo` - paths to the files that will be copied.

`path::out.debug` and `path::out.debugTwo` - paths where the files will be copied.


#### Add the steps:

This steps execute the predefined operations in the `reflector`.

<details>
  <summary><u>Click to expand!</u></summary>

```yaml
step :

  reflect.proto :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.proto
    criterion :
      debug : 1
      copyAll : 0

  reflect.protoTwo :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.protoTwo
    criterion :
      debug : 1
      copyAll : 1
```
</details>


`reflect.proto` and `reflect.protoTwo` - name of the steps.

`reflector` - command to execute.

`criterion` - defines the value of the criteria for each of the steps.

#### Add the build configurations:

Again, we create now two builds for each of the behaviours:

<details>
  <summary><u>Click to expand!</u></summary>

```yaml
build :

  debug.one :
    criterion :
      default : 1
      debug : 1
      copyAll : 0
    steps :
      - step::reflect.proto

  debug.all :
    criterion :
      debug : 1
      copyAll : 1
    steps :
      - step::reflect.protoTwo
```
</details>

`debug.one` - `debug.all` - name of the configurations.

`criterion` - defines criteria which help to select the necessary configuration ( criterion `copyAll` equal to 0 or 1 ).

`steps` - list of steps to execute in the current build configuration.

### Preparing the files to reflect:

To finally test this functionality, we need to create two sample files to reflect. Then, we have to include their paths in the
`path.proto` and `path.protoTwo` fields.


## Testing the build configuration:

The final version of the `.will.yml` file would be:

<details>
  <summary><u>Click to expand!</u></summary>

```yaml
about :

  name : criteria
  description : "Use of criteria"
  version : 0.0.0

path :

  proto : './fileA'
  protoTwo : './fileB'
  in : '.'
  out : 'out'
  out.debug :
    path : './out.debugA'
    criterion :
      debug : 1
  out.debugTwo :
    path : './out.debugB'
    criterion :
      debug : 1

reflector :

  reflect.proto :
    inherit : predefined.*
    criterion :
      copyAll : 0
    filePath :
      path::proto : path::out.debug

  reflect.protoTwo :
    inherit : predefined.*
    criterion :
      copyAll : 1
    filePath :
      path::protoTwo : path::out.debugTwo
      path::proto : path::out.debug

step :

  reflect.proto :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.proto
    criterion :
      debug : 1
      copyAll : 0

  reflect.protoTwo :
    inherit : predefined.reflect
    reflector :
      reflector::reflect.protoTwo
    criterion :
      debug : 1
      copyAll : 1

build :

  debug.one :
    criterion :
      default : 1
      debug : 1
      copyAll : 0
    steps :
      - step::reflect.proto

  debug.all :
    criterion :
      debug : 1
      copyAll : 1
    steps :
      - step::reflect.protoTwo
```
</details>

#### To launch the current ( default ) build configuration, run:

> Command should be executed from the root directory of the module.

```
will .build
```

The file referenced in the `path.proto` field will be copied:

```
  Building debug.one
    + Reflect 1 files to /C/./modules/criteria/out.debug in 0.054s

  Built debug.one in 0.094s
```

We can see that the build configuration `debug.one`,that has the criterion `default` equal 1, is the one executed.

#### To launch the build configuration to copy one file:

> Command should be executed from the root directory of the module.

```
will .build copyAll:0
```

In this case, we call our build with the criterion `copyAll` set to zero. We expect the same behaviour
as the default, only the file referenced in the `path.proto` field will be copied:

```
  Building debug.one
    + Reflect 1 files to /C/./modules/criteria/out.debug in 0.073s

  Built debug.one in 0.117s
```

We can see that only one file has been copied. Again, the build configuration `debug.one` has been executed. However, this time
it is not because of the `default` criterion, but because we called it with the criterion `copyAll` set to 0.  

#### To launch the build configuration to copy two files:

> Command should be executed from the root directory of the module.

```
will .build copyAll:1
```

In this case, we call our build with the criterion `copyAll` set to one. We now expect
that both files, referenced in the `path.proto` and `path.protoTwo` fields, will be copied:

```
  Building debug.all
    + Reflect 2 files to ( /C/./modules/criteria/ + [ out.debugTwo, out.debug ] ) in 0.115s

  Built debug.all in 0.158s
```

We can see that both files have been copied, and the build configuration `debug.all` has been executed. Thus, with the criterion value we can choose which
build configuration execute.

#
[Back to content](../README.md)
