# Збірка модуля за замовчуванням

Як побудувати збірку, що запускається без явного указання аргумента команди <code>.build</code>

### Як встановити збірку за замовчуванням

Якщо `вілфайл` має одну головну збірку, яка виконується частіше від інших, то зручно призначити її (збірку) для виконання за замовчуванням. Запуск побудови збірки за замовчуванням здійснюється фразою `will .build` без указання аргумента. Це виключає потребу звернення до `вілфайла` для уточнення назви потрібної збірки.  

В `вілфайлі` може бути лише одна збірка побудови за замовчуванням. Для позначення збірки за замовчуванням, вкажіть критеріон `default : 1` в відповідному ресурсі. 

### Модуль зі збіркою за замовчуванням     

<details>
  <summary><u>Структура модуля</u></summary>

```
defaultBuild
      └── .will.yml 

```

</details>
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

Створіть структуру файлів зображену вище та внесіть код в файл `.will.yml`.  

Утиліта `willbe` працює як з операційною системою, так і з зовнішніми програмами, що встановлені в неї. Наприклад, в кроці `npm.install` виконується запуск пакетного менеджера NPM для завантаження залежностей NodeJS. Додайте в директорію `defaultBuild` файл залежностей `package.json` з відповідним кодом.  

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

### Виконання побудови модуля

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

Введіть команду `will .build` в кореневій директорії `вілфайла`.  

Утиліта, завдяки критеріону `default : 1`, побудувала збірку `install` без указання аргумента команди `build`. Запущений збіркою пакетний менеджер NPM завантажив залежності NodeJS в директорію `node_modules`. 

### Підсумок   

- Запуск побудови збірки за замовчуванням виконується командою `will .build`. 
- Для встановлення збірки за замовчуванням використовується критеріон `default : 1`.
- В `вілфайлі` може бути одна збірка за замовчуванням.
- Утиліта взаємодіє з операційною системою та може запускати зовнішні програми.

[Наступний туторіал](ModuleExport.md)  
[Повернутись до змісту](../README.md#tutorials)
