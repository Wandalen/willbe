# Як користуватися інтерфейсом командного рядка `willbe`  

У цьому розділі описується використання командного рядку для взаємодії з пакетом `willbe`, застосування команд `.help` та `.list`  

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

З описом команд можна ознайомитись [тут](CommandLineInterfaceOfWill.ukr.md#will-commands).

<a name=".help-command"></a> Скористуємось командою `.help` для виводу довідки про команду. Введіть в консолі: `will .help`.  
Мабуть не зрозуміло чому отримали такий же список команд. Спробуємо знову, але доповнимо фразу ще однією командою, щоб отримати синтаксис: `will .help [команда]`. Тепер введіть в терміналі `will .help .build`, а потім `will .help .builds.list` і порівняйте результати з наведеними нижче.  
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

<a name="help-to-completion"></a> Користуватись довідкою просто. А що буде якщо ввести неповну фразу `will .help .submodules`? Введіть її та порівняйте:  
<details>
  <summary><u>Лістинг команди `will .help .submodules`</u></summary>

  ```
[user@user ~]$ will .help .submodules
Request ".help .submodules"

  .submodules.list - List submodules of the current module.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.upgrade - Upgrade each submodule, checking for available updates for such.
  .submodules.clean - Delete all downloaded submodules.

```
</details>

`Willbe` запропонував варіанти доповнення. Це зручно, адже, якщо ви не памятаете повну фразу з командою або бажаєте отримати вичерпний список команд з визначеним словом, достатньо ввести першу частину, а пакет запропонує доповнення.

Перед тим, як піти далі, спробуйте ввести попередні команди, але модифікувавши їх. Замініть літеру в команді `will .help`, а також замість '.' підставте інші знаки такі, як '-' та '\_'.  
Після цього не залишається сумнівів, що перед командами завжди потрібно вводити '.' та правильно вводити фразу.  

### Команди `*.list`
Наступним рівнем є використання операцій з [will-файлами](Concepts.urk.md#will-file). Створювати will-файли ми навчимось пізніше, а поки клонуйте Git-репозиторій ['willbe`](https://github.com/Wandalen/willbe) з готовими файлами.  

<a name="list-command"></a> Мабуть, ви звернули увагу на те, що списку доступних команд досить багато таких, які закінчуються на `.list`. Ці команди взаємодіють з [модулем](Concepts.urk.md#module) та виводять інформацію про нього. Якщо ввести будь-яку з команд в директорії, де відсутній файл, то ви отримаєте попередження про відсутність модуля:
```
[user@user ~]$ will .list
Request ".list"
Found no module::/[path] at "/[path]"
```
Тож, відкрийте клонований репозиторій і перейдіть за шляхом './sample/submodules/', де знаходиться файл `will.yml`  та відкрийте директорію в терміналі (або в терміналі виконайте `cd [.../willbe/sample/submodules/]`). Після цього введіть `will .paths.list`.
Після того як на моніторі відобразиться результат виконання, відкрийте файл `.will.yml` з допомогою вашого улюбленого текстового редактора. Порівняйте вміст секції `path` файлу і текст який отримали в терміналі.  

Якщо вам необхідно дізнатись інформацію з окремої секції модуля, ви можете скористуватись назвою секції додавши закінченя 's'. Тоді, повна команда виглядатиме так `will [назва секції]s.list`. Порівняйте результати виконання команд `will .paths.list` та `will .reflectors.list` для завантаженого `.will.yml` з приведеними нижче.
<details>
  <summary><u>Лістинг команди `will .paths.list`</u></summary>

  ```
[user@user ~]$ will .paths.list
Request ".paths.list"
  . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.080s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
Paths
  proto : './proto'
  in : '.'
  out : 'out'
  out.debug : 'out/debug'
```
</details>

<details>
  <summary><u>Лістинг команди `will .reflectors.list`</u></summary>

  ```
[user@user ~]$ will .reflectors.list
Request ".reflectors.list"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.077s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
reflector::reflect.submodules
  dst :
    basePath : '.'
    prefixPath : 'path::out.debug'
  criterion :
    debug : 1
  inherit :
    'submodule::*/exported::*=1/reflector::exportedFiles*=1'
```
</details>

Вони майже ідентичні. Виключення складають декілька рядків. Трохи детальніше їх проаналізуємо.
```
Request ".list"
. Read : /path_to_file/.will.yml
. Read 1 will-files in 0.096s
```
Перший рядок після вводу повідомляє, яка команда була введена. Другий вказує операцію, яка була проведена з файлом, а третій - час її виконання.  
Наступна частина:
```
! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading
```
Бачимо попередження про те, що неможливо зчитати інформацію про [підмодулі](Concepts.urk.md#submodule) (submodule). Далі, дається рекомендація завантажити вказані підмодулі з допомогою команди `.submodules.download`,  або спробувати очистити підмодулі перед їх завантаженням. Тобто, ці попередження викликані тим, що модуль `willbe`, не знайшов вказаних [підмодулів](Concepts.urk.md#submodule) в їх власних директоріях.  
Остання відмінність.
```
About
 enabled : 1
```
[`About`](WillFileStructure.md#about) - це [секція](Concepts.urk.md#will-file-section) `will`-файлу модуля, яка обов'язково повинна бути присутня. В завантаженому `.will.yml` ця секція не прописана і тому пакет `willbe` автоматично її згенерував з одним параметом за замовчуванням.
В тексті `will.yml` використовуються секції [`submodule`](WillFileStructure.md#submodule), [`path`](WillFileStructure.md#path), [`reflector`](WillFileStructure.md#reflector), [`step`](WillFileStructure.md#step), [`build`](WillFileStructure.md#build). Детальна інформація про структуру will-файлу знаходиться в розділі ["Will file structure"](WillFileFtructure.md).  

З іншими командами ми познайомимось в наступних уроках.

### <a name="conclusion"></a> Підсумок
В цьому розділі ви дізнались про інтерфейс командного рядка пакету [`willbe`](https://github.com/Wandalen/willbe) та навчились використовувати його.
1. Модифікатор '.' - обов'язковий для правильного виконання команд `willbe`.  
1. Щоб отримати список доступних команд введіть в терміналі `will .` або `will .help`.  
1. Для отримання довідки про обрану команду використовуйте синтаксис `will .help [команда]`.
1. Якщо ви ввели не повну команду, `willbe` запропонує варіанти доповнення.  
1. Для коректної роботи команд шляху до `will`-файла повинен бути без пробілів.
1. Команда `.list` виводить інформацію про [модуль](Concepts.urk.md#module). Для того, щоб зчитати інформацію про обрану [секцію](Concepts.urk.md#will-file-section) `will.yml` використовуйте синтаксис `will [назва секції]s.list`.

Тепер можемо створити свій [перший will-файл](FirstWillFile.md).

[Повернутись до меню](Topics.md)
