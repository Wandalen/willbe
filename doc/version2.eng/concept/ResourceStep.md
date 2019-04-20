## Resource step

Instruction for building the module. Describe an operation and desired outcome. Build consists of <code>step</code>. Step section resource which is an executing instruction of module building.

### Example
```yaml

step  :

  export.proto :
    export : path::fileToExport.*
    criterion :
      debug : 0

  view :
    inherit : predefined.view
    filePath : http:///www.google.com

```

Cекції step містить 2-ва кроки export.proto, view. Крок export.proto призначений для експортування модуля. Крок view призначений для перегляду файлу http:///www.google.com користувачем на якомусь етапі збірки.

The `step` section contains two steps for `export.proto`, `view`. The `export.proto` step is intended to export the module. The `view` step is intended to be used for viewing the file at http: ///www.google.com  by user at some stage of the build.

### Common fields of the step

| Field           | Description                                                             |
|----------------|------------------------------------------------------------------|
| description    | descriptive information for other developers                          |
| criterion      | condition of use of the resource (see [criterion](Criterions.md))     |
| opts           | additional options can be transmitted through the map `opts`            |
| inherit        | inheritance from other steps                       |

Section `step`
Секція містить кроки, які можуть бути застосовані збіркою для побудови модуля. Ресурси секції - кроки - поміщають в сценарії збірок секції build для виконання побудови.

The section contains steps that can be used by the build to build the module. The section resources - the steps - are placed in the build, in scenario of the build for implementation of the construction.
### List of predefined steps
### Predefined step `predefined.delete`  

Designed to delete files in the specified path.

Includes one `filePath` field, which specifies the path to the files which have to be deleted.

#### Example of a resource with step `predefined.delete`

```yaml
step:                                   # Name of the section
  delete.files:                         # Name of the step
    inherit: predefined.delete          # Inheritance
filePath: some/dir                      # File, which will be deleted
```

In resource `delete.files`, through [inheritance](Inheritance.md), predefined step is used `predefined.delete`. Step removes files by path `path::fileToDelete`.

### Predefined step `predefined.reflect`  

The step is designed for a copying the files by means of [reflector](ResourceReflector.md#Ресурс-рефлектор).  

Reflectors choose a set of files over which to perform some operation. The step `predefined.reflect` performs copying of files from one place to another. By default, copying is performed by storing of hard-links between a couple of files. This means that the destination file and the source file will have the same content and any changes made to one of the files will be displayed by the operating system in another file.

The step includes the `reflector` field to indicate the resource of the section` reflector` and field  `verbosity`, which determines the level of verbal output of the console, that is, the amount of service information when performing the step. The range of change in verbal level can be set from 0 to 9. 9 - the highest level of verbal.

#### Example of a resource with step `predefined.reflect`

```yaml
step:                                         # Name of the section
  reflect.files:                              # Name of the step
    inherit: predefined.reflect               # Inheritance
    reflector: reflector::reflect.some.files  # Reflector for build of the files
    verbosity: 3                              # Level of verbality

```
Крок reflect.files наслідується від predefined.reflect. Для вибору файлів крок використовує рефлектор reflect.some.files. Рівень вербальності виводу - 3.

The step `reflect.files` is inherited from `predefined.reflect`. To select files, the step uses `reflect.some.files`. Level of verbal output - 3.
### Predefined step `predefined.js`   

Designed to execute JavaScript files while constructing a module.  

`predefined.js` includes one field with a name `js`,which specifies the path to the JS file to execute.

Since the `js` field has only one step `predefined.js` - not in other predefined steps, the `predefined.js` step can be written without explicit imitation.

#### Examples of resources with step`predefined.js`

```yaml
step:                                   # Name of the sectiom
  run.js:                               # Name of the step
      js: run.js                        # The path to the JS file in the section 'path'

```

The step to run `run.js.` The inheritance is not explicit, since the field `js` is a unique field of the predefined step `predefined.js`..

### Predefined step `predefined.shell`  

Designed to run commands in the command shell of the operating system.

Extends the predefined opportunity of utilities through the use of external programs and operating system commands.

Step `predefined.shell` has fields:

- shell - indicates the command to be executed by operating system;
- currentPath - indicates the path to the directory in which the command will be executed. If the field is not specified then the `predefined.dir` path is used.
- forEachDst - The name of the reflector is specified in the field to indicate the destination directory for the files that will be created by the team. The destination directory is selected from the `dst` reflector filter.
- upToDate - a field that sets the ability to restart the command over files that have not changed from the previous comstruction. Accepts two values: `preserve` - do not execute the command if the files have not changed; `rebuild` - execute the command regardless of the changes in the file. The default value is `preserve`.

The `shell` field is present only in the built-in step `predefined.sll` and, therefore, the step can be written through implicit inheritance, that is, from the specified field` shell` in the resource.

#### Examples of resources with step `predefined.shell`

```yaml
step:                                   # Name of the section
  run.command:                          # Name of the step
    shell: ls -a                        # Command to enter the OS terminal

```
Calling of   an external ls -al program. The inheritance of predefined.shell is implemented implicitly.

### Predefined step `predefined.transpile`

Designed for transcribing JavaScript files or concatenating of them.

Конкатенація - об'єднання групи файлів в один. Транспіляція - перетворення вихідних файлів із кодом в вихідні із аналогічним змістом, але в іншій формі. Для вибору режиму перетворення застосовується критеріони <code>debug<code> та <code>raw<code>.

Concatenation - combining a group of files into one. Transpilation - converting output files with code files into outputs with similar content, but in a different form. To select the conversion mode, the <code> debug <code> and <code> raw <code> criterions are applied.

`debug`:` debug` utility performs concatenation of files without changing them (optimization)
`debug`:` release` - transcribing and optimizing the code is implemented.
`raw`:` raw` utility does not perform concatenation, but puts each file separately.
`raw`:` compiled` - concatenation of several files into one is implemented.

The `predefined.transpile` step has one` reflector` field to indicate the reflector for which the conversion will be made.

#### Example of a resource with step `predefined.transpile`

```yaml
step:                                           # Name of the section
  transpile.files:                              # Name of the step
    inherit: predefined.transpile               # Inheritance of the predefined JS-file merge step
    reflector: reflector::reflect.js.files      # Reflector for selecting JS-files
    criterion:
      debug : release
      raw : compiled

```

The `transpile.files` step executes the transcription of files (` debug: 0`) by the reflector `reflect.js.files`.
Specifies the paths to the files that will be composed and file which will be generated. To do this, specify the appropriate filters in the reflector. For example, if you use the `filePath` field of the reflector, the entry may have the form:

```yaml
reflector :
reflect.js.files :
  filePath :                                    # Map of the path
    path::filesFrom : '{path::filesTo}/file.js'

```
Move files from the path :: filesFrom and place them in {path :: filesTo}/file.js.

### Predefined step `predefined.export`  

Призначений для особливого виду побудови модуля - експорту. Результатом побудови є згенеровані `out-will-файл` i, опціонально, архів з експортованими файлами.

Designed for a special type of module construction - export. The result of the construction is the generated `out-will-file` and , optionally, the archive with the exported files.  

The generated `out-will-file` contains the complete information about the module and the exported files, as well as the build on which the export was built.

Крок `predefined.export` має поля:
- export - вказуються шляхи до файлів для експорту;
- tar - архівування файлів модуля. Поле прийма значення: 1 - архівування включене; 0 - архівування вимкнене. За замовувчуванням значення - 1.

The `predefined.export` step has the fields:
- export - specify the paths to files for export;
- tar - archiving of module files. The field accepts the value: 1 - archiving is included; 0 - archiving is off. By default, the value is 1.

Поле `export` присутнє тільки у вбудованому кроці `predefined.export` і, тому, крок може бути записаний через неявне наслідування, тобто, з указанням поля `export` в ресурсі.

The `export` field is present only in the predefined step` predefined.export`  and, therefore, the step can be written through implicit inheritance, that is, with specification of the `export` field in the resource.

#### Examples of resources with step`predefined.export`

```yaml
step:                                   # Name of the section
  export.files:                         # Name of the step
    export: path::proto                 # The path to the exported module files
    tar: 0                              #Do not create an archive.

```
When constructing, files will be exported through path :: proto, and the file archive creation is disabled.

### Predefined step `predefined.view`  

Designed to open files and URI-links in the programs to view by user.


The `predefined.view` step uses the viewing programs that are installed on the operating system to view this type of file by default. Use the `delay` field to start the view with delay.

Крок `predefined.view` має поля:
- `filePath` - вказується шлях до файлів, що потрібно відкрити;
- `delay` - затримка перед запуском програми для перегляду, вказується в мс.

The `predefined.view` step has fields:
- `filePath` - specifies the path to the files which need to be open;
- `delay` - delay before starting the program for viewing, it is indicated in ms.

#### Приклад ресурсу з кроком `predefined.view`

```yaml
step:                                        # Name of the section
  open.url:                                  # Name of the step
    inherit: predefined.view                 # Inheritance of the predefined step of the viewing
    filePath: 'http://google.com'            # URI-link
    delay: 10000                             #Delay of the file startup

```

Open to view`http://google.com` in 10 second.

#### Predefined step `submodules.download`

Performs loading of remote submodules specified in the section resources `submodule`.

There are no fields and it can be specified directly in the `steps` section of the` build `section without inheritance

#### Predefined step `submodules.update`

If new versions of remote submodules are available, it downloads and installs them.
There are no fields and it can be specified directly in the `steps` section of the` build `section without inheritance

#### Predefined step `submodules.reload`

Performs a dynamic reboot of submodules. Useful in a situation where submodules files that were not initially, were loaded during the implementation of some build.

There are no fields and it can be specified directly in the `steps` section of the` build `section without inheritance
#### Predefined step `submodules.clean`

Performs a complete removal of the `.module` directory with submodules.

There are no fields and it can be specified directly in the `steps` section of the` build `section without inheritance

#### Predefined step `clean`

Виконує видалення з модуля тимчасових і згененрованих файлів. До них відносяться:
- завантажені підмодулі (директорія `./.module`);

Performs removal from the module of temporary and generated files. It includes:
- loaded submodules (directory `./ module`);
- generated files: exported `out-will file` and archive.
- `path::temp` directory, if such is specified for the module.

There are no fields and it can be specified directly in the `steps` section of the` build `section without inheritance

#### An example of a resource with steps that can be written to a section `build`

```yaml
build:                                  # Name of the section
  submodules.download:                  # Name of the build
    steps:                              # Steps - scenario of the build
    - clean
    - submodules.download                          

```
Performs complete module cleaning and loading submodules.
