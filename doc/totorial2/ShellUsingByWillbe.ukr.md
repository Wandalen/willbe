# Використання оболонки операційної системи в `will`-файлі

В туторіалі показано як використовувати командну оболонку операційної системи з `will`-файла

### <a name="will-module-creation"></a> Shell-команди в `will`-файлі    

Створимо новий `.will.yml` та опишемо модуль:
```yaml

about :

  name : 'second'
  description : 'Second will-file'
  version : 0.0.2
  keywords :
      - willbe

```

<a name="shell-resource"></a>
Щоб використати командну оболонку в секцію [`step`](WillFileStructure.ukr.md#step) помістимо код:

```yaml

step :

  npm.install :
    currentPath : '.'
    shell : npm install

```
В секції описана процедура з назвою `npm.install`, яка має 2 поля - поточна директорії (`currentPath`) та команда оболонки (`shell`). Цей крок дозволить завантажити пакети залежностей NodeJS в поточну директорію.  
Тепер помістимо цю процедуру в секцію [`build`](WillFileStructure.ukr.md#build):
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
  description : 'Second module'
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

 
Побудова модуля проходить через процедуру `debug`, яка за замовчуванням ввімкнена (критерій має значення "1") та використовує команду  в кроці `npm.install`.

Щоб протестувати роботу `will`-файла створимо `package.json` з NodeJS-залежностями та помістимо його в директорію файла `.will.yml`:

``` json
{
  "name": "second",
  "dependencies": {
    "express": ""
  }
}

```

Тепер, ваша директорія має вигляд:

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



> `Willbe` може [використовувати командну оболонку](#shell-resource) операційної системи для управління модулями.

[Наступний туторіал](ExportedWillFile.ukr.md)  
[Повернутись до меню](Topics.ukr.md)