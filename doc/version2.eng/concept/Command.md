# Elements of an input in the command shell of the system

### Command

The raw which has a phrase in order to mark the intension of the developer and actions, which will be done by utility after its input. It is inputted in the interface of the command prompt by developer.

### Phrase

Word or couple of words which are separated by a point symbolize the command which should be done by utility.  

A point separate the words of the phrase on the parts, what facilitates typing and reading processes.

Example:
```
will .help
will .about.list
will .resources.list
will .paths.list

```

### Commands of the utility `willbe`

To display the commands of the utility, type `will` or `will .help`

| Phrase| Description                                       | Command                |
|-------------------|--------------------------------------------|----------------------------------|
| `.help`           | Display an information about the command| `will .help .[command]`          |
| `.set`            |    Setting parameters for the command     | `will .set [properties] .[command] [argument]`                                   |
| `.resources.list` | Display all available information about the current module   | `will .resources.list [resources] [criterion]`                                  |
| `.paths.list`     |  Recalculation of available paths of the current module | `will .paths.list [resources] [criterion]`         |
| `.submodules.list` | Recalculation of available submodules of the current module                   | `will .submodules.list [resources] [criterion]`     |
| `.reflectors.list` |  Recalculation of available reflectors of the current module                        | `will .reflectors.list [resources] [criterion]`     |
| `.steps.list`     |  Recalculation of available steps of the current module                             | `will .steps.list [resources] [criterion]`          |
| `.builds.list `   |     Recalculation of available builds of the current module        | `will .builds.list [resources] [criterion]`         |
| `.exports.list`   | Перерахунок наявних збірок для екаспортування поточного модуля Recalculation of available builds for the export of the current module           | `will .exports.list [resources] [criterion]`        |
| `.about.list`     | Display of description of the current module (section `about`)                               | `will .about.list`                                  |
| `.submodules.download` | Loading of each submodule according to resources of the section `submodule` | `will .submodules.download`               |
| `.submodules.update`  |  Verification and installation (if available) for each remoted submodule  | `will .submodules.update` |
| `.submodules.fixate`  | Reading and rewriting (without loading) URL-address remoted submodules in `will-file` on the last loaded version (last commit), it does not rewrite resources with specified version of the submodule. There is option `dry` with denotation "0" - implement rewriting and "1" - read without rewriting | `will .submodules.fixate [dry:1]` |
| `.submodules.upgrade.refs`  | Reading and rewriting (without loading) URL-address remoted submodules in `will-file` on the last loaded version (last commit), it ignores specified versions. There is option `dry` with denotation "0" - implement rewriting (by default) and "1" - read without rewriting  | `will .submodules.upgrade.refs [dry:1]` |
| `.submodules.clean`    | Deletion of all loaded submodules with the directory `.module`               | `will .submodules.clean`   |
| `.shell`          |  Implementation of the command in console of Operating System for the module                             | `will .shell [command_in_shell]`          |
| `.clean`          | Deletion of 3 types of the module out of directory 1) loaded submodules (directory `.module`); 2)`out` directory; 3) `temp` directory, if available                | `will .clean`                             |
| `.clean.what`     | `clean` Displays list of files, which can be deleted by the command `clean`             | `will .clean.what`                        |
| `.build`          | Construction of the module according to specified build                          | `will .build [scenario]`                  |
| `.export`         |   The form of the command `.build` for construction of module's export              | `will .export [scenario]`                 |
| `.with`           |  For the work with named `will-files`     | `will .with [will-file] [command] [argument]`                         |
| `.each`           | Implementation of specified command for each `will-file` in directory         | `will .each .[command]`                   |


Note. If command consists of two or more parts, then by the input of incomplete phrase utility will offer variants of addition. For example, by the input of the phrase `will .submodules` utility will propose all possible variants of phrases with word `submodule`:



<details>

  <summary><u> Command output <code>will .submodules</code></u></summary>

  ```
  [user@user ~]$ will .submodules
  Command ".submodules"
  Ambiguity. Did you mean?
    .submodules.list - List submodules of the current module.
    .submodules.clean - Delete all downloaded submodules.
    .submodules.download - Download each submodule if such was not downloaded so far.
    .submodules.update - Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.
    .submodules.fixate - Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.
    .submodules.upgrade.refs - Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.

  ```
