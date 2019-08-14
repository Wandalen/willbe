# Command <code>.submodules.upgrade</code>

The command to upgrade the version of the submodules using the automated overwriting of the <code>willfile</code>.

Submodule versions available at the time of export may be [fixated](CommandSubmodulesFixate.md). The `.submodules.upgrade` the command allows you to fixate the latest versions of submodules.

The command is intended for automated overwriting of current URI links of remote submodules in `willfile`. The command changes the current URIs to the most recent versions of submodule URIs. At the same time, downloading files of these submodules do not automatically occur.

The command has the option `dry` to enable overwriting of the `willfile`. It takes the value `0` and `1`. At `dry:0` the command overwrite URI-links. At `dry:1` the command `will. submodules.fixate dry:1` performs all the operation and displays the list of available updates without changing any file. The default value is `dry:0`.

### File structure

<details>
  <summary><u>File structure</u></summary>

```
submodulesUpgrade
          └── .will.yml
```

</details>

To test the command, create a module with the specified file structure and enter the code in the `willfile`. 

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.upgrade command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#ec60e39ded1669e27abaa6fc2798ee13804c400a
  PathBasic : git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic#master
  Files : git+https:///github.com/Wandalen/wFiles.git/out/wFiles#master

```
</details>

The submodule `Tools` has the specified version.

### Using of `.submodules.upgrade` command

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
Remote path of module::submodulesCommands / module::PathBasic fixated
  git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic : .#d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml
Remote path of module::submodulesCommands / module::Files fixated
  git+https:///github.com/Wandalen/wFiles.git/out/wFiles : .#075ce0ca21af083bc879b0d1a4091a29ed4a16d2 <- .#master
  in /path_to_file/submodulesUpgrade/.will.yml

```

</details>

Update the URIs of the submodules with the `will.submodules.upgrade` command.

The output indicates that the `.submodules.upgrade`  command has updated all three URI links of submodules to the latest ones (at the time of execution). The `Tools` submodule was also upgraded without taking into account the explicitly specified version.

The command `.submodules.upgrade` overwrites the URI versions of [informal submodules](SubmoduleInformal.md) if they are present in the` willfile`.

The command `.submodules.upgrade` is useful for automatically upgrading submodules to the latest versions. The command only overwrites the `willfiles`. The command does not download submodules files. To download submodel files use [command `.submodules.update`](CommandSubmodulesUpdate.md).

### Summary

- Command `.submodules.upgrade` overwrites the contents of the `willfiles` by upgrading the submodule versions;
- Command `.submodules.upgrade` does not download the files of submodules.
- Command `.submodules.upgrade` allows the developer to ensure the stability of the module by updating the submodules only at the right time.

[Back to content](../README.md#tutorials)
