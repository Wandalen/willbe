## Quick start

For quick start [install](<./tutorial/Instalation.md>) utility `willbe`, [get acquainted with](<./tutorial/CLI.md>) command line interface and create the first [module "Hello World"](<./tutorial/HelloWorld.md>). [Read](<./tutorial/Abstract.md>) abstract if you are wondering what is it for and what philosophy is behind utility `willbe`.

For gentle introduction use tutorials. For getting exhaustive information on one or another aspect use list of concepts to find a concept of interest and dive into it.

## Concepts

<details>
  <summary><a href="./concept/WillFile.md"><code>Will-file</code>  </a></summary>
  Config for describing and building a module. Each formal module has such file.
</details>
<details>
  <summary><a href="./concept/WillFileNamedAndSplit.md#Named-will-file">Named <code>will-file</code></a></summary>
  Kind of <code>will-file</code> which has nonstandard name. It makes possible to have multiple modules with different names in a directory.
</details>
<details>
  <summary><a href="./concept/WillFileNamedAndSplit.md#Split-will-file">Split <code>will-file</code></a></summary>
  Splitting <code>will-file</code> into two files. One of them is for importing data and the other for exporting. Its make possible splitting data related building and development of a module and data related its exporting and reusing by other modules.
</details>
<details>
  <summary><a href="./concept/Structure.md#Resources">Resources</a></summary>
  Structural and functional element of <code>will-file</code>. Resources of the same type collected in a section.
</details>
<details>
  <summary><a href="./concept/Structure.md#Type-of-resource">Type of resource</a></summary>
  Functionality associated with group of resources restricted by its purpose. Examples of types of resources: path, submodule, step, build. Each type of resources has its own purpose and is treated by the utility differently.
</details>
<details>
  <summary><a href="./concept/Inheritance.md">Inheritance</a></summary>
  Approach of description of a module according to wich <code>will-file</code> can reuse (inherit) value of fields of other resource(s) of the same type.
</details>
<details>
  <summary><a href="./concept/ResourcePath.md#Path">Recource path</a></summary>
    Recource to describe file structure of the module, it has file paths to files of the module. Paths are collected in section <code>path</code>.
</details>
<details>
  <summary><a href="./concept/ResourceReflector.md#Resource-reflector">Resource reflector</a></summary>
  Resource of section <code>reflector</code>, technique to describe set of files to perform an operation on this set of files.
</details>
<details>
  <summary><a href="./concept/ReflectorFileFilter.md">File filters</a></summary>
  Technique to describe conditions of selection required files for some operation on group of files. Reflector has two file filters: <code>src</code> and <code>dst</code>.
</details>
<details>
  <summary><a href="./concept/ResourceReflector.md#map-of-paths">Map of paths</a></summary>
  A field of a reflector and a technique to describe set of files to include as many files as required and to exclude unwanted files with help of excluding conditions and globs.
</details>
<details>
  <summary><a href="./concept/ResourceStep.md#Resource-step">Resource step</a></summary>
  <code>Step</code> section resource which is an  executing instruction of module building.
</details>
<details>
  <summary><a href="./concept/ResourceBuild.md#Resource-build">Resource build</a></summary>
  Sequence and conditions of procedures execution to build a module. Developer has to select a particular build calling command <code>.build</code> by name or by constraints.
</details>
<details>
  <summary><a href="./concept/Structure.md#Section-will-file">Section <code>will-file</code></a></summary>
  Higher structural element of <code>will-file</code> which consists of resources of single type or fields, which describe the module.
</details>
<details>
  <summary><a href="./concept/SectionAbout.md">Section <code>about</code></a></summary>
  The section has descriptive information about the module.
</details>
<details>
  <summary><a href="./concept/ResourcePath.md#Section-path">Section <code>path</code></a></summary>
  The section has list of paths for fast understanding of files structure of the module.
</details>
<details>
  <summary><a href="./concept/SectionSubmodule.md">Section <code>submodule</code></a></summary>
  The section has information about submodules of the module.
</details>
<details>
  <summary><a href="./concept/ResourceReflector.md#Section-reflector">Section <code>reflector</code></a></summary>
  The section has reflectors, special type of resource for operation on groups of files.
</details>
<details>
  <summary><a href="./concept/ResourceStep.md#Section-step">Section <code>step</code></a></summary>
  The section has steps which could be used by build for building of the module.
</details>
<details>
  <summary><a href="./concept/ResourceBuild.md#Section-build">Section <code>build</code></a></summary>
  Resources of the section describe sequence and conditions of building the module.
</details>
<details>
  <summary><a href="./concept/SectionExported.md">Section <code>exported</code></a></summary>
  Section of <code>out-will-file</code>, programatically generated with exporting of the module. It has list of exported files and it used by other modules for importing the module.
</details>
<details>
  <summary><a href="./concept/Export.md#Exported-will-file-out-will-file">Exported <code>will-file</code> (<code>out-will-file</code>)</a></summary>
  <code>Out-will-file</code> - kind of <code>will-file</code> generated by the utility during exporting of a module. Other modules can use the module importing its <code>out-will-file</code>.
</details>
<details>
  <summary><a href="./concept/Module.md#Module">Module</a></summary>
  Module is set of files described in <code>will-file</code>.
</details>
<details>
  <summary><a href="./concept/Module.md#Submodule">Submodule</a></summary>
  A module with its own <code>will-file</code> which used but other module (supermodule).
</details>
<details>
  <summary><a href="./concept/Module.md#Supermodule">Supermodule</a></summary>
  A module which has other modules (submodules).
</details>
<details>
  <summary><a href="./concept/SubmodulesLocalAndRemote.md#Local-submodule">Local submodule</a></summary>
  A submodule which is located locally.
</details>
<details>
  <summary><a href="./concept/SubmodulesLocalAndRemote.md#Remote-submodule">Remote submodule</a></summary>
  A module which is located remotely. It should be downloaded to be used.
</details>
<details>
  <summary><a href="./concept/ModuleCurrent.md">Current module</a></summary>
  A module on which utility will perform operations. By default the module is loaded from file <code>.will.yml</code> of the current directory.
</details>
<details>
  <summary><a href="./concept/Export.md#Export">Export</a></summary>
  Special kind of build which required for the module to been used by other developers and modules. Result of exporting is artefacts among wich is <code>out-will-file</code>.
</details>
<details>
  <summary><a href="./concept/SubmoduleInformal.md">Informal submodule</a></summary>
  Set of files distribution of which does not have <code>will-file</code>. It's possible to create <code>will-file</code> for such submodule on side of user to use it as a submodule.
</details>
<details>
  <summary><a href="./concept/Command.md#Command">Command</a></summary>
  A string which has phrase which describe intention of developer and desirable result of operation to be done by utility after user enter it. Developer enters command in command line interface.
</details>
<details>
  <summary><a href="./concept/Command.md#Phrase">Phrase</a></summary>
  Word or several words, separated by dot, denotes command which utility will perform.
</details>
<details>
  <summary><a href="./concept/Selectors.md#Selector">Selector</a></summary>
  String-reference on resource or group of resources of the module.
</details>
<details>
  <summary><a href="./concept/Selectors.md#Selector-with-globs">Selector with globs</a></summary>
  Selector which use glob technique for selecting resources of the module.
</details>
<details>
  <summary><a href="./concept/Criterions.md">Criterion</a></summary>
  Element of comparison for selection of resources.
</details>
<details>
  <summary><a href="./concept/Asserts.md">Glob with assertion</a></summary>
  Restriction of glob by number of expected resources which should be found by the selector.
</details>

## Tutorials

<details>
  <summary><a href="./tutorial/Abstract.md">Abstract</a></summary>
  General information. What utility <code>willbe</code> is and what it is not.
</details>
<details>
  <summary><a href="./tutorial/Installation.md">Installation</a></summary>
  Procedure of instalation of utility. <code>willbe</code>
</details>
<details>
  <summary><a href="./tutorial/CLI.md">Command line interface</a></summary>
  How to use command line interface of utility <code>willbe</code>. How to use command <code>.help</code> and command <code>.list</code>.
</details>
<details>
  <summary><a href="./tutorial/HelloWorld.md">Module "Hello, World!"</a></summary>
  Creating module "Hello, World!". Downloading of remote submodule.
</details>
<details>
  <summary><a href="./tutorial/CommandsSubmodules.md">Commands of updating, upgrading and cleaning of submodules</a></summary>
  Commands of updating files of submodules, upgrading submodules rewriting <code>will-file</code> automatically and cleaning of submodules removing downloaded files.
</details>
<details>
  <summary><a href="./tutorial/Build.md">Module building by command <code>.build</code></a></summary>
  Building chosen builds of the module.
</details>
<details>
  <summary><a href="./tutorial/StepsPredefined.md">Predefined steps</a></summary>
  How to use predefined steps for operating remote submodules.
</details>
<details>
  <summary><a href="./tutorial/Criterions.md">Criterions</a></summary>
  How to use criterions for resource selection.
</details>
<details>
  <summary><a href="./tutorial/CriterionDefault.md">Default build</a></summary>
  How to build without explicit argument for command <code>.build</code>.
</details>
<details>
  <summary><a href="./tutorial/ModuleExport.md">Exporting of a module</a></summary>
  Exporting a module to use it by another developer or module.
</details>
<details>
  <summary><a href="./tutorial/SubmodulesLocal.md">Importing of local submodule</a></summary>
  How to use local submodule from another module (supermodule).
</details>
<details>
  <summary><a href="./tutorial/SelectorsWithGlob.md">Selectors with globs</a></summary>
  How to use selectors with globs.
</details>
<details>
  <summary><a href="./tutorial/AssertsUsing.md">How to use assertions</a></summary>
  How assertions help to avoid errors during development.
</details>
<details>
  <summary><a href="./tutorial/WillFileMinimization.md">Minimization of <code>will-file</code></a></summary>
  How to minimize <code>will-file</code> with help of instantiation of sets of criterions.
</details>
<details>
  <summary><a href="./tutorial/WillFileSplit.md">Split <code>will-files</code></a></summary>
  How to create and use a module with split <code>will-fileми</code>.
</details>
<details>
  <summary><a href="./tutorial/WillFileNamed.md">Command <code>.with</code> and named <code>will-file</code></a></summary>
  How to use command <code>.with</code>? What is named <code>will-file</code>?
</details>
<details>
  <summary><a href="./tutorial/CommandEach.md">Command <code>.each</code></a></summary>
  How to use command <code>.each</code> for executing same operation for each module or submodule.
</details>
<details>
  <summary><a href="./tutorial/StepJS.md">Using <code>JavaScript</code> files by utility <code>willbe</code></a></summary>
  How to use JavaScript files by utility <code>willbe</code> for complicated scenarios of builds.
</details>
<details>
  <summary><a href="./tutorial/CommandSet.md">Command <code>.set</code></a></summary>
  How to use command <code>.set</code> to change state of the utility, for example to change level of verbosity.
</details>
<details>
  <summary><a href="./tutorial/SelectorComposite.md">Composite selectors</a></summary>
  How to use composite selectors for selecting of resources of submodules.
</details>
<details>
  <summary><a href="./tutorial/CommandsListSearch.md">List of resources with filter and glob</a></summary>
  How to request for list of resources which satisfy filter and glob.
</details>
<details>
  <summary><a href="./tutorial/ReflectorUsing.md">Copying of files with help of reflectors</a></summary>
  How to copy files with help of reflectors, field <code>recursive</code> of reflector.
</details>
<details>
  <summary><a href="./tutorial/ReflectorFilters.md">Filters of reflector</a></summary>
  How to use filters of reflectors for selection of files for coping.
</details>
<details>
  <summary><a href="./tutorial/ReflectorTimeFilters.md">Time filters of reflector</a></summary>
  How to use filters to select files by age.
</details>
<details>
  <summary><a href="./tutorial/ReflectorFSControl.md">Forming of paths in reflectors. Restrictors of copying</a></summary>
  Describe algorithm of path forming and explicit copying restrictions.
</details>
<details>
  <summary><a href="./tutorial/ReflectorsPredefined.md">Predefined reflectors</a></summary>
  How to use predefined reflectors to split debug and release files and how to build a multibuild.
</details>
<details>
  <summary><a href="./tutorial/ResourceInheritance.md">Resources inheritance</a></summary>
  How to use resource inheritance to reuse data.
</details>
<details>
  <summary><a href="./tutorial/StepView.md">Predefined step <code>predefined.view</code></a></summary>
  How to use predefined step <code>predefined.view</code> to view file.
</details>
<details>
  <summary><a href="./tutorial/StepTranspile.md">Transpilation</a></summary>
  How to use predefined step <code>predefined.transpile</code> to transpile <code>JavaScript</code> files or concatenate them.
</details>
<details>
  <summary><a href="./tutorial/CommandShell.md">Command <code>.shell</code> </a></summary>
  A command to call external application by utility <code>willbe</code> for chosen modules or submodules.
</details>
<details>
  <summary><a href="./tutorial/WillbeAsMake.md">Compiling of С++ application</a></summary>
  How to use utility <code>willbe</code> for compiling С++ application.
</details>
<details>
  <summary><a href="./tutorial/SubmoduleInformal.md">Informal submodules</a></summary>
  Importing of informal submodules.
</details>
<details>
  <summary><a href="./tutorial/CommandClean.md">Command  <code>.clean</code></a></summary>
  How to use command <code>.clean</code> for deleting generated and downloaded files.
</details>
