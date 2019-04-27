# Module, submodule, supermodule

### Module

A module is a set of files that are described in <code>will-file</code>.

Free definition of `willbe-module` imposes minimal restrictions on the development of software and using of utility. Any set of files may be considered as a module.

#### Example of `will-file` of module

![module.file.png](./images/module.file.png)

The figure shows the `will file` code. Numbers and arrows marked as it should be read (simplified scheme).
1. In section `about` (if specified) there is a description of the module like name, version, interpreters and keywords. All of this is the information for the developer. This figure shows that the module is called `exportModule`, version 0.0.1.
2. To determine the functionality of the module start reading from the section `build`, which is present in most `will-files`. The build section contains [builds](ResourceBuild.md) to build the module. At the figure the build with the name `export` executes the step with the name `export.single` (the arrow indicates the transition to the step).
3. The `export.single` step implements export. In the field `export`, the step refers to the resource section `path` with the name `fileToExport` (the arrow indicates the transition to the path). In resources it is accepted to formulate the link `Section name :: Resource name`.
4. The `fileToExport` resource of the section `path` specifies a file named `fileToExport` in the module directory.

To understand the file structure of module refer to the `path` section. To understand the modular structure of this module, see the section `submodule`. The section `build` explains kinds of build scenario and types of the builds available in this module.

### Submodule

An individual module with its own configuration <code> will-file </code> which is used by another module (supermodule).

### Supermodule

The module that includes other modules (submodules).

To connect a submodule place resource with the link to `will-file` of the submodule to the section `submodule` of current `will-file`.

#### Example of submodule connection

![supermodule.png](./images/supermodule.png)

The figure shows the part of `will-file` that describes the supermodule named `superModule`. The section `submodule` contains a submodule `Tools` with the link to a remote server.

More about submodules in concepts ["Local submodule"](SubmodulesLocalAndRemote.md#Local-submodule) and ["Remote submodule"](SubmodulesLocalAndRemote.md#Remote-submodule)
