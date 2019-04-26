## Resource build

Sequence and conditions of the procedure's execution to build a module. By implementation of the command <code>will .build</code>, the developer has to select a particular build which is wanted unambiguously calling command by name or by conditions of the build.

The most important field of the build is `steps`. `steps` is a build scenario. It is a sequence of steps that must be performed to construct the build.

### Build by default

The module may have a default build. In order to make it, the [cryterion `default : 1`](Criterions.md#Використання) is used.

### Example

![section.build.png](./Images/section.build.png)

The build named `copy.files` has one step `copy.proto`. Criterion `default : 1` makes this build the default build.

### Resource fields of `build` section 

| Field        | Description                                                       |
|---------------|------------------------------------------------------------------|
| description   | description for other developers                                 |
| criterion     | condition of module construction (see [criterion](Criterions.md)) |
| steps         | sequence of steps to module construction                         |
| inherit       | inheritance from another build                                   |

### Resource export

A special kind of build which is required in order to use this module by other developers and modules. The result of the module export are generated files, which is <code>out-will-file</code> and archive.

The result of the module export is the generated configuration `out-will-file`  and optionally the archive with the module files. Filling out of the section `about` is required and it must have the name and version of the module while module export.

The developer can export the module with the `will .export` command. In this case, the module must have a build for export. The export build must have a [predefined step `predefined.export`](ResourceStep.md#Predefined-step-predefinedexport) and the criterion `export : 1`.

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

In build `export` the step `export.proto` is used to export of the files. Combination of `export` and `default` criterions allows to appointing [export build by default](Criterions.md#Використання).

### Section <code>build</code>

Resources of the section (build) describe sequence and conditions of procedures of module's building.
