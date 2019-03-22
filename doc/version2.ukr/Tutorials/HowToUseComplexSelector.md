# Як використовувати складні селектори

В туторіалі пояснюється застосування складних селекторів при побудові модуля, приведено приклади застосування ґлобів та ассертів

Загальне призначення і використання селекторів ми вже дослідили на простих прикладах, де вибірка проходить в тій же директорії або лише на рівень нижче. В реальних системах вам може знадобитись використати дані з будь-якого місця операційної системи, для цього в `willbe` використовуються складні селектори.  
В прикладі розглянемо систему, яка буде будувати експорт модулів з двох різних шляхів. Але спершу створіть структуру для тесту:

```
.
├── Debug
│     ├── testing
│     │      └── fileToExport
│     └── temp        └── test.will.yml
│ 
├── Release
│      ├── setting
│      └── testing    
│ 
└── .will.yml

```

Складний селектор відрізняється від звичайного формою запису - вказує на обраний елемент як шлях до файла. Відповідно, побудуємо модуль використовуючи складні селектори з ґлобами.

<details>
    <summary><u><em>Лістинг `.will.yml`</em></u></summary>

```yaml
about :
  name : complexSelector
  description : 'To use complexSelector in will-file'
  version : 0.0.1

path :

  in : '.'
  out : 'out'

  out.debug :
    path : './D*/t??????/[a-f]*/test.*'
    criterion :
      debug : 1

  release :
    path : './R*/[s-t]*'

step :

  exportFile.to.out :
    export : path::out.*=1
    tar : 0
    criterion :
      debug : 1

  exportDir.to.out :
    export : path::release
    tar : 0

build :

  export.debug :
    criterion :
      default : 1
      export : 1
      debug : 1
    steps :
      - step::exportFile.*=1

  export.release :
    criterion :
      export : 1
    steps :
      - step::exportDir.*

```

</details>

Ми використали ще один вид глобу - квадратні дужки `[]`, в які поміщають діапазон значень для вибірки. В прикладі `[a-f]*` означає, що файл чи директорія повинна починатись на літеру від _а_ до _f_ та мати будь-яке продовження. Ассерти краще використовувати для попередження неправильного виконання кроків тому, вони не поміщені в вибірку файлів.  
Запустимо збірку експорту за замовчуванням:  

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