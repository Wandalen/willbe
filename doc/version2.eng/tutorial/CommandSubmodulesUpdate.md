# Command <code>.submodules.update</code>

Command to update remote submodules.

The commands [`.submodules.fixate`](CommandSubmodulesFixate.md) and [`.submodules.upgrade`](CommandSubmodulesUpgrade.md) overwrite the URIs in the `willfile`, but do not download the files of these submodules. They are necessary for managing the versions of remote submodules and allow the developer to install and fixate updates at a convenient time. The [`.submodules.update`](../concept/Command.md#Commands-of-the-utility-willbe) command is used to download updates.

To get information about the ability to update submodule files without actually updating, use the `dry` option. When `dry:1` is set, the `will .submodules.update dry:1` command performs all operations, displays a list of available updates without changing any file. The default value is `dry:0`.

### File structure

<details>
  <summary><u>File structure</u></summary>

```
submodulesUpdate
          └── .will.yml
```

</details>

To test the command, create a module with the specified file structure and enter the code in the `willfile`. 

<details>
    <summary><u>Code of file <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.update command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

</details>

The submodule `Tools` has the specified version.

### Command `.submodules.update`

<details>
  <summary><u>Command output <code>will .submodules.update dry:1</code></u></summary>

```
[user@user ~]$ will .submodules.update dry:1
...
  + module::Tools will be updated to version ec60e39ded1669e27abaa6fc2798ee13804c400a
  + module::PathFundamentals will be updated to version aa4b10e291c0cb0e79961b6ece128da544f00568
```

</details>

Use `will .submodules.update dry:1` to get information about submodules, versions of which can be updated. The `dry:1` option allows you not to download the submodule files.

The command output shows (at the time of creating the tutorial):
- the `Tools` submodule will be updated to the specified version of the commit - `# ec60e39ded1669e27abaa6fc2798ee13804c400a`;
- the version of `PathFundamentals` submodule will be updated to  `#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7`.

<details>
  <summary><u>Command output <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
  . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version ec60e39ded1669e27abaa6fc2798ee13804c400a was updated in 13.440s
   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals version master was updated in 5.047s

   + 2/2 submodule(s) of module::submodulesCommands were updated in 18.487s

```

</details>

Update the files of the remote submodules by entering the command `will .submodules.update`. Find the versions of downloaded submodules in the output.


<details>
  <summary><u>File structure after updating</u></summary>

```
submodulesUpdate
        ├── .module
        └── .will.yml

```

</details>

The `.module` directory for submodules has appeared.

The utility has downloaded updates for both submodules according to the installed versions: `#master` for the submodule` PathFundamentals` and `#ec60e39ded1669e27abaa6fc2798ee13804c400a` for the `Tools` submodule.  

The version of the `Tools` submodule is outdated. Update it.

<details>
  <summary><u>Command output <code>will .submodules.upgrade</code></u></summary>

```
[user@user ~]$ will .submodules.upgrade
...
Module at /path_to_file/.will.yml
...
  Remote path of module::submodulesCommands / module::Tools fixated
  git+https:///github.com/Wandalen/wTools.git/out/wTools : .#7db7bd21ac76fc495aae44cc8b1c4474ce5012a4 <- .#ec60e39ded1669e27abaa6fc2798ee13804c400a
  in /path_to_file/submodulesUpgrade/.will.yml
Remote path of module::submodulesCommands / module::PathFundamentals fixated
  git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals : .#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml

```

</details>

To update the `Tools` submodule, you need to modify its URI link in the `willfile`. The `will .submodules.upgrade` command do this automatically.

<details>
  <summary><u>Command output <code>will .submodules.update</code></u></summary>

```
[user@user ~]$ will .submodules.update
...
  . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version 7db7bd21ac76fc495aae44cc8b1c4474ce5012a4 was updated in 11.320s

  + 1/2 submodule(s) of module::submodulesCommands were updated in 11.420s

```

</details>

After executing the command `.submodules.upgrade`, the `Tools` submodule changed the version to a newer - `7db7bd21ac76fc495aae44cc8b1c4474ce5012a4` Therefore, the command `.submodules.update` has downloaded this updated version. Compare with the above output.

### Summary

- The `.submodules.update` command downloads submodule files.
- The `.submodules.update` command does not overwrite` willfile`, the commands [`.submodules.fixate`](CommandSubmodulesFixate.md) and [`.submodules.upgrade`](CommandSubmodulesUpgrade.md) are used for this purpose.
- The functions of rewriting the `willfile` and downloading submodule updates by the command` .submodules.update` are separated. It prevents crashes in the development process caused by changes in submodules. So, this allows the developer to update the remote submodules at a convenient time.

[Back to content](../README.md#tutorials)
