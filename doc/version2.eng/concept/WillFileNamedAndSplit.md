# Named and split `willfiles`

### Named <code>willfile</code>

Kind of <code>willfile</code> which has a non-standard name. It makes possible to have multiple modules with different names in a directory.

`willfile` name that looks like `.will.[extension]` is considered to be unnamed. At the same time, a directory may contain one unnamed `willfile` due to the name collision. The number of named` willfiles` is not limited.

![will.file.named.unnamed.png](../../images/will.file.named.unnamed.png)  

The figure shows the output of the `ls -al` command in the module directory of named `willfiles`.

#### `.with` command for named `willfiles`

To work with named `willfiles` command [`.with`](../tutorial/WillFileNamed.md) is used.

#### An example of using the `.with` command

```
will .with final.release.will.yml .build release
```

Build command of the `release` build for the `willfile` named  `final.release.will.yml`.

#### `.each` command for named `willfiles`

To work with a group of named `willfiles` command [`.each`](../tutorial/CommandEach.md) is used.

### Split <code>willfile</code>

Splitting <code>willfile</code> into two files. One of them is for the import of the module and the other is for export of it. It makes possible to split data related building and to develop a module and data which can be used by other modules.

The resources which are described in one of the split `willfiles` are available in the second. It eliminates the need to duplicate the data. Split can be implemented for named and unnamed `willfiles`. By splitting the unnamed `willfiles` the import file is called` .im.will.yml` and the export file is called `.ex.will.yml`.  

The structure of split of unnamed `willfiles`:   

```
.
├── .im.will.yml    # import split-file
├── .ex.will.yml    # export split-file

```

The split of named `willfiles` is different from the unnamed ones by name before the corresponding extension.  
```
.
├── first.im.will.yml    # import split-file
├── first.ex.will.yml    # export split-file

```
For example the `willfile` named `first` is split on `first.im.will.yml` import file and `first.ex.will.yml` export file.  

#### An example of two modules in one directory

![will.file.split.png](../../images/will.file.split.png)

The output of `ls -al` command in the module directory with the split of named and unnamed `willfile`.
