# Розділені `will-файли`

В туторіалі розглядається створення розділених `will-файлів`

### <a name="split-file-structure"></a> Поняття розділених `will-файлів`
Розділення етапів роботи - практика, яка дозволяє підвищити ефективність і якість виконання завдань. Побудова модуля і його експорт, також різні етапи роботи тому, утиліта `willbe` дозволяє працювати над ними окремо - з допомогою розділених `will-файлів`.  
Розділені `will-файли` - підхід до створення модульної системи, що основується на розділенні функцій експорту і імпорту модуля між двома взаємозалежними `will-файлами`. Таке розділення дозволяє абстрагуватись від задачі експорту і працювати над побудовою модуля, а після побудови створити експорт. Крім того, розділення функцій зменшує об'єм `will-файла` та полегшує його зчитування.  

### <a name=""></a> Побудова модуля з використанням розділених `will-файлів`
Завдання. На основі існуючого `will-файла` побудувати експорт модуля.  
Перший спосіб розв'язання - відредагувати вихідний `will-файл` і побудувати експорт модуля. Другий - побудувати експорт на основі розділених `will-файлів`.  
Другий спосіб не змінює вихідний `will-файл`. Його реалізація складається з наступних етапів:   
- перейменування вихіного `will-файла` в розділений `will-файла` імпорту (`.will.yml`в `.im.will.yml`);  
- створення розділеного `will-файла` експорту (`.ex.will.yml`).  

### <a name="import-configuration"></a> Конфігурація імпорту  
В туторіалі ["Збірка побудови модуля за замовчуванням"](DefaultCriterionInWillFile.md) встановлювались залежності NodeJS з використанням командного рядку операційної системи. Використайте його, попередньо перейменувавши його в `.im.will.yml`та видаливши зайві секції. Файл `package.json` копіюємо без змін.  

<details>
  <summary><u><code>.im.will.yml</code>,<code>package.json</code> і структура каталогу</u></summary>

<p><code>.im.will.yml</code></p>

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

<p><code>package.json</code></p>

``` json
{
  "name": "npmUsing",
  "dependencies": {
    "express": ""
  }
}

```

<p>Структура модуля</p>

```
defaultBuild
     ├── package.json
     └── .im.will.yml

```

</details>

### <a name="export-configuration"></a> Конфігурація експорту  
Ресурси секції визначені в одному з розділених `will-файлів` доступні в другому тому, для файла `.ex.will` не потрібно дублювати секцію `about` з `im.will`, а лише додати власні ресурси.  
Створіть конфігураційний файл експорту модуля `.ex.will.yml` в директорії модуля:

<details>
  <summary><u><code>.ex.will.yml</code></u></summary>

```yaml
path :

  out : 'out'
  fileToExport : './node_modules/*'

step  :

  export.single :
      inherit : predefined.export
      tar : 0
      export : path::fileToExport

build :

  export :
      criterion :
          default : 1
          export : 1
      steps :
          - export.single
          
```

<p>Структура модуля</p>

```
defaultBuild
     ├── package.json
     ├── .ex.will.yml
     └── .im.will.yml

```

</details>

### <a name="executions"></a> Побудова модуля  

> Команди виконуються в кореневій директорії модуля

Запустіть команду побудови модуля `.build install`:

<details>
  <summary><u>Натисніть, щоб відкрити!</u></summary>

```
[user@user ~]$ will .build install
...
. Read 2 will-files in 0.123s
...
Building install
 > npm install 
...
added 48 packages from 36 contributors and audited 121 packages in 8.733s
found 0 vulnerabilities

  Built install in 11.712s

```

<p>Структура після завантаження</p>

```
.
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


`Willbe` прочитав два файла в директорії та завантажив 48 пакетів залежностей за збіркою побудови модуля.  
Введіть фразу `will .export`:  

<details>
  <summary><u>Натисніть, щоб відкрити!</u></summary>

```
[user@user ~]$ will .export
...
 . Read 2 will-files in 0.131s

  Exporting export
   + Write out will-file /path_to_files/out/splited-config.out.will.yml
   + Exported export with 48 files in 2.108s
  Exported export in 2.155s

```

<p>Структура після завантаження</p>

```
.
├── node_modules
│         ├── ...
│         ├── ...
│
├── out
│    ├── splited-config.out.will.yml
│ 
├── package.json
├── package-lock.json
├── .ex.will.yml
└── .im.will.yml

```

</details>


`Willbe` експортував 48 включень директорії `node_modules` в `splited-config.out.will.yml`. При цьому файл `.im.will.yml` був прочитаний, але не виконувався.  

### Підсумок  
- Розділені `will-файли` дозволяють розділити етапи побудови і експорту модуля.  
- Створення розділеної конфігурації не потребує зміни вихідних `will-файлів`.
- `willbe` використовує ресурси обох розділених `will-файлів`.
 
[Повернутись до змісту](../README.md#tutorials)