# Перший will-файл

В цьому туторіалі описується робота з імпортованими підмодулями  

### <a name="importing-submodules"></a> Використання зовнішніх підмодулів  
Ви створили свій перший `will`-файл, який описує модуль, але не має функціоналу. Тепер перетворимо його в робочий [`will`-модуль](Concepts.ukr.md#module) - базову одиницю пакету.  

Перш ніж створювати власні сценарії, навчимось використовувати готові рішення в вигляді підмодулів. Інформація про підмодулі `willbe` розміщена в секції `submodule`. Тому, запишемо:

```yaml

submodule :

  Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

Об'єднавши її з попереднім файлом матимемо доступ до операцій з підмодулями.  

<details>  
  <summary><u>Файл `.will.yml`</u></summary>

```yaml

about :

    name : first
    description : "First module"
    version : 0.0.1
    keywords :
        - willbe

submodule :

    WTools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master

```

</details>

<p> </p>
Тепер в `submodule` поміщений один ресурс з назвою _'WTools'_, який має _URL_-шлях _'git+https:///github.com/Wandalen/wTools.git/out/wTools#master'_. Опис шляху свідчить про використання підмодуля з _GitHub_-у.  
Скориставшись знайомою з попереднього туторіалу командою `will. submodules.list`, отримаємо такі рядки (тут і далі, текст лістинга команди, що не включено в туторіал позначений '...'):

```
...
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
...
  isDownloaded : false
  Exported builds : []

```
Тепер, скористуємось фразою `will. submodules.download`:

```
[user@user ~]$ will .submodules.download
Request ".submodules.download"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.068s
 ! Failed to read submodule::WTools, try to download it with .submodules.download or even clean it before downloading
   . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
   + module::WTools was downloaded in 12.360s
 + 1/1 submodule(s) of module::first were downloaded in 12.365s

```

`Willbe` завантажив один підмодуль. Перевіримо вивід команди `.submodules.list`:

```
...
 . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
...
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

```

В кореневій директорії файла `.will.yml` має з'явитись каталог `.module`. Відкривши його ви знайдете підмодуль `WTools` з його власними файлами.  
Додамо ще один підмодуль в `.will.yml` та знову виконаємо `will .submodules.list`:

```
PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

```
...
submodule::WTools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : true
  Exported builds : [ 'proto.export' ]
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```

<a name="resource-inheritation"> Зверніть увагу на рядки, які позначають окремі підмодулі - _'submodule::WTools'_ i _'submodule::PathFundamentals'_. В порівнянні з виводом інформації секції `about` (фраза `will .about.list`).

```
...
About
  name : 'first'
  description : 'First module'
  ...

```

Запис вигляду _'секція::ресурс'_ використовує синтаксис наслідування класів в мовах програмування. Тобто, якщо ресурс вважати похідним класом, то він наслідує властивості секції, як базового класу.
Секція `about`, в такому випадку, не наслідується і має єдиний єдину форму запису.

### Підсумок  
- Пакет `willbe` дозволяє ефективно [працювати з готовими підмодулями](#will-module-creation).
- Якщо прийняти, що [ресурси _"наслідують"_ властивості секцій](#resource-inheritation), то секція `about` не наслідується і має єдиний форму запису.

[Наступний туторіал](SubmodulesExploring.md)  
[Повернутись до меню](Topics.ukr.md)
