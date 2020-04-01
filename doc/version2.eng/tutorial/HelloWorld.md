# Module "Hello, World!"

Creating module "Hello, World!". Downloading of remote submodule.

### Properties of `willfile`

`willfile` is a configuration file for building a modular system by utility `willbe`. It has its own [attributes](WillFile.md).

### First module

Creation of first module.

<details>
  <summary><u>File structure</u></summary>

```
first               # directory, the name is arbitrary
  └── .will.yml     # configuration file

```
</details>

To create the first module create an empty `first` directory. In the newly created directory `first` create an empty file named `.will.yml`.

<details>
  <summary><u>Code of the file <code>.will.yml</code></u></summary>

```yaml
about :

    name : helloWorld
    description : 'Hello, World!'
    version : 0.0.1
    keywords :
        - key
        -word
```
</details>

Copy the specified code into the `.will.yml` file.

<details>
  <summary><u>Command output <code>will .about.list</code></u></summary>

  ```
[user@user ~]$ will .about.list
Command ".about.list"
  . Read : /path_to_file/.will.yml
. Read 1 willfiles in 0.109s
About
 name : 'helloWorld'
 description : 'Hello, World!'
 version : '0.0.1'
 enabled : 1
 keywords :
   'willbe'

```

</details>

Make sure the module is created by executing the `will.about.list` command in the `first` directory.

The `about` section contains descriptive information, its presence is necessary to export this module and use it by other modules and developers.

### First construction

First construction of the module.


<details>
  <summary><u>Files structure</u></summary>

```
first
  └── .will.yml

```
</details>

<details>
  <summary><u>Code of the file <code>.will.yml</code></u></summary>

```yaml
about :

    name : helloWorld
    description : 'Hello, World!'
    version : 0.0.1
    keywords :
        - willbe

submodule :

    Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

</details>

Add the ready submodule. Use the remote module on `git+https:///github.com/Wandalen/wTools.git/out/wTools` by adding it to `submodule` section of the ` willfile`.

<details>
  <summary><u>Command output<code>will .submodules.list</code></u></summary>

```
[user@user ~]$ will .submodules.list
...
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
...
  isDownloaded : false
  Exported builds : []

```

</details>

Use the phrase `will.submodules.list` to get information about submodules.

<details>
  <summary><u>Command output<code>will .submodules.download</code></u></summary>

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 12.360s
 + 1/1 submodule(s) of module::helloWorld were downloaded in 12.365s

```

</details>

Enter the command `will.submodules.download` in the `first` directory.

The `will .submodules.download` command is used to download remote submodules. It has the option `dry` to enable downloading of submodules. The option has the value `0` and `1`. When `dry:0` is specified, the submodules are updated. If `dry:1` is specified, the `will .submodules.update dry:1` command displays a list of submodules that will be updated, but submodules are not downloaded. The default value is `dry: 0`, it is automatically added by the utility when there is no option in the entered command.

<details>
  <summary><u>Command output <code>ls -al</code></u></summary>

```
[user@user ~]$ ls -al
...
drwxr-xr-x 4 user user 4096 Mar 12 07:20 .module
-rw-r--r-- 1 user user  306 Mar  1 11:20 .will.yml

```

```
[user@user ~]$ ls -al module/
...
drwxr-xr-x 4 user user 4096 Mar 12 07:20 Tools

```

</details>
<details>
  <summary><u>The structure of the files corresponding to the output of the commands <code>ls -al</code></u></summary>

```
first
  ├── .module
  │       └── Tools
  └── .will.yml

```

</details>

Check the changes in the module directory by using the `ls` command. In the directory `.module` for the downloaded submodules, the utility `willbe` placed the submodule `Tools`.

<details>
  <summary><u>Command output<code>will .submodules.list</code></u></summary>

```
[user@user ~]$ will .submodules.list
...
 . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
...
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

```

</details>

Check the status of the submodule after it is downloaded.

Pay attention to the line `submodule::Tools`, which represents the submodule of the section. Console output of resources has form `Section name::Name of the resource`.

<details>
  <summary><u>Command output <code>will .about.list</code></u></summary>

```
[user@user ~]$ will .about.list
...
About
  name : 'helloWorld'
  description : 'Hello, World!'
  ...

```

</details>

The `about` section has a simpler form of writing.

### Summary

- Constructed modules are possible to use by connecting them as submodules in the `submodule` section.
- Console output of resources has form `Section name::Resource name`.
- The `about` section contains descriptive information.

[Next tutorial](CommandsSubmodules.md)
[Return to content](../README.md#tutorials)
