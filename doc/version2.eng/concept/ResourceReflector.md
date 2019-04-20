### Resource reflector

Resource of the section <code>reflector</code>, method of description of the set of files in order to implement some operation at it.

### Example

![section.reflector.png](./Images/section.reflector.png)

An example of a `reflector` section with a` reflector1` resource. The reflector has two fields: the first specifies the source of the files, and second - destination directory. That means, that  reflector copies files placed by path `path :: proto` in the directory.

### Fields of resource `reflector`

| Field          | Description                                                       |
|----------------|------------------------------------------------------------|
| description    | Description for other  developers                                    |
| recursive      | Include files from sub directories or not. Possible values: `0`,` 1`, `2`. The default value is `2` |
| mandatory      | Show an error if no file is found. Possible values: `0`,` 1`. The default value is `1` |
| filePath       | Map of the paths |
| src            | The file filters at which operation performing is needed |
| dst            | The file filters in which recording the result of the operation is needed, if any |
| criterion      | [Conditions](Criterions.md) using of resource
| inherit        | Inheritance of the values of the fields of another reflector        |

The fields `src`, `dst` can contain subfields which describe [file filters](ReflectorFileFilter.md).   

### Map of the paths

Reflector field and a way to describe a set of files, which allows including a lot of files in it and exclude from it the files that are not required by the terms of exclusion and globes.

The path map can:
- specify the location of files at which to performing of operation is needed;
- specify the placement of files in which recording of the result of the operation is needed;
- can specify many directories;
- many conditions for exclusion of files from the build;
- exclude sample files that match the globe via `false` or` 0`;
- exclude sample files that do not match the globe via `true` or` 1`

The path map can be specified in the `filePath` field or in the` src.filePath` or `dst.filePath` field of the reflector. By inheritance, those exclusion are taken, which have the value `0`,` 1`, `false`,` true`, and the directories (paths that have the `null`, simple specified path) in which the searching is made, are rewritten by the last ancestor or directly by descendant.

By inheritance, the exclusion which have the value `0`,` 1`, `false`,` true` are taken. Moreover  the directories (paths that have the `null`, simple specified path) in which the searching is made, are rewritten by the last ancestor or directly by descendant.

Excluding build files is possible not only with the map path , but also [filter of the file](<./ReflectorFileFilter.md#>).

### An example of a path map with exceptions

```yaml
src:
  filePath:
    'some/dir1' : null
    'some/dir2' : null
    '**.debug**' : 0
    '**.js' : 1
```

- `'some/dir1' : null` - Path of searching.
- `'some/dir2' : null` - Path of searching.
- `'**.debug**' : 0` - negative exclusion condition.
- `'**.js' : 1` - positive exclusion condition.

It reads like this: to view all the files in the `some / dir1` and` some / dir1` directories, reject all files that are in the `.debug` path or end with the` .js` extension.

### The field of the reflector `mandatory`


The field that controls the issue of missing files in the specified path. When the value `mandatory: 1` is used, the utility will issue an error and complete the build if no file is found in the specified path, and if` mandatory: 0` the error will not be shown and the construction procedure will continue. The default value is `1`.

### The field of the reflector `recursive`

The reflector has a `recursive` field in order to limit the depth of the file search. By default, the search depth is not limited and this field is `2`.

The `recursive` field accepts three possible values:
- `0` - select only the file specified in the path;
- `1` - select the file specified in the path and all the files it contains if it is a directory;
- `2` - select all files in the specified path at all levels of the nesting, without restrictions.

###  Examples of using of the field `recursive`

![recursive.0.png](./Images/recursive.0.png)

When `recursive: 0` is used, only the` proto` directory specified in the path `filePath` will be selected.

![recursive.1.png](./Images/recursive.1.png)

При значенні `recursive : 1` буде вибрано директорію `proto` та її вміст, тобто, файл `some_file.will.yml` i директорію `files`.

When `recursive: 1` is used, the` proto` directory and its contents will be selected, which means the file `some_file.will.yml` in the` files` directory.

![recursive.2.png](./Images/recursive.2.png)

By the value `recursive: 2`, all the contents of the` proto` directory of all levels of the nesting, including files in the `files` directory and the following levels if available, will be selected.
### Поля `basePath` i `prefixPath`  

The `basePath`,` prefixPath` and `filePath` fields are used to specify file allocation in the` src` i `dst` filters.

`basePath` -  The basic path to the files with respect to which all other ways of this reflector are set. Beginning point for paths.

`prefixPath` is a path that is added as a prefix to all reflector paths, such as` basePath` i `filePath`.

### An example of forming a path with a field `prefixPath`   

```yaml
src :
  prefixPath : 'out/out.debug'
  filePath :
    - File1.js
    - File2.js
```

Prefix `. / Out / out.debug / `will be added to such files with the description` filePath` so that the reflector will select 2 files `out / out.debug / File1.js` and` out / out.debug / File2. js`

### Section <code>reflector</code>  

Секція містить рефлектори - ресурси для виконання операцій над групами файлів.
Основними операціями є вибір файлів (директорій) та копіювання.

The section contains reflexes, it is resources for operations on file groups.
The basics of operations are the choice of files (directors) and copying information.
