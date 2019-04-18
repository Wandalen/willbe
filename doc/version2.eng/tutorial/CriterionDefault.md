# Default build

How to build without explicit argument for command <code>.build</code>.

### Як встановити збірку за замовчуванням
Якщо `will-файл` включає одну збірку побудови або декілька збірок з однією головною, то зручно призначити її (збірку) для виконання за замовчуванням. Запуск побудови збірки за замовчуванням здійснюється фразою `will .build` без указання аргумента, що виключає потребу звернення до `will-файла` для уточнення назви збірки. Для призначення збірки за замовчуванням, вкажіть критеріон `default : 1` в відповідному ресурсі. 

### Модуль зі збіркою за замовчуванням    
Утиліта `willbe` працює як з операційною системою, так і з зовнішніми програмами, що встановлені в неї тому, використаємо пакетний менеджер NPM для завантаження залежностей NodeJS.   
Створіть новий `.will.yml`-файл в директорії `defaultBuild` та запишіть в нього код:  

<details>
  <summary><u>Код файла <code>.will.yml</code></u></summary>

```yaml
about :

  name : 'defaultBuild'
  description : 'Default build with criterion'
  version : 0.0.1

step :

  npm.install :
    currentPath : '.'
    shell : npm install

build :

  install:
    criterion :
      default : 1
    steps :
      - npm.install

```

</details>
<details>
  <summary><u>Структура модуля</u></summary>

```
defaultBuild
      └── .will.yml 

```

</details>

Cтворіть файл залежностей `package.json` в директорії `defaultBuild`:

<details>
  <summary><u>Файл залежностей NodeJS <code>package.json</code></u></summary>

``` json
{
  "name": "npmUsing",
  "dependencies": {
    "express": ""
  }
}

```

</details>
<details>
  <summary><u>Структура модуля з файлом залежностей</u></summary>

```
defaultBuild
     ├── package.json
     └── .will.yml

```

</details>


Введіть команду `will .build` в кореневій директорії `will-файла`:  

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build
Command ".build"
...
  Building install
 > npm install
...
added 48 packages from 36 contributors and audited 121 packages in 4.863s
found 0 vulnerabilities

  Built debug in 8.456s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
defaultBuild
     ├── node_modules
     │         ├── ...
     │         ├── ...
     │ 
     ├── package.json
     ├── package-lock.json
     └── .will.yml

```

</details>

Утиліта побудувала збірку `install` без указання аргумента завдяки критеріону `default`.

### Підсумок   
- Встановлення критеріона `default : 1` в збірку дозволяє запустити її побудову фразою `will .build`.
- Утиліта `willbe` працює з зовнішніми програмами, які встановлені в операційну систему.

[Наступний туторіал](ModuleExport.md)  
[Повернутись до змісту](../README.md#tutorials)