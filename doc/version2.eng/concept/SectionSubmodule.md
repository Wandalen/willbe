# Section <code>submodule</code>

The section contains the information about the submodules.

Submodule is an individual module with its own configuration <code>will-file</code>, which is subordinated to another module.

### Example

```yml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  Path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#d95a35b
  Uri : out/UriFundamentals.informal.out
  Proto : out/Proto.informal.out
```

4 submodules are connected. 2 of them is [local](SubmodulesLocalAndRemote.md#Local-submodule) submodules - `out/UriFundamentals.informal.out`, `out/Proto.informal.out`, and 2 of them is [remote](SubmodulesLocalAndRemote.md#Remote-submodule) submodules - `git+https:///github.com/Wandalen/wTools.git/out/wTools#master`, `git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#d95a35b`. Remote modules are connected with the version specification (branches and commit numbers).

### Resource fields of the `submodule` section

| Field          | Description                                    |
|----------------|------------------------------------------------|
| path           | path to submodule, may be absolute/relative, local/global |
| description    | description for other developers                          |
| criterion      | condition of resource using (see [criterion](Criterions.md)) |
| inherit        | inheritance of the fields values of the another submodule    |
