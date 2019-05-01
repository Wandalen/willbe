# Section <code>exported</code>

The <code>out-willfile</code> section is programmatically generated when the module is exported. It contains the list of all exported files and is used by the importation of this module by another one.

### Example

```yml
exported:

  export.:
    version: 0.0.1
    criterion:
      default: 1
      debug: 0
      export: 1
    exportedReflector: 'reflector::exported.export.'
    exportedFilesReflector: 'reflector::exportedFiles.export.'
    exportedDirPath: 'path::exportedDir.export.'
    exportedFilesPath: 'path::exportedFiles.export.'
    archiveFilePath: 'path::archiveFile.export.'
    originalWillFilesPath: 'path::original.will.files'

  export.debug:
    version: 0.0.1
    criterion:
      default: 1
      debug: 1
      export: 1
    exportedReflector: 'reflector::exported.export.debug'
    exportedFilesReflector: 'reflector::exportedFiles.export.debug'
    exportedDirPath: 'path::exportedDir.export.debug'
    exportedFilesPath: 'path::exportedFiles.export.debug'
    archiveFilePath: 'path::archiveFile.export.debug'
    originalWillFilesPath: 'path::original.will.files'
```

The `exported` section with two `export` and`export.debug` resources are generated during the export of this module. `exported` resources contain links to the list of files, the original `willfile` and the base directory in which the files are located.

```yml
path :
  exportedFiles.export.debug :
    path :
      - out/debug
      - out/debug/File.debug.js

```

The list of exported files looks like this. All paths are relative to `path::in`.

### Resource fields of `exported` section   

| Field                    | Description                            |
|--------------------------|----------------------------------------|
| version                  | version of the module, exported from the section `about`  |
| criterion                | criterions which are exported from the `build` section when executing the export build(see [criterion](Criterions.md)) |
| exportedReflector        | original version of the reflector with all the filters and masks which was used to choose exported files  |
| exportedFilesReflector   | reflector for a list of all exported files  |  
| exportedDirPath          | path to directory with exported files        |
| exportedFilesPath        | path with a list of all exported files       |
| originalWillFilesPath    | the path to the original `willfile` of this module  |
| archiveFilePath          | the path to the archive with exported module files   |
