# Section <code>submodule</code>

The section contains information about the submodule.

Submodule is an individual module with its own configuration <code> will-file </ code>, which is subordinated to another module.

### Example

```yml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  Path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#d95a35b
  Uri : out/UriFundamentals.informal.out
  Proto : out/Proto.informal.out
```

4 submodules are connected, 2  [local](SubmodulesLocalAndRemote.md#Local-submodule) `out/UriFundamentals.informal.out`, `out/Proto.informal.out` and 2 [remote](SubmodulesLocalAndRemote.md#Remote-submodule) `git+https:///github.com/Wandalen/wTools.git/out/wTools#master`, `git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#d95a35b`. Remote modules are connected with the speversion (branches and commit numbers).

### The field of section resources `submodule`

| Field          | Description                                           |
|----------------|------------------------------------------------|
| path           | path to submodule, may be absolute / relative, local / global |
| description    | description for other developers                                |
| criterion      | condition of resource using (see [criterion](Criterions.md)) |
| inherit        | inheritance of the fields values of the another submodule     |
