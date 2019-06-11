# Збірка модуля за замовчуванням

Як побудувати збірку, що запускається без явного указання аргумента команди <code>.build</code>.

### Як встановити збірку за замовчуванням

Якщо `вілфайл` має якусь збірку, яка виконується частіше за інших, то зручно призначити її (збірку) для виконання за замовчуванням. Запуск побудови збірки за замовчуванням здійснюється фразою `will .build` без указання аргумента. Це прибирає потребу звернення до `вілфайла` для пошуку назви потрібної збірки і робить команду виклику коротшою.

В `вілфайлі` може бути лише одна збірка побудови за замовчуванням. Для позначення збірки за замовчуванням, вкажіть критеріон `default : 1` в відповідному ресурсі.  

### Модуль зі збіркою за замовчуванням     

<details>
  <summary><u>Структура модуля</u></summary>

```
defaultBuild
      └── .will.yml

```

</details>

Створіть структуру файлів зображену вище.

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

Внесіть код в файл `.will.yml`.  

Утиліта `willbe` працює як з операційною системою, так і з зовнішніми програмами. Наприклад, в кроці `npm.install` виконується запуск пакетного менеджера `NPM` для завантаження залежностей `NodeJS`.

Додайте в директорію `defaultBuild` файл залежностей `package.json` з відповідним кодом.  

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

Простий `npm-файл` із пакетом `express`.

<details>
  <summary><u>Структура модуля з файлом залежностей</u></summary>

```
defaultBuild
     ├── package.json
     └── .will.yml
```

</details>

Виклик команди `.build` запускає сценарій побудови модуля збірки `install`. Цей сценарій містить лише один крок -- встановлення `npm-пакетів`.

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

Введіть команду `will .build` в директорії `вілфайла`. Порівняйте вивід консолі.

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

Порівняйте зміни в директорії `defaultBuild` -- `npm-пакети` було встановлено.

### Підсумок   

- Запуск побудови збірки за замовчуванням виконується командою `will .build`.
- Для встановлення збірки за замовчуванням задайте для неї критеріон `default : 1`.
- В `вілфайлі` може бути одна збірка за замовчуванням.
- Утиліта взаємодіє з операційною системою та може запускати зовнішні програми.

[Повернутись до змісту](../README.md#tutorials)
