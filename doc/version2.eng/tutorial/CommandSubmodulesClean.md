# Command <code>.submodules.clean</code>

The command to clear the module from the temporary and downloaded submodules.

[Command `.submodules.clean`](../concept/Command.md#Commands-of-the-utility-willbe) is used to remove remote submodules from the` .module` directory.

### File structure

<details>
  <summary><u>File structure</u></summary>

```
 submodulesClean
          └── .will.yml    

```

</details>

To test the command, create the file structure specified above.  

<details>
    <summary><u>Code of file <code>.will.yml</code></u></summary>

```yaml
about :

  name : submodulesCommands
  description : "To test .submodules.clean command"

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathBasic : git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic#master

```

</details>

Enter the code in `willfile`

### Using the command `.submodules.clean`

To use the `.submodules.clean` command you need to have downloaded submodules.

<details>
  <summary><u>Command output <code>will .submodules.download</code></u></summary>

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools version 7db7bd21ac76fc495aae44cc8b1c4474ce5012a4 was downloaded in 16.504s
   . Read : /path_to_file/.module/PathBasic/out/wPathBasic.out.will.yml
   + module::PathBasic version d95a35b7ef1568df823c12efa5bd5e1f4ceec8b7 was downloaded in 5.986s

```

</details>

Download the submodules using the `will .submodules.download` command.

<details>
  <summary><u>File structure after executing the command <code>will .submodules.download</code></u></summary>

```
submodulesCommands
        ├── .module
        │      ├── PathBasic
        │      └── Tools
        └── .will.yml

```

</details>

Check the changes in the `submodulesClean` directory after the build. Compare file structure with the above.

Utility created the `.module` directory where the `Tools` and `PathBasic` remote submodules files are downloaded.   

<details>
  <summary><u>Command output <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 551 file(s) in 1.753s

```

</details>

The `.submodules.clean` command removes the downloaded submodules and the` .module` directory with them. Enter the command and check the changes in the `submodulesClean` directory.

<details>
  <summary><u>File structure after executing the command <code>will .submodules.clean</code></u></summary>

```
submodulesCommands
        └── .will.yml

```

</details>

The executed `will .submodules.clean` command has returned the module to its original state. The `.module` directory has been deleted, and the `willfile` has not changed.

### Summary

- The `.submodules.clean` command is useful if you need to clean the module from the files of downloaded submodules.
- The `.submodules.clean` command does not change `willfile`.

[Back to content](../README.md#tutorials)
