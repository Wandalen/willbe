# Імпорт локального підмодуля

Використання локального підмодуля із іншого модуля (супермодуля).

Крім віддалених підмодулів, ви можете використовувати створені локально на машині. Для цього в секцію `submodule` потрібно додати новий ресурс з шляхом до `вілфайла` підмодуля. Якщо використовується неіменований `вілфайл`, вказується тільки шлях, а для іменованих `вілфайлів` вказується шлях з назвою файла до розширення `.will.yml` або `.out.will.yml`.   

### Стартова конфігурація

<details>
  <summary><u>Структура модуля</u></summary>

```
localSubmodule
        ├── modules
        │      ├── localOne
        │      │     └── .will.yml
        │      │
        │      └── localTwo
        │             └── out
        └── .will.yml      └── local.out.will.yml

```

</details>

Створіть структуру, як приведено вище, для використання двох локальних підмодулів. Один файл іменований, другий - неіменований. 

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : 'local.import'
  description : 'To use local modules'
  version : 0.0.1

submodule :

  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  localOne : ./modules/localOne/
  localTwo : ./modules/localTwo/out/local

```

</details>

Помістіть в файл `.will.yml` приведений код.

Для порівняння роботи команд з віддаленими і локальними підмодулями введено віддалений підмодуль `PathFundamentals`.  

<details>
  <summary><u>Код файла <code>.will.yml</code> в директорії <code>localOne</code></u></summary>

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
    inherit : module.export
    export : path::fileToExport
    tar : 0

build :
  export.single :
    criterion :
      default : 1
      export : 1
    steps :
      - export.single

```

</details>

Для файла `.will.yml` в директорії `localOne` використайте код, що приведений вище.

Також, використайте експортований `exportModule.out.will.yml` файл з [попереднього туторіалу](ModuleExport.md). Перейменуйте його в `local.out.will.yml` та помістіть за шляхом `./modules/localTwo/out/`. Якщо у вас немає файла, ви можете його завантажити [за посиланням]( https://github.com/Wandalen/willbe/tree/master/sample/submodulesLocal/modules/localTwo/out/).   

### Дослідження локальних підмодулів

<details>
  <summary><u>Вивід команди <code>will .submodules.list</code></u></summary>

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

</details>

Перевірте конфігурацію підмодулів командою `will .submodules.list`.   

<details>
  <summary><u>Вивід команди <code>will .submodules.download</code></u></summary>

```
[user@user ~]$ will .submodules.download
...
   + module::PathFundamentals was downloaded in 4.872s
 + 1/3 submodule(s) of module::local.import were downloaded in 4.877s

```

</details>
<details>
  <summary><u>Структура модуля після завантаження</u></summary>

```
.
├── .modules
│      └── PathFundamentals
├── modules
│      ├── localOne
│      │     └── .will.yml
│      │
│      └── localTwo
│             └── out
└── .will.yml      └── local.out.will.yml

```

</details>

Завантаження та оновлення для локальних підмодулів не потрібне - на машині знаходиться актуальна версія модуля. Завантажте віддалений підмодуль командою `will .submodules.download`.  

<details>
  <summary><u>Вивід команди <code>will .submodules.list</code></u></summary>

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

</details>

Перегляньте зміни в виводі інформації про підмодулі (`will .submodules.list`).

Локальні підмодулі завжди мають статус завантажені `isDownloaded : 1`, a в виводі інформації про віддалені підмодулі вказується `true` або `false`. Якщо підмодуль посилається на експортований `вілфайл`, то в полі `Exported builds` виводиться інформація по якій збірці він будувався.  

<details>
  <summary><u>Вивід команди <code>will .submodules.clean</code></u></summary>

```
[user@user ~]$ will .submodules.clean
...
- Clean deleted 93 file(s) in 0.385s

```

</details>
<details>
  <summary><u>Структура модуля після видалення підмодулів</u></summary>

```
.
├── modules
│      ├── localOne
│      │     └── .will.yml
│      │
│      └── localTwo
│             └── out
└── .will.yml      └── local.out.will.yml

```

</details>

Видаліть підмодулі фразою `will .submodules.clean`.

Після проведення операції локальні підмодулі залишились без змін. Утиліта `willbe` не виконує операцій над локальними підмодулями для збереження даних.

### Підсумок

- Щоб підключити локальний підмодуль, внесіть ресурс в секцію `submodule` з посиланням на `вілфайл` підмодуля.  
- При підключенні підмодуля з `out-вілфайлом` утиліта відображає збірки, по яким він побудований.
- Для збереження данних `willbe` не виконує операцій над локальними підмодулями.  

[Повернутись до змісту](../README.md#tutorials)
