# Складні селектори

Використання складних селекторів для відбору ресурсів із підмодулів

При побудові модуля може виникнути потреба використати дані з будь-якого місця операційної системи, або ресурси іншого `will-файла`, для цього в `willbe` використовуються складні селектори. Складний селектор відрізняється від звичайного формою запису - вказує на обраний елемент як шлях до файла.   
Для дослідження складних селекторів побудуйте структуру файлів приведену нижче:  

<details>
  <summary><u>Структура модуля</u></summary>

```
.
├── Debug
│     ├── testing
│     │      └── fileToExport
│     └── temp        └── test.will.yml  
│
└── .will.yml

```

</details>

Внесіть в `.will.yml` код:  

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
  export.file :
    path : './D*/t??????/[a-f]*/test.*'

step :

  exportFile :
    export : path::export.file
    tar : 0

  exportSubmodule :
    export : submodule::*/exported::*=1/reflector::exportedFiles*=1
    tar : 0

build :

  export.debug :
    criterion :
      default : 1
    steps :
      - step::exportFile

  export.release :
    steps :
      - submodules.download
      - step::exportSubmodule

```

</details>

В прикладі використано ще один ґлоб - квадратні дужки `[]`, в які поміщають діапазон значень для вибірки. В файлі `[a-f]*` означає, що файл чи директорія повинна починатись на літеру від `а` до `f` та мати будь-яке продовження.   
Запустіть збірку експорту за замовчуванням:  


```
[user@user ~]$ will .export
...
Exporting export.debug
   + Write out will-file /path_to_file/out/complexSelector.out.will.yml
   + Exported export.debug with 1 files in 1.716s
  Exported export.debug in 1.771s

```

Експортовано один файл, помилок немає. Тепер запустимо другу збірку:

```
[user@user ~]$ will .export
...
  Exporting export.release
     . Read : /path_to_file/out/complexSelector.out.will.yml
   . Read 1 will-files in 0.215s
   + Write out will-file /path_to_file/out/complexSelector.out.will.yml
   + Exported export.release with 2 files in 2.380s
  Exported export.release in 2.440s

```

Експортовано дві директорії - `setting` i `testing`.  
Вибірка шляхів - не єдиний спосіб використання складних селекторів, дізнайтесь більше в туторіалі про рефлектори.

- Складні селектори дозволяють створити вибірку даних в будь-якому місці операційної системи.

[Наступний туторіал]()  
[Повернутись до змісту](../README.md#tutorials)
