# Збірка побудови модуля за замовчуванням

Як побудувати збірку, що запускається без указання аргумента команди `.build`

### <a name="default-criterion"></a> Як встановити збірку за замовчуванням
Якщо `will-файл` включає одну збірку побудови або декілька збірок з однією головною, то зручно призначити її (збірку) для виконання за замовчуванням. Запуск побудови збірки за замовчуванням здійснюється фразою `will .build` без указання аргумента, що виключає потребу звернення до `will-файла` для уточнення назви збірки. Для призначення збірки за замовчуванням, вкажіть критеріон `default : 1` в відповідному ресурсі. 

### <a name="will-module-creation"></a> Модуль зі збіркою за замовчуванням    
В туторіалах ["Критеріони в `will-файлах`"](CriterionsInWillFile.md) та ["Побудова модуля командою `.build`"](ModuleCreationByBuild.md) використовувався вивід в консоль повідомлення командою операційної системи, а утиліта `willbe` працює як з операційною системою, так і з зовнішніми програмами, що встановлені в неї. Тому, завантажимо залежності NodeJS через пакетний менеджер NPM.   
Створіть новий `.will.yml`-файл в директорії `defaultBuild` та запишіть в нього:  

<details>
  <summary><u>Повний код файла <code>.will.yml</code></u></summary>

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

<p>Структура модуля</p>

```
defaultBuild
      └── .will.yml 

```

</details>


Cтворіть файл залежностей `package.json` в директорії `will-файла`:

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

<p>Структура модуля з файлом залежностей</p>

```
defaultBuild
     ├── package.json
     └── .will.yml

```

</details>


Введіть фразу `will .build` в кореневій директорії `will-файла`:  

<details>
  <summary><u>Вивід фрази <code>will .build</code></u></summary>

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

<p>Структура модуля після побудови</p>

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


Утиліта побудувала збірку `install` завдяки критеріону `default`.

### Підсумок   
- Встановлення критеріона `default : 1` в збірку дозволяє запустити її побудову фразою `will .build`.
- Утиліта `willbe` працює з зовнішніми програмами, які встановлені в операційну систему.

[Наступний туторіал](ExportedWillFile.md)  
[Повернутись до змісту](../README.md#tutorials)