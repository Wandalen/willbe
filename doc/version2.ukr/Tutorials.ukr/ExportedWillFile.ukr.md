# Експортування модуля

В цьому туторіалі описана процедура експортування `will`-модуля

### <a name="export-module-term"></a> Поняття експорту модуля
Особливий вид побудови модульної системи результатом виконання якої є згенерований `*.out.will`-файл називається експортуванням модуля. Вихідний `*.out.will` містить повну інформацію про створений модуль і експортовані файли та використовується іншими модулями в процесі імпорту.  
Спрощена структура модуля для експорту має вигляд:

```
.
├── fileToExport
├── .will.yml
```

### <a name="export-module-creation"></a> Побудова експорт-модуля
Щоб побудувати перший експорт-модуль:
- Створіть файл `.will.yml` в обраній директорії.
- Створіть файл з назвою `fileToExport` в цій же директорії.  
- Далі відкрийте `.will.yml` в текстовому редакторі та запишіть:  

<a name="section-path"></a>
``` yaml
about :
    name : exportModule
    description : "To export single file"
    version : 0.0.1

path :
  in : '.'
  out : 'out'
  fileToExport : 'fileToExport'

```
[Секція `path`](CompositionOfWillFile.ukr.md#path) описує карту шляхів модуля для швидкого орієнтування в його структурі:
`in` - вбудований шлях, відносно якого розташовуються інші шляхи модуля. В лістингу - коренева директорія файла `.will.yml`.
`out` - вбудований шлях для експортованих модулів `*.out.will` відносно шляху `in`. `out` має вказувати на шлях відмінний від шляху `in` `will`-файла.   
`fileToExport` - шлях до файлів експорту вказаний користувачем відносно директорії `in`.

<a name="section-step"></a>
Додамо секцію `step` з процедурою `export.single`:

``` yaml
step  :
    export.single :
        inherit : predefined.export
        tar : 0
        export : path::fileToExport
```
Процедура має поля:  
`inherit` - наслідування вбудованого кроку експортування `predefined.export` (наслідування та вбудовані кроки - в окремих туторіалах).  
`tar` - архівування експортованих файлів ( 1 - ввімкнене / 0 - вимкнене архівування).
`export` - шлях до файлу або директорії з файлами для експорту. Використовуйте синтаксис `path::[export.path]` для правильного функціонування пакета.

<a name="section-build"></a>
Сконфігуруємо `build` для експорту:

``` yaml
build :
    export :
        criterion :
            default : 1
            export : 1
        steps :
            - export.single
            
```
В збірці `export` є два критеріони: `default : 1` і `export : 1`. Критеріон `default` - вбудований критеріон, визначає яка зі збірок буде виконуватись за замовчуванням, а `export` - позначає збірку експорту модуля. В полі `steps` внесено `export.single`, описаний вище.
<a name="export-module-listing"></a>

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :
    name : exportModule
    description : "To export single file"
    version : 0.0.1

path :
  in : '.'
  out : 'out'
  fileToExport : 'fileToExport'

step  :
  export.single :
      inherit : predefined.export
      export : path::fileToExport
      tar : 0

build :
  export :
      criterion :
          default : 1
          export : 1
      steps :
          - export.single
```
</details>

### <a name="exporting"></a> Експорт модуля

> Команда повинна виконуватись з кореневої директорії `.will.yml`

Введіть в консолі `will .export`:

```
[user@user ~]$ will .export
...
 Exporting export
   + Write out will-file /path_to_file/out/exportModule.out.will.yml
   + Exported export with 1 files in 0.705s
  Exported export in 0.752s
```

Після виконання команди `willbe` згенерує `exportModule.out.will.yml` за назвою модуля в `about` та помістить файл в директорію `out`.

- Експортувати модуль можливо при використанні вбудованої [функції `predefined.export` в секції `step`](#section-step) та правильному налаштуванні секцій [`path`](#section-path) i [`build`](#section-build). 

[Наступний туторіал](SelectorsTermInWillFile.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)
