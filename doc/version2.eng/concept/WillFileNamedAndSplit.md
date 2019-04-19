# Named and split `will-files`

### Named <code>will-file</code>

Kind of <code>will-file</code> which has nonstandard name. It makes possible to have multiple modules with different names in a directory.  

`Will-file` name that looks like `.will.[extension]` is considered unnamed. At the same time, a directory may contain one unnamed `will-file` due to a name collision but the number of named` will-files` is not limited.

![will.file.named.unnamed.png](./Images/will.file.named.unnamed.png)  

The figure shows the output of the `ls -al` command in the module directory of named `will-files`.

#### `.with` command for named `will-files`

To work with named `will-files` command [`.with`](../tutorial/WillFileNamed.md) is used.

#### An example of using the `.with` command 

```
will .with final.release.will.yml .build release
```

The build command for the `release` build for the named` will-file` `final.release.will.yml`.

#### `.each` command for named `will-files`

To work with group of named `will-файлів` command [`.each`](../tutorial/CommandEach.md) is used.

### Split <code>will-file</code>

Splitting <code>will-file</code> into two files. One of them is for importing data and the other for exporting. Its make possible splitting data related building and development of a module and data related its exporting and reusing by other modules.

The resources are described in one of the split `will-files` available in the second which eliminates the need to duplicate the data. Split is possible both for the unnamed `will-file` and for the named one. When splitting the unnamed `will-files` the import file is called` .im.will.yml` and the export file is called `.ex.will.yml`.

The structure of split of unnamed `will-files`:   

```
.
├── .im.will.yml    # import split-file
├── .ex.will.yml    # export split-file

```

The split of named `will-files` is different from the unnamed ones by name before the corresponding extension.

```
.
├── first.im.will.yml    # import split-file
├── first.ex.will.yml    # export split-file

```
For example, `will-file` named `first` will split on `first.im.will.yml` import file and `first.ex.will.yml` export file.  

#### An example of two modules in one directory

![will.file.split.png](./Images/will.file.split.png)

Output of `ls -al` command in the module directory with split of named and unnamed` will-file`.