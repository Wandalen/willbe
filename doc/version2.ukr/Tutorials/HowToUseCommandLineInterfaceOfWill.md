# Як користуватися інтерфейсом командного рядка `willbe`

Як користуватись командним рядком `willbe`, застосування команд `.help` та `.list`

### <a name="ui-intro"></a> Знайомство з користувацьким інтерфейсом. Команда `.help`
Користувацький інтерфейс `willbe` представлено консоллю операційної системи. Тож, відкрийте її та введіть фразу яка складається з двох слів:  'will .'  (в утиліті `willbe` всі фрази починаються з вводу цих слів).  
Фраза виведе повний список команд:  

<details>
  <summary><u>Вивід фрази <code>will .</code></u></summary>

```
[user@user ~]$ will .  
Request "."  
Request "."
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
  .submodules.download - Download each submodule if such was not downloaded so far. 
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such. 
  .submodules.clean - Delete all downloaded submodules. 
  .shell - Execute shell command on the module. 
  .clean - Clean current module. Delete genrated artifacts, temp files and downloaded submodules. 
  .clean.what - Find out which files will be deleted by clean command. 
  .build - Build current module with spesified criterion. 
  .export - Export selected the module with spesified criterion. Save output to output file and archive. 
  .with - Use "with" to select a module. 
  .each - Use "each" to iterate each module in a directory.

```

</details>


Якщо скористуватись [командою `.help`](#help-command), то результат не зміниться. Для отримання довідки по обраній команді використовуйте синтаксис: `will .help [команда]`.    
Тепер введіть в терміналі `will .help .build`, а потім `will .help .builds.list` і порівняйте з виводом в консолі нижче. 

<details>
  <summary><u>Вивід фрази <code>will .help .build</code></u></summary>

```
[user@user ~]$ will .help .build
Request ".help .build"

  .build - Build current module with spesified criterion.

```

</details>

<details>
  <summary><u>Вивід фрази <code>will .help .builds.list</code></u></summary>

```
[user@user ~]$ will .help .builds.list
Request ".help .builds.list"

  .builds.list - List avaialable builds.

```

</details>


Тепер ви можете отримати довідку по командам. А що буде, якщо ввести неповну фразу `will .help .submodules`? 

<details>
  <summary><u>Вивід фрази <code>will .help .submodules</code></u></summary>

```
[user@user ~]$ will .help .submodules
Request ".help .submodules"

  .submodules.list - List submodules of the current module.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.

```

</details>


`Willbe` запропонував варіанти команд з вказаним словом. Це зручно, адже, якщо не памятаете повну фразу з командою або бажаєте отримати вичерпний список команд з визначеним словом, достатньо ввести першу частину, а утиліта запропонує доповнення.  
Спробуйте отримати довідку про команду `.build` змінивши `.` на інші знаки, такі, як `-` та `_` або літеру в команді `will .help`.  

<details>
  <summary><u>Вивід фрази <code>will -help .build</code></u></summary>

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
<summary><u>Вивід фрази <code>will _help .build</code></u></summary>

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
  <summary><u>Вивід фрази <code>will .held .build</code></u></summary>

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


Не залишається сумнівів, що перед командами завжди потрібно ставити `.` та вірно вводити фразу.  

### <a name="list-commands"></a>  Команди групи `.list`
Наступним рівнем є використання операцій з `will-файлами`. Створювати `will-файли` навчимось пізніше, а поки склонуйте Git-репозиторій `willbe` з готовими прикладами за посиланням <https://github.com/Wandalen/willbe.git>.  

В списку команд утиліти `willbe` багато таких, які закінчуються на `.list`. Ці команди взаємодіють з модулем та виводять інформацію про нього. Якщо ввести будь-яку з команд групи `.list` в директорії, де відсутній `will-файл`, ви отримаєте попередження про відсутність модуля. Введіть фразу `will .builds.list` в директорії без `will-файла` та порівняйте:  

<details>
  <summary><u>Вивід фрази <code>will .builds.list</code></u></summary>

```
[user@user ~]$ will .builds.list
Request ".builds.list"
Found no module::/[path] at "/[path]"

```

</details>


Відкрийте склонований репозиторій і перейдіть за шляхом `./sample/submodules/` та відкрийте директорію в терміналі (або одразу виконайте `cd [path_to_willbe/willbe/sample/submodules/]`). Перевірте вміст директорії виконавши команду `ls -al`:

<details>
  <summary><u>Вивід команди <code>ls -al</code></u></summary>
    
```
[user@user ~]$ ls -al
итого 12
drwxr-xr-x 2 user user 4096 Мар 11 11:27 .
drwxr-xr-x 6 user user 4096 Мар 11 11:27 ..
-rw-r--r-- 1 user user  917 Мар  4 15:07 .will.yml

```

</details>


Введіть фразу `will .builds.list`. Після того як на моніторі відобразиться результат, відкрийте файл `.will.yml` з допомогою текстового редактора. Порівняйте вміст секції `build` і текст який отримали в терміналі.  

<details>
  <summary><u>Вивід фрази <code>will .builds.list</code></u></summary>

```
[user@user ~]$ will .builds.list
Request ".builds.list"
...
build::debug
  criterion : 
    default : 1 
  steps : 
    submodules.download 
    delete.out.debug 
    reflect.submodules


```

<p>Секція <code>path</code></p>

```yaml
build :

  debug :
    criterion :
      default : 1
    steps :
      - submodules.download
      - delete.out.debug
      - reflect.submodules

```

</details>

Інформацію про окрему секцію `will-файла` та модуля можливо отримати ввівши фразу `will [назва секції]s.list` (закінчення `s` додається до назв секції, виключення - секція `about` - без змін).  
Тепер дізнаємось інформацію з секції `submodule`. Порівняйте:  

<details>
  <summary><u>Вивід фрази <code>will .submodules.list</code></u></summary>

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

<p>Секція <code>submodule</code></p>

```yaml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

</details>

В консолі виводиться попередження про помилку зчитування інформації про підмодулі і дається рекомендація завантажити їх з допомогою команди `.submodules.download`,  або спробувати очистити підмодулі перед їх завантаженням.  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```
! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

```

</details>

Далі виводиться сервісна інформація про підмодулі - назва (після `Submodule::`), шлях (`path`), статус завантаження (`isDownloaded`) та експортні сценарії (`Exported builds`):  

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>
    
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

</details>

Шляхи і назви ресурсів співпадають і утиліта `willbe` вивела додаткову інформацію про статус підмодулів, яка спрощує управління модулем.  
А щоб дізнатись повну інформацію про модуль введіть фразу `will .resources.list`:

<details>
  <summary><u>Вивід фрази <code>will .resources.list</code></u></summary>

```
[user@user ~]$ will .resources.list
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
  predefined.willbe : '/usr/lib/node_modules/willbe/proto/dwtools/atop/will/Exec' 
  predefined.will.files : '/path_to_file/.will.yml' 
  predefined.dir : '/path_to_file' 
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

<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```
About
  name : 'test' 
  description : 'To test commands of willbe-package' 
  version : '0.0.1' 
  enabled : 1

```

</details>

В утиліті `willbe` деякі ресурси мають значення за замовчуванням. Якщо такий ресурс відсутній, то утиліта його генерує в оперативну пам'ять не змінюючи `will`-файл - `willbe` не має функцій для модифікації `will-файлів` користувача.  
Саме тому в виводі команди `will .resources.list` секція `about` має поле `enabled` яке відсутнє в `will-файлі`:  
<details>
  <summary><u>Відкрийте, щоб проглянути</u></summary>

```yaml
about :
  name : test
  description : "To test commands of willbe-package"
  version : 0.0.1

```

</details> 

### <a name="conclusion"></a> Підсумок

- Є декілька способів отримати список [команд `willbe`](#ui-intro) та [довідку по обраній](#help-command).  
- `Willbe` виводить підсказки, якщо не памятаете [повну фразу або бажаєте отримати список команд з визначеним словом](#help-completion).  
- Команди групи `.list` виводять актуальну [інформацію про `will-модуль`](#list-commands).  

Наступний туторіал: [Модуль "Hello, World!"](FirstWillFile.md).

[Повернутись до змісту](../README.md#tutorials)
