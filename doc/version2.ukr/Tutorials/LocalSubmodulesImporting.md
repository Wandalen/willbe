# Імпорт локального підмодуля

В туторіалі показано як додати локальний підмодуль

Крім віддалених підмодулів, ви можете використовувати створені локально на машині. Для цього в секцію `submodule` потрібно додати новий ресурс з шляхом до `will-файла`. Якщо використовується неіменований `will`-файл, використовуйте або повну назву файла або тільки шлях, а для іменованих `will`-файлыв вказуйте назву файла до розширення `.will.yml` або `.out.will.yml`.   
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
  localOne : ./local.modules/localOne/
  localTwo : ./local.modules/localTwo/out/local

```

Для порівняння роботи команд з віддаленими і локальними підмодулями введено віддалений ресурс `PathFundamentals`.  
Для файла `.im.will.yml` використаємо лістинг `.will.ymml` з туторілу [Експортування модуля](ExportedWillFile.md):

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

Також використаємо експортований `exportModule.out.will.yml` файл з цього туторіалу, перейменувавши його в `local.out.will.yml` та помістимо за шляхом `./local.modules/localTwo/out/` (якщо у вас немає файла, пройдіть туторіал [Експортування модуля](ExportedWillFile.md)).  
Перевіримо конфігурацію фразою `will .submodules.list`:

```
[user@user ~]$ will .submodules.list
...
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []
submodule::localOne
  path : ./local.modules/localOne/
  isDownloaded : 1
  Exported builds : []
submodule::localTwo
  path : ./local.modules/localTwo/out/local
  isDownloaded : 1
  Exported builds : [ 'export' ]

```

Завантаження та оновлення для локальних підмодулів не потрібне - на машині знаходиться актуальна версія модуля, але завантажимо віддалений. 

```
[user@user ~]$ will .submodules.download
...
   + module::PathFundamentals was downloaded in 4.872s
 + 1/3 submodule(s) of module::local.import were downloaded in 4.877s

``` 
Перегляньте директорію модуля:

``` 
[user@user ~]$ ls -al
...
drwxr-xr-x 4 user user 4096 Мар 12 13:25 local.modules
drwxr-xr-x 4 user user 4096 Мар 12 13:27 .module
-rw-r--r-- 1 user user  307 Мар 12 13:41 .will.yml

```

Виведемо інформацію про підмодулі (`will .submodules.list`):

```
[user@user ~]$ will .submodules.list
...
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : true
  Exported builds : [ 'proto.export' ]
submodule::localOne
  path : ./local.modules/localOne/
  isDownloaded : 1
  Exported builds : []
submodule::localTwo
  path : ./local.modules/localTwo/out/local
  isDownloaded : 1
  Exported builds : [ 'export' ]

```

З чого встановлюємо, що локальні підмодулі завжди мають статус завантажені `isDownloaded : 1` (в виводі інформації про віддалені підмодулі вказується `true` або `false`), а також, якщо підмодуль посилається на експортований `will`-файл, то виводиться інформація по якій збірці він будувався.  
Видалимо підмодулі фразою `will .submodules.clean`:

```
[user@user ~]$ will .submodules.clean
...
- Clean deleted 93 file(s) in 0.385s

```
Прогляньте структуру модуля:

``` 
[user@user ~]$ ls -al
...
drwxr-xr-x 4 user user 4096 Мар 12 13:25 local.modules
-rw-r--r-- 1 user user  307 Мар 12 13:41 .will.yml

```

```
[user@user ~]$ ls -al local.modules/
...
drwxr-xr-x 2 user user 4096 Мар 12 13:51 localOne
drwxr-xr-x 3 user user 4096 Мар 12 13:13 localTwo

```

Приведені лістинги свідчать, що утиліта `willbe` не виконує операцій з локальними підмодулями для їх збереження. Щоб керувати локальними підмодулями, потрібно використовувати інструменти утиліти для роботи з файловою системою. 

- Щоб підключити локальний підмодуль, внесіть відповідний ресурс в секцію `submodule`.  
- Для збереження данних, `willbe` не виконує операцій над локальними підмодулями.  

[Повернутись до змісту](../README.md#tutorials)