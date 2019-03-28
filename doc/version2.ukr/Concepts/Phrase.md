# <a name="will-phrase"></a> Фраза

**Фраза** - команда з одного обо декількох слів, розділених крапкою. Крапка розділяє слова команди на частини, що полегшує набір і зчитування. Всі фрази починається з вводу слів `will .`. Загальний синтаксис команд утиліти `willbe`: `will .[command] [argument]`, де, `will` вказує на використання утиліти `willbe`, префікс команд `.` - особливість роботи утиліти, `[command]` - команда утиліти, а `[argument]` - аргумент команди, якщо команда приймає аргументи.

## <a name="will-commands"></a> Команди утиліти `willbe`
Для виводу всіх доступних команд наберіть `will .` або `will .help`

#### <a name="table"></a> Таблиця. Команди утиліти willbe
| Команда           | Опис                                       | Синтаксис                        |
|-------------------|--------------------------------------------|----------------------------------|
| `.help`           | Вивід інформації про команду               | `will .help .[command]`          |
| `.set`            | Встановлення параметрів для команди        | `will .set [properties] .[command] [argument]`                                   |
| `.resources.list` | Вивід всієї інформації про модуль, в т.ч. готовність завантажених підмодулів і ресурси секцій                                | `will .resources.list [resources] [criterion]`      |
| `.paths.list`     | Вивід інформації про шляхи в секції `path` | `will .paths.list`         |
| `.submodules.list`| Вивід інформації про підмодулі в секції `submodule`                     | `will .submodules.list [resources] [criterion]`     |
| `.reflectors.list`| Вивід інформації про ресурси секції `reflector`                         | `will .reflectors.list [resources] [criterion]`     |
| `.steps.list`     | Вивід інформації про кроки в секції `step`                              | `will .steps.list [resources] [criterion]`          |
| `.builds.list `   | Вивід інформації про збірки побудови модуля (секція `build`)            | `will .builds.list [resources] [criterion]`         |
| `.exports.list`   | Вивід інформації про збірки експорту модуля (секція `build`)            | `will .exports.list [resources] [criterion]`        |
| `.about.list`     | Вивід про опису модуль (секція `about`)                                 | `will .about.list`                                  |
| `.execution.list` | В розробці                                                              | `will .execution.list`                              |
| `.submodules.download` | Завантаження кожного підмодуля згідно ресурсів секції `submodule`  | `will .submodules.download`|
| `.submodules.upgrade`  | Перевірка і встановлення оновлень (при наявності) для кожного підмодуля            | `will .submodules.upgrade` |
| `.submodules.clean`    | Видалення всіх завантажених підмодулів разом з директорією `.module`                | `will .submodules.clean`   |
| `.shell`          | Виконання команди в консолі ОС для модуля                               | `will .shell [command]`                   |
| `.clean`          | Видалення з директорії модуля 3-х типів файлів 1) завантажені підмодулі (директорія `.module`); 2) `out` дерикторія; 3) `temp` дерикторія, якщо наявна                | `will .clean`                             |
| `.clean.what`     | Відображає список файлів, які видаляються командою `clean`              | `will .clean.what`                        |
| `.build`          | Побудова модуля відповідно до вказаної збірки                           | `will .build [scenario]`                  |
| `.export`         | Форма команди `.build` для побудови експорту модуля                     | `will .export [scenario]`                 |
| `.with`           | Для роботи з іменованими `will-файлами`     | `will .with [will-file] [command] [argument]`                         |
| `.each`           | Виконання вказаної команди до кожного `will-файла` в директорії         | `will .each .[command]`                   |

**Примітка.** Команда виконується, якщо вона синтаксично завершена. Якщо команда складається з двох і більше частин, то при введенні однієї частини команди програма запропонує варіанти доповнення.