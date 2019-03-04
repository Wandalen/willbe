# Побудова модуля (build) за замовчуванням

В туторіалі показано як `willbe` працює з зовнішніми програмами та створено сценарій який виконується за замовчуванням

### <a name="will-module-creation"></a> Shell-команди в `will`-файлі    

Створимо новий `.will.yml` та опишемо модуль:
```yaml

about :

  name : 'defaultBuild'
  description : 'Default build with criterion'
  version : 0.0.1
  keywords :
      - willbe

```

<a name="shell-resource"></a>  

В попердньому туторіалі `willbe` виводив повідомлення в консоль, проте пакет також працює з зовнішніми програмами, що встановлені в систему. Використаємо пакетний менеджер _NodeJS_ для встановлення залежностей. Для цього в секцію `step` помістимо код:

```yaml
step :

  npm.install :
    currentPath : '.'
    shell : npm install

build :

  install :
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

  install:
    steps :
      - npm.install

```

</details>

Цей крок дозволить завантажити пакети залежностей NodeJS в поточну директорію, але поки що немає залежностей. Створимо `package.json` та помістимо його в директорію файла `.will.yml`:

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

Запустіть в консолі команду `will .build install` в кореневій директорії файла `.will.yml` і `willbe` створить готовий модуль з NodeJS-пакетом "express".  
В консолі отримаєте такий лог, що свідчить про правильне виконання скрипту:

```
[user@user ~]$ will .build install
Request ".build install"
...
  Building install
 > npm install
...
added 48 packages from 36 contributors and audited 121 packages in 4.863s
found 0 vulnerabilities

  Built debug in 9.456s

```

Тепер маємо наступну конфігурацію:

```
.
├── node_modules
│         ├── ...
│         ├── ...
│ 
├── package.json
├── package-lock.json
├── .will.yml

```

Якщо маємо лише один сценарій побудови модуля або декілька сценаріїв з одним головним, то введення необхідного може ускладнити процес побудови модуля. Пакет `willbe` дозволяє призначити один сценарій, який буде виконуватись за замовчуванням. Для цього потрібно додати критеріон _'default : 1'_. Після збереження файла, фраза `will .build` виконає обраний сценарій.  
Додамо критеріон в `.will.yml`.

```yaml
build :

  install:
    criterion :
      default : 1
    steps :
      - npm.install

```

Видаліть зайві файли з директорії (в косолі `rm -Rf node_modules package-lock.json` або в графічному менеджері) та виконайте фразу `will .build`.

```
[user@user ~]$ will .build
Request ".build"
...
  Building install
 > npm install
...
added 48 packages from 36 contributors and audited 121 packages in 4.863s
found 0 vulnerabilities

  Built debug in 8.456s

```

> `Willbe` має інструменти для автоматизації побудови модулів.

[Наступний туторіал](ExportedWillFile.ukr.md)  
[Повернутись до змісту](Topics.ukr.md)