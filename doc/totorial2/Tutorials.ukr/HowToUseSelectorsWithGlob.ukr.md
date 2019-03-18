# Як використовувати селектори з ґлобами

В туторіалі пояснюється застосування ґлобів в селекторах `will`-файла

Для створення модуля доводиться використовувати ресурси, які мають близьке значення - схожі назви, однакові розширення... На прямі посилання витрачається багато часу, тому, в `willbe` використовуються ґлоби - замінник регулярних виразів в мовах програмування для командної оболонки операційної системи, що спрощує пошук необхідних елементів.  

### Побудова `will`-файла експорту модуля з застосуванням ґлобів
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

Приведений лістинг показує, що в експорт-модуль при збірці відладки (`debug`) буде поміщено файл _'fileDebug'_, а при виконанні збірки релізу - _'fileRelease'_.   
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

Процедура `export.single` виконуватиме лише `debug`-збірку (критеріон відладки зі значенням "1"). Тому розіб'ємо його на два окремих - `export.debug` i `export.release`:

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

Також, побудуємо дві збірки в секції `build`, які б виконували відповідні експорти:
<details>
    <summary><u><em>Збірки секції `build`</em></u></summary>

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

### Експортування модуля з окремими файлами
В `will`-файлі використовується [ґлоб](https://linuxhint.com/bash_globbing_tutorial/) '\*', який означає - додати до назви будь-яку кількість довільних символів, включаючи варіант без додавання. Тобто, для секції `build` кроки з назвами `export.`, `export.a`, `export.abcd1234` є валідними, але секція `step` має два визначені - саме з ними йде порівняння мапи критеріонів.  
Кроки `export.debug` i `export.release` також обирають потрібний шлях порівнюючи мапи критеріонів.

<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

```yaml

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

<p></p>

- Поєднання селекторів з ґлобами та критеріонів - потужний інструмент в налаштуванні роботи модуля.  

Експортуємо модуль з процедурою відладки:

```
[user@user ~]$ will .export export.debug
...
   Exporting export.debug
   + Write out will-file /path_to_file/out/selectorWithGlob.out.will.yml
   + Exported export.debug with 1 files in 1.370s
  Exported export.debug in 1.419s

```

Використаємо ґлоб '?', який означає - будь-який знак. Приведіть ресурс в `path` до вигляду:

```yaml

  fileToExport.release :
    criterion :
       debug : 0
    path : './fileR??????'

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

- Використовуйте ґлоби для гнучкого пошуку пакетом `willbe` та покращення читабельності `will`-файла  

Наш модуль працює. Але збірка не виключає помилок, тож, дізнаймося як зменшити ймовірність помилок в `will`-файлі.

[Наступний туторіал](HowToUseAsserts.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)