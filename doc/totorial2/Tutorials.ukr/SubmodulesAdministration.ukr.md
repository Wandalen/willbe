# Оновлення та видалення підмодулів

В туторіалі продовжено опис підмодулів, більш детально розглянуто їх адміністрування

Окремі ресурси секцій можуть мати повну і скорочену форму запису. В секції `submodule` ми записували підмодулі в скороченій формі: 'Назва підмодуля : Шлях до підмодуля', а повна форма включає чотири поля: `description`, `path`, `criterion`, `inherit`. Два останніх - предмет окремих туторіалів, з ними ознайомитесь пізніше, а поки що перепишемо попередній приклад зі скороченою формою запису:
<a name="short-form">
  
```yaml
submodule :

    Tools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

в повну, додавши до першого з підмодулів поля `path` та `description`:

<a name="full-form">

```yaml
submodule :

    Tools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
       description : 'Import willbe tools'  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

Введіть в консолі `will .submodules.list`:

```
[user@user ~]$ will .submodules.list
...
submodule::Tools
  path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
  description : Import willbe tools
  isDownloaded : true
  Exported builds : [ 'proto.export' ]
submodule::PathFundamentals
  path : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master
  isDownloaded : false
  Exported builds : []

```  

<a name="submodules-cleaning">
    
В лістингу також з'явився опис підмодуля `Tools`. Для завантаження другого введіть фразу `will .submodules.download`. Проте, краще виконаємо чисте встановлення, попередньо видаливши директорію `.module` з підмодулями фразою `will .submodules.clean`

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 252 file(s) in 0.907s

```

Після виконанння команди `.submodules.download` структура модуля матиме вигляд:
```
.
├── .module
│   ├──Tools
│   └──PathFundamentals
└── .will.yml

```

Перевірте виконавши `ls -al .module/` з кореневої директорії `.will.yml`:

```
[user@user ~]$ ls -al .module/
...
drwxr-xr-x 6 user user 4096 Мар 12 07:20 PathFundamentals
drwxr-xr-x 9 user user 4096 Мар 12 07:20 Tools

```

<a name="submodules-upgrade">
    
Встановлені підмодулі будуть працювати, проте, з часом може виникнути потреба оновити підмодулі без очищення директорії `.module`. Для цього використовуйте команду `.submodules.upgrade` яка зчитує дані про підмодулі та порівнює їх з віддаленими версіями і, при наявності нової версії встановить її:

```
[user@user ~]$ will .submodules.upgrade
...
   . Read : /path_to_file/.module/Tools/out/wTools.out.will.yml
   + module::Tools was upgraded in 13.568s
   . Read : /path_to_file/.module/PathFundamentals/out/wPathFundamentals.out.will.yml
   + module::PathFundamentals was upgraded in 3.340s
 + 2/2 submodule(s) of module::first were upgraded in 16.917s

```

Якщо оновлень немає, то пакет виводить повідомлення:

```
[user@user ~]$ will .submodules.upgrade
...
 + 0/2 submodule(s) of module::first were upgraded in 3.121s

```

- Ресурс секції може мати [скорочену](#short-form) і [повну](#full-form) форму запису.
- `Willbe` виконує операції з зовнішніми підмодулями з командної оболонки системи.

[Наступний туторіал](ModuleCreationByBuild.ukr.md)  
[Повернутись до змісту](../README.md#tutorials)
