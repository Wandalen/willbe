# Селектори із ґлобами

Як користуватись селекторами з ґлобами.

### Поняття селекторів в `вілфайлах`

Селектор - рядок-посилання на ресурс або декілька ресурсів в `вілфайлі`. Селектори мають просту і більш складну форму запису в залежності від поля секції. В попередніх туторіалах вже неявно використовувались селектори.  

Для множинного пошуку ресурсів в утиліті `willbe` використовуються селектори з ґлобами. [Ґлоб ](https://linuxhint.com/bash_globbing_tutorial/) - метод опису пошукового запиту з використанням метасимволов (символів-джокерів), зокрема `*`, `?` та інших.  

### Приклад селекторів 

<details>
  <summary><u>Cекція <code>step</code></u></summary>

```yaml
step :

  export.out.debug :
    inherit : predefined.export  --> простий селектор
    export : path::out.debug*    --> селектор з ґлобом
    tar : 0
    ...

```

</details>

Селектор `predefined.export` - простий селектор, що вказує на вбудований крок.  
Селектор `path::out.debug*` - селектор з ґлобом `*`.

### Селектори з ґлобами. Конфігурація модуля  

<details>
  <summary><u>Структура модуля</u></summary>

```
selectorWithGlob
        ├── fileDebug
        ├── fileRelease         
        └── .will.yml       

```

</details>

Для дослідження селекторів з ґлобами створіть приведену структуру модуля.  

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

В файл `.will.yml` внесіть код.

Кожна із збірок `export.debug` i `export.release` обирає крок в секції `step` згідно критеріона. Код показує, що в експорт-модуль при збірці відладки (`debug`) буде поміщено файл `fileDebug`, а при виконанні збірки релізу - `fileRelease`.   

### Експортування модуля з окремими файлами  

В `вілфайлі` використовується ґлоб `*`, який означає - додати до назви будь-яку кількість довільних символів. Тобто, для селектора `export.*` кроки з назвами `export.`, `export.a`, `export.abcd1234` є валідними. Секція `step` має кроки `export.debug` i `export.release`, відповідно, вибір кроку здійснюється порівнянням мапи критеріонів. Кроки `export.debug` i `export.release` в свою чергу обирають потрібний шлях в секції `path` за селектором `path::fileToExport.*`.   

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

Експортуйте модуль зі збіркою з встановленим критеріоном `debug : 1`.  

<details>
  <summary><u>Ресурс <code>export.release</code> зі зміненим ґлобом</u></summary>

```yaml
  export.release :
    inherit : predefined.export
    export : path::fileToExport.r??????
    tar : 0
    criterion :
      debug : 0

```

</details>

Ґлоб `*` може бути замінений на `?` - один будь-який знак (при умові відомого числа знаків). Наприклад, змініть ресурс `export.release` в секції `step` до вказаної вище форми.  

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

Видаліть створену утилітою `willbe` директорію `out` (команда `rm -Rf out`) та введіть `will .export export.release`.  

Утиліта співставила назви шляхів, та обрала `fileToExport.release` згідно вказаних ґлобів. 

### Підсумок  

- Поєднання селекторів з ґлобами та критеріонів - потужний інструмент в налаштуванні побудови модуля.  - Використання ґлобів, робить побудову модуля гнучкою.  

Побудовані збірки не виключають помилок, тож, [в наступному туторіалі](AssertsUsing.md) показано як зменшити ймовірність їх появи в `вілфайлі`.

[Повернутись до змісту](../README.md#tutorials)
