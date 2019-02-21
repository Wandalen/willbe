# Як користуватися інтерфейсом командного рядка `willbe`  

У цьому туторіалі ви ознойомитесь зі способом взаємодії пакету `willbe` з допомогою командного рядку. Дізнаєтесь про команди `.help` та `'list`  

Для того, щоб почати використовувати можливості пакету `willbe`, його необхідно встановити. Для цього введіть в терміналі `npm -g install willbe` (_зверніть увагу_, якщо пакет встановлено локально, то всі описані нижче інструкції мають виконуватись в директорії пакету) Більш детально про `willbe` і процес інсталяції в [введені](Introduction.md).

<a name="ui-intro"></a> Почнемо знайомство з _користувацьким інтерфейсом_, який представлено консоллю операційної системи. Тож, відкрийте її та введіть команду `will .`.  
Після вводу ви отримаєте список доступних команд:  
<details>
  <summary><u>Лістинг команди `will .`</u></summary>
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

<a name=".help-command"></a> Скористуємось командою `.help`. Введіть в консолі наступний рядок: `will .help`.  
Що ви отримали? Правильно, такий же лістинг як і при вводі `will .`. Для того, щоб отримати довідку про обрану команду, необхідно використати синтаксис вигляду `will .help [команда]`.  
Попрактикуємо. Введіть в терміналі `will .help .build`, а потім `will .help .builds.list` і порівняйте результати з наведеними нижче лістингами.  
<details>
  <summary><u>Лістинг команди `will .help .build`</u></summary>

  ```
[user@user ~]$ will .help .build
Request ".help .build"

  .build - Build current module with spesified criterion.
```
</details>

<details>
  <summary><u>Лістинг команди `will .help .builds.list`</u></summary>

  ```
[user@user ~]$ will .help .builds.list
Request ".help .builds.list"

  .builds.list - List avaialable builds.
```
</details>

<a name="help-to-completion"></a> Як бачите користування довідкою просте. А що буде якщо ми введемо неповну команду `will .help .submodules`?  
Ви можете побачити такий лістинг:
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

**_Якщо ви не памятаете необхідну команду, яка складається з декількох частин, достатньо ввести першу частину, а `willbe` запропонує доповнення._**

Перед тим, як піти далі, спробуйте ввести попередні команди, але модифікувавши їх. Наприклад, змініть літеру в команді або застосуйте інші знаки такі як '-' та '\_'.  
Після таких дослідів не залишається сумнівів, що крім правильно введених слів, потрібно застосовувати модифікатор '.' перед командою.  

### Команда `.list`
Наступним рівнем є використання операцій з [will-файлами](Concepts.urk.md#will-file). Створювати will-файли ми навчимось пізніше, а поки що буде достатньо завантажити файл [`.will.yml`](https://github.com/Wandalen/willbe/blob/master/sample/submodules/) зі вказаної директорії та зберегти його на компьютері.  
_Будьте уважні_ Для запобігання помилок при виконанні команд помістіть файл за шляхом, який не містить пробілів.

<a name="list-command"></a> Мабуть, ви звернули увагу на те, що списку доступних команд досить багато таких, які закінчуються на `.list`. Ці команди взаємодіють з [модулем](Concepts.urk.md#module) і в першу чергу з його основним конфігураційним файлом `will.yml`. Якщо ввести будь-яку з команд в директорії, де відсутній файл, то ви отримаєте попередження про відсутність модуля:
```
[user@user ~]$ will .list
Request ".list"
Found no module::/[path] at "/[path]"
```
Тож, відкрийте директорію файлу `will.yml` в терміналі скориставшись командою `cd` і введіть команду `will .list`. Після того як на моніторі відобразиться результат виконання, відкрийте файл `.will.yml` з допомогою вашого улюбленого текстового редактора. Порівняйте вміст файлу і текст який отримали в терміналі.  
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

### <a name="exercises"></a> Завдання
Перевірте засвоєні знання виконавши декілька простих кроків.  
1. Запустіть термінал і перейдіть в директорію завантаженого `.will.yml`.
1. З допомогою команд `will` отримайте в терміналі інформацію з секцій `step` та `build`.
1. Завантажте модулі командою `.submodules.download`.
1. Перевірте директорію з файлом.
1. Порівняйте назви директорій в `./module` з полями секції `submodule` `.will.yml`.  

З іншими командами ми познайомимось в наступних уроках.

### <a name="conclusion"></a> Підсумок
В цьому розділі ви дізнались про інтерфейс командного рядка пакету [`willbe`](https://github.com/Wandalen/willbe) та навчились використовувати його.
1. Модифікатор '.' - обов'язковий для правильного виконання команд `willbe`.  
1. Щоб отримати список доступних команд введіть в терміналі `will .` або `will .help`.  
1. Для отримання довідки про обрану команду використовуйте синтаксис `will .help [команда]`.
1. Якщо ви ввели не повну команду, `willbe` запропонує варіанти доповнення.  
1. Для коректної роботи команд шляху до `will`-файла повинен бути без пробілів.
1. Команда `.list` виводить всю доступну інформацію про [модуль](Concepts.urk.md#module) і його основний конфігураційний файл [`will.yml`]((Concepts.urk.md#will-file). Для того, щоб зчитати інформацію про обрану [секцію](Concepts.urk.md#will-file-section) `will.yml` використовуйте синтаксис `will [назва секції]s.list`.

Тепер можемо створити свій [перший will-файл](FirstWillFile.md).

[Повернутись до меню](Topics.md)
