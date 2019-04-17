# Command  <code>.clean</code>

How to use command <code>.clean</code> for deleting generated and downloaded files.

Побудова модуля пов'язана з виконанням файлових операцій завантаження, копіювання, перетворення, що призводить до появи тимчасових, проміжних файлів, які в кінцевій стадії не потрібні. Вони видаляються для створення віддаленої копії версії модуля, для очищення модуля або перед побудовою для перевірки внесених змін в `will-файл`. В утиліті `willbe` є три типи файлів, які очищаються при введенні команди `.clean` - це директорія `.module` з підмодулями, шлях `temp` і згенеровані при експорті модуля `.out.will`-файл з архівом. Завантажені підмодулі, використовуються модулем при побудові і можуть не використовуватись після, тимчасові (проміжні, згенеровані) файли зручно поміщати в спеціалізовану директорію `temp`, а експортовані файли потрібно очищати перед новим експортом модуля - утиліта перезаписує файли якщо вони наявні в директорії `out`.   

### Використання команди `.clean`. Конфігурація
Створіть структуру файлів, приведену нижче та внесіть код в кожен файл:  

<details>
  <summary><u>Структура модуля</u></summary>

```
cleanCommand
        ├── module
        │     └── Color.download.will.yml
        └── .will.yml

```

</details>
<details>
  <summary><u>Код файла <code>Color.download.will.yml</code></u></summary>

```yaml
about :

  name : downloadFiles
  version : 0.0.1

path :

  in : '..'
  predefined.remote : 'git+https:///github.com/Wandalen/wColor.git'
  predefined.local : './temp'

reflector :

  download.files :
    src : path::predefined.remote
    dst : path::predefined.local

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
    currentPath : path::predefined.dir
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
      - export.module*=1

```

</details>

В файлі `.will.yml` в збірці `make.module` приведена основна послідовність дій: завантаження віддалених підмодулів >> копіювання файлів підмодуля >> завантаження файлів для модуля в директорію `temp` (запуск побудови в директорії `module`) >> копіювання файлів з директорії `temp` >> експорт побудованого модуля. Файл `Color.download.will.yml` створений для завантаження файлів з віддаленого сервера.  
Запустіть побудову модуля в кореневій директорії `.will.yml`:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
...
 . Read 1 will-files in 1.491s

  Building module::cleanCommand / build::make.module
     . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
     + module::Tools version master was downloaded in 21.695s
   + 1/1 submodule(s) of module::cleanCommand were downloaded in 21.704s
   + reflect.submodules reflected 56 files /path_to_file/ : out/module.debug <- .module/Tools/proto in 2.059s
 > will .each module .build
Command ".each module .build"

Module at /path_to_file/module/Color.download.will.yml
 . Read : /path_to_file/module/Color.download.will.yml
 . Read 1 will-files in 1.189s

    Building module::downloadFiles / build::download.files
     + download.files reflected 71 files :/// : path_to_file/temp <- git+https://github.com/Wandalen/wColor.git in 4.383s
    Built module::downloadFiles / build::download.files in 4.438s

   + reflect.files reflected 9 files /path_to_file/ : out/module.debug <- temp/out in 0.603s
   + Write out archive /path_to_file/out/ : cleanCommand.out.tgs <- module.debug
   + Write out will-file /path_to_file/out/cleanCommand.out.will.yml
   + Exported make.module with 64 files in 2.675s
  Built module::cleanCommand / build::make.module in 39.521s

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

Модуль побудовано і експортовано. Якщо, з часом, розробник змінив модуль, то перед новою побудовою йому потрібно видалити зайві файли. Введіть команду очищення і перевірте зміни в директорії `cleanCommand`:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

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

Після видалення залишились всі файли, які не відносяться до директорій `.module` i `temp`. Також, в директорії `out` видалено експортовані файли.

### Підсумок  
- Команда `.clean` потрібна для очищення модуля від тимчасових і згенерованих файлів.
- Команда `.clean` очищає директорію `.module`, директорію `temp` i експортовані файли.  

[Повернутись до змісту](../README.md#tutorials)
