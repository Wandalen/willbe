# Перший will-модуль. Завантаження віддаленого підмодуля

В цьому туторіалі описується робота з імпортованими підмодулями  

В попередньому туторіалі ви створили конфігурацію для роботи з зовнішніми підмодулями, зробимо наступний крок для створення модуля.  
Скористуємось фразою `will. submodules.download`:

```
[user@user ~]$ will .submodules.download
Request ".submodules.download"
   . Read : /path_to_file/.will.yml
 . Read 1 will-files in 0.068s
 ! Failed to read submodule::Tools, try to download it with .submodules.download or even clean it before downloading
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 12.360s
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

В кореневій директорії файла `.will.yml` має з'явитись каталог підмодулів `.module`. Відкривши його ви знайдете директорію `Tools` з файлами підмодуля.  
Додамо ще один підмодуль в `.will.yml` та знову виконаємо `will .submodules.list`:

```yaml

PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

```
...
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  isDownloaded : true
  Exported builds : [ 'proto.export' ]
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```

<a name="resource-inheritation"> Зверніть увагу на рядки, які позначають окремі підмодулі - _'submodule::Tools'_ i _'submodule::PathFundamentals'_. В порівнянні з виводом інформації секції `about` (фраза `will .about.list`).

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

[Наступний туторіал](SubmodulesImporting2.ukr.md)  
[Повернутись до змісту](Topics.ukr.md)
