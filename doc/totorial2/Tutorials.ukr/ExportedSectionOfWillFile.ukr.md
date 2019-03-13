# Секція _'exported'_ will-файла

В цьому туторіалі розглядається секція `exported`

Секція `exported` - присутня лише в експортованому `will`-файлі який генерується пакетом при експортуванні модуля. Головне призначення секції - інформаційна карта для імпорту.  
Розглянемо секцію `exported` при експорті модуля з одним файлом. Для цього створіть в одній директорії файли `.will.yml` i `fileToExport`. В файл `.will.yml` додайте:  

```yaml
about :
    name : exportedSection
    description : "To study exported section"
    version : 0.0.1
    
submodule :
   exported : ./out/exportedSection

path :
    in : '.'
    out : 'out'
    fileToExport : 'fileToExport'

step :
  export.single :
    inherit : predefined.export
    export : path::fileToExport
    tar : 0

build :

  export :
    criterion :
        default : 1
        export : 1
    steps :
        - export.*

  export.two :
    criterion :
        debug : 1
        export : 1
    steps :
        - export.*

```

В цьому файлі створено дві подібні збірки експорту модуля, та підключено локальний підмодуль з експортованого файла.  
Запустіть експорт першої збірки:  

```
[user@user ~]$ will .export
...
  Exporting export
   + Write out will-file /path_to_file/out/exportedSection.out.will.yml
   + Exported export with 1 files in 1.579s
  Exported export in 1.630s
  
```

Відкрийте файл `exportedSection.out.will.yml` (в консолі введіть `less out/exportedSection.out.will.yml` або в іншому редакторі) та знайдіть в кінці документа секцію `exported`:  

```yaml
exported:
  export:
    version: 0.0.1
    criterion:
      default: 1
      export: 1
    exportedReflector: 'reflector::exported.export'
    exportedFilesReflector: 'reflector::exportedFiles.export'
    exportedDirPath: 'path::exportedDir.export'
    exportedFilesPath: 'path::exportedFiles.export'

```

