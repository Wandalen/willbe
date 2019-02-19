# Як користуватися інтерфейсом командного рядка `willbe`  

У цьому туторіалі ви ознойомитесь зі способом взаємодії пакету `willbe` з допомогою командного рядку. Дізнаєтесь про команди `.help` та `'list`  

Для того, щоб почати використовувати можливості пакету `willbe`, його необхідно встановити. Щоб встановити пакет, введіть `npm -g install willbe` в вашій консолі. Більш детально про пакет і процес інсталяції в [введені](Introduction.md).

<a name="ui-intro"></a> Почнемо знайомство з _користувацьким інтерфейсом_, який представлено консоллю операційної системи. Відкрийте консоль і введіть команду `will .` (якщо пакет встановлено локально, необхідно зайти в директорію встановлення пакету, виконавши команду `cd [шлях_до_willbe]` ).  
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
Що ви отримали? Правильно, такий же лістинг як і при введені `will .`. Для того щоб отримати довідку про обрану команду необхідно використати синтаксис вигляду `will .help [команда]`.  
Попрактикуємо. Введіть в терміналі `will .help .build`, а потім `will .help .builds.list` і порівняйте результати.  
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

Як бачите користування довідкою просте. А що буде якщо ми введемо неповну команду `will .help .submodules`?  
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

Наступним рівнем є використання команд, які працюють з [will-файлами](Concepts.urk.md#will-file). Створювати will-файли ми навчимось пізніше, а поки що буде достатньо завантажити файл [`.will.yml`](https://github.com/Wandalen/willbe/blob/master/sample/submodules/) зі вказаної директорії та зберегти на компьютері.
_Будьте уважні_ Для запобігання помилок при виконанні команд помістіть файл за шляхом, який не містить пробілів.
