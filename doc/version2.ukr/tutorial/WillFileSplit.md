# Розділені <code>вілфайли</code>

Як створити та використовувати модуль із розділеними <code>вілфайлами</code>.

### Поняття розділених `вілфайлів`

Розділення етапів роботи - практика, яка дозволяє підвищити ефективність і якість виконання завдань. Побудова модуля і його експорт, також різні етапи побудови тому, утиліта `willbe` дозволяє працювати над ними окремо - з допомогою розділених `вілфайлів`.  

Розділені `вілфайли` - підхід до створення модульної системи, що основується на розділенні функцій експорту і імпорту модуля між двома взаємозалежними `вілфайлами`. Таке розділення дозволяє абстрагуватись від задачі експорту і працювати над побудовою модуля, а після побудови створити експорт. Крім того, розділення функцій зменшує об'єм окремого `вілфайла` та полегшує його зчитування.  

### Побудова модуля з використанням розділених `вілфайлів`

Якщо перед розробником стоїть задача на основі існуючого `вілфайла` побудувати експорт модуля, то перший спосіб розв'язання - відредагувати вихідний `вілфайл` і побудувати експорт модуля. Другий - побудувати експорт на основі розділених `вілфайлів`.  

Створення розділених `вілфайлів` не потребує коррекції початкового `вілфайла`, а його реалізація складається з наступних етапів:   
- перейменування вихіного `вілфайла` в `вілфайла` імпорту (`.will.yml` в `.im.will.yml`);  
- створення розділеного `вілфайла` експорту (`.ex.will.yml`).  
Приставки `im` та `ex` застосовуються для створення як неіменованих, так іменованих розділених `вілфайлів`. Якщо використовуються іменовані `вілфайли`, то, відповідно, вони позначаються як `*.im.will.yml` i `*.ex.will.yml`.

### Конфігурація    

<details>
  <summary><u>Структура модуля</u></summary>
    
```
split
  ├── package.json
  ├── .ex.will.yml
  └── .im.will.yml 

```

</details>

Побудуйте приведену конфігурацію файлів в директорії `split`.

<details>
  <summary><u>Код файла <code>.im.will.yml</code></u></summary>

```yaml
about :

  name : splited-config
  description : "Splited module config"
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
<summary><u>Код файла <code>package.json</code></u></summary>

``` json
{
  "name": "npmUsing",
  "dependencies": {
    "express": ""
  }
}

```

</details>

Внесіть в файли `.im.will.yml` i `package.json` код.

Збірка `install` в файлі `.im.will.yml` виконує завантаження залежностей NodeJS в поточну директорію.  
Особливість розділених `вілфайлів` в тому, що ресурси визначені в одному з розділених `вілфайлів` доступні в другому. Тому, для файла `.ex.will` не потрібно дублювати секцію `about` з `im.will`, а лише додати власні ресурси.  

<details>
  <summary><u>Код файла <code>.ex.will.yml</code></u></summary>

```yaml
path :

  out : 'out'
  fileToExport : './node_modules/*'

step  :

  export.dependencies :
    inherit : predefined.export
    export : path::fileToExport
    tar : 0

build :

  export :
    criterion :
      default : 1
      export : 1
    steps :
      - export.dependencies
          
```

</details>

Скопіюйте код в файл `.ex.will.yml`.

Збірка `export` виконує експорт файлів з директорії `node_modules`.

### Побудова модуля 

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .build 
...
. Read 2 will-files in 0.123s
...
  Building module::splited-config / build::install
 > npm install 
...
added 48 packages from 36 contributors and audited 121 packages in 8.733s
found 0 vulnerabilities

  Built module::splited-config / build::install in 10.733s

```

</details>
<details>
  <summary><u>Структура модуля після побудови</u></summary>

```
split
  ├── node_modules
  │         ├── ...
  │         ├── ...
  │
  ├── package.json
  ├── package-lock.json
  ├── .ex.will.yml
  └── .im.will.yml

```

</details>

Запустіть команду побудови модуля `.build`. 

<details>
  <summary><u>Вивід команди <code>will .build</code></u></summary>

```
[user@user ~]$ will .export
...
 . Read 2 will-files in 0.131s

  Exporting module::splited-config / build::export
   + Write out will-file /path_to_files/out/splited-config.out.will.yml
   + Exported export with 48 files in 2.108s
  Exported module::splited-config / build::export in 2.155s

```

</details>
<details>
  <summary><u>Структура модуля після експорту</u></summary>

```
split
  ├── node_modules
  │         ├── ...
  │         ├── ...
  ├── out
  │    └── splited-config.out.will.yml
  │ 
  ├── package.json
  ├── package-lock.json
  ├── .ex.will.yml
  └── .im.will.yml

```

</details>

`Willbe` завантажила залежності, еспортуйте модуль виконавши команду `will .export`. 

Утиліта експортувала конфігурацію модуля з 48-а включеннями директорії `node_modules` в файл `splited-config.out.will.yml`.    

### Підсумок  

- Розділені `вілфайли` дозволяють розділити етапи побудови і експорту модуля.  
- Створення розділеної конфігурації не потребує зміни вихідних `вілфайлів`.
- `Willbe` використовує ресурси обох розділених `вілфайлів` тому, ресурси визначені в одному з розділених `вілфайлів` доступні в другому.
 
[Повернутись до змісту](../README.md#tutorials)