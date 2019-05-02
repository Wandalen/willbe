# Command <code>.submodules.fixate</code>

The command to fixate the submodule version in <code>willfile</code> using its automated overwriting.

Stability of the module with remote submodules depends on the quality of the submodules. Updating remote submodules may cause the module to fail or become unstable. To avoid this problem during development and support, fixate the submodule versions with the command `. submodules. fixate`.

The command is intended for automated overwriting of current URI links of remote submodules in `willfile`. The command changes the current URIs to the most recent versions of submodule URIs. At the same time, downloading files of these submodules do not automatically occur. The command `.submodules.fixate` overwrites only those submodules for which the version (commit) is explicitly not specified.

The command has the option `dry` to enable overwriting of the `willfile`. It takes the value `0` i` 1`. At `dry:0` the command overwrite URI-links. At `dry:1` the command `will. submodules. fixate dry:1` performs all the operation and displays the list of available updates without changing `willfile`. The default value is `dry:0`.

### File structure

<details>
  <summary><u>File structure</u></summary>

```
submodulesFixate
        └── .will.yml

```

</details>

To test the command, create a module with the specified file structure and enter the code in the `willfile`.

<details>
    <summary><u>Code of file <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.fixate command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

### Command `.submodules.fixate` using

<details>
  <summary><u>Command output<code>will .submodules.fixate dry:1</code></u></summary>

```
[user@user ~]$ will .submodules.fixate dry:1
...
Remote path of module::submodulesCommands / module::Tools will be fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#56afe924c2680301078ccb8ad24a9e7be7008485 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::PathFundamentals will be fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/.will.yml
Remote path of module::submodulesCommands / module::Files will be fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/.will.yml

```

</details>

Navigate to the `submodulesFixate` directory and find the updates for the submodules with `.submodules.fixate` command using the `dry: 1` option.

Overwriting of submodule URI links did not occur, file `.will.yml` remained unchanged, and the console showed the list of submodules with the latest available versions.

The command output has three rows with the words `will be fixated`. There are more recent versions available for all three submodules. The `willfile` will be overwritten by these versions when the `will .submodules.fixate dry:0` command will be executed.

<details>
  <summary><u>Section <code>submodule</code> with changes in <code>Tools</code> submodule</u></summary>

```yaml    
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```

</details>

Open the file `.will.yml` and change the resource `Tools` on the above.

<details>
  <summary><u>Command output <code>will .submodules.fixate</code></u></summary>

```
[user@user ~]$ will .submodules.fixate
...
Remote path of module::submodulesCommands / module::PathFundamentals fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#84dd78771fd257bf8599dafe3cc37a9407a29896 <- .#master
  in /path_to_file/submodulesFixate/.will.yml
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#5a29f780c4c7ff7f2202dd8c61562d1f2ae095e9 <- .#master
  in /path_to_file/submodulesFixate/.will.yml

```

</details>

Enter the command `.submodules.fixate` without arguments.

Utility replaced versions of submodules in `wilfile`. At the time, command `.submodules.fixate` did not replace the `Tools` submodule for which the version is explicitly specified.

Use the command `.submodules.fixate` before building the module or immediately after. It fixates the version of submodules. The release of subsequent versions of submodules cannot break the module's work, and the developer will be able to update them at a convenient time.

To overwrite URI links of submodules to the most recent ones, regardless of whether the version of the submodule was specified, the [command `.submodules.upgrade`](CommandSubmodulesUpgrade .md)  is used, to download the submodule files [the command `.submodules.update`](CommandSubmodulesUpdate .md) is used.

### Summary

- Command `.submodules.fixate` ensures the stability of the module with remote submodules.
- Command `.submodules.fixate` designed to overwrite the URI-links of submodules.  
- Command `.submodules.fixate` automatically changes the contents of `willfile` for the developer.
- Command `.submodules.fixate` does not download the files of submodules.
- Command `.submodules.fixate` does not change the links with the explicitly specified version (commit).
- Command `.submodules.fixate` is better to use before the building of the module or immediately after. Thus, version remote submodule fixates at the time of building and ensures reliable work of module.

[Return to content](../README.md#tutorials)
