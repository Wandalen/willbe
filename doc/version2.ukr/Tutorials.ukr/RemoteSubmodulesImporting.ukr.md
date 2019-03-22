# Перший will-модуль. Завантаження віддаленого підмодуля

В туторіалі показано як імпортувати віддалені підмодулі  

В попередньому туторіалі створено конфігурацію для роботи з зовнішніми підмодулями, зробимо наступний крок для побудови модуля.  
<a name="submodules-download"> В директорії з файлом `.will.yml` введіть фразу `will. submodules.download`:

```
[user@user ~]$ will .submodules.download
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was downloaded in 12.360s
 + 1/1 submodule(s) of module::first were downloaded in 12.365s

```

Перевіримо зміни в директорії модуля - введіть `ls -al:

```
[user@user ~]$ ls -al
...
drwxr-xr-x 4 user user 4096 Мар 12 07:20 .module
-rw-r--r-- 1 user user  306 Мар  1 11:20 .will.yml

```

`Willbe` завантажив один підмодуль в директорію `.module`. Перейдіть і ви знайдете каталог `Tools` з підмодулем.  
Перевіримо вивід команди `.submodules.list`:

```
[user@user ~]$ will .submodules.list
...
 . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
...
  isDownloaded : true
  Exported builds : [ 'proto.export' ]

```

Додамо ще один підмодуль в `.will.yml` та знову виконаємо `will .submodules.list`:

```yaml

PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

```
[user@user ~]$ will .submodules.list
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
[user@user ~]$ will .about.list
...
About
  name : 'first'
  description : 'First module'
  ...

```

Інформація виводиться у вигляді 'Назва секції :: Назва ресурса', тобто, секція може мати необмежену кількість ресурсів, а секція `about`, в такому випадку, має єдину форму запису і, умовно, являється ресурсом.

- `willbe` працює з готовими модулями, їх достатньо внести в секцію `submodule`.
- Вивід інформації в консоль має вигляд 'Назва секції :: Назва ресурса'. Секція `about`, умовно, являється ресурсом.

[Наступний туторіал](SubmodulesImporting2.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)
