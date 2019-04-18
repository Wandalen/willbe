# Named and split `will-files`  

### Named <code>will-file</code>  

Kind of <code>will-file</code> which has nonstandard name. It makes possible to have multiple modules with different names in a directory.  

Name of `will-file` that looks like `.will.[extension]` is considered unnamed. At the same time, a directory may contain one unnamed `will-file` and unlimited number of named ones. To work with named `will-files` the` .with` command is used. Example: to build the `release` build scenario in the `will-file` named `final.release.will.yml` the command looks like` will .with final.release.will.yml .build release`. To work with the `will-files` group the` .each` command is used.  
The figure shows the output of the `ls -al` command in the module directory of named `will-files`:   

![will.file.named.unnamed.png](./Images/will.file.named.unnamed.png)  

### Split <code>will-file</code>  

Splitted <code>will-file</code> on two files - one for importing data another for exporting.  

Split `will-file` allows the developer to split the process of building a module and exporting it to individual stages.  

The resources are described in one of the split `will-files` available in the second which eliminates the need to duplicate the data. Split is possible both for the unnamed `will-file` and for the named one. When splitting the unnamed `will-files` the import file is called` .im.will.yml` and the export file is called `.ex.will.yml`.   
The structure of split of unnamed `will-files`:  

```
.
├── .im.will.yml    # спліт-файл імпорту
├── .ex.will.yml    # спліт-файл експорту

```  

The split of named `will-files` is different from the unnamed ones by name before the corresponding extension. For example,` will-file` named `first` will be divided into `first.im.will.yml` for the import file and` first.ex.will.yml` for the export file: 

```
.
├── first.im.will.yml    # спліт-файл імпорту
├── first.ex.will.yml    # спліт-файл експорту

```

Output of `ls -al` command in the module directory with split of named and unnamed` will-file`:

![will.file.split.png](./Images/will.file.split.png)
