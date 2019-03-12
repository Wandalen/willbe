# Імпорт локального підмодуля

В туторіалі показана процедура додавання локального підмодуля та її особливості

Крім віддалених підмодулів, ви можете використовувати створені локально на машині. Для цього в секцію `submodule` потрібно додати новий ресурс з шляхом до `will`-файла. Якщо використовується неіменований `will`-файл, використовуйте повну назву файла, а для іменованих вказуйте назву файла до розширення `.will.yml` або `.out.will.yml`.   
Створимо структуру для дослідження двох підмодулів - з іменованим та неіменованим файлом:

```
.
├── local.modules
│         ├── localOne
│         │     └── .im.will.yml
│         │
│         └── localTwo
│               └── out
└── .will.yml        └── local.out.will.yml

```

В директорії `local.modules` поміщено два модуля - `localOne` та `localTwo`.  
Відредагуємо `.will.yml` для використання відповідних підмодулів.  

```yaml
about :

  name : 'local.import'
  description : 'To use local modules'
  version : 0.0.1

submodule :

  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  localOne : ./local.modules/localOne/.im.will.yml
  localTwo : ./local.modules/localTwo/out/local

```

Для порівняння роботи команд з віддаленими і локальними підмодулями введено віддалений ресурс `PathFundamentals`.  
Для файла `.im.will.yml` використаємо лістинг `.will.ymml` з туторілу [Експортування модуля](ExportedWillFile.ukr.md):

<details>
  <summary><u>Лістинг файла `.im.will.yml`</u></summary>

```yaml

about :
    name : exportModule
    description : "To export single file"
    version : 0.0.1

path :
  in : '.'
  out : 'out'
  fileToExport : 'fileToExport'

step  :
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
          - export.single
```
</details>
