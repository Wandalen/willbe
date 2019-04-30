# Секція <code>exported</code>

Секція <code>out-вілфайла</code>, програмно генерується при експортуванні модуля, містить перелік всіх експортованих файлів та використовується при імпортуванні даного модуля іншим.

### Приклад  

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

Cекція `exported` із двома ресурсами `export.` та `export.debug` згенерованими при експортуванні цього модуля. Ресурси `exported` містять посилання на перелік файлів, оригінальний `вілфайл` та базову директорію в якій лежать файли.

```yml
path :
  exportedFiles.export.debug :
    path :
      - out/debug
      - out/debug/File.debug.js
      
```

Перелік експротованих файлів виглядає так. Всі шляхи відносно `path::in`.

### Поля ресурсів секції `exported`   

| Поле                     | Опис                                   |
|--------------------------|----------------------------------------|
| version                  | версія модуля, експортується з секції `about`                         |
| criterion                | критеріони, експортовані з секції `build` при виконанні збірки експорту (див. [критеріон](Criterions.md)) |
| exportedReflector        | оригінальна версія рефлектора із всіма фільтрами та масками, що застосовувалася для вибірки файлів для експортування |
| exportedFilesReflector   | рефлектор із переліком всіх експортованих файлів  |  
| exportedDirPath          | шлях до директорії із експортованими файлами      |
| exportedFilesPath        | перелік всіх експортованих файлів                                  |
| originalWillFilesPath    | шлях до оригінальної версії `вілфайлу` даного модуля             |
| archiveFilePath          | шлях до архіву із експортованими файлами модуля                          |
