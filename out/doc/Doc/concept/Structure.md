# `Will-file` structure

### Section of <code>will-file</code>  

The highest structural unit of the <code>will-file</code>, which consists of one-type resources or fields that describe this module.   

There are 6 sections for constructing the module: `about`,` path`, `submodule`,` step`, `reflector`,` build` and the `exported` section which is generated only by exporting the module.

#### Schematic structure of `will-file`

```
will-file
    ├── about
    ├── submodule
    ├── path
    ├── reflector
    ├── step
    ├── build
    └── exported

```

The figure shows all sections of `will-file`. None of the sections are required for use `will-file`. However, for the execution of some commands, the presence some of them is necessary. For example, to export the module, `will-file` must have the name and version specified in the section `about`.

### Sections assignment of `will-file`

<details><summary><a href="./concept/SectionAbout.md">
      Section <code>about</code>
  </a></summary>
  The section has the descriptive information about the module.
</details>
<details><summary><a href="./concept/ResourcePath.md#Section-path">
      Section <code>path</code>
  </a></summary>
  Section has the list of the module paths for quick orientation in its file structure.
</details>
<details><summary><a href="./concept/SectionSubmodule.md">
      Section <code>submodule</code>
  </a></summary>
  The section has an information about submodules.
</details>
<details><summary><a href="./concept/ResourceReflector.md#Section-reflector">
      Section <code>reflector</code>
  </a></summary>
  The section has reflectors. It is a special type of resources for operation on the groups of files.
</details>
<details><summary><a href="./concept/ResourceStep.md#Section-step">
      Section <code>step</code>
  </a></summary>
  The section has steps which could be used by build for building of the module.
</details>
<details><summary><a href="./concept/ResourceBuild.md#Section-build">
      Section <code>build</code>
  </a></summary>
  Resources of the section (build) describe sequence and conditions of procedures of module's building.
</details>
<details><summary><a href="./concept/SectionExported.md">
      Section <code>exported</code>
  </a></summary>
  It is programmatically generated section of <code>out-will-file</code> by exporting a module. It has a list of exported files and it is used by other modules for importing the module.
</details>

### Example of `will-file`   

![will.file.inner.png](./Images/will.file.inner.png)  

At the figure, the `will-file` with 4 sections and several resources is shown.

### Resources

Structural and functional unit of <code>will-file</code>. Resources of the same type are collected in a section.

The resources of the sections are denoted declaratively - that indicates the desired result without instructions for obtaining this result.
The appearance of the resources of individual sections is different.

![resource.png](./Images/resource.png)  

At the figure, the resource named `Tools` of the submodule type is located in the section `submodule` and has a shortened form of the record, whereas the resource `npm.install` of step type is placed in the `step` section and has a full (extended) record form.

### Type of resource

Functionality is associated with a group of resources, limited to the purpose. An example of resource types is a path, submodule, step, build. Each type of resource has its own purpose and is processed by utility in different ways.

### Resources by type

<details><summary><a href="./ResourcePath.md.md#Resource-path">
    Type of resources <code>path</code>
  </a></summary>
  Describe the file structure of the module, indicating the paths to the files of the module.
</details>
<details><summary><a href="./ResourceStep.md#Resource-step">
    Type of resources <code>step</code>
  </a></summary>
  The resource for the <code>step</code> section, which is an instruction for executing by the utility while constructing of the module. Describe the operations and the desired result. The builds consist of steps.
</details>
<details><summary><a href="./ResourceReflector.md#Resource-reflector">
    Type of resources <code>reflector</code>
  </a></summary>
  Resource of section <code>reflector</code>, technique to describe set of files to perform some operation at it.
</details>
<details><summary><a href="./SubmodulesLocalAndRemote.md">
    Type of resources <code>submodule</code>
  </a></summary>
  They are links to other modules that can be used as submodules of this module.
</details>
<details><summary><a href="./ResourceBuild.md#Resource-build">
    Type of resources <code>build</code>
  </a></summary>
  Contains a list of steps for building a module.
</details>
<details><summary><a href="./ResourceBuild.md#Resource-export">
    Type of resources <code>export</code>
  </a></summary>
  This is a special kind of build, the result of which is the generated `out-will-file` that can be used by another module.
</details>
<details><summary><a href="./SectionExported.md#Section-exported">
    Type of resources <code>exported</code>
  </a></summary>
  This resource is generated when the module is exported and only available in the generated files. The <code>out-will-file</code> has exactly the same amount of resources as <code>exported</code> as the number of times that the module was exported for different exports. Resources of this type include descriptive fields and a list of exported files.
</details>
