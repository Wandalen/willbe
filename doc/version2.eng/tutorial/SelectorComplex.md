# Складні селектори

Використання складних селекторів для відбору ресурсів із підмодулів.

При побудові модуля може виникнути потреба використати дані з будь-якого місця операційної системи, або  отримати доступ до ресурсів іншого `will-файла`, для цього в `willbe` використовуються складні селектори. Складний селектор відрізняється від звичайного формою запису - вказує на обраний елемент як шлях до файла.   
Для дослідження складних селекторів побудуйте структуру файлів приведену нижче:  

<details>
  <summary><u>Структура модуля</u></summary>

```
complexSelector
        ├── file
        │     ├── testing
        │     │      └── fileToExport
        │     └── temp        └── test.will.yml  
        │
        └── .will.yml

```

</details>

Внесіть в файл `.will.yml` код:  

<details>
    <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : complexSelector
  description : 'To use complexSelector in will-file'
  version : 0.0.1

submodule : 
 
  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

path :

  in : '.'
  out : 'out'
  export.file : './f*/t??????/[a-f]*/test.*'

step :

  exportFile :
    export : path::export.file
    tar : 0

  exportSubmodule :
    export : submodule::*/exported::*=1/reflector::exportedFiles*=1
    tar : 0

build :

  export.file :
    criterion :
      export : 1
      default : 1
    steps :
      - step::exportFile

  export.submodule :
    criterion :
      export : 1
    steps :
      - submodules.download
      - step::exportSubmodule

```

</details>

В шляху `export.file` використано ще один ґлоб - квадратні дужки `[]`- позначає діапазон значень для вибірки. В файлі ґлоб `[a-f]*` означає, що файл чи директорія повинна починатись на літеру від `а` до `f` та мати будь-яке продовження.   
Запустіть збірку експорту за замовчуванням:  

<details>
  <summary><u>Вивід команди <code>will .export</code></u></summary>
    
```
[user@user ~]$ will .export
...
Exporting module::complexSelector / build::export.file
   + Write out will-file /path_to_file/out/complexSelector.out.will.yml
   + Exported export.debug with 1 files in 1.984s
  Exported module::complexSelector / build::export.file in 2.059s

```

</details>
<details>
  <summary><u>Структура модуля після експорту</u></summary>

```
.
├── Debug
│     ├── testing
│     │      └── fileToExport
│     └── temp        └── test.will.yml 
├── out
│     └── complexSelector.out.will.yml
│
└── .will.yml

```

</details>

Експортовано один файл, помилок немає. В збірці `export.submodule` крок `exportSubmodule` використовує складний селектор, в якому здійснюється доступ до `out.will`-файла підмодуля, де вибираються ресурси секції `exported`. Запустіть експорт збірки `export.submodule`:

<details>
  <summary><u>Вивід команди <code>will .export export.submodule</code></u></summary>

```
[user@user ~]$ will .export
...
  Exporting module::complexSelector / build::export.submodule
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was downloaded in 13.710s
   + 1/1 submodule(s) of module::complexSelector were downloaded in 13.718s
   . Read : /path_to_file/out/complexSelector.out.will.yml
   . Read 1 will-files in 0.231s  
  
   + Write out will-file /path_to_file/out/complexSelector.out.will.yml
   + Exported export.submodule with 261 files in 3.741s
  Exported module::complexSelector / build::export.submodule in 3.895s

```

</details>

Експортовано файли підмодуля `Tools`.  

### Підсумок  
- Складний селектор записується як шлях до ресурса.
- Складні селектори дозволяють створити вибірку даних в будь-якому місці операційної системи.  
- Складні селектори використовують ресурси `will-файлів` підмодулів.  

[Повернутись до змісту](../README.md#tutorials)
