# Як користуватися інтерфейсом командного рядка `willbe`  

У цьому розділі описується використання командного рядка для взаємодії з пакетом `willbe`, застосування команд `.help` та `.list`  

</br>
Спочатку потрібно встановити пакет `willbe`. Для цього введіть в терміналі `npm -g install willbe` (_зверніть увагу_, якщо пакет встановлено локально, то всі описані нижче інструкції мають виконуватись в директорії пакету) Детально про `willbe` і процес інсталяції в [введені](Introduction.md).

### <a name="ui-intro"></a> Знайомство з користувацьким інтерфейсом. Команда `.help`
_Користувацький інтерфейс_ `willbe` представлено консоллю операційної системи. Тож, відкрийте її та введіть [фразу](Concepts.ukr.md#phrase) `will .`.  
Після вводу ви отримаєте повний список команд:  

<details>
  <summary><u>Лістинг `will .`</u></summary>

  ```

[user@user ~]$ will .  
Request "."  
Ambiguity  
  .help - Get help.   
  .set - Command set.
  .list - List information about the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List avaialable reflectors.
  .steps.list - List avaialable steps.
  .builds.list - List avaialable builds.
  .exports.list - List avaialable exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.
  .clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules.
  .clean.what - Find out which files will be deleted by clean command.
  .build - Build current module with spesified criterion.
  .export - Export selected the module with spesified criterion. Save output to output file and archive.
  .with - Use "with" to select a module.
  .each - Use "each" to iterate each module in a directory.

```

</details>

З описом команд можна ознайомитись в мануалі [Інтерфейс командного рядку `willbe`](CommandLineInterfaceOfWill.ukr.md#will-commands).

<a name=".help-command"></a> Скористуємось командою `.help` для виводу довідки про команду. Введіть в консолі: `will .help`.  
Результат не змінився. Спробуємо знову, але доповнимо фразу ще однією командою, щоб отримати синтаксис: `will .help [команда]`.    
Тепер введіть в терміналі `will .help .build`, а потім `will .help .builds.list` і порівняйте з лістингами нижче.  
<details>
  <summary><u>Лістинг `will .help .build`</u></summary>

  ```
  
[user@user ~]$ will .help .build
Request ".help .build"

  .build - Build current module with spesified criterion.

```

</details>

<details>
  <summary><u>Лістинг `will .help .builds.list`</u></summary>

  ```

[user@user ~]$ will .help .builds.list
Request ".help .builds.list"

  .builds.list - List avaialable builds.

```

</details>

</br>
<a name="help-completion"></a> Користуватись довідкою просто. А що буде якщо ввести неповну фразу `will .help .submodules`?
Лістинг команди `will .help .submodules`?

  ```
[user@user ~]$ will .help .submodules
Request ".help .submodules"

  .submodules.list - List submodules of the current module.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.

```

</br>
`Willbe` вивів список команд з `submodules`. Це зручно, адже, якщо ви не памятаете повну фразу з командою або бажаєте отримати вичерпний список команд з визначеним словом, достатньо ввести першу частину, а пакет запропонує доповнення.

Перед тим, як піти далі, спробуйте отримати довідку про команду `.build`, але модифікувавши '.' на інші знаки, такі, як '-' та '\_' або літеру в команді `will .help`.
<details>
  <summary><u>Лістинг `will -help .build`</u></summary>

  ```

[user@user ~]$ will -help .build
Illformed request "-help .build"

  .help - Get help.
  .set - Command set.
  .list - List information about the current module.
  .paths.list - List paths of the current module.
  .submodules.list - List submodules of the current module.
  .reflectors.list - List avaialable reflectors.
  .steps.list - List avaialable steps.
  .builds.list - List avaialable builds.
  .exports.list - List avaialable exports.
  .about.list - List descriptive information about the module.
  .execution.list - List execution scenarios.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.
  .clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules.
  .clean.what - Find out which files will be deleted by clean command.
  .build - Build current module with spesified criterion.
  .export - Export selected the module with spesified criterion. Save output to output file and archive.
  .with - Use "with" to select a module.
  .each - Use "each" to iterate each module in a directory.

```

</details>

<details>
<summary><u>Лістинг `will _help .build`</u></summary>

```

[user@user ~]$ will -help .build
Illformed request "-help .build"

.help - Get help.
.set - Command set.
.list - List information about the current module.
.paths.list - List paths of the current module.
.submodules.list - List submodules of the current module.
.reflectors.list - List avaialable reflectors.
.steps.list - List avaialable steps.
.builds.list - List avaialable builds.
.exports.list - List avaialable exports.
.about.list - List descriptive information about the module.
.execution.list - List execution scenarios.
.submodules.download - Download each submodule if such was not downloaded so far.
.submodules.upgrade - Upgrade each submodule, checking for available updates for such.
.submodules.clean - Delete all downloaded submodules.
.clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules.
.clean.what - Find out which files will be deleted by clean command.
.build - Build current module with spesified criterion.
.export - Export selected the module with spesified criterion. Save output to output file and archive.
.with - Use "with" to select a module.
.each - Use "each" to iterate each module in a directory.

```

</details>

<details>
  <summary><u>Лістинг команди `will .paths.list`</u></summary>

  ```

[user@user ~]$ will .held .build
Request ".held .build"
------------------------------- unhandled errorr ------------------------------->

 * Application
Current path : /[path]
Exec path : /usr/bin/node /usr/lib/node_modules/willbe/proto/dwtools/atop/will/MainTop.s .held .build

Unknown subject ".held"
Try subject ".help"   
------------------------------- unhandled errorr -------------------------------<

```

</details>

Після цього не залишається сумнівів, що перед командами завжди потрібно вводити '.' та вірно вводити фразу.  

### Команди `*.list`
Наступним рівнем є використання операцій з [will-файлами](Concepts.urk.md#will-file). Створювати will-файли ми навчимось пізніше, а поки клонуйте Git-репозиторій ['willbe`](https://github.com/Wandalen/willbe) з готовими прикладами за [посиланням](https://github.com/Wandalen/willbe).  

<a name="list-commands"></a> Мабуть, ви звернули увагу на те, що списку доступних команд досить багато таких, які закінчуються на `.list`. Ці команди взаємодіють з [модулем](Concepts.urk.md#module) та виводять інформацію про нього. Якщо ввести будь-яку з команд в директорії, де відсутній файл, то ви отримаєте попередження про його відсутність:

```

[user@user ~]$ will .list
Request ".list"
Found no module::/[path] at "/[path]"

```

Тож, відкрийте клонований репозиторій і перейдіть за шляхом './sample/submodules/', де знаходиться файл `.will.yml` та відкрийте директорію в терміналі (або одразу виконайте `cd [.../willbe/sample/submodules/]`). Можливо, його не буде видно, ввімкніть відображення прихованих файлів.
Після цього введіть `will .paths.list`.
Після того як на моніторі відобразиться результат, відкрийте файл `.will.yml` з допомогою вашого улюбленого текстового редактора. Порівняйте вміст [секції](Concepts.urk.md#will-file-section) `path` файлу і текст який отримали в терміналі.  
<details>
  <summary><u>Лістинг команди `will .paths.list`</u></summary>

  ```
[user@user ~]$ will .paths.list
Request ".paths.list"
  . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.080s
...
Paths
  proto : './proto'
  in : '.'
  out : 'out'
  out.debug : 'out/debug'

```

Секція `path`  
![path.section](./Images/path.section.png)

</details>

Інформацію окремої секції модуля можливо отримати ввівши фразу `will [назва секції]s.list` (закінчення 's' додається до назв секції, виключення - секція [`about`](WillFileStructure.ukr.md#about) без змін).
Тепер дізнаємось інформацію з секції `submodule`. Порівняйте:
<details>
  <summary><u>Лістинг `will .submodules.list`</u></summary>

  ```

[user@user ~]$ will .submodules.list
Request ".submodules.list"
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

Перший рядок після вводу повідомляє, яка команда була введена. Другий вказує операцію, яка була проведена з файлом, а третій - час її виконання.  
Наступна частина:

```

! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

```

Бачимо попередження про помилку зчитування інформації про [підмодулі](Concepts.urk.md#submodule) (submodule) і дається рекомендація завантажити їх з допомогою команди `.submodules.download`,  або спробувати очистити підмодулі перед їх завантаженням.  
Далі інформація про підмодулі - назва (після Submodule::), шлях (path), статус завантаження (isDownloaded) та експортна конфігурація (Exported builds):

```

submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : false
  Exported builds : []
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```

![submodule.section](./Images/submodule.section.png)

Шляхи і назви співпадають, проте `willbe` вивів додаткову інформацію про статус підмодулів, яка спрощує адміністрування системи.

А щоб дізнатись вичерпну інформацію про модуль введіть фразу `will .list`:
<details>
  <summary><u>Лістинг `will .list`</u></summary>

  ```

[user@user ~]$ will .List
 . Read : /path_to_file/submodules/.will.yml
 . Read 1 will-files in 0.068s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
About
  enabled : 1

Paths
  proto : './proto'
  in : '.'
  out : 'out'
  out.debug : 'out/debug'

submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : false
  Exported builds : []
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []
reflector::reflect.submodules
  dst :
    basePath : '.'
    prefixPath : 'path::out.debug'
  criterion :
    debug : 1
  inherit :
    'submodule::*/exported::*=1/reflector::exportedFiles*=1'

step::reflect.submodules
  opts :
    reflector : reflector::reflect.submodules*=1
  inherit :
    predefined.reflect

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
    reflect.submodules

```

</details>

Проглянувши файл `.will.yml` ви не знайдете секцію `About`:

```
About
  enabled : 1

```

[`About`](WillFileStructure.ukr.md#about) - це обов'язкова [секція](Concepts.urk.md#will-file-section) модуля. В завантаженому `.will.yml` вона відсутня, тому пакет автоматично її згенерував з єдиним параметром за замовчуванням.  
Детальна інформація про структуру will-файлу знаходиться в розділі ["Will file structure"](WillFileFtructure.ukr.md).  

А з іншими командами ми познайомимось в наступних уроках.

### <a name="conclusion"></a> Підсумок

- Ми дізнались, [як отримати список команд `willbe`](ui-intro) та [довідку по обраній](#.help-command).
- Як користуватись `willbe`, [якщо не памятаете повну фразу або бажаєте отримати вичерпний список команд з визначеним словом](#help-completion).  
- про команди групи 'list', які [виводять інформацію про секції модуля](#list-commands).

Тепер можемо створити свій [перший will-файл](FirstWillFile.ukr.md).

[Повернутись до меню](Topics.ukr.md)
