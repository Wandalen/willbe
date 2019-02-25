# Використання оболонки операційної системи в `will`-файлі

В туторіалі показано як використовувати командну оболонку операційної системи з `will`-файла

### <a name="will-module-creation"></a> Shell-команди в `will`-файлі  
Командна оболонка незамінний інструмент в адмініструванні системи. Пакет дозволяє створювати сценарії з її використанням.
Створимо новий `.will.yml` та опишемо модуль:
```yaml

about :

  name : 'second'
  description : 'Second will-file'
  version : 0.0.2
  keywords :
      - willbe

```

Щоб використати командну оболонку в секцію [`step`](WillFileStructure.ukr.md#step) помістимо код:

```yaml

step :

  npm.install :
    currentPath : '.'
    shell : npm install

```

Секція має одну процедуру `npm.install`, вказує на директорію виконання (_currentPath_) та виконує команду _'npm install'_ (_shell_). Переглянемо інформацію про секцію (`will .steps.list`):
```
...
step::npm.install
  opts :
    currentPath : .
    shell : npm install

```

[`build`](WillFileStructure.ukr.md#build). Перший з них описує всі можливі процедури для створення модулю, а другий, основуючись на даних попередніх секцій `.will.yml` створює послідовність виконання дій пакетом `willbe`.  
Додамо до створеного файлу:
```yaml

build :

  debug:
    criterion :
      default : 1
    steps :
      - npm.install

```

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

  name : 'second'
  description : 'Second will-file'
  version : 0.0.2
  keywords :
      - willbe

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

</details>

<p></p>

В блоці `step` описана процедура з назвою `npm.install`, яка виконується в поточній директорії (`currentPath : '.'`) та використовує команду `npm install` в інтерфейсі командного рядка.  
Секція `build` створює модуль з допомогою вбудованої функції `debug`. Вона має критерій (criterion) - умову виконання зі значенням за замовчуванням "1", тобто, ввімкнена. Процедура `debug` використовує крок `npm.install` описаний секцією `step`.

Щоб протестувати роботу `.will.yml` створимо зовнішній конфігураційний файл `package.json` та помістимо його в директорію файла `.will.yml`:

``` json
{
  "name": "first",
  "dependencies": {
    "express": ""
  }
}

```

Тепер, ваша директорія має такий вигляд:

```
.
├── package.json
├── .will.yml

```

Запустіть в консолі команду `will .build` в кореневій директорії файла `.will.yml` і `willbe` створить готовий модуль з NodeJS-пакетом "express".  
В консолі отримаєте такий лог, що свідчить про правильне виконання скрипту:
```
[user@user ~]$ will .build
Request ".build"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.079s

  Building debug
 > npm install

added 48 packages from 36 contributors and audited 121 packages in 4.863s
found 0 vulnerabilities

  Built debug in 16.456s

```
