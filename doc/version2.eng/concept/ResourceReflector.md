### Resource reflector

It is a resource of section `reflector`, a method to describe a set of files in order to perform some operation on it.

### Example

![section.reflector.png](./Images/section.reflector.png)

An example of a `reflector` section with a `reflector1` resource. The reflector has two fields. First of them specifies the source of the files and second specifies the destination directory. That means that reflector copies files placed by path `path::proto` in the directory by path `path::out`.

### Resource fields of `reflector` section

| Field          | Description                                                |
|----------------|------------------------------------------------------------|
| description    | Description for other  developers                          |
| recursive      | Include files from subdirectories or not. Possible values: `0`,` 1`, `2`. The default value is `2` |
| mandatory      | Show an error if no file is found. Possible values: `0`,` 1`. The default value is `1` |
| filePath       | Map of the paths                                         |
| src            | The file filters at which operation performing is needed |
| dst            | The file filters in which recording the result of the operation is needed, if any |
| criterion      | [Conditions](Criterions.md) of resource using            |
| inherit        | Inheritance of the another reflector                     |

The fields `src` and `dst` can contain subfields which describe [file filters](ReflectorFileFilter.md).   

### Map of the paths

It is reflector field and the way to describe a set of files that allows to include a lot of files in it. Moreover it allows to exclude from it the files that are not required by the terms of exclusion and globes.

The path map can:
- specify the location of files in which to performing of operation is needed;
- specify the placement of files in which recording of the operation result is required;
- specify many directories;
- have many conditions for exclusion of files from the build;
- exclude sample files that match the globe via `false` or `0`;
- exclude sample files that do not match the globe via `true` or `1`.

The path map can be specified in the `filePath` field or in the `src.filePath` or `dst.filePath` field of the reflector. The exclusion which have the value `0`,` 1`, `false`,` true` are taken by inheritance. Moreover, the directories (paths that have the `null` values, simple specified path) in which the searching is made, are rewritten by the last ancestor or directly by a descendant.

Excluding build files is possible not only with the path map, but also using [file filters](<./ReflectorFileFilter.md#>).

### An example of a path map with file exceptions

```yaml
src:
  filePath:
    'some/dir1' : null
    'some/dir2' : null
    '**.debug**' : 0
    '**.js' : 1
```

- `'some/dir1' : null` - path of searching.
- `'some/dir2' : null` - path of searching.
- `'**.debug**' : 0` - negative exclusion condition.
- `'**.js' : 1` - positive exclusion condition.

It reads like this: view all the files in the `some/dir1` and `some/dir1` directories, reject all files that have `.debug` in name or end with the` .js` extension.

### The field of the reflector `mandatory`

The field that controls the issue of missing files in the specified path. When the value `mandatory: 1` is used, the utility will issue an error about missing files and complete the build. On the other hand, if no file is found in the specified path and `mandatory: 0` is used, the error will not be shown and the construction procedure will continue. The default value is `1`.

### The field of the reflector `recursive`

The reflector has a `recursive` field in order to limit the depth of the file search. By default, the search depth is not limited and this field has the value of `2`.

The `recursive` field accepts three possible values:
- `0` - select only the file specified in the path;
- `1` - select the file specified in the path and all the files it contains if it is a directory;
- `2` - select all files in the specified path at all levels of the nesting, without restrictions.

###  Examples of `recursive` field using 

![recursive.0.png](./Images/recursive.0.png)

When `recursive: 0` is used, only the `proto` directory specified in the path `filePath` will be selected.

![recursive.1.png](./Images/recursive.1.png)

When `recursive: 1` is used, the `proto` directory and its contents will be selected. It means that the file `some_file.will.yml` and the` files` directory will be chosen.

![recursive.2.png](./Images/recursive.2.png)

By the value `recursive: 2`, all the contents of the` proto` directory of all levels of the nesting will be selected, including files in the `files` directory and the available next levels.

### Fields `basePath` and `prefixPath`  

The `basePath`,` prefixPath` and `filePath` fields are used to specify file allocation in the `src` and `dst` filters.

`basePath` -  the basic path to the files with respect to which all other ways of this reflector are set. Beginning point for paths.

`prefixPath` is a path that is added as a prefix to all reflector paths, such as `basePath` and `filePath`.

### An example of forming a path with a field `prefixPath`   

```yaml
src :
  prefixPath : 'out/out.debug'
  filePath :
    - File1.js
    - File2.js
```

Prefix `./out/out.debug/` adds to each file described in `filePath` field, so the reflector selects 2 files `out/out.debug/File1.js` and` out out.debug/File2.js`

### Section <code>reflector</code>  

The section has reflectors. It is a special type of resources for operation on the groups of files.
