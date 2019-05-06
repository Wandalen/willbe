# Command line interface

How to use command line interface of utility <code>willbe</code>. How to use command <code>.help</code> and command <code>.list</code>.

### Complement of the commands

After [installation](<Instalation.md>) of utility `willbe` enter the [`will .` command](../concept/Command.md#Commands-of-the-utility-willbe) in the console of your operating system.

<details>
  <summary><u>Command output <code>will .</code></u></summary>

```
[user@user ~]$ will .  
Command "."
Ambiguity. Did you mean?
  .help - Get help.
  .set - Command set.
  .resources.list - List information about resources of the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List avaialable reflectors.
  .steps.list - List avaialable steps.
  .builds.list - List avaialable builds.
  .exports.list - List avaialable exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.
  .submodules.clean - Delete all downloaded submodules.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.update - Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.
  .submodules.fixate - Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.
  .submodules.upgrade - Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.
  .shell - Execute shell command on the module.
  .clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules.
  .clean.what - Find out which files will be deleted by clean command.
  .build - Build current module with spesified criterion.
  .export - Export selected the module with spesified criterion. Save output to output file and archive.
  .with - Use "with" to select a module.
  .each - Use "each" to iterate each module in a directory.
```

</details>

All commands of utility `willbe` start with` will .`. Each command is a phrase composed of one or more words. For example:

```
will .help
will .about.list
will .resources.list
will .paths.list
```

Enter the command `will .list`:

<details>
  <summary><u>Command output <code>will .list</code></u></summary>

```
[user@user ~]$ will .list
Command ".list"
Ambiguity. Did you mean?
  .resources.list - List information about resources of the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List avaialable reflectors.
  .steps.list - List avaialable steps.
  .builds.list - List avaialable builds.
  .exports.list - List avaialable exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.

```

</details>

To get a list of phrases that have the word `list`, type the `will .list` command.

The `willbe` utility knows many commands containing the word` list` thus it outputs information about all possible phrases with the specified word. This is useful if you forgot the full phrase with the command. It helps to explore the utility capability. To get an exhaustive list of commands with a given word just enter it and the utility will offer options for adding.

### Command `.help`

For help on the selected command, use the syntax [`will .help [command]`](../concept/Command.md#Commands-of-the-utility-willbe).    
Now, enter in the terminal `will .help .build`:

<details>
  <summary><u>Command output<code>will .help .build</code></u></summary>

```
[user@user ~]$ will .help .build
Command ".help .build"

  .build - Build current module with specified criterion.

```

</details>

Enter the command `will .help .builds.list` and compare the output.

<details>
  <summary><u>Command output<code>will .help .builds.list</code></u></summary>

```
[user@user ~]$ will .help .builds.list
Command ".help .builds.list"

  .builds.list - List avaialable builds.

```

</details>

<details>
  <summary><u>Commands output<code>will .help .submodules</code></u></summary>

```
[user@user ~]$ will .help .submodules
Command ".help .submodules"

  .submodules.list - List submodules of the current module.
  .submodules.clean - Delete all downloaded submodules.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.update - Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.
  .submodules.fixate - Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.
  .submodules.upgrade - Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.

```

</details>

To get the information about all phrases containing the word `submodule`, enter the command `will .help .submodules`.

The command was incomplete, and the utility `willbe` again offered phrase variants with the specified word.

### Command `.*.list`  

Most commands work with the `willfiles` of specific modules.


<details>
  <summary><u>File structure</u></summary>

```
commands
    └── .will.yml

```

</details>

Create a new directory named `commands` and put a file named `.will.yml`.

<details>

  <summary><u>Code of the file<code>.will.yml</code></u></summary>

```yaml
about :
  name : test
  description : "To test commands of willbe-package"
  version : 0.0.1

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

path :

  proto : 'proto'
  out.debug : 'out/debug'

step :

  delete.proto :
    inherit : predefined.delete
    filePath: path::proto

  delete.out.debug :
    inherit : predefined.delete
    filePath : path::out.debug

build :

  debug :
    criterion :
      default : 1
    steps :
      - submodules.download
      - delete.out.debug
      - delete.proto

```

</details>

Copy the code in the `.will.yml` file.  

Utility `willbe` has the list of [commands that ends on ` .list`](../concept/Command.md#Commands-of-the-utility-willbe). They display a list of resources of the given type of the current module. Therefore, if you type one of the `.*.list` commands in the directory where` willfile `is missing, you will receive a warning about the absence of the module.

<details>
  <summary><u>Command output <code>will .builds.list</code>in the current directory</u></summary>

```
[user@user ~]$ will .builds.list
Command .builds.list
Found no module::/[path] at "/[path]"

```

</details>

To make sure that the `.builds.list` command works with the current module, enter in its  directory without the `willfile`.

<details>
  <summary><u>Command output <code>ls -al</code></u></summary>

```
[user@user ~]$ ls -al
total 12
drwxr-xr-x 2 user user 4096 Mar 11 11:27 .
drwxr-xr-x 6 user user 4096 Mar 11 11:27 ..
-rw-r--r-- 1 user user  917 Mar  4 15:07 .will.yml

```

</details>

Open the `commands` directory in the console and check its contents by executing the `ls -al` command.

<details>
  <summary><u>Command output <code>will .about.list</code></u></summary>

```
About
  name : 'test'
  description : 'To test commands of willbe-package'
  version : '0.0.1'
  enabled : 1
```

</details>

To get a descriptive information about the module use the command `will .about.list`.

Please, note that some resources have fields with default values. If the resource has no such field, utility generates it by loading `willfile` from the disk.

<details>
  <summary><u>Section <code>about</code> of the file <code>.will.yml</code></u></summary>

```yaml
about :
  name : test
  description : "To test commands of willbe-package"
  version : 0.0.1

```

</details>

Therefore,  section `about` has an `enabled` field in the output of the command `will.about.list` that does not exist in the `willfile`.

<details>
  <summary><u>Command output <code>will .builds.list</code></u></summary>

```
[user@user ~]$ will .builds.list
Command ".builds.list"
...
build::debug
  criterion :
    default : 1
  steps :
    - submodules.download
    - delete.out.debug
    - delete.proto

```

</details>
<details>
  <summary><u>Section <code>build</code> of the file <code>.will.yml</code></u></summary>

```yaml
build :

  debug :
    criterion :
      default : 1
    steps :
      - submodules.download
      - delete.out.debug
      - delete.proto

```

</details>

To obtain the list of builds of the current module, enter the command `will .builds.list`. Once the result is displayed on the monitor, open the `.will.yml` file using a text editor and compare the contents of the `build` section and the output of the command.

You can get information about a separate section of the `willfile` by entering the phrase `will.[Section name].list`.


<details>
  <summary><u>Command output <code>will .submodules.list</code></u></summary>

```
[user@user ~]$ will .submodules.list
Command ".submodules.list"
   . Read : /path_to_file/submodules/.will.yml
 . Read 1 willfiles in 0.084s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : false
  Exported builds : []
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```

</details>

<details>
  <summary><u>Section <code>submodule</code> of the file <code>.will.yml</code></u></summary>

```yaml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

</details>

The utility displays a warning error message when reading information about the submodule and recommends loading it by using the command `.submodules.download`.


<details>
  <summary><u>Error message about reading submodules</u></summary>

```
! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

```

</details>

The information that the utility `willbe` output corresponds to the one that is written in the `willfile`.

To enumerate all resources of the current module use `will.resources.list` command:

<details>
  <summary><u>Command output <code>will .resources.list</code></u></summary>

```
[user@user ~]$ will .resources.list
  . Read : /path_to_file/.will.yml
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even .clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even .clean it before downloading
 . Read 1 willfiles in 1.865s

About
  name : 'test'
  description : 'To test commands of willbe-package'
  version : '0.0.1'
  enabled : 1

Paths
  predefined.willbe : '/usr/lib/node_modules/willbe/proto/dwtools/atop/will/Exec'
  predefined.will.files : '/home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe/sample/version2/CLI/.will.yml'
  predefined.dir : '/home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe/sample/version2/CLI'
  proto : 'proto'
  out.debug : 'out/debug'

submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : false
  Exported builds : []

submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

step::delete.proto
  opts :
    filePath : path::proto
  inherit :
    predefined.delete

step::delete.out.debug
  opts :
    filePath : path::out.debug
  inherit :
    predefined.delete

build::debug
  criterion :
    default : 1
  steps :
    submodules.download
    delete.out.debug
    delete.proto

```

</details>

### Summary

- Use [the `will .` command](#command-help) to get the list of commands (phrases).
- Use the [`will .[word]` command](#command-help) to get the list of all commands (phrases) that have the word `word`.
- Use the [command `will .help *`](#команда-help) to get help with a specific command.
- If you forget the full phrase then `willbe` will list the phrases by [word](#CLI) which you remember.
- Use the [command `will .[resource].list`](#Command-list) in order to enumerate the resources of the type `resource` of the module.
- Use the [`will .resources.list` command](#Command-list) to enumerate all the resources of this module.

[Next tutorial](FirstWillFile.md).
[Return to content](../README.md#tutorials)
