# Як користуватися інтерфейсом командного рядка 'willbe ' 

В туторіалі описується використання командного рядка для взаємодії з пакетом `willbe`, застосування команд `.help` та `.list`  

### <a name="ui-intro"></a> Знайомство з користувацьким інтерфейсом. Команда `.help`
Користувацький інтерфейс `willbe` представлено консоллю операційної системи. Тож, відкрийте її та введіть [фразу](Concepts.ukr.md#phrase) яка складається з двох слів:  'will .'  (в пакеті `willbe` всі фрази починаються з вводу цих слів).  
Отримаємо повний список команд:  

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

<a name=".help-command"></a> Якщо скористуватись командою `.help`, то результат не зміниться. Для отримання довідки по обраній команді використовуйте синтаксис: `will .help [команда]`.    
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

<a name="help-completion"></a> Тепер ви можете отримати довідку по командам. А що буде якщо ввести неповну фразу `will .help .submodules`?  
Лістинг команди `will .help .submodules`:

```
[user@user ~]$ will .help .submodules
Request ".help .submodules"

  .submodules.list - List submodules of the current module.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.

```

</br>
`Willbe` вивів список команд з `submodules` -це зручно, адже, якщо ви не памятаете повну фразу з командою або бажаєте отримати вичерпний список команд з визначеним словом, достатньо ввести першу частину, а пакет запропонує доповнення.

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
  <summary><u>Лістинг команди ` will .held .build`</u></summary>

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

Після цього не залишається сумнівів, що перед командами завжди потрібно ставити '.' та вірно вводити фразу.  

### <a name="list-commands"></a>  Команди групи `.list`
Наступним рівнем є використання операцій з [will-файлами](Concepts.urk.md#will-file). Створювати will-файли навчимось пізніше, а поки склонуйте Git-репозиторій [`willbe`](https://github.com/Wandalen/willbe) з готовими прикладами за посиланням <https://github.com/Wandalen/willbe.git>.  

В списку команд пакету `willbe` багато таких, які закінчуються на `.list`. Ці команди взаємодіють з [модулем](Concepts.urk.md#module) та виводять інформацію про нього. Якщо ввести будь-яку з команд групи `.list` в директорії, де відсутній `will`-файл, ви отримаєте попередження про відсутність модуля:

```
[user@user ~]$ will .list
Request ".list"
Found no module::/[path] at "/[path]"

```

Після клонувння відкрийте репозиторій і перейдіть за шляхом './sample/submodules/' та відкрийте директорію в терміналі (або одразу виконайте `cd [path_to_willbe/willbe/sample/submodules/]`). Перевірте вміст директорії виконавши команду `ls -al`:
```
[user@user ~]$ ls -al
итого 12
drwxr-xr-x 2 user user 4096 Мар 11 11:27 .
drwxr-xr-x 6 user user 4096 Мар 11 11:27 ..
-rw-r--r-- 1 user user  917 Мар  4 15:07 .will.yml

```

Після цього введіть `will .paths.list`.
Після того як на моніторі відобразиться результат, відкрийте файл `.will.yml` з допомогою текстового редактора. Порівняйте вміст [секції](Concepts.urk.md#will-file-section) `path` файлу і текст який отримали в терміналі.  

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

<p>Секція `path`</p>

```yaml
path :

  proto : './proto'
  in : '.'
  out : 'out'
  out.debug : 'out/debug'

```

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

<p>Секція `submodule`</p>

```yaml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

</details>

В лістингу бачимо попередження про помилку зчитування інформації про [підмодулі](Concepts.urk.md#submodule) (submodule) і дається рекомендація завантажити їх з допомогою команди `.submodules.download`,  або спробувати очистити підмодулі перед їх завантаженням. 

```
! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

```

Далі виводиться сервісна інформація про підмодулі - назва (після Submodule::), шлях (path), статус завантаження (isDownloaded) та експортні сценарії (Exported builds):

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

Шляхи і назви ресурсів співпадають, проте `willbe` вивів додаткову інформацію про статус підмодулів, яка спрощує адміністрування системи.

А щоб дізнатись повну інформацію про модуль введіть фразу `will .list`:
<details>
  <summary><u>Лістинг `will .list`</u></summary>

```
[user@user ~]$ will .List
 . Read : /path_to_file/submodules/.will.yml
 . Read 1 will-files in 0.068s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
About
  name : 'test' 
  description : 'To test commands of willbe-package' 
  version : '0.0.1' 
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

Проглянувши вивід ви знайдете секцію `About`:

```
About
  name : 'test' 
  description : 'To test commands of willbe-package' 
  version : '0.0.1' 
  enabled : 1

```

В пакеті `willbe` деякі ресурси мають значення за замовчуванням. Якщо такий ресурс відсутній, то пакет його генерує в оперативну пам'ять не змінюючи `will`-файл - `willbe` не має функцій для модифікації `will`-файлів користувача.  
Саме тому в лістингу виводу команди `will .list` секція `about` має поле `enabled` яке відсутнє в `will`-файлі:

```yaml
about :
  name : test
  description : "To test commands of willbe-package"
  version : 0.0.1

```

Детальна інформація про структуру `will`-файла та команди пакету `willbe` знаходиться в [керівництві користувача](../Manuals.ukr/Topics.ukr.md).  

<a name="conclusion"></a> 
 
- Є декілька способів отримати список [команд `willbe`](ui-intro) та [довідку по обраній](#.help-command).  
- `Willbe` виводить підсказки, якщо не памятаете [повну фразу або бажаєте отримати список команд з визначеним словом](#help-completion).  
- Команди групи '.list' виводять актуальну [інформацію про `will`-модуль](#list-commands).  

Тепер можемо створити свій [перший will-файл](FirstWillFile.ukr.md).

[Повернутись до змісту](../README.md#tutorials)
