# Створення will-модуля

В керівництві описано створення will-файла та побудова модулів різного призначення

<a name="topics"></a>

Зміст   
- [Початок роботи](#start)
- [Базова конфігурація](#basic-configuration)
- [Робота з підмодулями](#submodules-importing)
- [Використання секцій `step` i `build` при створенні модуля](#step-and-build)
- [Експорт модуля](#module-export)
- [Розділені `will`-файли](#split-will-file)
- [Іменований підмодуль](#named-module)

> Команди в прикладах виконуються з кореневої директорії `will`- файла (`.will.yml`)

<a name="start"></a>
### Початок роботи
Will-файл має наступні властивості:
- will-файли мають розширення 'yml', 'json', 'cson' (_в прикладах використовується формат YAML. Ви можете використовувати зручний для вас формат._);
- документ складається з секцій, які описують функціональності модуля (about, path, step, reflector, build...);
- секція `about` обов'язкова.  

Першим кроком створіть порожній `will`-файл в обраній директорії. Стандартний (неіменований) файл має назву `.will.yml`.

```
.
├── .will.yml  

```

<a name="basic-configuration"></a>
### Базова конфігурація
В створений `.will.yml` внесіть інформацію в секцію `about`. Приклад іллюструє всі поля секції, ви можете використати окремі:

```yaml
about :
    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe
    interpreters:
        - nodejs >= 6.0.0
```

_Починати роботу з заповнення секції `about` є доброю практикою, адже, ця інформація дозволяє іншим користувачам легко отримати загальні дані про модуль, а також адміністувати його в довготривалій перспективі._  

<a name="submodules-importing"></a>
### Робота з підмодулями
Для створення робочого модуля в `.will.yml` потрібно додати секції, що описують файли модуля.  
[Секція `submodule`](WillFileStructure.md#submodule) дозволяє використовувати готові підмодулі для компонування системи.

```yaml
submodule :

  Tools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
       description : 'Import willbe tools'
       #criterion :
       #    debug : 1
       #inherit : some inherit parameter

```
Приклад вище іллюструє використання повної форми - запису всіх полів секції. Щоб використовувати її, вказуйте назву процедури, в данному випадку, назву підмодуля (Tools). Критеріони (criterion) та наслідування (inherit, в прикладі закоментовано) розглянуті окремо. Також, якщо немає додаткових умов, шлях можна записати в скороченій формі - назву підмодуля і шлях до нього:

```yaml
submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

Об'єднавши попередні секції в `.will.yml` вам стануть доступні операції з підмодулями: завантаження фразою `will .submodules.download`, оновлення фразою `will .submodules.upgrade` та видалення - `will .submodules.clean`. Інформація про підмодулі виводиться командою `.submodules.list`.
<details>
  <summary><u>Файл `.will.yml` та лістинги команд</u></summary>

```yaml

about :
    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe
    interpreters:
        - nodejs >= 6.0.0

submodule :

    Tools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
       description : 'Import willbe tools'
       #criterion :
       #    debug : 1
       #inherit : some inherited parameter

```
<p> </p>

```
[user@user ~]$ will .submodules.list
...
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  description : Downloading submodules from GitHub
  criterion :
    default : 1
  isDownloaded : false
  Exported builds : []

```

<p> </p>

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 12.360s
 + 1/1 submodule(s) of module::first were downloaded in 12.365s

```
<p> </p>

```
[user@user ~]$ will .submodules.upgrade
...
. Read : /path_to_file/.module/PathFundamentals/out/wTools.out.will.yml
+ module::Tools was upgraded in 15.133s
+ 1/1 submodule(s) of module::first were upgraded in 15.138s

```
<p> </p>

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 252 file(s) in 0.907s

```

</details>

Використання секції ефективне, якщо вас влаштовують готові підмодулі, проте для точного налаштування системи цього недостатньо.


<a name="step-and-build"></a>
### Використання секцій `step` i `build` при створенні модуля
[Секція `step`](WillFileStructure.md#step) описує визначені користувачем дії, які можуть використовуватись утилітою для створення модульної системи. `Step` складається з чотирьох полів: _description, criterion, opts i inherit._  Особливим є поле _opts_ яке дає змогу використовувати широкий набір інструментів як з утиліти `willbe`, так і зовнішніх програм, наприклад, використовувати командну оболонку системи або створювати експорт модуля.    
Приклад секції `step`:

```yaml
step :

  echoHello :
    currentPath : '.'
    shell : echo "Hello World"
    #inherit : some inherited parameter
    #criterion :
    #    debug : 1

```
Секція виконує команду _'echo'_, тобто, вивід рядка в консолі системи.
Секція `step` дозволяє реалізувати ідеї користувача по створенню модульної системи, але самостійно кроки з секції використати неможливо, для цього будуються збірки [секції `build`](WillFileStructure.md#build). Збіркою вважається умови і послідовності виконання дій утилітою `willbe` для створення модуля.  
Приклад секції `build` з усіма полями:

```yaml
build :

  echo:
    steps :
       - echoHello
    #description : "Some description"
    #criterion :
    #   debug : 1
    #inherit : some inherited parameter

```

<details>
  <summary><u>Файл `.will.yml` та лістинги команд</u></summary>

```yaml

about :
    name : buildWithStep

step :

  echoHello :
    currentPath : '.'
    shell : echo "Hello World"
    #inherit : some inherited parameter
    #criterion :
    #    debug : 1

build :

  echo:
    steps :
       - echoHello
    #description : "Some description"
    #criterion :
    #   debug : 1
    #inherit : some inherited parameter

```
<p> </p>


</details>

Для запуску збірки вводимо фразу `will .build [назва збірки]`. Якщо звернутись до прикладу, то фраза матиме вигляд `will .build echo`.

```
[user@user ~]$ will .build echo
...
  Building echo
 > echo "Hello World"
Hello World
  Built echo in 0.088s
```

Виконання побудови модуля за замовчуванням з використанням фрази `will .build` розглядається в керівництві користувача про критеріони.

### <a name="#module-export"></a> Експорт модуля
Особливий вид побудови модульної системи результатом виконання якої є згенерований `*.out.will`-файл називається експортуванням модуля. Вихідний `*.out.will` містить повну інформацію про створений модуль і експортовані файли та використовується іншими модулями в процесі імпорту.  
Спрощена структура модуля для експорту має вигляд:

```
.
├── fileToExport
├── .will.yml
```
Тому для операції експорту модуля необхідні файли для експорту. Ми використовуємо порожній файл з назвою _'fileToExport'_.  
[Секція `path`](WillFileStructure.md#path) описує карту шляхів модуля для швидкого орієнтування в його структурі:

``` yaml
about :
    name : export
    description : "Export module"
    version : 0.0.1

path :
  in : '.'
  out :
    path : 'out'
    #description
    #inherit
    #criterion
  fileToExport : 'fileToExport'

```

`in` - шлях, відносно якого розташовуються інші шляхи модуля. Якщо `in` не вказано, то за замовчуванням він починається в кореневій директорії `.will.yml`.
`out` - відносний шлях від `in`, де буде поміщений `*.out.will`-модуль. `out` має вказувати на шлях відмінний від шляху `in` `will`-файла.   
`fileToExport` - шлях до файлів експорту вказаний користувачем відносно директорії `in`.

Створимо процедуру експорту `export.single` в секції `step` використовуючи вбудовану функцію `predefined.export`. Використання вбудованих функцій описано в відповідному керівництві користувача.

``` yaml
step  :
    export.single :
        inherit : predefined.export
        tar : 0
        export : path::fileToExport

```

Процедура має поля:  
`inherit` - наслідування вбудованого кроку експортування `predefined.export`.  
`tar` - архівування експортованих файлів ( 1 - ввімкнене / 0 - вимкнене архівування).
`export` - шлях до файлу або директорії з файлами для експорту. Використовуйте синтаксис `path::[export.path]` для правильного функціонування утиліти.

Сконфігуруємо `build` для експорту:
``` yaml
build :
    export :
        criterion :
            export : 1
        steps :
            - export.single
```
Збірка `export` має критерій: `export : 1`, що свідчить про використання функції експорту модуля.

<details>
  <summary><u>Повний лістинг файла `.will.yml` для експорту модуля</u></summary>

```yaml

about :
    name : export
    description : "Export module"
    version : 0.0.1

path :
  in : '.'
  out :
    path : 'out'
    #description
    #inherit
    #criterion
  fileToExport : 'fileToExport'

step  :
  export.single :
      inherit : predefined.export
      export : path::fileToExport
      tar : 0

build :
  export :
      criterion :
         export : 1
      steps :
         - export.single
```
</details>

Введіть в консолі `will .export`:

```
...
 Exporting export
   + Write out will-file /path_to_file/out/third.out.will.yml
   + Exported export with 1 files in 0.705s
  Exported export in 0.752s

```

Після виконання команди `willbe` згенерує `export.out.will.yml` за назвою модуля в `about` та помістить файл в директорію `out`.

[Повернутись до змісту](../README.md#manuals)
