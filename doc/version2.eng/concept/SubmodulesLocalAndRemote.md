# Local and remote submodules

### Local submodule

Submodule, which is located at the user's computer

A module located at the local machine can be connected as a submodule of another module. To connect a submodule in the section `submodule`, the resource is specified with path to `will-file` of another module. To connect a local submodule, it is better to use exported `some_name.out.will`-files because they contain information about the module and builds by which it is built.

#### Example of a local submodule

![submodule.local.png](./Images/submodule.local.png)

The module consists of 2 local submodules, namely`ModuleOne` and `LocalModule`. The first local submodule is placed in the `ModuleOne` directory, which is in the root directory of the module (relative path), and the second in the directory by the path` /home/user/localModule/` (absolute posix path).

### Remote submodule

The module that is on the remote server is downloaded to the local machine for use. The remote submodules are loaded into the `.module` directory, which belongs to the root directory of the current module.

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

- the command `will .submodules.list` calculates   the connected submodules and information about them;
- the command `will .submodules.download`  loads files of remote submodules;
- the predefined step [`submodules.download`](ResourceStep.md#submodulesdownload) loads the files of remote submodules;
- the command `will .submodules.update` download the latest versions of the remote submodules files (without patching the `will-file`) [`submodules.download`](ResourceStep.md#submodulesdownload) uploads files of remote submodules;
- the predefined step of [`submodules.update`](ResourceStep.md#submodulesupdate) loads files of remote submodules;
- the `will.submodules.fixate` command fixes the submodule version, patching the current module's `will-file` to the latest versions paths of the remote submodules, unless a specific version was specified;
- the ` will command.submodules.upgrade.refs` updates the version of the submodules, patching the current module's `will-file` to the most recent paths of versions of the remote submodules (if newer versions are available);
- the `will .submodules.clean` command deletes the remote submodules files (`.module` directory);
- predefined step [`submodules.clean`](ResourceStep.md#submodulesclean) removes files from remote submodules (`.module` directory).
