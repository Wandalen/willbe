# Елементи вводу в командній оболонці системи

### Команда

Рядок що містить фразу для позначення наміру розробника і дії, котрі будуть виконані утилітою по її введенні. Вводиться в інтерфейс командного рядка розробником.

### Фраза

Слово або декілька слів, відокремлених крапкою, позначає команду, яку має виконати утиліта.

Крапка розділяє слова фрази на частини, що полегшує набір і зчитування.  

Приклад:

```
will .help
will .about.list
will .resources.list
will .paths.list

```

### Команди утиліти `willbe`
Для виводу команд утиліти наберіть `will .` або `will .help`

| Фраза             | Опис                                       | Команда                |
|-------------------|--------------------------------------------|----------------------------------|
| `.help`           | Вивід інформації про команду               | `will .help .[command]`          |
| `.set`            | Встановлення параметрів для команди        | `will .set [properties] .[command] [argument]`                                   |
| `.resources.list` | Вивід всієї доступної інформації про поточний модуль          | `will .resources.list [resources] [criterion]`                                  |
| `.paths.list`     | Перерахунок наявних шляхів поточного модуля | `will .paths.list [resources] [criterion]`         |
| `.submodules.list` | Перерахунок наявних підмодулів поточного модуля                     | `will .submodules.list [resources] [criterion]`     |
| `.reflectors.list` | Перерахунок наявних рефлекторів поточного модуля                         | `will .reflectors.list [resources] [criterion]`     |
| `.steps.list`     | Перерахунок наявних кроків поточного модуля                              | `will .steps.list [resources] [criterion]`          |
| `.builds.list `   | Перерахунок наявних збірок поточного модуля            | `will .builds.list [resources] [criterion]`         |
| `.exports.list`   | Перерахунок наявних збірок для екаспортування поточного модуля            | `will .exports.list [resources] [criterion]`        |
| `.about.list`     | Вивід про описової інформації поточного модуля (секція `about`)                                 | `will .about.list`                                  |
| `.submodules.download` | Завантаження кожного підмодуля згідно ресурсів секції `submodule`  | `will .submodules.download`               |
| `.submodules.update`  | Перевірка і встановлення оновлень (при наявності) для кожного віддаленого підмодуля  | `will .submodules.update` |
| `.submodules.fixate`  | Зчитування та перезапис (без завантаження) URL-адреси віддалених підмодулів в `will-файлі` на останню завантажену версію (останній комміт), не переписує ресурси з указаною версією підмодуля. Є опція `dry` зі значенням "0" - виконати перезапис та "1" - зчитати без перезапису | `will .submodules.fixate [dry:1]` |
| `.submodules.upgrade.refs`  | Зчитування та перезапис (без завантаження) URL-адреси віддалених підмодулів в `will-файлі` на останню завантажену версію (останній комміт), ігнорує вказані версії. Є опція `dry` зі значенням "0" - виконати перезапис (за замовчуванням) та "1" - зчитати без перезапису | `will .submodules.upgrade.refs [dry:1]` |
| `.submodules.clean`    | Видалення всіх завантажених підмодулів разом з директорією `.module`                | `will .submodules.clean`   |
| `.shell`          | Виконання команди в консолі ОС для модуля                               | `will .shell [command_in_shell]`          |
| `.clean`          | Видалення з директорії модуля 3-х типів файлів 1) завантажені підмодулі (директорія `.module`); 2) `out` директорія; 3) `temp` директорія, якщо наявна                | `will .clean`                             |
| `.clean.what`     | Відображає список файлів, які видаляються командою `clean`              | `will .clean.what`                        |
| `.build`          | Побудова модуля відповідно до вказаної збірки                           | `will .build [scenario]`                  |
| `.export`         | Форма команди `.build` для побудови експорту модуля                     | `will .export [scenario]`                 |
| `.with`           | Для роботи з іменованими `will-файлами`     | `will .with [will-file] [command] [argument]`                         |
| `.each`           | Виконання вказаної команди до кожного `will-файла` в директорії         | `will .each .[command]`                   |

Примітка. Якщо команда складається з двох і більше частин, то при введенні неповної фрази утиліта запропонує варіанти доповнення. Наприклад, при вводі фрази `will .submodules` утиліта запропонує всі можливі варіанти фраз із словом `submodule`:

<details>
  <summary><u>Вивід команди <code>will .submodules</code></u></summary>

```
[user@user ~]$ will .submodules
Command ".submodules"
Ambiguity. Did you mean?
  .submodules.list - List submodules of the current module.
  .submodules.clean - Delete all downloaded submodules.
  .submodules.download - Download each submodule if such was not downloaded so far.
  .submodules.update - Update each submodule, checking for available updates for each submodule. Does nothing if all submodules have fixated version.
  .submodules.fixate - Fixate remote submodules. If URI of a submodule does not contain a version then version will be appended.
  .submodules.upgrade.refs - Upgrade remote submodules. If a remote repository has any newer version of the submodule, then URI of the submodule will be upgraded with the latest available version.

```

</details>
