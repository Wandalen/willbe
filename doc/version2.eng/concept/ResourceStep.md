## Resource step

Instruction for building the module. Describe an operation and desired outcome. Build consists of <code>steps</code>.

The steps are described in the section `step`, but in order to execute them, they should be used in the build. The build can be created through the `.build` command and it can have as one of the steps the step which is given.

### Example

```yml
step  :

  export.proto :
    export : path::fileToExport.*
    criterion :
      debug : 0

  view :
    inherit : file.view
    filePath : http:///www.google.com

```

The `step` section contains two steps for `export.proto`, `view`. The `export.proto` step is intended to export the module. The `view` step is intended to be used for viewing the file `http:///www.google.com`  by the user at some stage of the build.

### Common fields of the step

| Field          | Description                                                             |
|----------------|------------------------------------------------------------------|
| description    | descriptive information for other developers                          |
| criterion      | condition of use of the resource (see [criterion](Criterions.md))     |
| opts           | additional options can be transmitted through the map `opts`            |
| inherit        | inheritance from other steps                       |

## Section <code>step</code>

The section contains steps that can be used by the build to build the module.
 The section resources are the steps. The steps are placed in
 the `build` scenario section to implement the build.

 ### List of predefined steps
 ### Predefined step `predefined.delete`  

 Designed to delete files in the specified path.

 Includes one `filePath` field, which specifies the path to the files which have to be deleted.

 ```yaml
 step:                                   # Name of the section
   delete.files:                         # Name of the step
     inherit: predefined.delete          # Inheritance
     filePath: some/dir                  # File, which will be deleted
 ```

 In `delete.files` step is [inherited](Inheritance.md),from `predefined.delete`. This step removes files by path `path::fileToDelete`.

### Predefined step `predefined.reflect`  

 This is the step for copying the files by means of [reflector](ResourceReflector.md#Resource-reflector).  

 Reflectors choose a set of files over which to perform some operation. The step `predefined.reflect` performs the copying of files from one place to another. By default, copying is performed with the storing of hard-links between a couple of files. This means that the destination file and the source file will have the same content. Furthermore any changes made to one of the files will be displayed by the operating system in another file.

 The step includes the `reflector` field to indicate the resource of the section` reflector` and field  `verbosity`, which determines the level of verbal output of the console, namely the amount of service information while step performing. The range of change in verbal level can be set from 0 to 9. 9 - the highest level of the verbosity.

 ```yaml
 step:                                         # Name of the section
   reflect.files:                              # Name of the step
     inherit: predefined.reflect               # Inheritance
     reflector: reflector::reflect.some.files  # Reflector for build of the files
     verbosity: 3                              # Level of verbosity

 ```

 The step `reflect.files` is [inherited](Inheritance.md) from `predefined.reflect`. To select the files, the step uses the reflector `reflect.some.files`. Level of verbal output - 3.

 ### Predefined step `js.run`   

 Designed to execute JavaScript files while module constructing.

 `js.run` includes one field with a name `js`,which specifies the path to the `JS-file` that has to be executed.

 Since the `js` field has only one step `js.run` which is absent in other predefined steps, the `js.run` step can be written without explicit inheritance.

 ```yaml
 step:                                   # Name of the section
   run.js:                               # Name of the step
       js: run.js                        # The path to the JS file in the 'path' section

 ```

 The step to run `run.js.` The inheritance is not explicit, since the field `js` is a unique field of the predefined step `js.run`.

 ### Predefined step `shell.run`

 Designed to run commands in the command shell of the operating system.

 Extends the predefined opportunity of utilities through the use of external programs and operating system commands.

 Step `shell.run` has fields:

 - `shell` - the command to be executed by the operating system;
 - `currentPath` - indicates the path to the directory in which the command will be executed. If the field is not specified then the `module.dir` path is used.
 - `forEachDst` - the name of the reflector is specified in the field to indicate the destination directory for the files that will be created by the command. The destination directory is selected from the `dst` reflector filter.
 - `upToDate` - a field that sets the ability to restart the command over files that have not changed from the previous construction. Accepts two values: `preserve` - do not execute the command if the files have not changed; `rebuild` - execute the command regardless of the changes in the file. The default value is `preserve`.

 The `shell` field is present only in the predefined step `shell.run` and, therefore, the step can be written through implicit inheritance,which means with the specification of the field `shell` in the resource.

 ```yaml
 step:                                   # Name of the section
   run.command:                          # Name of the step
     shell: ls -a                        # Command to enter the OS terminal

 ```

 Call of an external `ls -al` program. The inheritance of `shell.run` is implemented implicitly.

 ### Predefined step `files.transpile`

 Designed for transpilation of the `JavaScript` files or concatenating of them.

 Concatenation is the combining of the group of files into one. Transpilation is converting output files with code files into outputs with similar content, but in a different form. To select the conversion mode, the <code>debug</code> and <code>raw</code> criterions are applied.
 - `debug`:` debug` utility performs concatenation of files without changing them (optimization)
 - `debug`:` release` - transpilation and optimization of the code are implemented.
 - `raw`:` raw` utility does not perform concatenation, but puts each file separately.
 - `raw`:` compiled` - a concatenation of several files into one is implemented.

 The `files.transpile` step has one` reflector` field to indicate the reflector by which the conversion will be made.

 ```yaml
 step:                                           # Name of the section
   transpile.files:                              # Name of the step
     inherit: files.transpile               # Inheritance of the predefined JS-file merge step
     reflector: reflector::reflect.js.files      # Reflector for selecting JS-files
     criterion:
       debug : release
       raw : compiled

 ```

The `transpile.files` step implements the transpilation of the files with optimization `debug : release` and concatenation `raw : compiled`. The `reflect.js.files` reflector implements the selection of files which have to be transpiled. Moreover it decides where to put the result of the transpilation. Reflector can have the following look:

```yaml
reflector :
reflect.js.files :
  filePath :                                    # Map of the path
    path::filesFrom : '{path::filesTo}/file.js'

```

Move files from the `path::filesFrom` and place them in `{path :: filesTo}/file.js`.

### Predefined step `module.export`  

Designed for a special type of module construction - export. The result of the construction is the generated `out-willfile` and , optionally, the archive with the exported files.  

The generated `out-willfile` contains the complete information about the module and the exported files, the list of the exported files, version and so on.

The `module.export` step has the fields:
- export - specify the paths to files for export. The reflector can be specified. Unique field of this step
- tar - archiving of module files. The field accepts the value: 1 - archiving is on; 0 - archiving is off. By default, the value is 1.

The `export` field is present only in the predefined step` module.export`  and, therefore, the step can be written through implicit inheritance, which means with the specification of the `export` field in the resource.

```yaml
step:                                   # Name of the section
  export.files:                         # Name of the step
    export: path::proto                 # The path to the exported module files
    tar: 0                              # Do not create an archive.

```

While construction, files will be exported through `path::proto` and the file archive creation is disabled.

### Predefined step `file.view`  

Designed to open the local or remote files to the view by the user of the system.

The `file.view` step uses the viewing programs that are installed on the operating system to view this type of file by default. Use the `delay` field to start the view with delay.

The `file.view` step has fields:
- the field `filePath` - specifies the path to the files which need to be open;
- the field `delay` - delay before starting the program for viewing, it is indicated in ms.

```yaml
step:                                        # Name of the section
  open.url:                                  # Name of the step
    inherit: file.view                 # Inheritance of the predefined step of the viewing
    filePath: 'http://google.com'            # URI-link
    delay: 10000                             # Delay

```

Open to view `http://google.com` in 10 seconds.

#### Predefined step `submodules.download`

Performs downloading of remote submodules specified in the section resources `submodule`.

There are no fields and it can be specified directly in the `steps` filed of the` build `section without inheritance.

#### Predefined step `submodules.update`
If new versions of remote submodules are available, it downloads and installs them.

There are no fields and it can be specified directly in the `steps` field of the` build `section without inheritance

#### Predefined step `submodules.reload`

Performs a dynamic reboot of the submodules. Useful in a situation where submodules files that were not initially loaded, were loaded during the implementation of some build.

There are no fields and it can be specified directly in the `steps` field of the` build `section without inheritance

#### Predefined step `submodules.clean`

Performs a complete removal of the `.module` directory with the submodules.

There are no fields and it can be specified directly in the `steps` field of the` build `section.

#### Predefined step `clean`

Performs removal from the module of temporary and generated files. It includes:
- downloaded submodules (`.module` directory);
- generated files: exported `out-will file` and archive.
- `path::temp` directory, if such is specified for the module.

There are no fields and it can be specified directly in the `steps` field of the` build `section.

```yaml
build:                                  # Name of the section
  submodules.download:                  # Name of the build
    steps:                              # Steps - scenario of the build
    - clean
    - submodules.download                          

```

Performs complete module cleaning and downloading of the submodules.
