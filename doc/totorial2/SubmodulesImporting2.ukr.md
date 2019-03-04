# Оновлення та видалення підмодулів

В туторіалі продовжено опис імпортованих підмодулів, більш детально розглянуто їх адміністрування

В попередньому туторіалі йдеться про умовне [_"наслідування"_ ресурсами властивостей секції](SubmodulesImporting.ukr.md#resource-inheritation), тобто, ресурс має наслідувати структуру секції за замовчуванням, а для `submodule` вона включає чотири поля: `description`, `path`, `criterion`, `inherit`. Два останніх - предмет окремих туторіалів, з ними ознайомитесь пізніше, а поки що перепишемо попередній приклад зі скороченою формою запису:
<a name="short-form">
  
```yaml
submodule :

    WTools : git+https:///github.com/Wandalen/wTools.git/out/wTools#master  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

в повну, додавши до першого з підмодулів поля `path` та `description`:

<a name="full-form">

```yaml
submodule :

    WTools :
       path : git+https:///github.com/Wandalen/wTools.git/out/wTools#master
       description : 'Import willbe tools'  
    PathFundamentals : git+https:///github.com/Wandalen/wPathFundamentals.git/out/wPathFundamentals#master

```

Введіть в консолі `will .submodules.list`:

```
...
submodule::WTools
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
    
Маємо один завантажений підмодуль з описом. Для завантаження другого введіть фразу `will .submodules.download`. Проте, краще виконаємо чисте встановлення, попередньо видаливши директорію `.module` з підмодулями фразою `will .submodules.clean`

```
[user@user ~]$ will .submodules.clean
...
 - Clean deleted 252 file(s) in 0.907s

```

Після виконанння команди `.submodules.download` структура модуля матиме вигляд:
```
.
├── .module
│   ├──WTools
│   └──PathFundamentals
└── .will.yml

```

<a name="submodules-upgrade">
    
Ці підмодулі будуть виконувати своє призначення, проте, з часом може виникнути потреба оновити підмодулі не виконуючи очистку і повне завантаження. Для цього використовується команда `.submodules.upgrade` яка зчитує дані про підмодулі та порівнює їх з віддаленими версіями. При наявності оновлення пакет його встановить:

```
[user@user ~]$ will .submodules.upgrade
...
   . Read : /path_to_file/.module/WTools/out/wTools.out.will.yml
   + module::WTools was upgraded in 13.568s
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

### Підсумок
> Ресурс секції може мати [скорочену](#short-form) і [повну](#full-form) форму запису.
> `Willbe` виконує операції з зовнішніми підмодулями з командної оболонки системи.

[Наступний туторіал](ModuleCreationByBuild.ukr.md)  
[Повернутись до змісту](Topics.ukr.md)
