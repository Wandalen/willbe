## Resource build

Sequence and conditions of the procedure's execution to build a module. By implementation of the command `will .build`, the developer has to select a particular build which is wanted unambiguously calling command by name or by conditions of the build.

The most important the field of the build  is `steps` - a build script. Build script is a sequence of steps that must be performed to consider the build being constructed.

### Build by default

The module may have a default build. In order to make a such a build it is needed to specify for her
  [cryterion `default : 1`](Criterions.md#Використання).

### Example

![section.build.png](./Images/section.build.png)

The build with the name `copy.files` has one step `copy.proto`. Criterion `default : 1` makes this build the default build.

### The fields of resources of section `build`  

| Field        | Description                                                            |
|---------------|------------------------------------------------------------------|
| description   | description for other developers                                    |
| criterion     | condition of module construction (see [criterion](Criterions.md))          |
| steps         | sequence of steps to be performed in order to consider the build being constructed        |
| inherit       | inheritance from another collection                       |

### Resource export

A special kind of build which is needed in order to use this module by other developers and modules. The result of the module export are generated files, which is <code> out-will-file </ code> and archive.

The result of the module exportation is the generated configuration `out-will-file`  and optionally the archive with the module files. While exporting the module, filling out the section `about` is required and must have the name and version of the module.

The developer can export the module with the `will .export command.` In this case, the module must have a build for export. The export build must have a [predefined step `predefined.export`](ResourceStep.md#вбудований-крок-predefinedexport) and the criterion `export : 1`.

### Example of build's export

```yaml
step :

  export.proto :
    export : path::proto

build :

  export :
    criterion :
      default : 1
      export : 1
    steps :
      - export.proto
```

In build `export` the step `export.files` is used to export of the files. Merging of criterions `export` and `default` allows to appoint [build's export by default](Criterions.md#Використання).

### Section <code>build</code>

Resource of the section (builds) describe the sequence and conditions of the implementation of creation of the external module.
