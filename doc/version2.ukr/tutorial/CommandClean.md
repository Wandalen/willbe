# Команда очистки <code>.clean</code>

Використання команди <code>.clean</code> для очистки згенерованих та тимчасових файлів.

Побудова модуля пов'язана з виконанням файлових операцій завантаження, копіювання, перетворення, що призводить до появи тимчасових, проміжних файлів, які в кінцевій стадії не потрібні. Вони видаляються перед створенням реліз-версії модуля, для очищення модуля від зайвих файлів або перед новою побудовою для перевірки внесених змін в `вілфайл`. 

В утиліті `willbe` є три типи файлів, які очищаються при введенні [команди `.clean`](../concept/Command.md#Таблиця-команд-утиліти-willbe) - це директорія `.module` з підмодулями, директорія за шляхом `temp` та згенеровані при експорті модуля `.out-вілфайл` з архівом. Завантажені підмодулі, використовуються модулем при побудові і можуть не використовуватись після, тимчасові (проміжні, згенеровані) файли зручно поміщати в спеціалізовану директорію за шляхом `temp`, а експортовані файли потрібно очищати перед новим експортом модуля. Якщо залишити існуючі `out-вілфайли`, то утиліта перепише їх, додавши нові експортні дані.   

### Використання команди `.clean`. Конфігурація

<details>
  <summary><u>Структура модуля</u></summary>

```
cleanCommand
        ├── module
        │     └── Color.download.will.yml
        └── .will.yml

```

</details>

Створіть структуру файлів приведену вище для дослідження команди `.clean`.

<details>
  <summary><u>Код файла <code>Color.download.will.yml</code></u></summary>

```yaml
about :

  name : downloadFiles
  version : 0.0.1

path :

  in : '..'
  remote : 'git+https:///github.com/Wandalen/wColor.git'
  local : './temp'

reflector :

  download.files :
    src : path::remote
    dst : path::local

build :

  download.files :
    criterion :
      default : 1
    steps :
      - step::download.files

```

</details>
<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : cleanCommand
  description : "To use .clean command"
  version : 0.0.1

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

path :

  in : '.'
  out : 'out'
  temp : 'temp'
  out.debug :
    path : './out/module.debug'
    criterion :
      debug : 1
  out.release :
    path : './out/module.release'
    criterion :
      debug : 0

reflector :

  reflect.submodules :
    inherit : submodule::*/exported::*=1/reflector::exportedFiles*=1
    dst :
      basePath : .
      prefixPath : path::out.*=1
    criterion :
      debug : 1
    step : predefined.reflector

  reflect.files :
    filePath :
      '*.yml' : false
      '{path::temp}/out' : path::out.*=1
    criterion :
      debug : 1

step :

  files.import :
    currentPath : path::module.dir
    shell : 'will .each module .build'

  export.module :
    export : path::out.*=1
    criterion :
      debug : 1

build :

  make.module :
    criterion :
      default : 1
      debug : 1
    steps :
      - submodules.download
      - reflect.submodules*=1
      - files.import
      - reflect.files
  
  export : 
    criterion :
      default : 1
      export : 1
    steps :
      - export.module*=1

```

</details>

Внесіть відповідний код в файли.

В файлі `.will.yml` в збірці `make.module` приведена основна послідовність дій: 
- завантаження віддалених підмодулів;
- копіювання файлів підмодуля в кроці `reflect.submodules*=1`;
- завантаження файлів для неформального підмодуля в директорію `temp` (крок `files.import`);
- копіювання файлів з директорії `{path::temp}/out` в директорію `path::out.*=1`.
Збірка `export` виконує експорт побудованого модуля.  

Файл `Color.download.will.yml` створений для завантаження файлів з віддаленого сервера.   

### Побудова і очищення модуля

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
 Building module::cleanCommand / build::make.module
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools was downloaded version master in 14.125s
   + 1/1 submodule(s) of module::cleanCommand were downloaded in 14.134s
   + reflect.submodules reflected 56 files /path_to_file/ : out/module.debug <- .module/Tools/proto in 2.041s
 > will .each module .build
Command ".each module .build"

Module at /path_to_file/module/Color.download.will.yml
 . Read : /path_to_file/module/Color.download.will.yml
 . Read 1 will-files in 0.270s 

    Building module::downloadFiles / build::download.files
     + download.files reflected 71 files :/// : path_to_file/temp <- git+https://github.com/Wandalen/wColor.git in 3.573s
    Built module::downloadFiles / build::download.files in 3.644s

   + reflect.files reflected 9 files /path_to_file/ : out/module.debug <- temp/out in 0.435s
  Built module::cleanCommand / build::make.module in 26.338s

```

</details>
<details>
  <summary><u>Вивід команди <code>will .export</code></u></summary>

```
[user@user ~]$ will .export
...
 Exporting module::cleanCommand / build::export
   + Write out will-file /path_to_file/out/cleanCommand.out.will.yml
   + Exported export with 64 files in 2.241s
  Exported module::cleanCommand / build::export in 2.293s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
cleanCommand
        ├── .module
        │     └── Tools
        ├── module
        │     └── Color.download.will.yml
        ├── out
        │    ├── module.debug
        │    │           ├── debug
        │    │           └── dwtools
        │    ├── cleanCommand.out.tgs
        │    └── cleanCommand.out.will.yml
        ├── temp
        │     ├── out
        │    ...   ├── debug
        │          └── wColor.out.will.yml
        └── .will.yml

```

</details>

Запустіть побудову модуля в кореневій директорії `.will.yml` командою `will .build`. Після побудови виконайте експорт модуля командою `will .export`  

<details>
  <summary><u>Вивід команди <code>will .clean</code></u></summary>

```
[user@user ~]$ will .clean
...
 - Clean deleted 323 file(s) in 1.227s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
cleanCommand
        ├── module
        │     └── Color.download.will.yml
        ├── out
        │    └── module.debug
        │                ├── debug
        │                └── dwtools
        └── .will.yml

```

</details>

Модуль побудовано і експортовано. Якщо, з часом, розробник змінив модуль, то перед новою побудовою йому потрібно видалити зайві файли. Введіть команду `will .clean` і перевірте зміни в директорії `cleanCommand`.

Після видалення залишились всі файли, які не відносяться до директорій `.module` i `temp`. Також, в директорії `out` видалено експортовані файли.

### Підсумок  

- Команда `.clean` потрібна для очищення модуля від тимчасових і згенерованих файлів.
- Команда `.clean` видаляє директорію `.module`, директорію за шляхом `temp` i експортовані файли модуля.  
- Команда `.clean` не видаляє локальні підмодулі.

[Повернутись до змісту](../README.md#tutorials)
