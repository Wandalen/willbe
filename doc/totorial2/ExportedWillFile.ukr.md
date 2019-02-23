# Створення експорту `will`-модуля

В цьому туторіалі описана процедура створення експорту `will`-модуля

### <a name="export-module-term"></a> Поняття експорту модуля
Особливий вид `will`-файла результатом виконання якого є згенерований `*.out.will` файл називається експортним. Вихідний `*.out.will` містить повну інформацію про створений модуль і експортовані файли та використовується іншими модулями в процесі імпорту.  
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
    name : second
    description : "Second module"
    version : 0.0.1

path :
  out : '.'
  fileToExport : './fileToExport'

```
Секція `path` визначає шляхи, які використовуються в модулі:  
`out` - директорія де будуть поміщені згенеровані файли модуля.  
`fileToExport` - шлях до файлів експорту вказаний користувачем.

<a name="section-step"></a>
Додамо секцію `step` з процедурою `export.single`:

``` yaml
step  :
    export.single :
        inherit : export
        tar : 0
        export : './fileToExport'
```
Процедура має поля:
`inherit` - наслідування вбудованого сценарію.  
`tar` - архівування експортованих файлів ( 1 - ввімкнене / 0 - вимкнене архівування).
`export` - шлях до файлу або директорії з файлами для експорту.

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
В процедурі `export` є два критерії: `default : 1` і `export : 1`, що свідчить про використання вбудованого сценарію експорту (побудови) модуля.
<a name="export-module-listing"></a>

<details>
  <summary><u>Повний лістинг файла `.will.yml`</u></summary>

```yaml

about :
    name : second
    description : "Second module"
    version : 0.0.1

path :
  out : '.'
  fileToExport : './fileToExport'

step  :
    export.single :
        inherit : export
        tar : 0
        export : './fileToExport'

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
 Exporting export
   + Write out file to ...doc/tutorial/modules/second/second.out.will.yml
  Exported export with 1 files in 0.073s
```

В процесі експорту `willbe` згенерує `*.out.will.yml` файл, який містить інформацію, що потрібна для імпорту модуля.

### Підсумок
В цьому розділі описана процедура [експорту `will`-модуля](#export-module-term). Для її проведення необхідні файли, які будуть експортуватись та зконфігурований `.will.yml`.
Для правильного виконання команди:
- [секція `path`](#section-path) повинна вказувати на шлях до файлів, які будуть експотруватись, та шлях, де буде поміщено згенерований вихідний (out) модуль;
- [секція `step`](#section-step) описати конфігурацію процедури експорту;
- [секція `build`](#section-build) повинна описати операцію експорту (побудови) модуля.

[Повернутись до меню](Topics.ukr.md)
