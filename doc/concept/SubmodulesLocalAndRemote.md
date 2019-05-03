# Local and remote submodules

### Local submodule

A submodule which is located on the local machine.

A module located on the local machine can be connected as a submodule of another module. To connect a submodule place resource with the link to `willfile` of another module to the section `submodule` of current `willfile`. To connect a local submodule, it is better to use exported `out-willfiles` because they contain information about the module and builds by which it is built.

#### Example of a local submodule

![submodule.local.png](../images/submodule.local.png)

The module consists of 2 local submodules, which are named `ModuleOne` and `LocalModule`. The first local submodule is placed in the `ModuleOne` directory, which is located in the root directory of the module (relative path), and the second is located in the directory by the path `/home/user/localModule/` (absolute path).

### Remote submodule

A module located on the remote server is downloaded to the local machine for use.
The remote submodules are downloaded into the <code>.module</code> directory, which is located in the root directory of the current module.

To connect the remote submodule, the URI-path resource is specified in the section `submodule`.

#### Example of section `submodule`  

```yaml
submodule :
    Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
    Color : npm:///wColor/out/wColor#0.3.102

```

The module connects the `Tools` and `PathFundamentals` submodules.

Management tools of remote submodules:

- the command `will .submodules.list` lists the connected submodules and information about them;
- the command `will .submodules.download` downloads files of remote submodules;
- the predefined step [`submodules.download`](ResourceStep.md#submodulesdownload) downloads the files of remote submodules;
- the command `will .submodules.update` download the latest versions of the remote submodules files (without patching the `willfile`);
- the predefined step of [`submodules.update`](ResourceStep.md#submodulesupdate) updates files of remote submodules;
- the `will.submodules.fixate` command fixates the submodule version, patching the current submodule paths in `willfile` to the latest versions of the remote submodules unless a specific version was specified;
- the ` will command.submodules.upgrade` updates the version of the submodules, patching the current submodule paths in `willfile` to the most recent versions of the remote submodule (if newer versions are available);
- the `will .submodules.clean` command deletes the remote submodules files (`.module` directory);
- predefined step [`submodules.clean`](ResourceStep.md#submodulesclean) deletes the remote submodules files (`.module` directory).
