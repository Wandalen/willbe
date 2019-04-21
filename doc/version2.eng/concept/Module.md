# Module, submodule, supermodule

### Module

A module is a collection of files that are described in <code> will-files </code>.
Free definition of `willbe-module` imposes minimal restrictions on the development of software and using of utilities. Any set of files may be considered as a module.

#### Example of `will-файла` of module

![module.file.png](./Images/module.file.png)

The figure shows the `will file` code, numbers and arrows marked as it should be read (simplified scheme).
1. In section `about` (if specified) there is a description of the module - name, version, description, interpreters and keywords - information for the developer. At this figure it is specified that the module is called `exportModule`, version 0.0.1.
2. To determine the functionality of the module, start reading from the section `build`, which is present in most` will-files`. The build section contains [builds](ResourceBuild.md) to build the module. At the figure, the build with the name `export` executes the step with the name` export.single` (the arrow indicates the transition to the step).
3. The `export.single` step implements export. In the field `export`, the step refers to the resource section` path` with the name `fileToExport` (the arrow indicates the transition to the path). In resources it is accepted to formulate the link `Section title :: The name of the resource`.
4. The `fileToExport` resource of the section `path` 'specifies a file named` fileToExport` in the module directory.

To understand the structure of the files refer to the `path` section. For getting information about submodules, see section `submodule`.To understand the modular structure of this module, see the section `submodule`. To understand which kind of build scenario are and which builds are available in this module, explore its section `build`.

### Submodule

An individual module with its own configuration <code> will-file </code> which is used by another module (supermodule).

### Supermodule

The module that includes other modules (submodules).

Для підключення підмодуля в секцію `submodule` `will-файлa` поміщається ресурс з посиланням на `will-файл` підмодуля.  

To connect a submodule to the section `submodule`` will-file` is placed in the resource with the link to` will-file` of submodule.

#### Example of submodule connection

![supermodule.png](./Images/supermodule.png)

The figure shows the part of `will-file` that describes the supermodule named` superModule`. The section `submodule` contains a submodule` Tools` with the link to a remote server.

More about submodules in concepts ["Local submodule"](SubmodulesLocalAndRemote.md#Local-submodule), ["Remote submodule"](SubmodulesLocalAndRemote.md#Remote-submodule)
