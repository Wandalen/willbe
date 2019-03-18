# Розділені will-файли (Split will-files)

В туторіалі розглядається створення розділених `will`-файлів

### <a name="split-file-structure"></a> Структура розділеного модуля
При побудові складної модульної системи зберігання інформації в одному `will`-файлі дещо ускладнює роботу з ним. В цьому випадку зручніше розділити функціональності по окремих файлах і інтегрувати їх в одному - це класична методика в програмуванні. `Willbe` інтегрує в одне ціле `will`-файли в одній директорії.  
Розглянемо задачу, коли потрібно створити експорт модуля після того, як система уже налагоджена. Розділимо `.will.yml` на окремі файли для імпорту та експорту (умовно названі `im.will.yml` та `ex.will.yml`). Відповідно, структура модуля з розділеними `will`-файлами матиме вигляд:

```
.
├── filesToExport
├── .ex.will.yml
└── .im.will.yml

```

### <a name="import-configuration"></a> Створення конфігурації імпорту  
В туторіалі ["Побудова модуля (build) за замовчуванням"](DefaultCriterionInWillFile.ukr.md) ми використовували командний рядок оболонки для встановлення залежностей NodeJS. З невеликими змінами можемо повторно використати конфігураційний файл, попередньо перейменувавши його в `.im.will.yml`. Зміна полягає в видаленні зайвих секцій.  
Лістинг файла `.im.will.yml`:
<details>
  <summary><u>Натисніть, щоб відкрити!</u></summary>

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
    steps :
      - npm.install
      
```

</details>


Файл `package.json` копіюємо без змін.

### <a name="export-configuration"></a> Конфігурація для експорту  
Використаємо конфігураційний файл експорту модуля перейменувавши в `.ex.will.yml`, змінивши його так, що будуть експортуватись модулі NodeJS.  
Важливою рисою `willbe` є те, що ресурси секції визначені в одному з `will`-файлів доступні в другому (власне, у всіх `will`-файлах директорії). Тому, для створеного `.ex.will` не потрібно дублювати секцію `about` з `im.will`, а лише додати власні ресурси.
Остаточна версія `.ex.will.yml`:
<details>
  <summary><u>Натисніть, щоб відкрити!</u></summary>

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

</details>




### <a name="executions"></a> Створення модуля з розділеними `will`-файлами

> Команди виконуються в кореневій директорії модуля

<a name="build-command"></a>

Запустимо команду побудови модуля `.build install`:

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

`Willbe` прочитав два файла в директорії та завантажив 48 пакетів залежностей за збіркою побудови модуля.

<a name="export-command"></a>

Тепер введемо фразу `will .export`:

```
[user@user ~]$ will .export
...
 . Read 2 will-files in 0.131s

  Exporting export
   + Write out will-file /path_to_files/out/splited-config.out.will.yml
   + Exported export with 48 files in 2.108s
  Exported export in 2.155s

```

`Willbe` експортував 48 включень директорії `node_modules` в `splited-config.out.will.yml`. При цьому файл `.im.will.yml` був прочитаний, але не виконувався.

Після виконаних операцій директорія з `will`-файлом повинна мати вигляд:

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

- В туторіалі показано як `willbe` одночасно використовує ресурси розділених `will`-файлів, але окремо виконує операції ([експорту](#export-command) та [імпорту](#build-command)).

[Наступний туторіал]()   
[Повернутись до змісту](../README.md#tutorials)