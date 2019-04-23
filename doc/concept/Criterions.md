# Criterions

Element of comparison for selection of resources.

In `will-file` the map of criterions is represented by an associative array. Each resource can have any number of criterions. Criterions are used by selection by one resource another one through [selector with globe](Selector.md#Selector-with-globe). Criterions are not used in selector without glob as this selector has no ambiguity.

### Example

```yml
path :

  out.debug :
    path : out/debug
    criterion :
      debug : 1
  out.release :
    path : out/release
    criterion :
      debug : 0

step :

  delete.files :
    inherit : predefined.delete
    filePath : path::out.*
  criterion :
    debug : 1
```
For example, in the `step::delete.files` step, the` path::out.debug` path is used, which is selected through the selector with the globe `path::out.*`. The utility knows that one of the two possible paths `path::out.debug` or` path::out.release` is needed to select `path::out.debug`, because the step `step::delete.files`, and path `path::out.debug` has the criterion `debug:1`.

### Instantiation of critetions

In `will-file` for a single criterion it is possible to establish a set of values. Herewith not one [resource](Structure.md#Resources) will be created, but, as many different values combinations of the criterion of this resource as possible.

```yaml
step :
  delete.files :
    inherit : predefined.delete
    filePath : path::out.*
  criterion :
    raw : 1           # single meaning - ordinary form of writing
    debug : [ 0,1 ]   # plural meaning - record in array form, used by instantiation of criterions
```

The step `step::delete.files`, which has two criterions `raw` and `debug`, is defined. The `debug` criterion has a plural value. Therefore during instantiation of criterions, the two steps `delete.files.` and `delete.files.debug` are created.

[Tutorial](../tutorial/WillFileMinimization.md) about instantiation of criterions.

### Possible values.

Criterions can have Boolean or string values.

```yaml
condition : false       # Boolean value
compile : 1             # Boolean value
raw : one               # String value
name : name1            # String value
```

`false` and `0` -- considered to be alias.
`true` and `1` -- considered to be alias.

### Resource by default

The `default` criterion has a particular meaning. The resource that has the criterion `default:1` is considered as the default resource. By means of `default: 1` criterion, you can specify the [build](ResourceBuild.md#Resource-collection), which is built by default.

![criterion.default.png](./Images/criterion.default.png)

### Criterion of the build for the export

The special `export: 1` criterion differentiates the build which is intended for [export](ResourceBuild.md#Resource-Export) of the module from other builds of this module.

![criterion.export.png](./Images/criterion.export.png)

This module has one regular build and one export. The `will .build` command will execute the build` build::release ` and` will .export` command will execute the build for export `build::export`. Both builds are default builds because they have `default : 1`. Therefore the commands for their construction do not require any additional arguments.

### Resources which do not have the criterion

By build [selector with globe](Selector.md#Selector-with-globs), resources which do not have the criterion are selected, but not rejected.

![resource.without.criterion.png](./Images/resource.without.criterion.png)

The `step::proto.release` will be executed by any value of the criterion `debug` in build `build::release`. The result will not change if you add criterions in `step::proto.relase` or in `build::release`.
