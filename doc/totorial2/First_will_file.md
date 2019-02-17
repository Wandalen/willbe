# Перший will-файл
---
В цьому туторіалі описується створення will-файлу та його основні особливості

### Will-файл. Визначання, особливості
Основним поняттям в пакеті `willbe` є поняття [модулю](). Згідно з ним, модулем вважається сукупність файлів описаних will-файлом.
##### Структура will-модуля
```
.
├── package.json (або інші види файлів)
├── .will.yml
```
Will-файл - особливий вид конфігураційного файлу для побудови складної модульної системи пакетом `willbe`.
Will-файл має наступні особливості:
- конфігураційні will-файли мають розширення YML;
- наявні функціональні блоки, які описують поведінку модуля, що створюється (about, path, submodules, step, reflector, build...);
- робота з зовнішніми конфігураційними файлами форматів YAML, JSON, CSON.

### Створення will-файла
Для створення найпростішого will-файла достатньо виконати наступні кроки:
1.  Створити пустий файл з назвою `.will.yml`.
2.  Додати основну інформацію про модуль в блок `about`. **_Зауваження_**. Найважливішим обов'язковим полем є `name`, яке визначає назву модулю. Додатково можливо заповнити поля: description - опис модулю, version - версія модулю, keywords - ключові слова, та інші.
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

Для створення робочого файлу необхідно доповнити його, як мінімум, двома блоками `step` і `build`. Перший з них описує всі можливі процедури для створення модулю, а другий, основуючись на даних попередніх блоків `.will.yml` створює послідовність виконання дій пакетом `willbe`. Важливо враховувати, що деякі з процедур вже вбудовані в пакет і їх опис в блоці `step` не обов'язковий.
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
Блок `build` створює модуль з допомогою процедури відладки з критерієм за замовчуванням "1" та використовує лише один крок `npm.install` описаного блоком `step`.

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