# Selectors with globs

How to use selectors with globs.

### Поняття селекторів в `will-файлах`
Селектор - рядок-посилання на ресурс або декілька ресурсів в `will-файлі`. Селектори мають просту і більш складну форму запису в залежності від поля секції. В попередніх туторіалах неявно використовувались прості селектори в ресурсах, які посилались на інші ресурси.  
Приклад простих селекторів в секції `step`:

<details>
  <summary><u>Cекція <code>step</code></u></summary>

```yaml
step :

  export.out.debug :
    inherit : predefined.export  --> простий селектор
    export : path::out.debug   --> простий селектор
    tar : 0
    ...

```

</details>

Селектор `path::out.debug` - простий селектор, він має пряме посилання на секцію `path` та ресурс `out.debug`. Селектор `predefined.export` - простий селектор, що вказує на вбудований крок.

### Селектори з ґлобами. Конфігурація модуля  
При побудові модуля використовуються ресурси, які мають близький або ідентичний функціонал, а тому і схожі назви, розширення... Використаня простих селекторів і лінійних сценаріїв збільшує об'єм `will-файла` і займає багато часу, тому, в утиліті `willbe`, для вибору ресурсів використовуються ґлоби. [Ґлоб ](https://linuxhint.com/bash_globbing_tutorial/) - шаблон пошуку - метод опису пошукового запиту з використанням метасимволов (символів-джокерів), зокрема `*`, `?`, `[]` та інших.  
Для дослідження селекторів з ґлобами створіть наступну структуру файлів:  

<details>
  <summary><u>Структура модуля</u></summary>

```
selectorWithGlob
        ├── fileDebug
        ├── fileRelease         
        └── .will.yml       

```

</details>

В файл `.will.yml` внесіть код:

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

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
    path : 'fileDebug'

  fileToExport.release :
    criterion :
      debug : 0
    path : 'fileRelease'

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

Кожна із збірок `export.debug` i `export.release` обирає крок в секції `step` згідно критеріона. Код показує, що в експорт-модуль при збірці відладки (`debug`) буде поміщено файл `fileDebug`, а при виконанні збірки релізу - `fileRelease`.   

### Експортування модуля з окремими файлами
В `will-файлі` використовується ґлоб`*`, який означає - додати до назви будь-яку кількість довільних символів, включаючи варіант без додавання. Тобто, для селектора `export.*` в секції `build` кроки з назвами `export.`, `export.a`, `export.abcd1234` є валідними. Секція `step` має кроки `export.debug` i `export.release`, відповідно, для вибору необхідного кроку утиліта порівнює мапи критеріонів. Кроки `export.debug` i `export.release` в свою чергу обирають потрібний шлях в секції `path` за селектором `path::fileToExport.*`.  
Експортуйте модуль з критеріоном `debug : 1`:  

<details>
  <summary><u>Вивід команди <code>will .export export.debug</code></u></summary>

```
[user@user ~]$ will .export export.debug
...
   Exporting export.debug
   + Write out will-file /path_to_file/out/selectorWithGlob.out.will.yml
   + Exported export.debug with 1 files in 1.370s
  Exported module::selectorWithGlob / build::export.debug in 1.370s

```

</details>
<details>
  <summary><u>Структура модуля після експорту</u></summary>

```
selectorWithGlob
        ├── out
        │    └── selectorWithGlob.out.will.yml
        ├── fileDebug
        ├── fileRelease         
        └── .will.yml       

```

</details>

Ґлоб `*` може бути замінений на `?` - будь-який знак, при умові відомого числа знаків. Наприклад, змініть ресурс `fileToExport.release` в секції `path` до вигляду:

<details>
  <summary><u>Ресурс <code>fileToExport.release</code> секції <code>path</code></u></summary>

```yaml

  fileToExport.release :
    criterion :
       debug : 0
    path : './fileR??????'

```

</details>

Видаліть створену утилітою `willbe` директорію `out` (команда `rm -Rf out`) та введіть `will .export export.release`:

<details>
  <summary><u>Вивід команди <code>will .export export.release</code></u></summary>

```
[user@user ~]$ will .export export.release
...
  Exporting export.release
   + Write out will-file /path_to_file/out/selectorWithGlob.out.will.yml
   + Exported export.release with 1 files in 1.379s
  Exported module::selectorWithGlob / build::export.release in 1.379s

```

</details>
<details>
  <summary><u>Структура модуля після експорту</u></summary>

```
selectorWithGlob
        ├── out
        │    └── selectorWithGlob.out.will.yml
        ├── fileDebug
        ├── fileRelease         
        └── .will.yml       

```

</details>

### Підсумок
- Поєднання селекторів з ґлобами та критеріонів - потужний інструмент в налаштуванні побудови модуля.  - Використання ґлобів, робить побудову модуля гнучкою.  

Побудовані збірки не виключають помилок, тож, [в наступному туторіалі](AssertsUsing.md) показано як зменшити ймовірність їх появи в `will-файлі`.

[Повернутись до змісту](../README.md#tutorials)
