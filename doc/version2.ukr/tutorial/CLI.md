# Інтерфейс командного рядка

Як користуватися інтерфейсом командного рядка утиліти <code>willbe</code>. Застосування команд <code>.help</code> та <code>.list</code>.

### Доповнення команд

Після [встановлення](<Instalation.md>) утиліти `willbe` в консолі вашої ОС введіть команду `will .`.

<details>
  <summary><u>Вивід команди <code>will .</code></u></summary>

```
[user@user ~]$ will .  
Command "."
Ambiguity. Did you mean?
  .help - Get help.
  .set - Command set.
  .resources.list - List information about resources of the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List avaialable reflectors.
  .steps.list - List avaialable steps.
  .builds.list - List avaialable builds.
  .exports.list - List avaialable exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.
  .submodules.clean - Delete all downloaded submodules.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.update - Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.
  .submodules.fixate - Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.
  .submodules.upgrade.refs - Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.
  .shell - Execute shell command on the module.
  .clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules.
  .clean.what - Find out which files will be deleted by clean command.
  .build - Build current module with spesified criterion.
  .export - Export selected the module with spesified criterion. Save output to output file and archive.
  .with - Use "with" to select a module.
  .each - Use "each" to iterate each module in a directory.
```

</details>

В утиліті `willbe` всі команди починаються з вводу `will .`. Кожна команда - це фраза, котра складається із одного або більше слів. Наприклад:

```
will .help
will .about.list
will .resources.list
will .paths.list
```

<details>
  <summary><u>Вивід команди <code>will .list</code></u></summary>

```
[user@user ~]$ will .list
Command ".list"
Ambiguity. Did you mean?
  .resources.list - List information about resources of the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List avaialable reflectors.
  .steps.list - List avaialable steps.
  .builds.list - List avaialable builds.
  .exports.list - List avaialable exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.

```

</details>

Для отримання переліку фраз, що мають слово `list` введіть команду `will .list`:

Утиліта `willbe` має багато команд, що містять слово `list` тому вона виводить інорфмацію про всі можливі фрази із вказаним словом при такому виводі. Це зручно, якщо ви забули повну фразу з командою. Це допомагає дослідити можливості утиліти. Щоб отримати вичерпний список команд з даним словом, достатньо його ввести, а утиліта запропонує варіанти доповнення.

### Команда `.help`

Для отримання довідки по обраній команді використовуйте синтаксис: `will .help [команда]`.    

<details>
  <summary><u>Вивід команди <code>will .help .build</code></u></summary>

```
[user@user ~]$ will .help .build
Command ".help .build"

  .build - Build current module with spesified criterion.

```

</details>

Введіть в терміналі `will .help .build`

<details>
  <summary><u>Вивід команди <code>will .help .builds.list</code></u></summary>

```
[user@user ~]$ will .help .builds.list
Command ".help .builds.list"

  .builds.list - List avaialable builds.

```

</details>

Для отримання переліку збірок даного модуля введіть команду `will .help .builds.list` і порівняйте вивід.

<details>
  <summary><u>Вивід команди <code>will .help .submodules</code></u></summary>

```
[user@user ~]$ will .help .submodules
Command ".help .submodules"

  .submodules.list - List submodules of the current module.
  .submodules.clean - Delete all downloaded submodules.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.update - Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.
  .submodules.fixate - Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.
  .submodules.upgrade.refs - Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.

```

</details>

Для отимання довідки по всім фразам, що містять слово `submodule` введіть команду `will .help .submodules`.

Команда була неповною і утиліта `willbe` знову запропонувала варіанти фраз з вказаним словом.

### Команда `.*.list`  

Більшість команд працюємо із `will-файлами` конкретних модулів.

<details>
  <summary><u>Файлова структура</u></summary>

```
commands
    └── .will.yml
```

</details>

Створіть нову директорію з назвою `commands` в яку помістіть файл з назвою `.will.yml`.

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :
  name : test
  description : "To test commands of willbe-package"
  version : 0.0.1

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

path :

  proto : 'proto'
  out.debug : 'out/debug'

step :

  delete.proto :
    inherit : predefined.delete
    filePath: path::proto

  delete.out.debug :
    inherit : predefined.delete
    filePath : path::out.debug

build :

  debug :
    criterion :
      default : 1
    steps :
      - submodules.download
      - delete.out.debug
      - delete.proto

```

</details>

Скопіюйте код, приведений нижче, в файл `.will.yml`:  

В списку команд утиліти `willbe` багато таких, які закінчуються на `.list`. Вони роблять перелік ресурсів заданого типу поточного модуля. Тому якщо ввести одну із команд `.*.list` в директорії, де відсутній `will-файл`, ви отримаєте попередження про відсутність модуля.

<details>
  <summary><u>Вивід команди <code>will .builds.list</code>в поточній директорії</u></summary>

```
[user@user ~]$ will .builds.list
Command .builds.list
Found no module::/[path] at "/[path]"

```

</details>

Для того щоб переконатися, що команду `will .about.list` працює із поточним модулем введіть її в директорі без `will-файла`:

<details>
  <summary><u>Вивід команди <code>ls -al</code></u></summary>

```
[user@user ~]$ ls -al
итого 12
drwxr-xr-x 2 user user 4096 Mar 11 11:27 .
drwxr-xr-x 6 user user 4096 Mar 11 11:27 ..
-rw-r--r-- 1 user user  917 Mar  4 15:07 .will.yml

```

</details>

Відкрийте директорію `commands` в консолі та перевірте її вміст виконавши команду `ls -al`:

<details>

  <summary><u>Вивід команди <code>will .about.list</code></u></summary>

```
About
  name : 'test'
  description : 'To test commands of willbe-package'
  version : '0.0.1'
  enabled : 1
```

</details>

Для отримання описової інформацію про модуль використайте команду `will .about.list`

Зверніть увагу, що деякі ресурси мають поля із значеннями за замовчуванням. Якщо таке поле відсутнє, то завантажуючи `will-файл` з диска утиліта його генерує.  

<details>
  <summary><u>Секція <code>about</code> файлу <code>.will.yml</code></u></summary>

```yaml
about :
  name : test
  description : "To test commands of willbe-package"
  version : 0.0.1
```

</details>

Тому в виводі команди `will .about.list` секція `about` має поле `enabled`, яке відсутнє в `will-файлі`:  

<details>
  <summary><u>Вивід команди <code>will .builds.list</code></u></summary>

```
[user@user ~]$ will .builds.list
Command ".builds.list"
...
build::debug
  criterion :
    default : 1
  steps :
    - submodules.download
    - delete.out.debug
    - delete.proto

```

</details>
<details>
  <summary><u>Секція <code>build</code> файлу <code>.will.yml</code></u></summary>

```yaml
build :

  debug :
    criterion :
      default : 1
    steps :
      - submodules.download
      - delete.out.debug
      - delete.proto

```

</details>

Для отирмання переліку збірок поточного модуля введіть команду `will .builds.list`. Після того як на моніторі відобразиться результат, відкрийте файл `.will.yml` за допомогою текстового редактора і порівняйте вміст секції `build` файла і вивід команди.

Інформацію про окрему секцію `will-файла` можливо отримати ввівши фразу `will .[назва секції].list`.

<details>
  <summary><u>Вивід команди <code>will .submodules.list</code></u></summary>

```
[user@user ~]$ will .submodules.list
Command ".submodules.list"
   . Read : /path_to_file/submodules/.will.yml
 . Read 1 will-files in 0.084s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : false
  Exported builds : []
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```

</details>
<details>
  <summary><u>Секція <code>submodule</code> файлу <code>.will.yml</code></u></summary>

```yaml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

</details>

Перерахуємо підмодулі командо `will .submodules.list`.

Перераховуючи підмодулі утиліта виводить попередження про помилку зчитування інформації про підмодулі і дає рекомендацію завантажити їх з допомогою команди `.submodules.download`.  

<details>
  <summary><u>Повідомлення про помилку зчитування підмодулів</u></summary>

```
! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

```

</details>

Інформація, що утиліта `willbe` вивела відповідає тій, яка записана в `will-файлі`.

<details>
  <summary><u>Вивід команди <code>will .resources.list</code></u></summary>

```
[user@user ~]$ will .resources.list
  . Read : /path_to_file/.will.yml
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even .clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even .clean it before downloading
 . Read 1 will-files in 1.865s

About
  name : 'test'
  description : 'To test commands of willbe-package'
  version : '0.0.1'
  enabled : 1

Paths
  predefined.willbe : '/usr/lib/node_modules/willbe/proto/dwtools/atop/will/Exec'
  predefined.will.files : '/home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe/sample/version2/CLI/.will.yml'
  predefined.dir : '/home/dmytry/Документы/UpWork/IntellectualServiceMysnyk/willbe/sample/version2/CLI'
  proto : 'proto'
  out.debug : 'out/debug'

submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : false
  Exported builds : []

submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

step::delete.proto
  opts :
    filePath : path::proto
  inherit :
    predefined.delete

step::delete.out.debug
  opts :
    filePath : path::out.debug
  inherit :
    predefined.delete

build::debug
  criterion :
    default : 1
  steps :
    submodules.download
    delete.out.debug
    delete.proto

```

</details>

Щоб перерахувати всі ресурси поточного модуля використайте команду `will .resources.list`:

### Підсумок

- Використовуйте [команду `will .`](#команда-help) для отримання переліку всіх команд ( фраз ).
- Використовуйте [команду `will .[word]`](#команда-help) для отримання переліку всіх команд ( фраз ), що мають слово `word`.
- Використовуйте [команду `will .help [command]`](#команда-help) для отримання довідки по конкретній команді ( фразі ).
- Якщо ви забули повну фразу то `willbe` виведе перелік фраз по одному [слову](#інтерфейс-командного-рядка) яке ви пам'ятаєте.
- Використовуйте [команду `will .[resource].list`](#Команда-list) для того щоб перерахувати ресурси типу `resource` даного модуля.
- Використовуйте [команду `will .resources.list`](#Команда-list) для того щоб перерахувати всі ресурси даного модуля.

[Наступний туторіал](FirstWillFile.md).
[Повернутись до змісту](../README.md#tutorials)
