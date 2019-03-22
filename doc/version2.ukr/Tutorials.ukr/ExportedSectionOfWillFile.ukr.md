# Секція _'exported'_ will-файла

В цьому туторіалі розглядається секція `exported`

Секція `exported` - присутня лише в експортованому `will`-файлі який генерується пакетом при експортуванні модуля. Головне призначення секції - інформаційна карта для імпорту.  
Розглянемо секцію `exported` при експорті модуля з одним файлом. Для цього створіть в одній директорії файли `.will.yml`, `fileToExport` та `fileToExportTwo`. В файл `.will.yml` додайте:  

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
    fileToExportSingle :
      path : 'fileToExport'
      criterion :
        debug : 0
    fileToExportTwo : 
      path : 'fileToExport*'
      criterion :
        debug : 1

step :
    export.single :
      inherit : predefined.export
      export : path::fileToExport*
      tar : 0
      criterion :
        debug : [ 0,1 ]

build :

    export :
      criterion :
        default : 1
        debug : [ 0,1 ]
        export : 1
    steps :
        - export.*

```

В цьому файлі створено дві збірки експорту модуля з критеріоном `debug` об'єднані в одну використовуючи основи [мінімізації `will`-файла](MinimizationOfWillFile.ukr.md) та підключено локальний підмодуль з експортованого файла. При експорті буде створюватись архів.   
Запустіть експорт першої збірки:  

```
[user@user ~]$ will .export export.
...
  Exporting export.
   + Write out archive /path_to_file/ : out/exportedSection.out.tgs <- fileToExport
   + Write out will-file /path_to_file/out/exportedSection.out.will.yml
   + Exported export. with 1 files in 1.860s
  Exported export. in 1.917s

  
```

Відкрийте файл `exportedSection.out.will.yml` (в консолі введіть `less out/exportedSection.out.will.yml` або в іншому редакторі) та знайдіть в кінці документа секцію `exported`:  

```yaml
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

```

В секції поміщено один ресурс з назвою збірки, по якій пакет виконував експорт. Поле `version` копіює відповідний ресурс секції `about`, критеріони відповідають встановленим в збірці `export`. Наступні поля: `exportedReflector`, `exportedFilesReflector`, `exportedDirPath`, `exportedFilesPath`, `archiveFilePath` вказують на ресурси в секціях `reflector` i `path` які пакет використовував при побудові експорту модуля. 