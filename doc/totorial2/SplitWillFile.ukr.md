# Розділені `will`-файли

В туторіалі розглядається створення розділених `will`-файлів

### <a name="split-file-structure"></a> Структура розділеного модуля
При створенні модуля виникають ситуації, коли потрібно створити експорт-модуль після того, як система уже налагоджено. Це можливо зробити, модифікувавши `.will.yml`, проте `willbe` дозволяє одночасно працювати з окремими файлами на імпорт та експорт (умовно названі `im.will.yml` та `ex.will.yml`).
Тому, структура модуля з розділеними `will`-файлами матиме вигляд:

```
.
├── fileToExport
├── .ex.will.yml
├── .im.will.yml

```


### <a name="export-configuration"></a> Конфігурація для експорту  
В попередньому туторіалі ми [створили експорт модуля](ExportedWillFile.ukr.md). Використаємо його конфігураційний файл перейменувавши в `.ex.will.yml`. Також, створимо відповідний `fileToExport`-файл в кореневій директорії `.ex.will.yml`.  
Остаточна версія `.ex.will.yml`:

<details>
  <summary><u>Натисніть, щоб відкрити!</u></summary>

```yaml
about :

  name : splited-config-ex
  description : "Splited module config : export"
  version : 0.0.1

path :
  out : 'out'
  fileToExport : 'fileToExport'

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


### <a name="import-configuration"></a> Створення конфігурації імпорту  
В туторіалі ["Використання оболонки операційної системи в `will`-файлі"](ShellUsingByWillbe.ukr.md) ми використовували командний рядок оболонки для встановлення залежностей NodeJS. З невеликими змінами можемо повторно використати конфігураційний файл, попередньо перейменувавши його в `.im.will.yml`. Зміна полягає в використанні команди `echo .im.will.yml executed`. Оскільки команда не встановлює пакети NodeJS, то створювати файл _'package.json'_ теж не потрібно.

Важливою рисою `willbe` є есурси секції визначені в одному з `will`-файлів доступні в другому (власне, у всіх `will`-файлах директорії). Тому, для створеного `.im.will` не потрібно дублювати секцію `about` з `ex.will`, а лише додати власні ресурси.
Тому файл `im.will.yml` матиме вигляд:

<details>
  <summary><u>Натисніть, щоб відкрити!</u></summary>

```yaml

step :

  echo :
    currentPath : '.'
    shell : echo .im.will.yml executed

build :

  debug:
    criterion :
      default : 1
    steps :
      - echo
      
```

</details>

### <a name="executions"></a> Створення модуля з розділеними `will`-файлами

> Команди виконуються в кореневій директорії модуля

<a name="export-command"></a>

Запустимо команду експорту `.export`:

```
[user@user ~]$ will .export
Request ".export"
   . Read : /path_to_file/.im.will.yml
   . Read : /path_to_file/.ex.will.yml
 . Read 2 will-files in 0.123s

  Exporting export
   + Write out will-file /path_to_file/out/splited-config-ex.out.will.yml
   + Exported export with 1 files in 0.341s
  Exported export in 0.388s

```

`Willbe` експортував `splited-config-ex.out.will.yml` в директорію `out`. При цьому файл `.im.will.yml` був прочитаний, але не виконувався.

<a name="build-command"></a>

Тепер введемо фразу `will .build`:

```
[user@user ~]$ will .build
Request ".build"
   . Read : /path_to_file/.im.will.yml
   . Read : /path_to_file/.ex.will.yml
 . Read 2 will-files in 0.104s

  Building debug
 > echo .im.will.yml executed
.im.will.yml executed
  Built debug in 0.100s

```

`Willbe` також зчитав обидва файли, але виконувалась команда в `im.will.yml`, яка вивела рядок _'.im.will.yml executed'_.


> В туторіалі показано як `willbe` одночасно використовує ресурси розділених `will`-файлів модуля, але по черзі виконує операції [експорту](#export-command) та [імпорту](#build-command).

[Наступний туторіал](SubmodulesImporting.md)   
[Повернутись до меню](Topics.ukr.md)