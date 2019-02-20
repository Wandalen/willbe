# Перший will-файл

В цьому туторіалі описується створення will-файлу та особливості секцій `about`, `step`, `build`

### <a name="will-file-futures"></a> Визначення та властивості `will`-файла
Will-файл - особливий вид конфігураційного файлу для побудови складної модульної системи пакетом `willbe`.
Will-файл має наступні властивості:
- конфігураційні will-файли мають розширення YML;
- наявні функціональні секції, які описують поведінку модуля, що створюється (about, path, step, reflector, build...);
- секція `about` обов'язкова;
- робота з зовнішніми конфігураційними файлами форматів YAML, JSON, CSON.  

Основним поняттям в пакеті `willbe` є поняття [модулю](Concepts.ukr.md#module). Модуль поєднує `will`-файл та файли описані в ньому.  
Створимо перший `will`-файл та перший модуль.

### <a name="will-file-creation"></a> Створення will-файла
Для створення найпростішого will-файла достатньо виконати наступні кроки:
1. В директорії, де бажаете помістити модуль, створити пустий файл з назвою `.will.yml`.
1.  Додати опис модуля в секцію  [`about`](WillFileStructure.md#about) (_Зауваження_. Обов'язковим є поле `enabled` з параметром за замовчуванням "1", проте його не потрібно вказувати - пакет автоматично його згенерує. Наступним важливим полем є `name`, яке визначає назву модулю).
1. Додатково можна заповнити поля: description - опис модулю, version - версія модулю, keywords - ключові слова, interpreters - інтерпретатори, що використовуються.
Приклад найпростішого will-файлу:
    ``` yaml
    about :
        name : first
        description : "Out first module"
        version : 0.0.1
        keywords :
            - willbe
    ```
Після збереження файлу можливо перевірити конфігурацію за допомогою команди `will .about.list`.

Для створення робочого файлу необхідно доповнити його, як мінімум, двома секціями `step` і `build`. Перший з них описує всі можливі процедури для створення модулю, а другий, основуючись на даних попередніх секцій `.will.yml` створює послідовність виконання дій пакетом `willbe`. Важливо враховувати, що деякі з процедур вже вбудовані в пакет і їх опис в блоці `step` не обов'язковий.
Додамо до створеного файлу наступні рядки:
```yaml
step :

  npm.install :
    currentPath : '.'
    shell : npm install

build :

  debug:
    criterion :
      default : 1
    steps :
      - npm.install
```
В блоці `step` описана процедура `npm.install`, яка виконується в поточній директорії (`currentPath : '.'`) та виконує команду `npm install` в інтерфейсі командного рядка.
Секція `build` створює модуль з допомогою процедури відладки з критерієм за замовчуванням "1" та використовує лише один крок `npm.install` описаного секцією `step`.

Щоб протестувати роботу `.will.yml` створимо зовнішній конфігураційний файл `package.json`:
``` json
{
  "name": "first",
  "dependencies": {
    "express": ""
  }
}
```
Після запуску команди `will .build` з налаштуваннями за замовчуванням отримаємо готовий модуль з пакетом "express".
В консолі має бути приблизно такий текст:
```
  Building debug
    > npm install
  added 48 packages from 36 contributors and audited 121 packages in 2.302s

  Built debug in 2.875s
```
Що свідчить про правильне виконання скрипту.
**_Будьте уважні._** Для правильного функціонування пакету в шляху до директорії не повинно бути пробільних або спеціальних символів. Можливий лог такого запуску:
```
willbe@willbe:PATH_WITH_SPACES# will .build
Request ".build"
   . Read : PATH_WITH_SPACES.will.yml
   . Read 1 will-files in 0.065s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
 ! Failed to read submodule::PathFundamentals, try to download it with .submodules.download or even clean it before downloading

  Building debug
 * Message
Failed to download submodules of module::PATH_WITH_SPACES
Failed to download module::Tools
Failed to form destination filter
Assertion fails           

 * Condensed calls stack
    at wFileRecordFilter._formFinal (/usr/local/lib/node_modules/willbe/node_modules/wFiles/proto/dwtools/amid/files/l1/FileRecordFilter.s:332:5)
    etc.
```

[Повернутись до меню](Topics.md)
