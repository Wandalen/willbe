# Як використовувати селектори з глобами та ассертами

В туторіалі пояснюється застосування ґлобів та ассертів в селекторах `will`-файла

Для створення модуля доводиться використовувати ресурси які мають близьке значення - схожі назви, виконання різних дій над одним об'єктом, вибірка файлів... Використання прямих посилань для них потребує створення значних массивів даних і займає час. `Willbe` дозволяє використовувати ґлоби - замінник регулярних виразів в мовах програмування для командної оболонки операційної системи, що значно спрощує пошук необхідних елементів.  
Створимо приклад, в якому модуль буде вибирати необхідний шлях в секції `path` для експорту модуля в директорію `out`.

```yaml
about :

  name : selectorWithGlob
  description : "Using selector with glob to choise path"
  version : 0.0.1

path :

  in : '.'
  out : 'out'
  fileToExport.debug :
    path : './fileDebug'
    criterion :
       debug : 1

  fileToExport.release :
    path : './fileRelease'
    criterion :
       debug : 0

```

Приведений лістинг показує, що в експорт-модуль при сценарії відладки (`debug`) буде поміщено файл _'fileDebug'_, а при виконанні сценарію релізу - _'fileRelease'_.   
Додамо крок для експорту:  

```yaml
step  :
  export.single :
      inherit : predefined.export
      export : path::fileToExport.*
      tar : 0
      criterion :
         debug : 1
         
```

Приведений крок `export.single` виконуватиме сценарій для процедури `debug`. Тому розіб'ємо його на два окремих - `export.debug` i `export.release`:

<details>
    <summary><u><em>Кроки `export.debug` i `export.release`</em></u></summary>

```yaml
step  :
  export.debug :
      inherit : predefined.export
      export : path::fileToExport.*
      tar : 0
      criterion :
         debug : 1

  export.release :
      inherit : predefined.export
      export : path::fileToExport.*
      tar : 0
      criterion :
         debug : 0

```

</details>

Створимо сценарії секції `build` які б виконували відповідні експорти:
<details>
    <summary><u><em>Сценарії секції `build`</em></u></summary>

```yaml
build :

  export.debug :
      criterion :
          export : 1
          debug : 1
      steps :
          - export.*
          
  export.release :
      criterion :
          export : 1
          debug : 0
      steps :
          - export.*

```

</details>

<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

```yaml
build :

  about :

  name : selectorWithGlob
  description : "Using selector with glob to choise path"
  version : 0.0.1

path :

  in : '.'
  out : 'out'
  fileToExport.debug :
    criterion :
       debug : 1
    path : './fileDebug'

  fileToExport.release :
    criterion :
       debug : 0
    path : './fileRelease'

step  :
  export.debug :
      inherit : predefined.export
      export : path::fileToExport.*
      tar : 0
      criterion :
         debug : 1

  export.release :
      inherit : predefined.export
      export : path::fileToExport.*
      tar : 0
      criterion :
         debug : 0

build :

  export.debug :
      criterion :
          export : 1
          debug : 1
      steps :
          - export.*

  export.release :
      criterion :
          export : 1
          debug : 0
      steps :
          - export.*

```

</details>

Експортуємо модуль з процедурою відладки:

```
[user@user ~]$ will .export export.debug
...
   Exporting export.debug
   + Write out will-file /path_to_file/out/selectorWithGlob.out.will.yml
   + Exported export.debug with 1 files in 1.370s
  Exported export.debug in 1.419s

```

Видаліть створену пакетом `willbe` директорію `out` та введіть `will .export export.release`

```
[user@user ~]$ will .export export.release
...
  Exporting export.release
   + Write out will-file /path_to_file/out/selectorWithGlob.out.will.yml
   + Exported export.release with 1 files in 1.379s
  Exported export.release in 1.429s

```


[Повернутись до змісту](Topics.ukr.md)