### Command

A string which has a phrase which describes the intention of a developer and actions which will be done by utility after the user enters it. It is entered in the interface of the command prompt by the developer.

### Phrase

The word or a couple of words which are separated by a point. It specifies the command to be executed by the utility.

A point separates the words of the phrase on the parts, it facilitates typing and reading processes.

Examples:

```
will .help
will .about.list
will .resources.list
will .paths.list
```
### Commands of the utility `willbe`

To display the commands of the utility, type `will .` or `will .help`

| Phrase             | Description                                | Command                          |
|--------------------|--------------------------------------------|----------------------------------|
| `.help`            | Display an information about the command   | `will .help .[command]`          |
| `.set`             | Change the internal state of the utility, for example, the level of verbosity | `will .imply [properties] .[command] [argument]`                                   |
| `.resources.list`  | Display all available information about the current module   | `will .resources.list [resources] [criterion]`  |
| `.paths.list`      | List paths of the current module           | `will .paths.list [resources] [criterion]`         |
| `.submodules.list` | List submodules of the current module      | `will .submodules.list [resources] [criterion]`   |
| `.reflectors.list` | List avaialable reflectors the current module  | `will .reflectors.list [resources] [criterion]`     |
| `.steps.list`      | List avaialable steps the current module       | `will .steps.list [resources] [criterion]`   |
| `.builds.list `    | List avaialable builds the current module      | `will .builds.list [resources] [criterion]`   |
| `.exports.list`    | List avaialable exports the current module     | `will .exports.list [resources] [criterion]`   |
| `.about.list`      | Display descriptive infoormation about current module (section `about`)  | `will .about.list`   |
| `.submodules.download` | Download each submodule if such was not downloaded so far. There is option `dry` with denotation "0" - implement downloading and "1" - display a list of submodules to download. Default value is "0" | `will .submodules.download`               |
| `.submodules.update`   | Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version. There is option `dry` with denotation "0" - implement updating and "1" - display a list of submodules to update. Default value is "0" | `will .submodules.update` |
| `.submodules.fixate`  | Fixates the submodule version, patching the current submodule paths in `willfile` to the latest versions of the remote submodules, unless a specific version was specified. There is option `dry` with denotation "0" - implement rewriting and "1" - read without rewriting. Default value is "0" | `will .submodules.fixate [dry:1]` |
| `.submodules.upgrade`  | Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version. There is option `dry` with denotation "0" - implement rewriting and "1" - read without rewriting. Default value is "0"  | `will .submodules.upgrade.refs [dry:1]` |
| `.submodules.clean` | Delete all downloaded submodules with the directory `.module` | `will .submodules.clean`   |
| `.shell`          |  Execute shell command on the module                       | `will .shell [command_in_shell]`          |
| `.clean`          | Deletion of 3 types of the module out of directory. Command deletes: 1) downloaded submodules (directory `.module`); 2)`out-willfile` and archive; 3) `path::temp` specified directory (if this path is determined in `willfile`). There is option `dry` with denotation "0" - implement deletion and "1" - display information about the files to be deleted. Default value is "0" | `will .clean [dry:1]` |
| `.build`          | Construction of the module according to specified build                          | `will .build [scenario]`                  |
| `.export`         | Exports the module for use it with its other modules      | `will .export [scenario]`                 |
| `.with`           | Select the current module by the name of its `willfiles` | `will .with [willfile] [command] [argument]`                         |
| `.each`           | Implementation of specified command for each module in the directory         | `will .each .[command]`                   |

### Incomplete command entry

If command consists of two or more parts, then by the input of incomplete phrase utility will offer variants of addition.

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
    .submodules.fixate - Fixate remote submodules. If URI of a submodule does not contain a version then the version will be appended.
    .submodules.upgrade - Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.

  ```
</details>

For example, by the input of the phrase `will .submodules` utility will propose all possible variants of phrases with the word `submodule`
