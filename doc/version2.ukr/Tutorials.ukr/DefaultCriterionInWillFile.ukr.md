# Побудова модуля (build) за замовчуванням

В туторіалі показано як користуватись зовнішніми програмами та створено збірку, яка виконується за замовчуванням

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

Раніше ми використали приклад, де `willbe` виводив повідомлення в консоль, проте пакет працює як з операційною системою так і з зовнішніми програмами, що встановлені в неї. Тому, встановимо залежності _NodeJS_ з допомогою пакету `willbe`. Для цього в `.will.yml` додамо код:

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

<a name="full-file"></a>

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :

  name : 'defaultBuild'
  description : 'Default build with criterion'
  version : 0.0.1
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

Крок `npm.install` дозволить завантажити пакети залежностей NodeJS в поточну директорію, але поки що немає залежностей. Створимо `package.json` та помістимо його в директорію файла `.will.yml`:

``` json
{
  "name": "npmUsing",
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
В консолі отримаєте такий лог:

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
└── .will.yml

```

<a name="default-criterion"></a>

Якщо маємо лише одну збірку побудови модуля або декілька збірок з однією головною, то введення повної фрази необов'язкове - пакет `willbe` дозволяє призначити збірку, яка буде виконуватись за замовчуванням. Для цього потрібно додати критеріон _'default : 1'_. Після збереження файла, фраза `will .build` виконає збірку з критеріоном _'default : 1'_.  
Додамо критеріон в `.will.yml`.

```yaml
build :

  install:
    criterion :
      default : 1
    steps :
      - npm.install

```

Видаліть зайві файли з директорії (в консолі `rm -Rf node_modules package-lock.json` або в графічному менеджері) та виконайте фразу `will .build`.

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

- Пакет `willbe` має інструменти для автоматизації побудови модулів.

[Наступний туторіал](ExportedWillFile.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)